using Microsoft.AspNetCore.OpenApi;
using Microsoft.AspNetCore.Http.HttpResults;
using FinanceFlow.Server.DBContext;
using Microsoft.EntityFrameworkCore;
namespace FinanceFlow.Server.Models
{
    public class StatusModel
    {
        public int id { get; set; }

        public required string Name { get; set; }
    }


public static class StatusModelEndpoints
{
	public static void MapStatusModelEndpoints (this IEndpointRouteBuilder routes)
    {
        var group = routes.MapGroup("/api/StatusModel").WithTags(nameof(StatusModel));

        group.MapGet("/", async (FinanceDBContext db) =>
        {
            return await db.Statuses.ToListAsync();
        })
        .WithName("GetAllStatusModels")
        .WithOpenApi();

        group.MapGet("/{id}", async Task<Results<Ok<StatusModel>, NotFound>> (int id, FinanceDBContext db) =>
        {
            return await db.Statuses.AsNoTracking()
                .FirstOrDefaultAsync(model => model.id == id)
                is StatusModel model
                    ? TypedResults.Ok(model)
                    : TypedResults.NotFound();
        })
        .WithName("GetStatusModelById")
        .WithOpenApi();

        group.MapPut("/{id}", async Task<Results<Ok, NotFound>> (int id, StatusModel statusModel, FinanceDBContext db) =>
        {
            var affected = await db.Statuses
                .Where(model => model.id == id)
                .ExecuteUpdateAsync(setters => setters
                  .SetProperty(m => m.id, statusModel.id)
                  .SetProperty(m => m.Name, statusModel.Name)
                  );
            return affected == 1 ? TypedResults.Ok() : TypedResults.NotFound();
        })
        .WithName("UpdateStatusModel")
        .WithOpenApi();

        group.MapPost("/", async (StatusModel statusModel, FinanceDBContext db) =>
        {
            db.Statuses.Add(statusModel);
            await db.SaveChangesAsync();
            return TypedResults.Created($"/api/StatusModel/{statusModel.id}",statusModel);
        })
        .WithName("CreateStatusModel")
        .WithOpenApi();

        group.MapDelete("/{id}", async Task<Results<Ok, NotFound>> (int id, FinanceDBContext db) =>
        {
            var affected = await db.Statuses
                .Where(model => model.id == id)
                .ExecuteDeleteAsync();
            return affected == 1 ? TypedResults.Ok() : TypedResults.NotFound();
        })
        .WithName("DeleteStatusModel")
        .WithOpenApi();
    }
}}
