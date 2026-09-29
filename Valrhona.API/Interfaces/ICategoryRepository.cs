using Valrhona.API.Dtos.Categories;
using Valrhona.API.Models;

namespace Valrhona.API.Interfaces;

public interface ICategoryRepository
{
    Task<IEnumerable<Category>> GetAllAsync();
    Task<Category?> GetByIdAsync(int categoryId);
    Task InsertAsync(CreateCategoryDto dto);
    Task UpdateAsync(UpdateCategoryDto dto);
    Task DeleteAsync(DeleteCategoryDto dto);
}