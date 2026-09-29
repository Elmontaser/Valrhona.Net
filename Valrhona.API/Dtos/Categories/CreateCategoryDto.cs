namespace Valrhona.API.Dtos.Categories;

public class CreateCategoryDto
{
    public string CategoryName { get; set; } = string.Empty;
    public int? ParentCategoryId { get; set; }
}