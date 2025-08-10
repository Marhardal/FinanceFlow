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
using System.Security.Claims;
using FinanceFlow.Server.Classes;

namespace FinanceFlow.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class IncomesController : ControllerBase
    {
        private readonly FinanceDBContext _context;

        public IncomesController(FinanceDBContext context)
        {
            _context = context;
        }

        [Authorize]
        // GET: api/Incomes
        [HttpGet]
        public async Task<ActionResult<IEnumerable<IncomeModel>>> GetIncomeModel(string search = null)
        {   
            IQueryable<IncomeModel> query = _context.Incomes.Include(s => s.Status).Include(c => c.IncomeCategory).OrderByDescending(i => i.Date);
            if (!string.IsNullOrEmpty(search))
            {
                query = query.Where(i => i.Name.Contains(search) || i.Status.Name.Contains(search) || i.IncomeCategory.name.Contains(search));
            }
            List<IncomeModel> incomes = await query.ToListAsync();
            return Ok(incomes);
        }

        [Authorize]
        // GET: api/Incomes/5
        [HttpGet("{id}")]
        public async Task<ActionResult<IncomeModel>> GetIncomeModel(int id)
        {
            var incomeModel = await _context.Incomes.FindAsync(id);

            if (incomeModel == null)
            {
                return NotFound();
            }

            return incomeModel;
        }

        [Authorize]
        // PUT: api/Incomes/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutIncomeModel(int id, IncomeModel incomeModel)
        {
            var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (id != incomeModel.Id)
            {
                return BadRequest();
            }

            _context.Entry(incomeModel).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!IncomeModelExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }
            var notify = _context.Notification.Where(i => i.IncomeID == incomeModel.Id);
            if (!notify.Any())
            {
                if (incomeModel.Date >= DateTime.Now.Date && incomeModel.StatusID == 1)
                {
                    NotificationModel notification = new NotificationModel
                    {
                        userID = incomeModel.UserID,
                        StatusID = incomeModel.StatusID,
                        IncomeID = incomeModel.Id,
                        DueDate = (DateTime)incomeModel.Date,
                        isrecurring = false,
                    };

                    _context.Notification.Add(notification);
                    await _context.SaveChangesAsync();
                }
            }
            var userIdInt = int.Parse(userId);
            var transactionsQuery = _context.Transactions.Where(b => b.UserId == userIdInt).ToList();
            
            var transactioncredits = transactionsQuery.Where(t => t.type == TransactionType.Incomes).Sum(t => t.credit ?? 0);
            var transactiondebits = transactionsQuery.Where(t => t.type == TransactionType.Investment && t.type == TransactionType.Budgets).Sum(t => t.debit ?? 0);
            
            decimal credit = transactionsQuery.Sum(b => b.credit ?? 0);
            decimal debit = transactionsQuery.Sum(b => b.debit ?? 0);
            decimal balance = credit - debit;
            
            FinAccess access = new FinAccess(_context);
            Task bal = access.GetBalanceAsync(userId);
            var transactionToUpdate = transactionsQuery.FirstOrDefault(b => b.incomeid == incomeModel.Id);
            
            if (transactionToUpdate != null)
            {
                transactionToUpdate.credit = incomeModel.Amount;
                transactionToUpdate.valuedate = incomeModel.Date.Value;
                transactionToUpdate.incomeid = incomeModel.Id;
                transactionToUpdate.balance = balance;

                _context.Transactions.Update(transactionToUpdate);
                await _context.SaveChangesAsync();
            }
            else
            {
                TransactionModel transactions = new TransactionModel();
                transactions.credit = incomeModel.Amount;
                transactions.valuedate = incomeModel.Date.Value;
                transactions.incomeid = incomeModel.Id;
                transactions.type = TransactionType.Incomes;
                transactions.incomeid = incomeModel.Id;
                transactions.balance = balance + incomeModel.Amount;
                transactions.UserId = int.Parse(userId);
                _context.Transactions.Add(transactions);
                await _context.SaveChangesAsync();
            }
            return NoContent();
        }

        [Authorize]
        // POST: api/Incomes
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<IncomeModel>> PostIncomeModel(IncomeModel incomeModel)
        {
            var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            // OR if using a custom claim name:
            //var userId = User.FindFirst("userID")?.Value;

            if (userId is null)
            {
                return NoContent();
            }
            incomeModel.UserID = Convert.ToInt32(userId);
            if (incomeModel is null)
            {
                return NoContent();
            }
            
            incomeModel.CreateDate = DateTime.Now;
            _context.Incomes.Add(incomeModel);

            await _context.SaveChangesAsync();

            //foreach (var item in incomePayment)
            //{
            //    item.IncomeID = incomeModel.Id;
            //    _context.incomePayment.Add(item);

            //}

            await _context.SaveChangesAsync();

            var transaction = _context.Transactions.Where(b => b.incomeid == incomeModel.Id);
            decimal lasttransaction = _context.Transactions.OrderByDescending(t => t.createdon).Last()?.balance ?? 0;
            
            if (incomeModel.Status != null || incomeModel.StatusID == 2)
            {
                TransactionModel transactions = new TransactionModel();

                transactions.credit = incomeModel.Amount;
                transactions.valuedate = incomeModel.Date.Value;
                transactions.incomeid = incomeModel.Id;
                transactions.type = TransactionType.Incomes;
                transactions.createdon = DateTime.Now;
                //transactions.date = DateTime.Now;
                transactions.incomeid = incomeModel.Id;
                transactions.balance = lasttransaction + Convert.ToDecimal(incomeModel.Amount);

                _context.Transactions.Add(transactions);
                await _context.SaveChangesAsync();
            }

            //Add Notification
            // Fix for the problematic line in the PostIncomeModel method
            if (incomeModel.Date >= DateTime.Now.Date && incomeModel.StatusID == 1)
            {
                NotificationModel notification = new NotificationModel
                {
                    userID = incomeModel.UserID,
                    StatusID = incomeModel.StatusID,
                    IncomeID = incomeModel.Id,
                    DueDate = (DateTime)incomeModel.Date,
                    isrecurring = false,
                };

                _context.Notification.Add(notification);
                await _context.SaveChangesAsync();
            }

            return CreatedAtAction("GetIncomeModel", new { id = incomeModel.Id }, incomeModel);
        }

        [Authorize]
        // DELETE: api/Incomes/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteIncomeModel(int id)
        {
            var incomeModel = await _context.Incomes.FindAsync(id);
            if (incomeModel == null)
            {
                return NotFound();
            }

            _context.Incomes.Remove(incomeModel);
            await _context.SaveChangesAsync();

            return NoContent();
        }



        private bool IncomeModelExists(int id)
        {
            return _context.Incomes.Any(e => e.Id == id);
        }
    }
}
