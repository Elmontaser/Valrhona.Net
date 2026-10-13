using Valrhona.API.Dtos.UnitConversions;
using Valrhona.API.Interfaces;

namespace Valrhona.API.Endpoints;

public static class UnitConversionEndpoint
{
    public static void MapUnitConversionEndpoint(
        this WebApplication app)
    {
        var group = app.MapGroup("/api/unitConversions");

        group.MapGet("/", async (
            IUnitConversionRepository repository) =>
        {
            var conversions = await repository.GetAllAsync();

            return Results.Ok(conversions);
        });

        group.MapGet("/{id:int:min(1)}", async (
            int id,
            IUnitConversionRepository repository) =>
        {
            var conversion = await repository.GetByIdAsync(id);

            return conversion is null
                ? Results.NotFound()
                : Results.Ok(conversion);
        });

        group.MapPost("/", async (
            CreateUnitConversionDto dto,
            IUnitConversionRepository repository) =>
        {
            var conversion = await repository.InsertAsync(dto);

            return conversion is null
                ? Results.BadRequest()
                : Results.Created(
                    $"/api/unitConversions/{conversion.UnitConversionId}",
                    conversion);
        });

        group.MapPut("/{id:int:min(1)}", async (
            int id,
            UpdateUnitConversionDto dto,
            IUnitConversionRepository repository) =>
        {
            dto.UnitConversionId = id;

            await repository.UpdateAsync(dto);

            return Results.NoContent();
        });

        group.MapPut("/{id:int:min(1)}/status", async (
            int id,
            bool isActive,
            IUnitConversionRepository repository) =>
        {
            await repository.SetActiveAsync(id, isActive);

            return Results.NoContent();
        });

        group.MapPost("/convert", async (
            ConvertUnitDto dto,
            IUnitConversionRepository repository) =>
        {
            var result =
                await repository.ConvertAsync(dto);

            return result is null
                ? Results.BadRequest()
                : Results.Ok(result);
        });
    }
}