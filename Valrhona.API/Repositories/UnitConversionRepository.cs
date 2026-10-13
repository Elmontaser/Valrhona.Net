using System.Data;
using Dapper;
using Valrhona.API.Data;
using Valrhona.API.Dtos.UnitConversions;
using Valrhona.API.Interfaces;
using Valrhona.API.Models;

namespace Valrhona.API.Repositories;

public class UnitConversionRepository(SqlConnectionFactory connectionFactory) : IUnitConversionRepository
{
    public async Task<IEnumerable<UnitConversion>> GetAllAsync()
    {
        using var connection = connectionFactory.CreateConnection();

        return await connection.QueryAsync<UnitConversion>(
            "UnitConversion_GetAll",
            commandType: CommandType.StoredProcedure);
    }

    public async Task<UnitConversion?> GetByIdAsync(int unitConversionId)
    {
        using var connection = connectionFactory.CreateConnection();

        return await connection.QuerySingleOrDefaultAsync<UnitConversion>(
            "UnitConversion_GetById",
            new { UnitConversionId = unitConversionId },
            commandType: CommandType.StoredProcedure);
    }

    public async Task<UnitConversion?> InsertAsync(CreateUnitConversionDto dto)
    {
        using var connection = connectionFactory.CreateConnection();
        var result = await connection.ExecuteForResultAsync(
            "UnitConversion_Insert",
            dto);

        if (result.UnitConversionId is null)
        {
            throw new InvalidOperationException(
                "لم يُرجع UnitConversion_Insert معرّف التحويل.");
        }

        return await GetByIdAsync(result.UnitConversionId.Value);
    }

    public async Task UpdateAsync(UpdateUnitConversionDto dto)
    {
        using var connection = connectionFactory.CreateConnection();

        await connection.ExecuteForResultAsync(
            "UnitConversion_Update",
            dto);
    }

    public async Task SetActiveAsync(int unitConversionId, bool isActive)
    {
        using var connection = connectionFactory.CreateConnection();

        await connection.ExecuteForResultAsync(
            "UnitConversion_SetActive",
            new { UnitConversionId = unitConversionId, IsActive = isActive });
    }

    public async Task<UnitConversionResult?> ConvertAsync(ConvertUnitDto dto)
    {
        using var connection = connectionFactory.CreateConnection();

        return await connection.QuerySingleOrDefaultAsync<UnitConversionResult>(
            "Unit_Convert", dto, commandType: CommandType.StoredProcedure);
    }
}