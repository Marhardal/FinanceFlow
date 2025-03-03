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
    public class ExpenseController : ControllerBase
    {
        private readonly FinanceDBContext _context;

        public ExpenseController(FinanceDBContext context)
        {
            _context = context;
        }

        // GET: api/Expense
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ExpenseModel>>> GetExpenses()
        {
            return await _context.Expenses.ToListAsync();
        }

        // GET: api/Expense/5
        [HttpGet("{id}")]
        public async Task<ActionResult<ExpenseModel>> GetExpenseModel(int id)
        {
            var expenseModel = await _context.Expenses.FindAsync(id);

            if (expenseModel == null)
            {
                return NotFound();
            }

            return expenseModel;
        }

        // PUT: api/Expense/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutExpenseModel(int id, ExpenseModel expenseModel)
        {
            if (id != expenseModel.id)
            {
                return BadRequest();
            }

            _context.Entry(expenseModel).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ExpenseModelExists(id))
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

        public async Task<ActionResult<ItemsModel>> GetItem(int id)
        {
            var items = await _context.Items.FindAsync(id);
            if (items == null)
            {
                return NotFound();
            }
            return Ok(items);
        }

        // POST: api/Expense
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<ExpenseModel>> PostExpenseModel(ExpenseModel expenseModel)
        {
            if (expenseModel is null)
            {
                return NoContent();
            }
            var itemResult = await GetItem(expenseModel.ItemID);
            if (itemResult.Result is NotFoundResult)
            {
                return NotFound();
            }
            var item = itemResult.Value;
            if (item == null)
            {
                return NotFound();
            }
            expenseModel.amount = expenseModel.Quantity * (double)item.Price;
            _context.Expenses.Add(expenseModel);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetExpenseModel", new { id = expenseModel.id }, expenseModel);
        }

        // DELETE: api/Expense/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteExpenseModel(int id)
        {
            var expenseModel = await _context.Expenses.FindAsync(id);
            if (expenseModel == null)
            {
                return NotFound();
            }

            _context.Expenses.Remove(expenseModel);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool ExpenseModelExists(int id)
        {
            return _context.Expenses.Any(e => e.id == id);
        }
    }
}
