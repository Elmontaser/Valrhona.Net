using System.ComponentModel.DataAnnotations;

namespace Valrhona.Client.Models.ItemPrices;

public class ItemPriceFormModel
{
    [Range(1, int.MaxValue, ErrorMessage = "اختر الصنف.")]
    public int ItemId { get; set; }

    [Range(typeof(decimal), "0", "79228162514264337593543950335",
        ErrorMessage = "السعر لا يمكن أن يكون سالبًا.")]
    public decimal Price { get; set; }

    [Range(1, int.MaxValue, ErrorMessage = "اختر وحدة السعر.")]
    public int UnitId { get; set; }

    [Required(ErrorMessage = "العملة مطلوبة.")]
    [StringLength(10, ErrorMessage = "العملة لا تتجاوز 10 أحرف.")]
    public string Currency { get; set; } = "LYD";

    public DateTime EffectiveDate { get; set; } = DateTime.Today;

    [StringLength(500, ErrorMessage = "الملاحظات لا تتجاوز 500 حرف.")]
    public string? Notes { get; set; }
}