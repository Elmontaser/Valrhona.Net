namespace Valrhona.API.Dtos.Items;

public class CreateItemDto
{
    public string ItemCode { get; set; } = string.Empty;

    public string ItemName { get; set; } = string.Empty;

    public byte ItemTypeId { get; set; }

    public int CategoryId { get; set; }

    public int UnitId { get; set; }

    public string? Notes { get; set; }
}
