
namespace Valrhona.Client.Models.Items;

public class ItemDto
{
    public int ItemId { get; set; }

    public string ItemCode { get; set; } = string.Empty;

    public string ItemName { get; set; } = string.Empty;

    public int ItemTypeId { get; set; }

    public int CategoryId { get; set; }

    public int UnitId { get; set; }

    public bool IsActive { get; set; }

    public string? Notes { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }
}