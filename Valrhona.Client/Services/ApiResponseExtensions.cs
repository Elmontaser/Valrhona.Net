using System.Net.Http.Json;
using System.Text.Json;

namespace Valrhona.Client.Services;

/// <summary>
/// خطأ قادم من الـ API برسالة جاهزة للعرض للمستخدم.
/// </summary>
public class ApiException(string message, int statusCode = 0)
    : Exception(message)
{
    public int StatusCode { get; } = statusCode;
}

public static class ApiResponseExtensions
{
    /// <summary>
    /// يتحقق من نجاح الطلب، وعند الفشل يستخرج الرسالة من:
    /// { "error": "..." } أو ProblemDetails (title/detail/errors).
    /// </summary>
    public static async Task EnsureApiSuccessAsync(
        this HttpResponseMessage response)
    {
        if (response.IsSuccessStatusCode)
            return;

        throw new ApiException(
            await ReadMessageAsync(response),
            (int)response.StatusCode);
    }

    public static async Task<T> ReadApiAsync<T>(
        this HttpResponseMessage response)
    {
        await response.EnsureApiSuccessAsync();

        var value = await response.Content.ReadFromJsonAsync<T>();

        return value ?? throw new ApiException(
            "استجابة فارغة من الخادم.",
            (int)response.StatusCode);
    }

    private static async Task<string> ReadMessageAsync(
        HttpResponseMessage response)
    {
        string fallback = response.StatusCode switch
        {
            System.Net.HttpStatusCode.NotFound => "العنصر المطلوب غير موجود.",
            System.Net.HttpStatusCode.InternalServerError => "حدث خطأ داخلي في الخادم.",
            _ => $"فشل الطلب (رمز {(int)response.StatusCode})."
        };

        try
        {
            var text = await response.Content.ReadAsStringAsync();

            if (string.IsNullOrWhiteSpace(text))
                return fallback;

            using var doc = JsonDocument.Parse(text);
            var root = doc.RootElement;

            if (root.ValueKind != JsonValueKind.Object)
                return fallback;

            // الشكل الذي يرجعه GlobalExceptionHandler
            if (root.TryGetProperty("error", out var error)
                && error.ValueKind == JsonValueKind.String)
            {
                return error.GetString() ?? fallback;
            }

            // أخطاء التحقق التلقائي (ProblemDetails)
            if (root.TryGetProperty("errors", out var errors)
                && errors.ValueKind == JsonValueKind.Object)
            {
                var messages = errors
                    .EnumerateObject()
                    .SelectMany(p => p.Value.ValueKind == JsonValueKind.Array
                        ? p.Value.EnumerateArray()
                            .Select(v => v.GetString())
                        : Enumerable.Empty<string?>())
                    .Where(m => !string.IsNullOrWhiteSpace(m))
                    .Distinct();

                var joined = string.Join(" ", messages);

                if (!string.IsNullOrWhiteSpace(joined))
                    return joined;
            }

            if (root.TryGetProperty("detail", out var detail)
                && detail.ValueKind == JsonValueKind.String)
            {
                return detail.GetString() ?? fallback;
            }

            if (root.TryGetProperty("title", out var title)
                && title.ValueKind == JsonValueKind.String)
            {
                return title.GetString() ?? fallback;
            }
        }
        catch (JsonException)
        {
            // الاستجابة ليست JSON
        }

        return fallback;
    }
}
