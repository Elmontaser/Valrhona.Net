namespace Valrhona.API.Exceptions;

/// <summary>
/// خطأ منطقي متوقع (كود مكرر، عنصر غير موجود...) رسالته آمنة للعرض للمستخدم.
/// </summary>
public class BusinessRuleException(string message, int? code = null)
    : Exception(message)
{
    public int? Code { get; } = code;
}
