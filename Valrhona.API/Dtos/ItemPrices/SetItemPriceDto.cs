using System.ComponentModel.DataAnnotations;

namespace Valrhona.API.Dtos.ItemPrices;

public class SetItemPriceDto
{
    [Range(1, int.MaxValue,
        ErrorMessage = "ItemId يجب أن يكون أكبر من صفر.")]
    public int ItemId { get; set; }

    [Range(typeof(decimal), "0",
        "79228162514264337593543950335",
        ErrorMessage = "السعر لا يمكن أن يكون سالبًا.")]
    public decimal Price { get; set; }

    [Range(1, int.MaxValue,
        ErrorMessage = "UnitId يجب أن يكون أكبر من صفر.")]
    public int UnitId { get; set; }

    [Required(ErrorMessage = "العملة مطلوبة.")]
    [StringLength(10,
        ErrorMessage = "العملة لا يمكن أن تتجاوز 10 أحرف.")]
    public string Currency { get; set; } = "LYD";

    public DateTime? EffectiveDate { get; set; }

    [StringLength(500,
        ErrorMessage = "الملاحظات لا يمكن أن تتجاوز 500 حرف.")]
    public string? Notes { get; set; }
}