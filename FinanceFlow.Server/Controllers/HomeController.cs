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
            double income = (double)await _context.Incomes.Where(i => i.CreateDate == DateTime.Now.Month && i.CreateDate.year == DateTime.Now.Year).SumAsync(i => i.amount);
            //BudgetModel budget = await _context.Budgets.LastAsync();
            double investments = (double)await _context.Invests.Where(i => i.Date.Month == DateTime.Now.Month && i.Date.Year == DateTime.Now.Year).SumAsync(i => i.amount);
            return Ok();
        }
    }
}
