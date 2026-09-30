using Valrhona.API.Dtos.ItemCosts;
using Valrhona.API.Interfaces;

namespace Valrhona.API.Endpoints;

public static class ItemCostEndpoint
{
    public static void MapItemCostEndpoint(
        this WebApplication app)
    {
        var group = app.MapGroup("/api/item-costs");

        group.MapPost("/recalculate", async (
            RecalculateItemCostDto dto,
            IItemCostRepository repository) =>
        {
            var costs =
                await repository.RecalculateAsync(dto);

            return Results.Ok(costs);
        });
    }
}