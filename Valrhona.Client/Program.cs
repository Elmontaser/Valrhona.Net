using Microsoft.AspNetCore.Components.Web;
using Microsoft.AspNetCore.Components.WebAssembly.Hosting;
using Valrhona.Client;
using Valrhona.Client.Services.Items;
using Valrhona.Client.Services.Lookups;
using Valrhona.Client.Services.Recipes;


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
builder.Services.AddScoped<LookupService>();
builder.Services.AddScoped<RecipeService>();
await builder.Build().RunAsync();
