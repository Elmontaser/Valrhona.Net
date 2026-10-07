namespace Valrhona.Client.Models.Lookups;

public class UnitDto
{
    public int UnitId { get; set; }
    public string UnitName { get; set; } = string.Empty;
    public string? Symbol { get; set; }
    public bool IsActive { get; set; }
}

public class ItemTypeDto
{
    public byte ItemTypeId { get; set; }
    public string TypeName { get; set; } = string.Empty;
    public bool IsActive { get; set; }
}

public class CategoryDto
{
    public int CategoryId { get; set; }
    public string CategoryName { get; set; } = string.Empty;
    public int? ParentCategoryId { get; set; }
    public bool IsActive { get; set; }
}
