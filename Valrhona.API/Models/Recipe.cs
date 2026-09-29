namespace Valrhona.API.Models;

public class Recipe
{
    public int RecipeId { get; set; }

    public string RecipeCode { get; set; } = string.Empty;

    public string RecipeName { get; set; } = string.Empty;

    public int OutputItemId { get; set; }

    public decimal OutputQuantity { get; set; }

    public int OutputUnitId { get; set; }

    public int VersionNo { get; set; }

    public bool IsActive { get; set; }

    public string? Notes { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }

    public decimal? ActualOutputQuantity { get; set; }

    public decimal? BatchInputQuantity { get; set; }
}