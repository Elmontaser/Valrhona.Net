using System.Data;
using Dapper;
using Valrhona.API.Exceptions;

namespace Valrhona.API.Data;

/// <summary>
/// نتيجة الإجراءات المخزنة التي تُرجع ResultCode / ResultMessage.
/// </summary>
public class ProcedureResult
{
    public int ResultCode { get; set; }
    public string? ResultMessage { get; set; }

    public int? ErrorNumber { get; set; }
    public string? ErrorMessage { get; set; }

    // المعرّف المُرجَع بعد نجاح الإضافة أو التعديل
    public int? ItemId { get; set; }
    public int? CategoryId { get; set; }
    public int? UnitId { get; set; }
}

public static class DbResult
{
    /// <summary>
    /// 1 = نجاح. أقل من أو يساوي -500 = خطأ داخلي يُسجَّل ويظهر للمستخدم كخطأ عام.
    /// أي قيمة سالبة أخرى = خطأ منطقي برسالة عربية تصل للمستخدم.
    /// </summary>
    public static void EnsureSuccess(
        int resultCode,
        string? message,
        string? errorMessage = null)
    {
        if (resultCode == 1)
            return;

        if (resultCode <= -500)
        {
            throw new InvalidOperationException(
                $"{message} | {errorMessage}");
        }

        throw new BusinessRuleException(
            message ?? "فشلت العملية.",
            resultCode);
    }

    public static async Task<ProcedureResult> ExecuteForResultAsync(
        this IDbConnection connection,
        string procedureName,
        object? parameters = null)
    {
        var result =
            await connection.QuerySingleOrDefaultAsync<ProcedureResult>(
                procedureName,
                parameters,
                commandType: CommandType.StoredProcedure);

        if (result is null)
        {
            throw new InvalidOperationException(
                $"لم يتم استلام نتيجة من {procedureName}.");
        }

        EnsureSuccess(
            result.ResultCode,
            result.ResultMessage,
            result.ErrorMessage);

        return result;
    }
}
