namespace Valrhona.API.Dtos.Recipes;

public class RecipeIngredientDto
{
    public int IngredientItemId { get; set; }

    public decimal Quantity { get; set; }

    public int UnitId { get; set; }

    public int SequenceNo { get; set; }

    public decimal WastePercent { get; set; }

    public string? Notes { get; set; }
}