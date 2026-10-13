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
            "Unit_GetAll",
            commandType: CommandType.StoredProcedure);
    }

    public async Task<Unit?> GetByIdAsync(int unitId)
    {
        using var connection = connectionFactory.CreateConnection();

        return await connection.QuerySingleOrDefaultAsync<Unit>(
            "Unit_GetById",
            new
            {
                UnitId = unitId
            },
            commandType: CommandType.StoredProcedure);
    }

    // Unit_Insert يعتمد على THROW (يصل للمستخدم كـ 400 برسالة عربية)
    public async Task<Unit?> InsertAsync(CreateUnitDto dto)
    {
        using var connection = connectionFactory.CreateConnection();

        return await connection.QuerySingleOrDefaultAsync<Unit>(
            "Unit_Insert",
            dto,
            commandType: CommandType.StoredProcedure);
    }

    public async Task UpdateAsync(UpdateUnitDto dto)
    {
        using var connection = connectionFactory.CreateConnection();

        await connection.ExecuteForResultAsync(
            "Unit_Update",
            dto);
    }

    public async Task DeleteAsync(DeleteUnitDto dto)
    {
        using var connection = connectionFactory.CreateConnection();

        await connection.ExecuteForResultAsync(
            "Unit_Delete",
            dto);
    }
}
