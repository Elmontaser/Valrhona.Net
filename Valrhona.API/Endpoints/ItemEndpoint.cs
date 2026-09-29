using Valrhona.API.Dtos.Items;
using Valrhona.API.Interfaces;

namespace Valrhona.API.Endpoints;

public static class ItemEndpoint
{
    public static void MapItemEndpoint(this WebApplication app)
    {
        var group = app.MapGroup("/api/items");

        group.MapGet("/", async (IItemRepository repository) =>
        {
            var items = await repository.GetAllAsync();

            return Results.Ok(items);
        });

        group.MapGet("/{id:int}", async (
            int id,
            IItemRepository repository) =>
        {
            var item = await repository.GetByIdAsync(id);

            return item is null
                ? Results.NotFound()
                : Results.Ok(item);
        });

        group.MapPost("/", async (
            CreateItemDto dto,
            IItemRepository repository) =>
        {
            var item = await repository.InsertAsync(dto);

            return item is null
                ? Results.BadRequest()
                : Results.Created($"/api/items/{item.ItemId}", item);
        });

        group.MapPut("/{id:int}", async (
            int id, UpdateItemDto dto,
            IItemRepository repository) =>
        {
            dto.ItemId = id;

            await repository.UpdateAsync(dto);

            return Results.NoContent();
        });

        group.MapDelete("/{id:int}", async (
            int id,
            IItemRepository repository) =>
        {
            var dto = new DeleteItemDto
            {
                ItemId = id
            };

            await repository.DeleteAsync(dto);

            return Results.NoContent();
        });

        group.MapGet("/search", async ([AsParameters] SearchItemDto dto,
            IItemRepository repository) =>
        {
            var items = await repository.SearchAsync(dto);

            return Results.Ok(items);
        });
    }


}