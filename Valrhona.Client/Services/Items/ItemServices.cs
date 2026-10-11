using System.Net.Http.Json;
using Valrhona.Client.Models.Items;

namespace Valrhona.Client.Services.Items;

public class ItemService
{
    // BaseAddress ينتهي بـ api/ لذلك المسارات هنا نسبية بدون api/ في أولها
    private readonly HttpClient _httpClient;

    public ItemService(HttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    public async Task<List<ItemDto>> GetAllAsync()
    {
        var response = await _httpClient.GetAsync("Items");

        return await response.ReadApiAsync<List<ItemDto>>();
    }

    public async Task CreateAsync(ItemFormModel model)
    {
        var response = await _httpClient.PostAsJsonAsync(
            "Items",
            new
            {
                model.ItemCode,
                model.ItemName,
                ItemTypeId = (byte)model.ItemTypeId,
                model.CategoryId,
                model.UnitId,
                model.Notes
            });

        await response.EnsureApiSuccessAsync();
    }

    public async Task UpdateAsync(ItemFormModel model)
    {
        var response = await _httpClient.PutAsJsonAsync(
            $"Items/{model.ItemId}",
            new
            {
                model.ItemId,
                model.ItemCode,
                model.ItemName,
                ItemTypeId = (byte)model.ItemTypeId,
                model.CategoryId,
                model.UnitId,
                model.Notes
            });

        await response.EnsureApiSuccessAsync();
    }

    /// <summary>
    /// إيقاف الصنف (تعطيل وليس حذفاً فعلياً).
    /// </summary>
    public async Task ActivateAsync(int itemId, bool isActive)
    {
        var response = await _httpClient.PutAsync(
            $"Items/{itemId}/activate?isActive={isActive.ToString().ToLowerInvariant()}",
            content: null);

        await response.EnsureApiSuccessAsync();
    }
}
