using Valrhona.API.Dtos.UnitConversions;
using Valrhona.API.Models;

namespace Valrhona.API.Interfaces;

public interface IUnitConversionRepository
{
    Task<IEnumerable<UnitConversion>> GetAllAsync();
    Task<UnitConversion?> GetByIdAsync(int unitConversionId);
    Task<UnitConversion?> InsertAsync(CreateUnitConversionDto dto);
    Task UpdateAsync(UpdateUnitConversionDto dto);
    Task SetActiveAsync(int unitConversionId, bool isActive);
    Task<UnitConversionResult?> ConvertAsync(
        ConvertUnitDto dto);
}