using System.ComponentModel.DataAnnotations;

namespace Valrhona.Client.Models.UnitConversions;

public class UnitConversionFormModel : IValidatableObject
{
    public int UnitConversionId { get; set; }

    [Range(1, int.MaxValue, ErrorMessage = "اختر وحدة المصدر.")]
    public int FromUnitId { get; set; }

    [Range(1, int.MaxValue, ErrorMessage = "اختر وحدة الهدف.")]
    public int ToUnitId { get; set; }

    [Range(typeof(decimal), "0.00000001", "79228162514264337593543950335",
        ErrorMessage = "معامل التحويل يجب أن يكون أكبر من صفر.")]
    public decimal ConversionFactor { get; set; } = 1;

    [StringLength(500, ErrorMessage = "الملاحظات لا تتجاوز 500 حرف.")]
    public string? Notes { get; set; }

    public string? FromUnitName { get; set; }
    public string? ToUnitName { get; set; }

    public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
    {
        if (FromUnitId > 0 && FromUnitId == ToUnitId)
        {
            yield return new ValidationResult(
                "يجب أن تختلف وحدة المصدر عن وحدة الهدف.",
                [nameof(ToUnitId)]);
        }
    }
}