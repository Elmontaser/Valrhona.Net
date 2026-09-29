namespace Valrhona.API.Models;

public class Unit
{
    public int UnitId { get; set; }

    public string UnitName { get; set; } = string.Empty;

    public string? Symbol { get; set; }

    public bool IsActive { get; set; }
}