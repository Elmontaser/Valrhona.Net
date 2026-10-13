using System.Net.Http.Json;
using Valrhona.Client.Models.ItemPrices;

namespace Valrhona.Client.Services.ItemPrices;

public class ItemPriceService(HttpClient httpClient)
{
    public async Task<List<ItemPriceDto>> GetAllAsync()
    {
        var response = await httpClient.GetAsync("ItemPrices");

        return await response.ReadApiAsync<List<ItemPriceDto>>();
    }

    public async Task<ItemPriceDto> SetAsync(ItemPriceFormModel model)
    {
        var response = await httpClient.PostAsJsonAsync(
            "ItemPrices",
            new
            {
                model.ItemId,
                model.Price,
                model.UnitId,
                Currency = model.Currency.Trim().ToUpperInvariant(),
                model.EffectiveDate,
                model.Notes
            });

        return await response.ReadApiAsync<ItemPriceDto>();
    }

    public async Task<List<ItemPriceDto>> ActivateDuePricesAsync(DateTime asOfDate)
    {
        var response = await httpClient.PostAsJsonAsync(
            "ItemPrices/activate-due",
            new { AsOfDate = asOfDate.Date });

        return await response.ReadApiAsync<List<ItemPriceDto>>();
    }
}