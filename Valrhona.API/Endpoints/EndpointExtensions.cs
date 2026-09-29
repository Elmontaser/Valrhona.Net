using Valrhona.API.Endpoints;

namespace Valrhona.API;

public static class EndpointExtensions
{
    public static void MapEndpoints(this WebApplication app)
    {
        app.MapItemEndpoint();
        app.MapCategoryEndpoint();
    }
}