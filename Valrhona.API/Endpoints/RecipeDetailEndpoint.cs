using Valrhona.API.Dtos.RecipeDetails;
using Valrhona.API.Interfaces;

namespace Valrhona.API.Endpoints;

public static class RecipeDetailEndpoint
{
    public static void MapRecipeDetailEndpoint(
        this WebApplication app)
    {
        var group = app.MapGroup("/api/recipe-details");

        group.MapGet("/{recipeId:int:min(1)}", async (
            int recipeId,
            IRecipeDetailRepository repository) =>
        {
            var details =
                await repository.GetByRecipeIdAsync(recipeId);

            return Results.Ok(details);
        });

        group.MapPost("/", async (
            CreateRecipeDetailDto dto,
            IRecipeDetailRepository repository) =>
        {
            var recipeDetailId =
                await repository.InsertAsync(dto);

            return recipeDetailId is null
                ? Results.BadRequest()
                : Results.Created(
                    $"/api/recipe-details/{recipeDetailId}",
                    new
                    {
                        RecipeDetailId = recipeDetailId
                    });
        });

        group.MapPut("/{id:long:min(1)}", async (
            long id,
            UpdateRecipeDetailDto dto,
            IRecipeDetailRepository repository) =>
        {
            dto.RecipeDetailId = id;

            await repository.UpdateAsync(dto);

            return Results.NoContent();
        });

        group.MapDelete("/{id:long:min(1)}", async (
            long id,
            IRecipeDetailRepository repository) =>
        {
            await repository.DeleteAsync(id);

            return Results.NoContent();
        });
    }
}