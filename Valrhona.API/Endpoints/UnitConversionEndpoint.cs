using Valrhona.API.Dtos.UnitConversions;
using Valrhona.API.Interfaces;

namespace Valrhona.API.Endpoints;

public static class UnitConversionEndpoint
{
    public static void MapUnitConversionEndpoint(
        this WebApplication app)
    {
        var group = app.MapGroup("/api/unit-conversions");

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