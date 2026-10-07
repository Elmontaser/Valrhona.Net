using System.ComponentModel.DataAnnotations;

namespace Valrhona.Client.Models.Recipes;

public class RecipeFormModel
{
    public int RecipeId { get; set; }

    [Required(ErrorMessage = "كود الوصفة مطلوب.")]
    [StringLength(50, ErrorMessage = "الكود لا يتجاوز 50 حرفًا.")]
    public string RecipeCode { get; set; } = string.Empty;

    [Required(ErrorMessage = "اسم الوصفة مطلوب.")]
    [StringLength(200, ErrorMessage = "الاسم لا يتجاوز 200 حرف.")]
    public string RecipeName { get; set; } = string.Empty;

    [Range(1, int.MaxValue, ErrorMessage = "اختر صنف الناتج.")]
    public int OutputItemId { get; set; }

    [Range(typeof(decimal), "0.0001", "79228162514264337593543950335", ErrorMessage = "كمية الناتج يجب أن تكون أكبر من صفر.")]
    public decimal OutputQuantity { get; set; }

    [Range(1, int.MaxValue, ErrorMessage = "اختر وحدة الناتج.")]
    public int OutputUnitId { get; set; }

    [Range(1, int.MaxValue, ErrorMessage = "رقم النسخة يجب أن يكون أكبر من صفر.")]
    public int VersionNo { get; set; } = 1;

    [StringLength(1000, ErrorMessage = "الملاحظات لا تتجاوز 1000 حرف.")]
    public string? Notes { get; set; }

    public List<RecipeIngredientFormModel> Ingredients { get; set; } = new();
}

public class RecipeIngredientFormModel
{
    public int IngredientItemId { get; set; }
    public decimal Quantity { get; set; }
    public int UnitId { get; set; }
    public decimal WastePercent { get; set; }
    public string? Notes { get; set; }
}
