using Valrhona.API.Dtos.RecipeDetails;
using Valrhona.API.Models;

namespace Valrhona.API.Interfaces;

public interface IRecipeDetailRepository
{
    Task<IEnumerable<RecipeDetail>> GetByRecipeIdAsync(int recipeId);

    Task<long?> InsertAsync(CreateRecipeDetailDto dto);

    Task<bool> UpdateAsync(UpdateRecipeDetailDto dto);

    Task<bool> DeleteAsync(long recipeDetailId);
}