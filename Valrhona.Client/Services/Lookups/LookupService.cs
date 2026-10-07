using System.Net.Http.Json;
using Valrhona.Client.Models.Lookups;

namespace Valrhona.Client.Services.Lookups;

public class LookupService
{
    private readonly HttpClient _httpClient;

    public LookupService(HttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    // Units و ItemTypes يرجعان الفعّال فقط من الإجراءات المخزنة
    public async Task<List<UnitDto>> GetUnitsAsync()
    {
        var response = await _httpClient.GetAsync("Units");

        return await response.ReadApiAsync<List<UnitDto>>();
    }

    public async Task<List<ItemTypeDto>> GetItemTypesAsync()
    {
        var response = await _httpClient.GetAsync("itemTypes");

        return await response.ReadApiAsync<List<ItemTypeDto>>();
    }

    // Category_GetAll يرجع الفعّال وغير الفعّال معاً، والتصفية في الصفحة
    public async Task<List<CategoryDto>> GetCategoriesAsync()
    {
        var response = await _httpClient.GetAsync("Categories");

        return await response.ReadApiAsync<List<CategoryDto>>();
    }
}
