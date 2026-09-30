namespace Valrhona.API.Models;

public class ItemPrice
{
    public int ItemPriceId { get; set; }
    public int ItemId { get; set; }

    public decimal Price { get; set; }

    public int UnitId { get; set; }

    public string Currency { get; set; } = string.Empty;

    public DateTime EffectiveDate { get; set; }

    public bool IsActive { get; set; }

    public string? Notes { get; set; }

    // تستخدم عند جلب الأسعار المستحقة
    public string? ItemCode { get; set; }
    public string? ItemName { get; set; }
}