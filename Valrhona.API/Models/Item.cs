namespace Valrhona.API.Models;

public class Item
{
    public int ItemId { get; set; }

    public string ItemCode { get; set; } = string.Empty;

    public string ItemName { get; set; } = string.Empty;

    public byte ItemTypeId { get; set; }

    public string? ItemTypeName { get; set; }

    public int CategoryId { get; set; }

    public string? CategoryName { get; set; }

    public int UnitId { get; set; }

    public string? UnitName { get; set; }

    public string? Symbol { get; set; }

    public bool IsActive { get; set; }

    public string? Notes { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }
}
