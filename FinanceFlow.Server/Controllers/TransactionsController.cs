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
    public class TransactionsController : ControllerBase
    {
        private readonly FinanceDBContext _context;

        public TransactionsController(FinanceDBContext context)
        {
            _context = context;
        }

        [Authorize]
        // GET: api/Transactions
        [HttpGet]
        public async Task<ActionResult<IEnumerable<TransactionModel>>> GetTransactions()
        {
            var transactions = await _context.Transactions
        .Include(t => t.Income)  // Properly include Income
        .Include(t => t.Budget)  // Properly include Budget
        .Include(t => t.Invest)
        .ThenInclude(i => i.Investments)
        .OrderByDescending(i => i.vdate)
        .Select(t => new
        {
             t.id,
            t.type,
            t.debit,
            t.credit,
            t.balance,
            t.vdate,
            t.incomeid,
            t.budgetid,
            IncomeName = t.Income != null ? t.Income.Name : null,   // Get Income Name if available
            BudgetName = t.Budget != null ? t.Budget.Name : null,   // Get Budget Name if available
            InvestmentName = t.Invest.Investment.Name != null ? t.Invest.Investment.Name : null,
        }).ToListAsync();

            if (!transactions.Any())
            {
                return NoContent();
            }

            return Ok(transactions);
        }

        [Authorize]
        // GET: api/Transactions/5
        [HttpGet("{id}")]
        public async Task<ActionResult<TransactionModel>> GetTransactionModel(int id)
        {
            var transactionModel = await _context.Transactions.FindAsync(id);

            if (transactionModel == null)
            {
                return NotFound();
            }

            return transactionModel;
        }

        [Authorize]
        // PUT: api/Transactions/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutTransactionModel(int id, TransactionModel transactionModel)
        {
            if (id != transactionModel.id)
            {
                return BadRequest();
            }

            _context.Entry(transactionModel).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!TransactionModelExists(id))
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

        [Authorize]
        // POST: api/Transactions
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<TransactionModel>> PostTransactionModel(TransactionModel transactionModel)
        {
            _context.Transactions.Add(transactionModel);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetTransactionModel", new { id = transactionModel.id }, transactionModel);
        }

        [Authorize]
        // DELETE: api/Transactions/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteTransactionModel(int id)
        {
            var transactionModel = await _context.Transactions.FindAsync(id);
            if (transactionModel == null)
            {
                return NotFound();
            }

            _context.Transactions.Remove(transactionModel);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool TransactionModelExists(int id)
        {
            return _context.Transactions.Any(e => e.id == id);
        }
    }
}
