using Valrhona.API;
using Valrhona.API.Data;
using Valrhona.API.Interfaces;
using Valrhona.API.Repositories;
using Valrhona.API.Exceptions;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddProblemDetails();
builder.Services.AddValidation();

builder.Services.AddExceptionHandler<GlobalExceptionHandler>(); builder.Services.AddSingleton<SqlConnectionFactory>();
builder.Services.AddScoped<IItemRepository, ItemRepository>();
builder.Services.AddScoped<ICategoryRepository, CategoryRepository>();
builder.Services.AddScoped<IUnitRepository, UnitRepository>();
builder.Services.AddScoped<IItemTypeRepository, ItemTypeRepository>();
builder.Services.AddScoped<IRecipeRepository, RecipeRepository>();
builder.Services.AddScoped<IRecipeDetailRepository, RecipeDetailRepository>();
builder.Services.AddScoped<IItemPriceRepository, ItemPriceRepository>();
builder.Services.AddScoped<IItemCostRepository, ItemCostRepository>();
builder.Services.AddScoped<IUnitConversionRepository, UnitConversionRepository>();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseExceptionHandler();
app.MapEndpoints();

app.Run();