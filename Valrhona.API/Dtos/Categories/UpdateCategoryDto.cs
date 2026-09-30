using System.ComponentModel.DataAnnotations;

namespace Valrhona.API.Dtos.Categories;

public class UpdateCategoryDto
{
    public int CategoryId { get; set; }

    [Required(ErrorMessage = "CategoryName مطلوب.")]
    public string CategoryName { get; set; } = string.Empty;

    [Range(1, int.MaxValue,
        ErrorMessage = "ParentCategoryId يجب أن يكون أكبر من صفر.")]
    public int? ParentCategoryId { get; set; }
}