using System.ComponentModel.DataAnnotations;

namespace Valrhona.API.Dtos.ItemCosts;

public class RecalculateItemCostDto
{
    [Range(1, int.MaxValue,
        ErrorMessage = "ItemId يجب أن يكون أكبر من صفر.")]
    public int ItemId { get; set; }

    public DateTime? AsOfDate { get; set; }
}