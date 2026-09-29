using Valrhona.API.Dtos.Recipes;
using Valrhona.API.Models;

namespace Valrhona.API.Interfaces;

public interface IRecipeRepository
{
    Task<IEnumerable<Recipe>> GetAllAsync();

    Task<Recipe?> GetByIdAsync(int recipeId);

    Task<Recipe?> InsertAsync(CreateRecipeDto dto);

    Task<Recipe?> UpdateAsync(UpdateRecipeDto dto);

    Task<IEnumerable<Recipe>> GetByIngredientAsync(int ingredientItemId);

    Task<bool> DeactivateAsync(int recipeId);
}