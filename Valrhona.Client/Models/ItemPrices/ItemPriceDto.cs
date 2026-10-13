namespace Valrhona.Client.Models.ItemPrices;

public class ItemPriceDto
{
    public int ItemPriceId { get; set; }
    public int ItemId { get; set; }
    public string? ItemCode { get; set; }
    public string? ItemName { get; set; }
    public decimal Price { get; set; }
    public int UnitId { get; set; }
    public string? UnitName { get; set; }
    public string? UnitSymbol { get; set; }
    public string Currency { get; set; } = string.Empty;
    public DateTime EffectiveDate { get; set; }
    public bool IsActive { get; set; }
    public string? Notes { get; set; }
    public DateTime CreatedAt { get; set; }
}