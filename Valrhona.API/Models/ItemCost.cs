namespace Valrhona.API.Models;

public class ItemCost
{
    public int RecipeId { get; set; }

    public string RecipeCode { get; set; } = string.Empty;

    public int ItemId { get; set; }

    public string ItemCode { get; set; } = string.Empty;

    public string ItemName { get; set; } = string.Empty;

    public decimal ActualOutputQuantity { get; set; }

    public decimal CostPerUnit { get; set; }

    public string Currency { get; set; } = string.Empty;

    public DateTime CostDate { get; set; }
}