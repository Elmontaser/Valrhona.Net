using System.ComponentModel.DataAnnotations;

namespace Valrhona.API.Dtos.UnitConversions;

public class CreateUnitConversionDto
{
    [Range(1, int.MaxValue, ErrorMessage = "اختر وحدة المصدر.")]
    public int FromUnitId { get; set; }

    [Range(1, int.MaxValue, ErrorMessage = "اختر وحدة الهدف.")]
    public int ToUnitId { get; set; }

    [Range(typeof(decimal), "0.00000001", "79228162514264337593543950335",
        ErrorMessage = "معامل التحويل يجب أن يكون أكبر من صفر.")]
    public decimal ConversionFactor { get; set; }

    [StringLength(500, ErrorMessage = "الملاحظات لا تتجاوز 500 حرف.")]
    public string? Notes { get; set; }
}