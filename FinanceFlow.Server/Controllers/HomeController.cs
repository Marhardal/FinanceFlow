using FinanceFlow.Server.DBContext;
using FinanceFlow.Server.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Linq;

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
            // Get current values
            double income = await _context.Incomes
                .Where(i => i.CreateDate.Month == DateTime.Now.Month &&
                            i.CreateDate.Year == DateTime.Now.Year &&
                            i.StatusID == 2)
                .SumAsync(i => (double?)i.Amount) ?? 0;

            double budget = await _context.Budgets
                .Where(i => i.createdon.Month == DateTime.Now.Month &&
                            i.createdon.Year == DateTime.Now.Year &&
                            i.statusID == 2)
                .SumAsync(i => (double?)i.Amount) ?? 0;

            double investments = await _context.Invests
                .Where(i => i.createdOn.Month == DateTime.Now.Month &&
                            i.createdOn.Year == DateTime.Now.Year &&
                            i.StatusID == 2)
                .SumAsync(i => (double?)i.amount) ?? 0;

            // Define fallback placeholders
            var fallbackIncome = new { Amount = (double?)0, Month = "", Year = 0 };
            var fallbackExpense = new { Amount = (double?)0, Month = "", Year = 0 };
            var fallbackInvestment = new { Amount = (double?)0, Month = "", Year = 0 };

            // Fallbacks if current values are 0
            if (income == 0)
            {
                fallbackIncome = await _context.Incomes
                    .Where(i => i.StatusID == 2 &&
                                (i.CreateDate.Month != DateTime.Now.Month || i.CreateDate.Year != DateTime.Now.Year))
                    .OrderByDescending(i => i.CreateDate)
                    .Select(i => new
                    {
                        Amount = (double?)i.Amount,
                        Month = new DateTime(i.CreateDate.Year, i.CreateDate.Month, 1).ToString("MMMM"),
                        Year = i.CreateDate.Year
                    })
                    .FirstOrDefaultAsync() ?? fallbackIncome;

                income = fallbackIncome.Amount ?? 0;
            }

            if (budget == 0)
            {
                fallbackExpense = await _context.Budgets
                    .Where(i => i.statusID == 2 &&
                                (i.createdon.Month != DateTime.Now.Month || i.createdon.Year != DateTime.Now.Year))
                    .OrderByDescending(i => i.createdon)
                    .Select(i => new
                    {
                        Amount = (double?)i.Amount,
                        Month = new DateTime(i.createdon.Year, i.createdon.Month, 1).ToString("MMMM"),
                        Year = i.createdon.Year
                    })
                    .FirstOrDefaultAsync() ?? fallbackExpense;

                budget = fallbackExpense.Amount ?? 0;
            }

            if (investments == 0)
            {
                fallbackInvestment = await _context.Invests
                    .Where(i => i.StatusID == 2 &&
                                (i.createdOn.Month != DateTime.Now.Month || i.createdOn.Year != DateTime.Now.Year))
                    .OrderByDescending(i => i.createdOn)
                    .Select(i => new
                    {
                        Amount = (double?)i.amount,
                        Month = new DateTime(i.createdOn.Year, i.createdOn.Month, 1).ToString("MMMM"),
                        Year = i.createdOn.Year
                    })
                    .FirstOrDefaultAsync() ?? fallbackInvestment;

                investments = fallbackInvestment.Amount ?? 0;
            }

            // Result formatting
            var header = new List<double> { income, budget, investments };
            var headerDetails = new
            {
                Current = new { income, budget, investments },
                Fallbacks = new
                {
                    Income = fallbackIncome,
                    Budget = fallbackExpense,
                    Investments = fallbackInvestment
                }
            };

            return Ok(headerDetails);
        }

    }
}
