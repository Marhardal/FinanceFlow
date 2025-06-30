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
    public class ExpenseController : ControllerBase
    {
        private readonly FinanceDBContext _context;

        public ExpenseController(FinanceDBContext context)
        {
            _context = context;
        }

        [Authorize]
        // GET: api/Expense
        [HttpGet("{budgetid}")]
        public async Task<ActionResult<IEnumerable<ExpenseModel>>> GetBudgetedExpenses(int budgetid, string search = null)
        {
            IQueryable<ExpenseModel> expense = _context.Expenses.Include(i => i.Item).Where(b => b.BudgetID == budgetid);
            // Add additional logic to handle the search parameter and return the result
            if (expense is null)
            {
                return NoContent();
            }
            if (search is not null)
            {
                expense.Where(expense => expense.Item.Name.Contains(search));
            }
            List<ExpenseModel> expenses = expense.ToList();
            return Ok(expenses);
        }

        [Authorize]
        //GET: api/Expense/5
        [HttpGet("{expenseid}/{budgetid}")]
        public async Task<ActionResult<ExpenseModel>> GetExpenseModel(int expenseid, int budgetid)
        {
            var expenseModel = await _context.Expenses
                .Where(e => e.id == expenseid && e.BudgetID == budgetid)
                .FirstOrDefaultAsync();

            if (expenseModel == null)
            {
                return NotFound();
            }

            return expenseModel;
        }

        [Authorize]
        // PUT: api/Expense/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutExpenseModel(int id, ExpenseModel expenseModel)
        {
            if (expenseModel is null)
            {
                return NoContent();
            }

            if (expenseModel.BudgetID != 0)
            {
                var budget = await _context.Budgets.FindAsync(expenseModel.BudgetID);
                if (budget != null)
                {
                    // Update the budget entity as needed
                    budget.spentAmount = _context.Expenses.Where(e => e.BudgetID == expenseModel.BudgetID).Sum(e => e.amount);
                    _context.Budgets.Update(budget);
                    var transaction = _context.Transactions.Where(b => b.budgetid == expenseModel.BudgetID).FirstOrDefault();

        //            var lasttransaction = _context.Transactions
        //.OrderByDescending(t => t.createdon).Last()?.balance ?? 0;

        //            if (transaction is not null)
        //            {
        //                TransactionModel transactions = new TransactionModel();
        //                transactions.id = transaction.id;
        //                transactions.debit = Convert.ToDecimal(expenseModel.amount);
        //                transactions.valuedate = DateTime.Now;
        //                transactions.investId = expenseModel.BudgetID;
        //                transactions.type = TransactionType.Budgets;
        //                //transactions.createdon = DateTime.Now;
        //                //transactions.date = DateTime.Now;
        //                transactions.balance = lasttransaction - Convert.ToDecimal(expenseModel.amount);
        //                _context.Update(transactions);

        //            }
                }
                _context.Expenses.Update(expenseModel);
            }


            

            try
            {
                _context.Entry(expenseModel).State = EntityState.Modified;

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

            return Ok();
        }

        [Authorize]
        [HttpGet]
        public async Task<ActionResult<ItemsModel>> GetItem(int id)
        {
            var items = await _context.Items.FindAsync(id);
            if (items == null)
            {
                return NotFound();
            }
            return Ok(items);
        }

        [Authorize]
        // POST: api/Expense
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<ExpenseModel>> PostExpenseModel(ExpenseModel expenseModel)
        {
            if (expenseModel is null)
            {
                return NoContent();
               
            }
            var budget = await _context.Budgets.FindAsync(expenseModel.BudgetID);
            if (budget != null)
            {
                // Update the budget entity as needed
                budget.spentAmount = _context.Expenses.Where(e => e.BudgetID == expenseModel.BudgetID).Sum(e => e.amount) + expenseModel.amount;
                _context.Budgets.Update(budget);
            }
            _context.Expenses.Add(expenseModel);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetBudgetedExpenses", new { id = expenseModel.id }, expenseModel);
        }

        [Authorize]
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
