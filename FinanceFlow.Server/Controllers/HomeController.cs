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
            double income = (double)await _context.Incomes.Where(i => i.CreateDate.Month == DateTime.Now.Month && i.CreateDate.Year == DateTime.Now.Year && i.StatusID == 2).SumAsync(i => i.Amount);
            double budget = (double)await _context.Budgets.Where(i => i.createdon.Month == DateTime.Now.Month && i.createdon.Year == DateTime.Now.Year && i.statusID == 2).SumAsync(i => i.Amount);
            double investments = (double)await _context.Invests.Where(i => i.createdOn.Month == DateTime.Now.Month && i.createdOn.Year == DateTime.Now.Year && i.StatusID == 2).SumAsync(i => i.amount);

            if (income is 0)
            {
                income = await _context.Incomes
         .Where(i =>
             (i.CreateDate.Month != DateTime.Now.Month || i.CreateDate.Year != DateTime.Now.Year) &&
             i.StatusID == 2)
         .OrderByDescending(i => i.CreateDate)
         .Select(i => (double?)i.Amount)
         .FirstOrDefaultAsync() ?? 0;
            }

            if (budget is 0)
            {
                budget = await _context.Incomes
         .Where(i =>
             (i.CreateDate.Month != DateTime.Now.Month || i.CreateDate.Year != DateTime.Now.Year) &&
             i.StatusID == 2)
         .OrderByDescending(i => i.CreateDate)
         .Select(i => (double?)i.Amount)
         .FirstOrDefaultAsync() ?? 0;
            }

            if (investments is 0)
            {
                investments = (double)await _context.Invests.Where(i => i.createdOn.Month == DateTime.Now.Month && i.createdOn.Year == DateTime.Now.Year && i.StatusID == 2).SumAsync(i => i.amount);
            }

            return Ok();
        }
    }
}
