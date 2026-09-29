using Valrhona.API;
using Valrhona.API.Data;
using Valrhona.API.Interfaces;
using Valrhona.API.Repositories;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddSingleton<SqlConnectionFactory>();
builder.Services.AddScoped<IItemRepository, ItemRepository>();
builder.Services.AddScoped<ICategoryRepository, CategoryRepository>();
builder.Services.AddScoped<IUnitRepository, UnitRepository>();
builder.Services.AddScoped<IItemTypeRepository, ItemTypeRepository>();
builder.Services.AddScoped<IRecipeRepository, RecipeRepository>();

var app = builder.Build();

app.MapEndpoints();

app.Run();