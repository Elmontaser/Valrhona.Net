namespace Valrhona.API.Models;

public class ItemType
{
    public byte ItemTypeId { get; set; }

    public string TypeName { get; set; } = string.Empty;

    public bool IsActive { get; set; }
}