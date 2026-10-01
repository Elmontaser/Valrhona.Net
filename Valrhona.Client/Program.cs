using Microsoft.AspNetCore.Components.Web;
using Microsoft.AspNetCore.Components.WebAssembly.Hosting;
using Valrhona.Client;
using Valrhona.Client.Services.Items;


var builder = WebAssemblyHostBuilder.CreateDefault(args);
builder.RootComponents.Add<App>("#app");
builder.RootComponents.Add<HeadOutlet>("head::after");

builder.Services.AddScoped(sp => new HttpClient
{
    BaseAddress = new Uri(
    builder.Configuration["ApiBaseUrl"]!
)
});


builder.Services.AddScoped<ItemService>();
await builder.Build().RunAsync();
