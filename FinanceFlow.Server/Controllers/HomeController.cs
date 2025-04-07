using FinanceFlow.Server.DBContext;
using FinanceFlow.Server.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using NuGet.Protocol;
using System.Linq;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace FinanceFlow.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HomeController : ControllerBase
    {
        private readonly FinanceDBContext _context;

        public HomeController(FinanceDBContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult> gethome()
        {
            //// Get current values
            double Income = (double)await _context.Incomes
                .Where(
                i => i.Date.Value.Month == DateTime.Now.Month &&
                     i.Date.Value.Year == DateTime.Now.Year &&
                     i.StatusID == 2
                )
                .SumAsync(i => (double?)i.Amount);

            double budget = (double)await _context.Budgets
                .Where(i => i.createdon.Month == DateTime.Now.Month &&
                            i.createdon.Year == DateTime.Now.Year &&
                            i.statusID == 2)
                .SumAsync(i => (double?)i.Amount);

            double investments = (double)await _context.Invests
                .Where(i => i.createdOn.Month == DateTime.Now.Month &&
                            i.createdOn.Year == DateTime.Now.Year)
                .SumAsync(i => (double?)i.amount);

            // Define fallback placeholders
            var fallbackExpense = new { Amount = (double?)0, Month = 0, Year = 0 };
            var fallbackInvestment = new { Amount = (double?)0, Month = "N/A", Year = 0 };
            var fallbackIncome = new { Amount = (double?)0, Month = "N/A", Year = 0 };

            if (Income is 0)
            {
                fallbackIncome = await _context.Incomes
    .Where(i => i.Date.HasValue && i.StatusID == 2)
    .GroupBy(i => new { i.Date.Value.Month, i.Date.Value.Year })
    .OrderByDescending(g => g.Key.Year)
    .ThenByDescending(g => g.Key.Month)
    .Select(g => new
    {
        Amount = (double?)g.Sum(i => i.Amount),
        Month = new DateTime(g.Key.Year, g.Key.Month, 1).ToString("MMMM"),
        Year = g.Key.Year
    }).FirstOrDefaultAsync() ?? fallbackIncome;
            }


            //        if (budget == 0)
            //        {

            //            fallbackExpense = await _context.Expenses
            //.Where(i => i.createdate && i.Budgets == 2)
            //.GroupBy(i => new { i.Date.Value.Month, i.Date.Value.Year })
            //.OrderByDescending(g => g.Key.Year)
            //.ThenByDescending(g => g.Key.Month)
            //.Select(g => new
            //{
            //    Amount = (double?)g.Sum(i => i.Amount),
            //    Month = new DateTime(g.Key.Year, g.Key.Month, 1).ToString("MMMM"),
            //    Year = g.Key.Year
            //}).FirstOrDefaultAsync() ?? fallbackIncome;
            //        }

            if (investments == 0)
            {
                fallbackInvestment = await _context.Invests
.Where(i => i.StatusID == 2)
.GroupBy(i => new { i.Date.Month, i.Date.Year })
.OrderByDescending(g => g.Key.Year)
.ThenByDescending(g => g.Key.Month)
.Select(g => new
{
Amount = (double?)g.Sum(i => i.amount),
Month = new DateTime(g.Key.Year, g.Key.Month, 1).ToString("MMMM"),
Year = g.Key.Year
}).FirstOrDefaultAsync() ?? fallbackInvestment;
            }

            // Result formatting
            //var header = new List<double> { income, budget, investments };
            var headerDetails = new
            {
                //budget,
                //investments
                Current = new { Income, },
                Fallbacks = new
                {
                    Income = fallbackIncome,
                    //Budget = fallbackExpense,
                    //Investments = fallbackInvestment
                }
            };

            return Ok(headerDetails);
        }

    }
}
