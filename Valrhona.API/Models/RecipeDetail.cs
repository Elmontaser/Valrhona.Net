namespace Valrhona.API.Models;

public class RecipeDetail
{
    public long RecipeDetailId { get; set; }

    public int RecipeId { get; set; }

    public int IngredientItemId { get; set; }

    public string ItemCode { get; set; } = string.Empty;

    public string ItemName { get; set; } = string.Empty;

    public decimal Quantity { get; set; }

    public int UnitId { get; set; }

    public string UnitName { get; set; } = string.Empty;

    public string? Symbol { get; set; }

    public int SequenceNo { get; set; }

    public decimal WastePercent { get; set; }

    public string? Notes { get; set; }
}