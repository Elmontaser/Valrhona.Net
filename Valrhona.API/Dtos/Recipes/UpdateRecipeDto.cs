using System.ComponentModel.DataAnnotations;

namespace Valrhona.API.Dtos.Recipes;

public class UpdateRecipeDto
{
    [Range(1, int.MaxValue,
        ErrorMessage = "RecipeId يجب أن يكون أكبر من صفر.")]
    public int RecipeId { get; set; }

    [Required(ErrorMessage = "RecipeCode مطلوب.")]
    [StringLength(50,
        ErrorMessage = "RecipeCode لا يمكن أن يتجاوز 50 حرفًا.")]
    public string RecipeCode { get; set; } = string.Empty;

    [Required(ErrorMessage = "RecipeName مطلوب.")]
    [StringLength(200,
        ErrorMessage = "RecipeName لا يمكن أن يتجاوز 200 حرف.")]
    public string RecipeName { get; set; } = string.Empty;

    [Range(1, int.MaxValue,
        ErrorMessage = "OutputItemId يجب أن يكون أكبر من صفر.")]
    public int OutputItemId { get; set; }

    [Range(typeof(decimal), "0.0001",
        "79228162514264337593543950335",
        ErrorMessage = "OutputQuantity يجب أن تكون أكبر من صفر.")]
    public decimal OutputQuantity { get; set; }

    [Range(1, int.MaxValue,
        ErrorMessage = "OutputUnitId يجب أن يكون أكبر من صفر.")]
    public int OutputUnitId { get; set; }

    [Range(1, int.MaxValue,
        ErrorMessage = "VersionNo يجب أن يكون أكبر من صفر.")]
    public int VersionNo { get; set; }

    [StringLength(1000,
        ErrorMessage = "Notes لا يمكن أن تتجاوز 1000 حرف.")]
    public string? Notes { get; set; }

    [Required(ErrorMessage = "Ingredients مطلوبة.")]
    [MinLength(1,
        ErrorMessage = "يجب إضافة مكوّن واحد على الأقل.")]
    public List<RecipeIngredientDto> Ingredients { get; set; } = [];
}