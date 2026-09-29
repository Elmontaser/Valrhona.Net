using Valrhona.API.Dtos.Units;
using Valrhona.API.Interfaces;

namespace Valrhona.API.Endpoints;

public static class UnitEndpoint
{
    public static void MapUnitEndpoint(this WebApplication app)
    {
        var group = app.MapGroup("/api/units");

        group.MapGet("/", async (IUnitRepository repository) =>
        {
            var units = await repository.GetAllAsync();

            return Results.Ok(units);
        });

        group.MapGet("/{id:int}", async (
            int id, IUnitRepository repository) =>
        {
            var unit = await repository.GetByIdAsync(id);

            return unit is null
                ? Results.NotFound()
                : Results.Ok(unit);
        });

        group.MapPost("/", async (
           CreateUnitDto dto, IUnitRepository repository) =>
        {
            var unit = await repository.InsertAsync(dto);

            return unit is null
                ? Results.BadRequest()
                : Results.Created($"/api/units/{unit.UnitId}", unit);
        });

        group.MapPut("/{id:int}", async (
            int id, UpdateUnitDto dto,
            IUnitRepository repository) =>
        {
            dto.UnitId = id;

            await repository.UpdateAsync(dto);

            return Results.NoContent();
        });

        group.MapDelete("/{id:int}", async (
            int id,
            IUnitRepository repository) =>
        {
            var dto = new DeleteUnitDto
            {
                UnitId = id
            };

            await repository.DeleteAsync(dto);

            return Results.NoContent();
        });
    }
}