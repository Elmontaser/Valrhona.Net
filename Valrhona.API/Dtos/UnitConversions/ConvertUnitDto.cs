using System.ComponentModel.DataAnnotations;

namespace Valrhona.API.Dtos.UnitConversions;

public class ConvertUnitDto
{
    [Range(typeof(decimal), "0.0001",
        "79228162514264337593543950335",
        ErrorMessage = "Quantity يجب أن تكون أكبر من صفر.")]
    public decimal Quantity { get; set; }

    [Range(1, int.MaxValue,
        ErrorMessage = "FromUnitId يجب أن يكون أكبر من صفر.")]
    public int FromUnitId { get; set; }

    [Range(1, int.MaxValue,
        ErrorMessage = "ToUnitId يجب أن يكون أكبر من صفر.")]
    public int ToUnitId { get; set; }
}