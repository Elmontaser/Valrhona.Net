namespace Valrhona.API.Dtos.Items;

public class SearchItemDto
{
    public string? Search { get; set; }
    public byte? ItemTypeId { get; set; }
    public int? CategoryId { get; set; }
}