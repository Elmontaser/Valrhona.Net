using System.Data;
using Dapper;
using Valrhona.API.Data;
using Valrhona.API.Dtos.ItemTypes;
using Valrhona.API.Interfaces;
using Valrhona.API.Models;

namespace Valrhona.API.Repositories;

public class ItemTypeRepository(SqlConnectionFactory connectionFactory) : IItemTypeRepository
{
    public async Task<IEnumerable<ItemType>> GetAllAsync()
    {
        using var connection = connectionFactory.CreateConnection();

        return await connection.QueryAsync<ItemType>(
            "dbo.ItemType_GetAll",
            commandType: CommandType.StoredProcedure);
    }

    public async Task<ItemType?> GetByIdAsync(byte itemTypeId)
    {
        using var connection = connectionFactory.CreateConnection();

        return await connection.QuerySingleOrDefaultAsync<ItemType>(
            "dbo.ItemType_GetById",
            new
            {
                ItemTypeId = itemTypeId
            },
            commandType: CommandType.StoredProcedure);
    }

    public async Task<ItemType?> InsertAsync(ItemTypeDto dto)
    {
        using var connection = connectionFactory.CreateConnection();

        return await connection.QuerySingleOrDefaultAsync<ItemType>(
            "dbo.ItemType_Insert",
             new
             {
                 dto.TypeName
             },
            commandType: CommandType.StoredProcedure);
    }

    public async Task UpdateAsync(ItemTypeDto dto)
    {
        using var connection = connectionFactory.CreateConnection();

        await connection.ExecuteAsync(
            "dbo.ItemType_Update",
            dto,
            commandType: CommandType.StoredProcedure);
    }

    public async Task DeleteAsync(ItemTypeDto dto)
    {
        using var connection = connectionFactory.CreateConnection();

        await connection.ExecuteAsync(
            "dbo.ItemType_Delete",
            new
            {
                dto.ItemTypeId
            },
            commandType: CommandType.StoredProcedure);
    }
}