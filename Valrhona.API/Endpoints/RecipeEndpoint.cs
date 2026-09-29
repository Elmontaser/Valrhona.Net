using Valrhona.API.Dtos.Recipes;
using Valrhona.API.Interfaces;

namespace Valrhona.API.Endpoints;

public static class RecipeEndpoint
{
    public static void MapRecipeEndpoint(this WebApplication app)
    {
        var group = app.MapGroup("/api/recipes");

        group.MapGet("/", async (IRecipeRepository repository) =>
        {
            var recipes = await repository.GetAllAsync();

            return Results.Ok(recipes);
        });

        group.MapGet("/{id:int}", async (
            int id,
            IRecipeRepository repository) =>
        {
            var recipe = await repository.GetByIdAsync(id);

            return recipe is null
                ? Results.NotFound()
                : Results.Ok(recipe);
        });

        group.MapPost("/", async (
            CreateRecipeDto dto,
            IRecipeRepository repository) =>
        {
            var recipe = await repository.InsertAsync(dto);

            return recipe is null
                ? Results.BadRequest()
                : Results.Created(
                    $"/api/recipes/{recipe.RecipeId}",
                    recipe);
        });

        group.MapGet("/by-ingredient/{ingredientItemId:int}",
            async (
                int ingredientItemId,
                IRecipeRepository repository) =>
            {
                var recipes =
                    await repository.GetByIngredientAsync(
                        ingredientItemId);

                return Results.Ok(recipes);
            });

        group.MapPut("/{id:int}", async (
int id,
UpdateRecipeDto dto,
IRecipeRepository repository) =>
{
    dto.RecipeId = id;

    var recipe = await repository.UpdateAsync(dto);

    return recipe is null
        ? Results.NotFound()
        : Results.Ok(recipe);
});

        group.MapDelete("/{id:int}", async (
            int id,
            IRecipeRepository repository) =>
        {
            await repository.DeactivateAsync(id);

            return Results.NoContent();
        });
    }
}