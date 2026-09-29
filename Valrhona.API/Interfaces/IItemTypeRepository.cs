using Valrhona.API.Dtos.ItemTypes;
using Valrhona.API.Models;

namespace Valrhona.API.Interfaces;

public interface IItemTypeRepository
{
    Task<IEnumerable<ItemType>> GetAllAsync();

    Task<ItemType?> GetByIdAsync(byte itemTypeId);

    Task<ItemType?> InsertAsync(ItemTypeDto dto);

    Task UpdateAsync(ItemTypeDto dto);

    Task DeleteAsync(ItemTypeDto dto);
}