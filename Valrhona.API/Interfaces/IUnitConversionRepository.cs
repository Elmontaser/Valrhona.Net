using Valrhona.API.Dtos.UnitConversions;
using Valrhona.API.Models;

namespace Valrhona.API.Interfaces;

public interface IUnitConversionRepository
{
    Task<UnitConversionResult?> ConvertAsync(
        ConvertUnitDto dto);
}