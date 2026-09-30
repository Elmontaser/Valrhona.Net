using System.ComponentModel.DataAnnotations;

namespace Valrhona.API.Dtos.Units;

public class UpdateUnitDto
{
    public int UnitId { get; set; }

    [Required(ErrorMessage = "UnitName مطلوب.")]
    public string UnitName { get; set; } = string.Empty;

    public string? Symbol { get; set; }
}