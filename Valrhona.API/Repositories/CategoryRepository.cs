using System.Data;
using Dapper;
using Valrhona.API.Data;
using Valrhona.API.Dtos.Categories;
using Valrhona.API.Interfaces;
using Valrhona.API.Models;

namespace Valrhona.API.Repositories;

public class CategoryRepository(
    SqlConnectionFactory connectionFactory) : ICategoryRepository
{
    public async Task<IEnumerable<Category>> GetAllAsync()
    {
        using var connection = connectionFactory.CreateConnection();

        return await connection.QueryAsync<Category>(
            "dbo.Category_GetAll",
            commandType: CommandType.StoredProcedure);
    }

    public async Task<Category?> GetByIdAsync(int categoryId)
    {
        using var connection = connectionFactory.CreateConnection();

        return await connection.QuerySingleOrDefaultAsync<Category>(
            "dbo.Category_GetById",
            new { CategoryId = categoryId },
            commandType: CommandType.StoredProcedure);
    }

    public async Task InsertAsync(CreateCategoryDto dto)
    {
        using var connection = connectionFactory.CreateConnection();

        await connection.ExecuteAsync(
            "dbo.Category_Insert",
            dto,
            commandType: CommandType.StoredProcedure);
    }

    public async Task UpdateAsync(UpdateCategoryDto dto)
    {
        using var connection = connectionFactory.CreateConnection();

        await connection.ExecuteAsync(
            "dbo.Category_Update",
            dto,
            commandType: CommandType.StoredProcedure);
    }

    public async Task DeleteAsync(DeleteCategoryDto dto)
    {
        using var connection = connectionFactory.CreateConnection();

        await connection.ExecuteAsync(
            "dbo.Category_Delete",
            dto,
            commandType: CommandType.StoredProcedure);
    }
}