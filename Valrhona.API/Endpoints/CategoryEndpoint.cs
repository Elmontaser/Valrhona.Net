using Valrhona.API.Dtos.Categories;
using Valrhona.API.Interfaces;

namespace Valrhona.API.Endpoints;

public static class CategoryEndpoint
{
    public static void MapCategoryEndpoint(this WebApplication app)
    {
        var group = app.MapGroup("/api/categories");

        group.MapGet("/", async (
            ICategoryRepository repository) =>
        {
            var categories = await repository.GetAllAsync();

            return Results.Ok(categories);
        });

        group.MapGet("/{id:int}", async (
            int id,
            ICategoryRepository repository) =>
        {
            var category = await repository.GetByIdAsync(id);

            return category is null
                ? Results.NotFound()
                : Results.Ok(category);
        });

        group.MapPost("/", async (
            CreateCategoryDto dto,
            ICategoryRepository repository) =>
        {
            await repository.InsertAsync(dto);

            return Results.NoContent();
        });

        group.MapPut("/{id:int}", async (
            int id,
            UpdateCategoryDto dto,
            ICategoryRepository repository) =>
        {
            dto.CategoryId = id;

            await repository.UpdateAsync(dto);

            return Results.NoContent();
        });

        group.MapDelete("/{id:int}", async (
            int id,
            ICategoryRepository repository) =>
        {
            var dto = new DeleteCategoryDto
            {
                CategoryId = id
            };

            await repository.DeleteAsync(dto);

            return Results.NoContent();
        });
    }
}