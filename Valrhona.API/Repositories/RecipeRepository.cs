using System.Data;
using Dapper;
using Valrhona.API.Data;
using Valrhona.API.Dtos.Recipes;
using Valrhona.API.Interfaces;
using Valrhona.API.Models;

namespace Valrhona.API.Repositories;

public class RecipeRepository(SqlConnectionFactory connectionFactory) : IRecipeRepository
{
    public async Task<IEnumerable<Recipe>> GetAllAsync()
    {
        using var connection = connectionFactory.CreateConnection();

        return await connection.QueryAsync<Recipe>(
            "dbo.Recipe_GetAll",
            commandType: CommandType.StoredProcedure);
    }

    public async Task<Recipe?> GetByIdAsync(int recipeId)
    {
        using var connection = connectionFactory.CreateConnection();

        return await connection.QuerySingleOrDefaultAsync<Recipe>(
            "dbo.Recipe_GetById",
            new
            {
                RecipeId = recipeId
            },
            commandType: CommandType.StoredProcedure);
    }

    public async Task<IEnumerable<Recipe>> GetByIngredientAsync(
        int ingredientItemId)
    {
        using var connection = connectionFactory.CreateConnection();

        return await connection.QueryAsync<Recipe>(
            "dbo.Recipe_GetByIngredient",
            new
            {
                IngredientItemId = ingredientItemId
            },
            commandType: CommandType.StoredProcedure);
    }


    public async Task<Recipe?> InsertAsync(CreateRecipeDto dto)
    {
        using var connection = connectionFactory.CreateConnection();

        var parameters = new DynamicParameters();

        parameters.Add("@RecipeId", null, DbType.Int32);
        parameters.Add("@RecipeCode", dto.RecipeCode);
        parameters.Add("@Recipename", dto.RecipeName);
        parameters.Add("@OutputItemId", dto.OutputItemId);
        parameters.Add("@OutputQuantity", dto.OutputQuantity);
        parameters.Add("@OutputUnitId", dto.OutputUnitId);
        parameters.Add("@VersionNo", dto.VersionNo);
        parameters.Add("@Notes", dto.Notes);

        var ingredientsTable = CreateIngredientsTable(dto.Ingredients);

        parameters.Add(
            "@Ingredients",
            ingredientsTable.AsTableValuedParameter(
                "dbo.RecipeIngredientType"));

        using var multi = await connection.QueryMultipleAsync(
    "dbo.Recipe_Save",
    parameters,
    commandType: CommandType.StoredProcedure);

        dynamic? result = null;

        while (!multi.IsConsumed)
        {
            var rows = (await multi.ReadAsync()).ToList();

            if (rows.Count > 0)
            {
                var first = rows[0];

                if ((int?)first.ResultCode != null)
                {
                    result = first;
                }
            }
        }

        if (result is null)
        {
            throw new InvalidOperationException(
                "لم يتم استلام نتيجة من Recipe_Save.");
        }

        int resultCode = result.ResultCode;

        if (resultCode != 1)
        {
            throw new InvalidOperationException(
                (string)result.ResultMessage);
        }

        int recipeId = result.RecipeId;

        return await GetByIdAsync(recipeId);


    }
    public async Task<Recipe?> UpdateAsync(UpdateRecipeDto dto)
    {
        using var connection = connectionFactory.CreateConnection();

        var parameters = new DynamicParameters();

        parameters.Add("@RecipeId", dto.RecipeId);
        parameters.Add("@RecipeCode", dto.RecipeCode);
        parameters.Add("@Recipename", dto.RecipeName);
        parameters.Add("@OutputItemId", dto.OutputItemId);
        parameters.Add("@OutputQuantity", dto.OutputQuantity);
        parameters.Add("@OutputUnitId", dto.OutputUnitId);
        parameters.Add("@VersionNo", dto.VersionNo);
        parameters.Add("@Notes", dto.Notes);

        var ingredientsTable = CreateIngredientsTable(dto.Ingredients);

        parameters.Add(
            "@Ingredients",
            ingredientsTable.AsTableValuedParameter(
                "dbo.RecipeIngredientType"));

        using var multi = await connection.QueryMultipleAsync(
            "dbo.Recipe_Save",
            parameters,
            commandType: CommandType.StoredProcedure);

        dynamic? result = null;

        while (!multi.IsConsumed)
        {
            var rows = (await multi.ReadAsync()).ToList();

            if (rows.Count > 0)
            {
                var first = rows[0];

                if ((int?)first.ResultCode != null)
                {
                    result = first;
                }
            }
        }

        if (result is null)
        {
            throw new InvalidOperationException(
                "لم يتم استلام نتيجة من Recipe_Save.");
        }

        int resultCode = result.ResultCode;

        if (resultCode != 1)
        {
            throw new InvalidOperationException(
                (string)result.ResultMessage);
        }

        return await GetByIdAsync(dto.RecipeId);
    }

    public async Task<bool> DeactivateAsync(int recipeId)
    {
        using var connection = connectionFactory.CreateConnection();

        var result = await connection.QuerySingleAsync(
            "dbo.Recipe_Deactivate",
            new
            {
                RecipeId = recipeId
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

    private static DataTable CreateIngredientsTable(IEnumerable<RecipeIngredientDto> ingredients)
    {
        var table = new DataTable();

        table.Columns.Add("IngredientItemId", typeof(int));
        table.Columns.Add("Quantity", typeof(decimal));
        table.Columns.Add("UnitId", typeof(int));
        table.Columns.Add("SequenceNo", typeof(int));
        table.Columns.Add("WastePercent", typeof(decimal));
        table.Columns.Add("Notes", typeof(string));

        foreach (var ingredient in ingredients)
        {
            table.Rows.Add(
                ingredient.IngredientItemId,
                ingredient.Quantity,
                ingredient.UnitId,
                ingredient.SequenceNo,
                ingredient.WastePercent,
                ingredient.Notes ?? (object)DBNull.Value);
        }

        return table;
    }
}