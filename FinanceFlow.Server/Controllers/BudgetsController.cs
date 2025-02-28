using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using FinanceFlow.Server.DBContext;
using FinanceFlow.Server.Models;

namespace FinanceFlow.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BudgetsController : ControllerBase
    {
        private readonly FinanceDBContext _context;

        public BudgetsController(FinanceDBContext context)
        {
            _context = context;
        }

        // GET: api/Budgets
        [HttpGet]
        public async Task<ActionResult<IEnumerable<BudgetModel>>> GetBudgets()
        {
            return await _context.Budgets.ToListAsync();
        }

        // GET: api/Budgets/5
        [HttpGet("{id}")]
        public async Task<ActionResult<BudgetModel>> GetBudgetModel(int id)
        {
            var budgetModel = await _context.Budgets.FindAsync(id);

            if (budgetModel == null)
            {
                return NotFound();
            }

            return budgetModel;
        }

        // PUT: api/Budgets/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutBudgetModel(int id, BudgetModel budgetModel)
        {
            if (id != budgetModel.Id)
            {
                return BadRequest();
            }

            _context.Entry(budgetModel).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!BudgetModelExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Budgets
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<BudgetModel>> PostBudgetModel(BudgetModel budgetModel)
        {
            _context.Budgets.Add(budgetModel);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetBudgetModel", new { id = budgetModel.Id }, budgetModel);
        }

        // DELETE: api/Budgets/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteBudgetModel(int id)
        {
            var budgetModel = await _context.Budgets.FindAsync(id);
            if (budgetModel == null)
            {
                return NotFound();
            }

            _context.Budgets.Remove(budgetModel);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool BudgetModelExists(int id)
        {
            return _context.Budgets.Any(e => e.Id == id);
        }
    }
}
