using System.ComponentModel.DataAnnotations;

namespace Valrhona.API.Dtos.Recipes;

public class RecipeIngredientDto
{
    [Range(1, int.MaxValue,
        ErrorMessage = "IngredientItemId يجب أن يكون أكبر من صفر.")]
    public int IngredientItemId { get; set; }

    [Range(typeof(decimal), "0.0001",
        "79228162514264337593543950335",
        ErrorMessage = "Quantity يجب أن تكون أكبر من صفر.")]
    public decimal Quantity { get; set; }

    [Range(1, int.MaxValue,
        ErrorMessage = "UnitId يجب أن يكون أكبر من صفر.")]
    public int UnitId { get; set; }

    [Range(1, int.MaxValue,
        ErrorMessage = "SequenceNo يجب أن يكون أكبر من صفر.")]
    public int SequenceNo { get; set; }

    [Range(typeof(decimal), "0", "100",
        ErrorMessage = "WastePercent يجب أن تكون بين 0 و100.")]
    public decimal WastePercent { get; set; }

    [StringLength(500,
        ErrorMessage = "Notes لا يمكن أن تتجاوز 500 حرف.")]
    public string? Notes { get; set; }
}