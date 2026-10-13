namespace Valrhona.Client.Models.UnitConversions;

public class UnitConversionDto
{
    public int UnitConversionId { get; set; }
    public int FromUnitId { get; set; }
    public string FromUnitName { get; set; } = string.Empty;
    public string? FromUnitSymbol { get; set; }
    public int ToUnitId { get; set; }
    public string ToUnitName { get; set; } = string.Empty;
    public string? ToUnitSymbol { get; set; }
    public decimal ConversionFactor { get; set; }
    public bool IsActive { get; set; }
    public string? Notes { get; set; }
    public DateTime CreatedAt { get; set; }
}