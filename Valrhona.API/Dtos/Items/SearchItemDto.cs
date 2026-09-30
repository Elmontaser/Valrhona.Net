using System.ComponentModel.DataAnnotations;

namespace Valrhona.API.Dtos.Items;

public class SearchItemDto
{
    [StringLength(200,
        ErrorMessage = "Search لا يمكن أن يتجاوز 200 حرف.")]
    public string? Search { get; set; }

    [Range(1, byte.MaxValue,
        ErrorMessage = "ItemTypeId يجب أن يكون أكبر من صفر.")]
    public byte? ItemTypeId { get; set; }

    [Range(1, int.MaxValue,
        ErrorMessage = "CategoryId يجب أن يكون أكبر من صفر.")]
    public int? CategoryId { get; set; }
}