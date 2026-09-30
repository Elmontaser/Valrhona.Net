using System.Data;
using Dapper;
using Valrhona.API.Data;
using Valrhona.API.Dtos.UnitConversions;
using Valrhona.API.Interfaces;
using Valrhona.API.Models;

namespace Valrhona.API.Repositories;

public class UnitConversionRepository(SqlConnectionFactory connectionFactory) : IUnitConversionRepository
{
    public async Task<UnitConversionResult?> ConvertAsync(ConvertUnitDto dto)
    {
        using var connection = connectionFactory.CreateConnection();

        return await connection.QuerySingleOrDefaultAsync<UnitConversionResult>(
            "dbo.Unit_Convert", dto, commandType: CommandType.StoredProcedure);
    }
}