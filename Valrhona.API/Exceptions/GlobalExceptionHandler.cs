using Microsoft.AspNetCore.Diagnostics;
using Microsoft.Data.SqlClient;

namespace Valrhona.API.Exceptions;

public class GlobalExceptionHandler : IExceptionHandler
{
    public async ValueTask<bool> TryHandleAsync(
        HttpContext httpContext,
        Exception exception,
        CancellationToken cancellationToken)
    {
        httpContext.Response.ContentType = "application/json";

        if (exception is SqlException sqlException)
        {
            httpContext.Response.StatusCode = StatusCodes.Status400BadRequest;

            await httpContext.Response.WriteAsJsonAsync(
                new
                {
                    error = sqlException.Message,
                    sqlErrorNumber = sqlException.Number
                },
                cancellationToken);

            return true;
        }

        httpContext.Response.StatusCode =
            StatusCodes.Status500InternalServerError;

        await httpContext.Response.WriteAsJsonAsync(
            new
            {
                error = "حدث خطأ داخلي في الخادم."
            },
            cancellationToken);

        return true;
    }
}