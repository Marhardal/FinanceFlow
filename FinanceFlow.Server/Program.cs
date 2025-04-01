using FinanceFlow.Server.DBContext;
using Microsoft.EntityFrameworkCore;
using Scalar.AspNetCore;
using FinanceFlow.Server.Controllers;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using FinanceFlow.Server.Services;
using Microsoft.Extensions.Configuration;
using System.Security.Cryptography;
using Microsoft.IdentityModel.Tokens;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new Microsoft.IdentityModel.Tokens.TokenValidationParameters()
        {
            ValidateIssuer = true,
            ValidIssuer = builder.Configuration["AppSettings:Issuer"],
            ValidateAudience = true,
            ValidAudience = builder.Configuration["AppSettings:Audience"],
            IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(builder.Configuration["AppSettings:Token"]!)),
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true
        };
        options.Authority = "https://localhost:7000";
        options.Audience = "scalar";
    });

builder.Services.AddScoped<IAuthService, AuthService>();

// Add CORS policy
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowSpecificOrigin",
        policy =>
        {
            policy.WithOrigins("https://localhost:53386") // Allow frontend URL
                  .AllowAnyMethod()
                  .AllowAnyHeader();
        });
});

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
builder.Services.AddOpenApi();

builder.Services.AddDbContext<FinanceDBContext>(options =>
   options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")),
   ServiceLifetime.Scoped
);

builder.Services.AddControllers()
    .AddJsonOptions(options =>
    {
        options.JsonSerializerOptions.ReferenceHandler = System.Text.Json.Serialization.ReferenceHandler.IgnoreCycles;
        options.JsonSerializerOptions.WriteIndented = true; // Optional: makes JSON more readable
    });

builder.Services.Configure<ScalarOptions>(options =>
{
    options.WithOpenApiRoutePattern("/openapi/v1.json");
});

builder.Services.AddEndpointsApiExplorer();

builder.Services.AddSwaggerGen();


var app = builder.Build();

app.UseDefaultFiles();
app.MapStaticAssets();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.MapScalarApiReference();
    app.MapOpenApi();
}

// Enable CORS before middleware
app.UseCors("AllowSpecificOrigin");

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
};

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.MapFallbackToFile("/index.html");

app.Run();

//https://localhost:7001/scalar/v1#tag/expensecategory
