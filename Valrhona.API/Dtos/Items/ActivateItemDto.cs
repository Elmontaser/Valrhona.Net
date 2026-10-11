using System;

namespace Valrhona.API.Dtos.Items;

public class ActivateItemDto
{
    public int ItemId { get; set; }
    public bool IsActive { get; set; }
}
