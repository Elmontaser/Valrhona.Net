using System.Data;
using Dapper;
using Valrhona.API.Data;
using Valrhona.API.Dtos.Items;
using Valrhona.API.Exceptions;
using Valrhona.API.Interfaces;
using Valrhona.API.Models;

namespace Valrhona.API.Repositories;

public class ItemRepository(SqlConnectionFactory connectionFactory)
    : IItemRepository
{
    public async Task<IEnumerable<Item>> GetAllAsync()
    {
        using var connection = connectionFactory.CreateConnection();

        return await connection.QueryAsync<Item>(
            "Item_GetAll",
            commandType: CommandType.StoredProcedure);
    }

    public async Task<Item?> GetByIdAsync(int itemId)
    {
        using var connection = connectionFactory.CreateConnection();

        return await connection.QuerySingleOrDefaultAsync<Item>(
            "Item_GetById",
            new
            {
                ItemId = itemId
            },
            commandType: CommandType.StoredProcedure);
    }

    public async Task<Item?> InsertAsync(CreateItemDto dto)
    {
        using var connection = connectionFactory.CreateConnection();

        // يرمي BusinessRuleException عند الفشل (كود مكرر، فئة غير فعالة...)
        var result = await connection.ExecuteForResultAsync(
            "Item_Insert",
            dto);

        if (result.ItemId is null)
        {
            throw new InvalidOperationException(
                "لم يُرجع Item_Insert معرّف الصنف.");
        }

        return await GetByIdAsync(result.ItemId.Value);
    }

    public async Task UpdateAsync(UpdateItemDto dto)
    {
        using var connection = connectionFactory.CreateConnection();

        await connection.ExecuteForResultAsync(
            "Item_Update",
            dto);
    }

    public async Task ActivateAsync(ActivateItemDto dto)
    {
        using var connection = connectionFactory.CreateConnection();

        await connection.ExecuteForResultAsync(
            "Item_Activate", dto);
    }

    public async Task<IEnumerable<Item>> SearchAsync(SearchItemDto dto)
    {
        using var connection = connectionFactory.CreateConnection();

        return await connection.QueryAsync<Item>(
            "Item_Search",
            dto,
            commandType: CommandType.StoredProcedure);
    }
}
