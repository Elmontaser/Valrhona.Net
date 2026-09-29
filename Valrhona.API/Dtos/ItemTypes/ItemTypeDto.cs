namespace Valrhona.API.Dtos.ItemTypes;

public class ItemTypeDto
{
    public byte ItemTypeId { get; set; }

    public string TypeName { get; set; } = string.Empty;

    public bool IsActive { get; set; }
}