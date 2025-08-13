using FinanceFlow.Server.DBContext;
using FinanceFlow.Server.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using NuGet.Protocol;
using System.Globalization;
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
        
        [Authorize]
        [HttpGet("Header")]
        public async Task<ActionResult> getHeader()
        {
            //// Get current values
            double Income = (double)await _context.Incomes
                .Where(
                i => i.Date.Value.Month == DateTime.Now.Month &&
                     i.Date.Value.Year == DateTime.Now.Year &&
                     i.StatusID == 2 && i.UserID == 1
                )
                .SumAsync(i => (double?)i.Amount);

            double budget = (double)(await _context.Budgets
                .Where(i => i.statusID == 2 &&
                        i.remindon.Month == DateTime.Now.Month &&
                        i.remindon.Year == DateTime.Now.Year &&
                        i.UserID == 1
                            )
                .SumAsync(i => (double?)i.spentAmount) ?? 0);

            double investments = (double)await _context.Invests
                .Where(i => i.createdOn.Month == DateTime.Now.Month &&
                            i.createdOn.Year == DateTime.Now.Year
                            && i.Investment.UserId == 1)
                .SumAsync(i => (double?)i.amount);

            // Define fallback placeholders
            var fallbackExpense = new { Amount = (double?)0, Spend = (double?)0, Month = "N/A", Year = 0 };
            var fallbackInvestment = new { Amount = (double?)0, Month = "N/A", Year = 0 };
            var fallbackIncome = new { Amount = (double?)0, Month = "N/A", Year = 0 };

            if (Income is 0)
            {
                fallbackIncome = await _context.Incomes
    .Where(i => i.StatusID == 2 && i.Date.HasValue && i.UserID == 1)
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

            if (budget == 0)
            {

                fallbackExpense = await _context.Budgets
.Where(i => i.statusID == 2 && i.UserID == 1)
.GroupBy(i => new { i.remindon.Month, i.remindon.Year })
.OrderByDescending(g => g.Key.Year)
.ThenByDescending(g => g.Key.Month)
.Select(g => new
{
    Amount = (double?)g.Sum(i => i.Amount),
    Spend = (double?)g.Sum(i => i.spentAmount),
    Month = new DateTime(g.Key.Year, g.Key.Month, 1).ToString("MMMM"),
    Year = g.Key.Year
}).FirstOrDefaultAsync() ?? fallbackExpense;

            }

            if (investments == 0)
            {
                fallbackInvestment = await _context.Invests
.Where(i => i.StatusID == 2 && i.Investment.UserId == 1)
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

            double balance = Income - (investments + budget);
            // Result formatting
            //var header = new List<double> { income, budget, investments };
            var headerDetails = new
            {
                Current = new
                {
                    Income,
                    budget,
                    investments,
                    balance
                },
                Fallbacks = new
                {
                    Income = fallbackIncome,
                    Budget = fallbackExpense,
                    Investments = fallbackInvestment
                }
            };

            return Ok(headerDetails);
        }

        [Authorize]
        [HttpGet("last12months")]
        public async Task<IActionResult> GetTransactionChartData()
        {
            var endDate = DateTime.Now;
            var startDate = endDate.AddMonths(-11);

            // Get data grouped by month and type  
            var transactions = await _context.Transactions
                .Where(t => t.valuedate >= startDate && t.valuedate <= endDate)
                .GroupBy(t => new { t.valuedate.Year, t.valuedate.Month, t.type })
                .Select(g => new
                {
                    YearMonth = new DateTime(g.Key.Year, g.Key.Month, 1),
                    Type = g.Key.type,
                    Amount = g.Sum(t => t.balance ?? 0)
                })
                .ToListAsync();

            // Filter months where the total amount is greater than zero  
            var filteredMonths = transactions
                .Where(t => t.Amount > 0)
                .Select(t => t.YearMonth)
                .Distinct()
                .OrderBy(m => m)
                .ToList();

            // Process data for Chart.js  
            var labels = filteredMonths
                .Select(m => m.ToString("MMM yy"))
                .ToArray();

            // Define the three specific types we want  
            var types = new[] { "Incomes", "Budgets", "Invests" };

            var datasets = types.Select(type => new
            {
                Label = type,
                Data = filteredMonths.Select(month =>
                    transactions
                        .Where(t => t.Type.ToString() == type &&
                                   t.YearMonth.Year == month.Year &&
                                   t.YearMonth.Month == month.Month)
                        .Sum(t => t.Amount))
                        .ToArray(),
                BorderColor = GetColorForType(type),
                BackgroundColor = GetColorForType(type, true)
            }).ToList();

            return Ok(new
            {
                Labels = labels,
                Datasets = datasets
            });
        }
        //public async Task<IActionResult> GetTransactionChartData()
        //{
        //    var endDate = DateTime.Now;
        //    var startDate = endDate.AddMonths(-11);

        //    // Get all months in range (for consistent x-axis)
        //    var allMonths = Enumerable.Range(0, 12)
        //        .Select(offset => startDate.AddMonths(offset))
        //        .ToList();

        //    // Get all transactions in date range
        //    var transactions = await _context.Transactions
        //        .Where(t => t.date >= startDate && t.date <= endDate)
        //        .ToListAsync();

        //    // Process data for each type
        //    var typeData = new Dictionary<string, List<decimal>>
        //    {
        //        ["Income"] = new List<decimal>(),
        //        ["Expense"] = new List<decimal>(),
        //        ["Invest"] = new List<decimal>()
        //    };

        //    foreach (var month in allMonths)
        //    {
        //        // Income (directly named)
        //        typeData["Income"].Add(transactions
        //            .Where(t => t.type.ToString() == "Income" &&
        //                       t.date.Year == month.Year &&
        //                       t.date.Month == month.Month)
        //            .Sum(t => t.amount ?? 0));

        //        // Expense (mapped from Budgets)
        //        typeData["Expense"].Add(transactions
        //            .Where(t => t.type.ToString() == "Budgets" &&
        //                       t.date.Year == month.Year &&
        //                       t.date.Month == month.Month)
        //            .Sum(t => t.amount ?? 0));

        //        // Invest (mapped from Invests)
        //        typeData["Invest"].Add(transactions
        //            .Where(t => t.type.ToString() == "Invests" &&
        //                       t.date.Year == month.Year &&
        //                       t.date.Month == month.Month)
        //            .Sum(t => t.amount ?? 0));
        //    }

        //    // Build datasets (only include types with data)
        //    var datasets = new List<object>();

        //    foreach (var type in typeData)
        //    {
        //        if (type.Value.Any(amount => amount > 0))
        //        {
        //            datasets.Add(new
        //            {
        //                Label = type.Key,
        //                Data = type.Value.ToArray(),
        //                BorderColor = GetColorForType(type.Key),
        //                BackgroundColor = GetColorForType(type.Key, true)
        //            });
        //        }
        //    }

        //    return Ok(new
        //    {
        //        Labels = allMonths.Select(m => m.ToString("MMM yy")).ToArray(),
        //        Datasets = datasets
        //    });
        //}

        [Authorize]
        [HttpGet("TopBudgetCategories")]
        public async Task<IActionResult> GetTopBudgetCategories([FromQuery] int topCount = 5)
        {
            try
            {
                var currentMonth = DateTime.Now.Month;
                var currentYear = DateTime.Now.Year;

                // Get all categories sorted by usage frequency
                var categories = await _context.Expenses
                    .Where(e => e.createdate.Month == currentMonth && e.createdate.Year == currentYear)
                    .GroupBy(e => e.Item.ItemCategory)
                    .Select(g => new
                    {
                        Category = g.Key.Name,
                        TotalAmount = g.Sum(e => e.amount),
                        UsageCount = g.Count()
                    })
                    .OrderByDescending(x => x.UsageCount)
                    .ToListAsync();

                // Calculate total transactions for percentages
                var totalTransactions = categories.Sum(x => x.UsageCount);

                // Take top N categories and group the rest as "Other"
                var topCategories = categories.Take(topCount).ToList();
                var otherAmount = categories.Skip(topCount).Sum(x => x.TotalAmount);
                var otherCount = categories.Skip(topCount).Sum(x => x.UsageCount);

                // Combine results
                var result = new List<object>();

                // Add top categories
                foreach (var category in topCategories.Where(x => x.TotalAmount > 0))
                {
                    result.Add(new
                    {
                        Category = category.Category,
                        TotalAmount = category.TotalAmount,
                        UsageCount = category.UsageCount,
                        Percentage = Math.Round((double)category.UsageCount / totalTransactions * 100, 1),
                        Type = "Top"
                    });
                }

                // Add "Other" category if there are remaining categories
                if (categories.Count > topCount && otherAmount > 0)
                {
                    result.Add(new
                    {
                        Category = $"Other ({categories.Count - topCount} categories)",
                        TotalAmount = otherAmount,
                        UsageCount = otherCount,
                        Percentage = Math.Round((double)otherCount / totalTransactions * 100, 1),
                        Type = "Other"
                    });
                }

                return Ok(new
                {
                    Labels = result.Select(x => (x as dynamic).Category).ToArray(),
                    Data = result.Select(x => (x as dynamic).TotalAmount).ToArray(),
                    TransactionCounts = result.Select(x => (x as dynamic).UsageCount).ToArray(),
                    Colors = result.Select(x => (x as dynamic).Type == "Top"
                        ? GetCategoryColor((x as dynamic).Category)
                        : "#CCCCCC").ToArray(),
                    TotalAmount = result.Sum(x => (decimal)(x as dynamic).TotalAmount),
                    PercentageOfTransactions = result.Select(x => (x as dynamic).Percentage).ToArray()
                });
                //return Ok(categories);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { Error = "Failed to load budget categories", Details = ex.Message });
            }
        }

        [Authorize]
        [HttpGet("GetRecentTransactions")]
        public async Task<IActionResult> getRecentTransactions()
        {
            List<TransactionModel> recent = await _context.Transactions
                .OrderByDescending(t => t.valuedate)
                .Take(5)
                .Select(t => new TransactionModel
                {
                    type = t.type,
                    //amount = t.amount,
                    valuedate = t.valuedate,
                    createdon = t.createdon,
                 })
                .ToListAsync();

            return Ok(recent);
        }

        [Authorize]
        [HttpGet("GetRecentandUpcomingInvests")]
        public async Task<IActionResult> getRecentandUpcominginvets()
        {
            List<InvestModel> recent = await _context.Invests
                .OrderByDescending(t => t.Date)
                .Take(5)
                .Select(t => new InvestModel
                {
                    InvestmentId = t.InvestmentId, // Fix: Set the required member
                    StatusID = t.StatusID, // Fix: Ensure required member is set
                    IncomeID = t.IncomeID, // Fix: Set the required member
                    Date = t.Date,
                    amount = t.amount,
                })
                .ToListAsync();

            return Ok(recent);
        }

        [Authorize]
        [HttpGet("GetUpcomingEvents")]
        public async Task<IActionResult> GetUpcomingEvents()
        {
            var upcoming = await (from Budget in _context.Budgets
                                  join Invest in _context.Invests on new { Month = Budget.remindon.Month, Year = Budget.remindon.Year }
                                  equals new { Month = Invest.Date.Month, Year = Invest.Date.Year }
                                  where Budget.statusID == 1 && Invest.StatusID == 1
                                  orderby Budget.remindon ascending
                                  select new
                                  {
                                      Name = Budget.Name != null ? Budget.Name : Invest.Investment.Name ,
                                      Type = Budget.Name != null ? "Budget" : (Invest.description != null ? "Investment" : "Unknown"),
                                      Amount = (float)Budget.Amount > 0 ? (float)Invest.amount : 0, // Fix: Corrected the conditional expression
                                      RemindOn = Budget.remindon != null ? Invest.Date : DateTime.UtcNow,
                                  }).ToListAsync();

            return Ok(upcoming);
        }

        [Authorize]
        private string GetCategoryColor(string category)
        {
            // Customize based on your categories
            return category switch
            {
                "Housing" => "#36a2eb",
                "Food" => "#ff6384",
                "Transportation" => "#ffcd56",
                "Utilities" => "#4bc0c0",
                "Entertainment" => "#9966ff",
                _ => "#" + new Random().Next(0x1000000).ToString("X6") // Random color for others
            };
        }

        private string GetColorForType(string type, bool transparent = false)
        {
            string color = type switch
            {
                "Incomes" => "#4bc0c0",
                "Budgets" => "#ff6384",
                "Invests" => "#9966ff",
                _ => "#36a2eb"
            };
            return transparent ? color + "40" : color;
        }
    }
}
