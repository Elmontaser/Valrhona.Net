
using System.Net.Http.Json;
using Valrhona.Client.Models.Items;

namespace Valrhona.Client.Services.Items;

public class ItemService
{
    private readonly HttpClient _httpClient;

    public ItemService(HttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    public async Task<List<ItemDto>> GetAllAsync()
    {
        var result = await _httpClient
            .GetFromJsonAsync<List<ItemDto>>("Items");

        return result ?? new List<ItemDto>();
    }
}