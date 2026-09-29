using System.Data;
using Dapper;
using Valrhona.API.Data;
using Valrhona.API.Dtos.Units;
using Valrhona.API.Interfaces;
using Valrhona.API.Models;

namespace Valrhona.API.Repositories;

public class UnitRepository(SqlConnectionFactory connectionFactory)
    : IUnitRepository
{
    public async Task<IEnumerable<Unit>> GetAllAsync()
    {
        using var connection = connectionFactory.CreateConnection();

        return await connection.QueryAsync<Unit>(
            "dbo.Unit_GetAll",
            commandType: CommandType.StoredProcedure);
    }

    public async Task<Unit?> GetByIdAsync(int unitId)
    {
        using var connection = connectionFactory.CreateConnection();

        return await connection.QuerySingleOrDefaultAsync<Unit>(
            "dbo.Unit_GetById",
            new
            {
                UnitId = unitId
            },
            commandType: CommandType.StoredProcedure);
    }

    public async Task<Unit?> InsertAsync(CreateUnitDto dto)
    {
        using var connection = connectionFactory.CreateConnection();

        return await connection.QuerySingleOrDefaultAsync<Unit>(
            "dbo.Unit_Insert",
            dto,
            commandType: CommandType.StoredProcedure);
    }

    public async Task UpdateAsync(UpdateUnitDto dto)
    {
        using var connection = connectionFactory.CreateConnection();

        await connection.ExecuteAsync(
            "dbo.Unit_Update", dto,
            commandType: CommandType.StoredProcedure);
    }

    public async Task DeleteAsync(DeleteUnitDto dto)
    {
        using var connection = connectionFactory.CreateConnection();

        await connection.ExecuteAsync(
            "dbo.Unit_Delete",
            dto,
            commandType: CommandType.StoredProcedure);
    }
}