using System.ComponentModel.DataAnnotations;

namespace Valrhona.API.Dtos.Items;

public class UpdateItemDto
{
    public int ItemId { get; set; }

    [Required(ErrorMessage = "ItemCode مطلوب.")]
    public string ItemCode { get; set; } = string.Empty;

    [Required(ErrorMessage = "ItemName مطلوب.")]
    public string ItemName { get; set; } = string.Empty;

    [Range(1, byte.MaxValue,
        ErrorMessage = "ItemTypeId يجب أن يكون أكبر من صفر.")]
    public byte ItemTypeId { get; set; }

    [Range(1, int.MaxValue,
        ErrorMessage = "CategoryId يجب أن يكون أكبر من صفر.")]
    public int CategoryId { get; set; }

    [Range(1, int.MaxValue,
        ErrorMessage = "UnitId يجب أن يكون أكبر من صفر.")]
    public int UnitId { get; set; }

    public string? Notes { get; set; }
}