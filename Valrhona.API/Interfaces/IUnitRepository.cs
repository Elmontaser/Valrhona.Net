using Valrhona.API.Dtos.Units;
using Valrhona.API.Models;



namespace Valrhona.API.Interfaces;

public interface IUnitRepository
{
    Task<IEnumerable<Unit>> GetAllAsync();
    Task<Unit?> GetByIdAsync(int unitId);
    Task<Unit?> InsertAsync(CreateUnitDto dto);
    Task UpdateAsync(UpdateUnitDto dto);
    Task DeleteAsync(DeleteUnitDto dto);
}