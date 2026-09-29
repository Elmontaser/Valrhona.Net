using Valrhona.API.Dtos.Items;
using Valrhona.API.Models;

namespace Valrhona.API.Interfaces;

public interface IItemRepository
{
    Task<IEnumerable<Item>> GetAllAsync();
    Task<Item?> GetByIdAsync(int itemId);
    Task<Item?> InsertAsync(CreateItemDto dto);
    Task UpdateAsync(UpdateItemDto dto);
    Task DeleteAsync(DeleteItemDto dto);
    Task<IEnumerable<Item>> SearchAsync(SearchItemDto dto);

}