using Microsoft.AspNetCore.Cors.Infrastructure;
using Microsoft.AspNetCore.Diagnostics;
using Microsoft.Data.SqlClient;

namespace Valrhona.API.Exceptions;

public class GlobalExceptionHandler(
    ILogger<GlobalExceptionHandler> logger) : IExceptionHandler
{
    // يجب أن يطابق اسم السياسة في Program.cs
    private const string CorsPolicyName = "ValrhonaClient";

    public async ValueTask<bool> TryHandleAsync(
        HttpContext httpContext,
        Exception exception,
        CancellationToken cancellationToken)
    {
        // أخطاء منطقية متوقعة: رسالتها آمنة وتصل للمستخدم
        if (exception is BusinessRuleException businessException)
        {
            return await WriteAsync(
                httpContext,
                StatusCodes.Status400BadRequest,
                businessException.Message,
                cancellationToken);
        }

        if (exception is SqlException sqlException)
        {
            // THROW 50000+ من الإجراءات المخزنة: رسائل عربية مكتوبة لنا
            if (sqlException.Number >= 50000)
            {
                return await WriteAsync(
                    httpContext,
                    StatusCodes.Status400BadRequest,
                    sqlException.Message,
                    cancellationToken);
            }

            // أخطاء SQL الأخرى (قيود، مهلة، اتصال): لا نكشف نصها للعميل
            logger.LogError(
                sqlException,
                "SQL error {Number}",
                sqlException.Number);

            return await WriteAsync(
                httpContext,
                StatusCodes.Status500InternalServerError,
                "حدث خطأ في قاعدة البيانات.",
                cancellationToken);
        }

        logger.LogError(exception, "Unhandled exception");

        return await WriteAsync(
            httpContext,
            StatusCodes.Status500InternalServerError,
            "حدث خطأ داخلي في الخادم.",
            cancellationToken);
    }

    private static async Task<bool> WriteAsync(
        HttpContext httpContext,
        int statusCode,
        string message,
        CancellationToken cancellationToken)
    {
        // الـ ExceptionHandler قد يمسح ترويسات CORS، فنعيد تطبيقها
        // حتى يستطيع المتصفح قراءة رسالة الخطأ
        await ApplyCorsAsync(httpContext);

        httpContext.Response.StatusCode = statusCode;
        httpContext.Response.ContentType = "application/json";

        await httpContext.Response.WriteAsJsonAsync(
            new { error = message },
            cancellationToken);

        return true;
    }

    private static async Task ApplyCorsAsync(HttpContext httpContext)
    {
        var provider =
            httpContext.RequestServices.GetService<ICorsPolicyProvider>();

        var service =
            httpContext.RequestServices.GetService<ICorsService>();

        if (provider is null || service is null)
            return;

        var policy =
            await provider.GetPolicyAsync(httpContext, CorsPolicyName);

        if (policy is null)
            return;

        var result = service.EvaluatePolicy(httpContext, policy);

        service.ApplyResult(result, httpContext.Response);
    }
}
