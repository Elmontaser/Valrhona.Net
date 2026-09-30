using Valrhona.API.Dtos.ItemTypes;
using Valrhona.API.Interfaces;

namespace Valrhona.API.Endpoints;

public static class ItemTypeEndpoint
{
    public static void MapItemTypeEndpoint(
        this WebApplication app)
    {
        var group = app.MapGroup("/api/item-types");

        group.MapGet("/", async (
            IItemTypeRepository repository) =>
        {
            var itemTypes = await repository.GetAllAsync();

            return Results.Ok(itemTypes);
        });

        group.MapGet("/{id:int:min(1):max(255)}", async (
            int id,
            IItemTypeRepository repository) =>
        {
            var itemType = await repository.GetByIdAsync((byte)id);

            return itemType is null
                ? Results.NotFound()
                : Results.Ok(itemType);
        });

        group.MapPost("/", async (
            ItemTypeDto dto,
            IItemTypeRepository repository) =>
        {
            var itemType = await repository.InsertAsync(dto);

            return itemType is null
                ? Results.BadRequest()
                : Results.Created(
                    $"/api/item-types/{itemType.ItemTypeId}",
                    itemType);
        });

        group.MapPut("/{id:int:min(1):max(255)}", async (
            int id,
            ItemTypeDto dto,
            IItemTypeRepository repository) =>
        {
            dto.ItemTypeId = (byte)id;

            await repository.UpdateAsync(dto);

            return Results.NoContent();
        });

        group.MapDelete("/{id:int:min(1):max(255)}", async (
            int id,
            IItemTypeRepository repository) =>
        {
            var dto = new ItemTypeDto
            {
                ItemTypeId = (byte)id
            };

            await repository.DeleteAsync(dto);

            return Results.NoContent();
        });
    }
}