using Valrhona.API.Dtos.ItemCosts;
using Valrhona.API.Models;

namespace Valrhona.API.Interfaces;

public interface IItemCostRepository
{
    Task<IEnumerable<ItemCost>> RecalculateAsync(RecalculateItemCostDto dto);
}