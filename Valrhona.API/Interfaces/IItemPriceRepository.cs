using Valrhona.API.Dtos.ItemPrices;
using Valrhona.API.Models;

namespace Valrhona.API.Interfaces;

public interface IItemPriceRepository
{
    Task<IEnumerable<ItemPrice>> GetAllAsync();
    Task<ItemPrice?> SetAsync(SetItemPriceDto dto);

    Task<IEnumerable<ItemPrice>> ActivateDuePricesAsync(ActivateDuePricesDto dto);
}