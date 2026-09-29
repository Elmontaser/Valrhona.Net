namespace Valrhona.API.Dtos.Categories;

public class UpdateCategoryDto
{
    public int CategoryId { get; set; }
    public string CategoryName { get; set; } = string.Empty;
    public int? ParentCategoryId { get; set; }
}