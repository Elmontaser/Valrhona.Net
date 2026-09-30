using System.Data;
using Dapper;
using Valrhona.API.Data;
using Valrhona.API.Dtos.ItemCosts;
using Valrhona.API.Interfaces;
using Valrhona.API.Models;

namespace Valrhona.API.Repositories;

public class ItemCostRepository(SqlConnectionFactory connectionFactory) : IItemCostRepository
{
    public async Task<IEnumerable<ItemCost>> RecalculateAsync(RecalculateItemCostDto dto)
    {
        using var connection = connectionFactory.CreateConnection();

        return await connection.QueryAsync<ItemCost>("ItemCost_RecalculateFromItem", dto, commandType: CommandType.StoredProcedure);
    }
}