namespace Valrhona.API.Dtos.Recipes;

public class UpdateRecipeDto
{
    public int RecipeId { get; set; }

    public string RecipeCode { get; set; } = string.Empty;

    public string RecipeName { get; set; } = string.Empty;

    public int OutputItemId { get; set; }

    public decimal OutputQuantity { get; set; }

    public int OutputUnitId { get; set; }

    public int VersionNo { get; set; }

    public string? Notes { get; set; }

    public List<RecipeIngredientDto> Ingredients { get; set; } = [];
}