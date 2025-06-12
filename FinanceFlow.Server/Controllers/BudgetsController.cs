using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using FinanceFlow.Server.DBContext;
using FinanceFlow.Server.Models;
using Microsoft.AspNetCore.Authorization;

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

        [Authorize]
        // GET: api/Budgets
        [Authorize]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<BudgetModel>>> GetBudgets(string search = null)
        {
            IQueryable<BudgetModel> query = _context.Budgets.Include(s => s.status).Include(i => i.Income).OrderByDescending(b => b.createdon);
            if (search is not null)
            {
                query = query.Where(b => b.Name.Contains(search)).Where(i => i.Income.Name.Contains(search)).Where(s => s.status.Name.Contains(search));
            }
            List<BudgetModel> budgets = await query.ToListAsync();
            return budgets;
        }

        [Authorize]
        // GET: api/Budgets/5
        [HttpGet("{id}")]
        public async Task<ActionResult<BudgetModel>> GetBudgetModel(int id)
        {
            var budgetModel = await _context.Budgets.Include(s => s.status).Include(i => i.Income).FirstOrDefaultAsync(b => b.Id == id);

            if (budgetModel == null)
            {
                return NotFound();
            }

            return budgetModel;
        }

        [Authorize]
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


            var transaction = _context.Transactions.Where(b => b.budgetid == budgetModel.Id).FirstOrDefault();

            var lasttransaction = _context.Transactions
    .OrderByDescending(t => t.createdon).Last()?.balance ?? 0;
            if (transaction is null || (budgetModel.status is not null || budgetModel.statusID is 2))
            {
                TransactionModel transactions = new TransactionModel();

                transactions.debit = Convert.ToDecimal(budgetModel.Amount);
                transactions.vdate = budgetModel.createdon;
                transactions.budgetid = budgetModel.Id;
                transactions.type = TransactionType.Budgets;
                //transactions.createdon = DateTime.Now;
                //transactions.valuedate = DateTime.Now;
                transactions.balance = lasttransaction - Convert.ToDecimal(budgetModel.Amount);

                _context.Transactions.Update(transactions);
                await _context.SaveChangesAsync();

            }
            return NoContent();
        }

        [Authorize]
        // POST: api/Budgets
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<BudgetModel>> PostBudgetModel(BudgetModel budgetModel)
        {
            if (budgetModel is null)
            {
                return NoContent();
            }
            _context.Budgets.Add(budgetModel);
            await _context.SaveChangesAsync();

            var transaction = _context.Transactions.Where(b => b.budgetid == budgetModel.Id).FirstOrDefault();
            var lasttransaction = _context.Transactions
                .OrderByDescending(t => t.createdon).Last()?.balance ?? 0;
            if (transaction is null || (budgetModel.status is not null || budgetModel.statusID is 2))
            {
                TransactionModel transactions = new TransactionModel();

                transactions.debit = Convert.ToDecimal(budgetModel.Amount);
                transactions.vdate = budgetModel.createdon;
                transactions.budgetid = budgetModel.Id;
                transactions.type = TransactionType.Budgets;
                transactions.createdon = DateTime.Now;
                transactions.balance = lasttransaction - Convert.ToDecimal(budgetModel.Amount);

                _context.Transactions.Add(transactions);
                await _context.SaveChangesAsync();
            }
            
            return CreatedAtAction("GetBudgetModel", new { id = budgetModel.Id }, budgetModel);
        }

        [Authorize]
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
