using System.Data;
using Dapper;
using Valrhona.API.Data;
using Valrhona.API.Dtos.ItemPrices;
using Valrhona.API.Interfaces;
using Valrhona.API.Models;

namespace Valrhona.API.Repositories;

public class ItemPriceRepository(
    SqlConnectionFactory connectionFactory)
    : IItemPriceRepository
{
    public async Task<ItemPrice?> SetAsync(SetItemPriceDto dto)
    {
        using var connection = connectionFactory.CreateConnection();

        using var multi = await connection.QueryMultipleAsync("dbo.ItemPrice_Set", dto, commandType: CommandType.StoredProcedure);

        ItemPrice? result = null;

        while (!multi.IsConsumed)
        {
            var rows = (await multi.ReadAsync<ItemPrice>()).ToList();

            if (rows.Count == 0)
                continue;

            var first = rows[0];

            // نبحث عن نتيجة ItemPrice الفعلية
            if (first.ItemPriceId > 0)
            {
                result = first;
            }
        }

        return result;
    }

    public async Task<IEnumerable<ItemPrice>> ActivateDuePricesAsync(ActivateDuePricesDto dto)
    {
        using var connection = connectionFactory.CreateConnection();

        return await connection.QueryAsync<ItemPrice>("dbo.ItemPrice_ActivateDuePrices", dto, commandType: CommandType.StoredProcedure);
    }
}