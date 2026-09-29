using System.Data;
using Dapper;
using Valrhona.API.Data;
using Valrhona.API.Dtos.Items;
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
            "dbo.Item_GetAll",
            commandType: CommandType.StoredProcedure);
    }

    public async Task<Item?> GetByIdAsync(int itemId)
    {
        using var connection = connectionFactory.CreateConnection();

        return await connection.QuerySingleOrDefaultAsync<Item>(
            "dbo.Item_GetById",
            new
            {
                ItemId = itemId
            },
            commandType: CommandType.StoredProcedure);
    }

    public async Task<Item?> InsertAsync(CreateItemDto dto)
    {
        using var connection = connectionFactory.CreateConnection();

        return await connection.QuerySingleOrDefaultAsync<Item>(
            "dbo.Item_Insert",
            dto,
            commandType: CommandType.StoredProcedure);
    }

    public async Task UpdateAsync(UpdateItemDto dto)
    {
        using var connection = connectionFactory.CreateConnection();

        await connection.ExecuteAsync(
            "dbo.Item_Update",
            dto, commandType: CommandType.StoredProcedure);
    }

    public async Task DeleteAsync(DeleteItemDto dto)
    {
        using var connection = connectionFactory.CreateConnection();

        await connection.ExecuteAsync(
            "dbo.Item_Delete",
            dto,
            commandType: CommandType.StoredProcedure);
    }

    public async Task<IEnumerable<Item>> SearchAsync(SearchItemDto dto)
    {
        using var connection = connectionFactory.CreateConnection();

        return await connection.QueryAsync<Item>(
            "dbo.Item_Search",
            dto,
            commandType: CommandType.StoredProcedure);
    }
}