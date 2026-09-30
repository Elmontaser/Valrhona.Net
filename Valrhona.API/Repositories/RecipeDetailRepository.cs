using System.Data;
using Dapper;
using Valrhona.API.Data;
using Valrhona.API.Dtos.RecipeDetails;
using Valrhona.API.Interfaces;
using Valrhona.API.Models;

namespace Valrhona.API.Repositories;

public class RecipeDetailRepository(
    SqlConnectionFactory connectionFactory) : IRecipeDetailRepository
{
    public async Task<IEnumerable<RecipeDetail>> GetByRecipeIdAsync(int recipeId)
    {
        using var connection = connectionFactory.CreateConnection();

        return await connection.QueryAsync<RecipeDetail>("dbo.RecipeDetail_GetByRecipeId",
            new
            {
                RecipeId = recipeId
            },
            commandType: CommandType.StoredProcedure);
    }

    public async Task<long?> InsertAsync(CreateRecipeDetailDto dto)
    {
        using var connection = connectionFactory.CreateConnection();

        var result = await connection.QuerySingleOrDefaultAsync<long>(
            "dbo.RecipeDetail_Insert", dto, commandType: CommandType.StoredProcedure);

        return result;
    }

    public async Task<bool> UpdateAsync(UpdateRecipeDetailDto dto)
    {
        using var connection = connectionFactory.CreateConnection();

        var result = await connection.QuerySingleAsync(
            "dbo.RecipeDetail_Update", dto, commandType: CommandType.StoredProcedure);

        int resultCode = result.ResultCode;

        if (resultCode != 1)
        {
            throw new InvalidOperationException(
                (string)result.ResultMessage);
        }

        return true;
    }

    public async Task<bool> DeleteAsync(long recipeDetailId)
    {
        using var connection = connectionFactory.CreateConnection();

        var result = await connection.QuerySingleAsync(
            "dbo.RecipeDetail_Delete",
            new
            {
                RecipeDetailId = recipeDetailId
            },
            commandType: CommandType.StoredProcedure);

        int resultCode = result.ResultCode;

        if (resultCode != 1)
        {
            throw new InvalidOperationException(
                (string)result.ResultMessage);
        }

        return true;
    }
}