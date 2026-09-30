namespace Valrhona.API.Models;

public class UnitConversionResult
{
    public decimal OriginalQuantity { get; set; }

    public int FromUnitId { get; set; }

    public int ToUnitId { get; set; }

    public decimal? ConversionFactor { get; set; }

    public decimal ConvertedQuantity { get; set; }
}