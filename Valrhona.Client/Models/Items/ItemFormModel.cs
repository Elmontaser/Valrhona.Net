using System.ComponentModel.DataAnnotations;

namespace Valrhona.Client.Models.Items;

public class ItemFormModel
{
    public int ItemId { get; set; }

    [Required(ErrorMessage = "كود الصنف مطلوب.")]
    [StringLength(50, ErrorMessage = "الكود لا يتجاوز 50 حرفًا.")]
    public string ItemCode { get; set; } = string.Empty;

    [Required(ErrorMessage = "اسم الصنف مطلوب.")]
    [StringLength(200, ErrorMessage = "الاسم لا يتجاوز 200 حرف.")]
    public string ItemName { get; set; } = string.Empty;

    [Range(1, 255, ErrorMessage = "اختر نوع الصنف.")]
    public int ItemTypeId { get; set; }

    [Range(1, int.MaxValue, ErrorMessage = "اختر الفئة.")]
    public int CategoryId { get; set; }

    [Range(1, int.MaxValue, ErrorMessage = "اختر الوحدة.")]
    public int UnitId { get; set; }

    [StringLength(500, ErrorMessage = "الملاحظات لا تتجاوز 500 حرف.")]
    public string? Notes { get; set; }
}
