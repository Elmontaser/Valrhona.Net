using System.Net.Http.Json;
using Valrhona.Client.Models.UnitConversions;

namespace Valrhona.Client.Services.UnitConversions;

public class UnitConversionService(HttpClient httpClient)
{
    public async Task<List<UnitConversionDto>> GetAllAsync()
    {
        var response = await httpClient.GetAsync("UnitConversions");

        return await response.ReadApiAsync<List<UnitConversionDto>>();
    }

    public async Task CreateAsync(UnitConversionFormModel model)
    {
        var response = await httpClient.PostAsJsonAsync(
            "UnitConversions",
            new
            {
                model.FromUnitId,
                model.ToUnitId,
                model.ConversionFactor,
                model.Notes
            });

        await response.EnsureApiSuccessAsync();
    }

    public async Task UpdateAsync(UnitConversionFormModel model)
    {
        var response = await httpClient.PutAsJsonAsync(
            $"UnitConversions/{model.UnitConversionId}",
            new
            {
                model.FromUnitId,
                model.ToUnitId,
                model.ConversionFactor,
                model.Notes
            });

        await response.EnsureApiSuccessAsync();
    }

    public async Task SetActiveAsync(int unitConversionId, bool isActive)
    {
        var response = await httpClient.PutAsync(
            $"UnitConversions/{unitConversionId}/status?isActive={isActive.ToString().ToLowerInvariant()}",
            content: null);

        await response.EnsureApiSuccessAsync();
    }
}