using Valrhona.API.Dtos.ItemPrices;
using Valrhona.API.Interfaces;

namespace Valrhona.API.Endpoints;

public static class ItemPriceEndpoint
{
    public static void MapItemPriceEndpoint(
        this WebApplication app)
    {
        var group = app.MapGroup("/api/item-prices");

        group.MapPost("/", async (
            SetItemPriceDto dto,
            IItemPriceRepository repository) =>
        {
            var itemPrice =
                await repository.SetAsync(dto);

            return itemPrice is null
                ? Results.BadRequest()
                : Results.Created(
                    $"/api/item-prices/{itemPrice.ItemPriceId}",
                    itemPrice);
        });

        group.MapPost("/activate-due", async (
            ActivateDuePricesDto dto,
            IItemPriceRepository repository) =>
        {
            var prices =
                await repository.ActivateDuePricesAsync(dto);

            return Results.Ok(prices);
        });
    }
}