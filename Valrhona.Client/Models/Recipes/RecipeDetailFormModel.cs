using System.ComponentModel.DataAnnotations;

namespace Valrhona.Client.Models.Recipes;

public class RecipeDetailFormModel
{
    public long RecipeDetailId { get; set; }

    [Range(1, int.MaxValue, ErrorMessage = "اختر المكوّن.")]
    public int IngredientItemId { get; set; }

    [Range(typeof(decimal), "0.0001", "79228162514264337593543950335",
        ErrorMessage = "الكمية يجب أن تكون أكبر من صفر.")]
    public decimal Quantity { get; set; }

    [Range(1, int.MaxValue, ErrorMessage = "اختر وحدة القياس.")]
    public int UnitId { get; set; }

    [Range(typeof(decimal), "0", "100", ErrorMessage = "نسبة الهدر يجب أن تكون بين 0 و100.")]
    public decimal WastePercent { get; set; }

    [StringLength(500, ErrorMessage = "الملاحظات لا تتجاوز 500 حرف.")]
    public string? Notes { get; set; }

    public string? CurrentItemLabel { get; set; }
    public string? CurrentUnitLabel { get; set; }
}