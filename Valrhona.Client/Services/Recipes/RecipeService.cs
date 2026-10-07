using System.Net.Http.Json;
using Valrhona.Client.Models.Recipes;

namespace Valrhona.Client.Services.Recipes;

public class RecipeService(HttpClient httpClient)
{
    public async Task<List<RecipeDto>> GetAllAsync()
    {
        var response = await httpClient.GetAsync("Recipes");
        return await response.ReadApiAsync<List<RecipeDto>>();
    }

    public async Task<RecipeDto> GetByIdAsync(int recipeId)
    {
        var response = await httpClient.GetAsync($"Recipes/{recipeId}");
        return await response.ReadApiAsync<RecipeDto>();
    }

    public async Task<List<RecipeIngredientDto>> GetIngredientsAsync(int recipeId)
    {
        var response = await httpClient.GetAsync($"RecipeDetails/{recipeId}");
        return await response.ReadApiAsync<List<RecipeIngredientDto>>();
    }

    public async Task CreateAsync(RecipeFormModel model)
    {
        var response = await httpClient.PostAsJsonAsync("Recipes", CreatePayload(model));
        await response.EnsureApiSuccessAsync();
    }

    public async Task UpdateAsync(RecipeFormModel model)
    {
        var response = await httpClient.PutAsJsonAsync(
            $"Recipes/{model.RecipeId}",
            new
            {
                model.RecipeId,
                model.RecipeCode,
                model.RecipeName,
                model.OutputItemId,
                model.OutputQuantity,
                model.OutputUnitId,
                model.VersionNo,
                model.Notes,
                Ingredients = CreateIngredientsPayload(model)
            });
        await response.EnsureApiSuccessAsync();
    }

    public async Task DeactivateAsync(int recipeId)
    {
        var response = await httpClient.DeleteAsync($"Recipes/{recipeId}");
        await response.EnsureApiSuccessAsync();
    }

    private static object CreatePayload(RecipeFormModel model) => new
    {
        model.RecipeCode,
        model.RecipeName,
        model.OutputItemId,
        model.OutputQuantity,
        model.OutputUnitId,
        model.VersionNo,
        model.Notes,
        Ingredients = CreateIngredientsPayload(model)
    };

    private static IEnumerable<object> CreateIngredientsPayload(RecipeFormModel model) =>
        model.Ingredients.Select((ingredient, index) => new
        {
            ingredient.IngredientItemId,
            ingredient.Quantity,
            ingredient.UnitId,
            SequenceNo = index + 1,
            ingredient.WastePercent,
            ingredient.Notes
        });
}
