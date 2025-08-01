﻿using System;
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

namespace FinanceFlow.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class InvestsController : ControllerBase
    {
        private readonly FinanceDBContext _context;

        public InvestsController(FinanceDBContext context)
        {
            _context = context;
        }

        [Authorize]
        // GET: api/Invests
        [HttpGet("{investmentid}")]
        public async Task<ActionResult<IEnumerable<InvestModel>>> GetInvests(int investmentid, string search = null)
        {
            IQueryable<InvestModel> invests = _context.Invests
                .Include(s => s.Status)
                .Include(i => i.Incomes)
                .Where(b => b.InvestmentId == investmentid);

            // Apply search filter if provided
            if (!string.IsNullOrEmpty(search))
            {
                invests = invests.Where(i => i.Status.Name.Contains(search));
            }

            // Check if there are any results
            if (!await invests.AnyAsync())
            {
                return NoContent();
            }

            return await invests.ToListAsync();
        }

        [Authorize]
        // GET: api/Invests/5
        [HttpGet("{investid}/{investmentid}")]
        public async Task<ActionResult<InvestModel>> GetInvestModel(int investid, int investmentid)
        {
            var investModel = await _context.Invests.FindAsync(investid);

            if (investModel == null)
            {
                return NotFound();
            }

            return investModel;
        }

        [Authorize]
        // PUT: api/Invests/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutInvestModel(int id, InvestModel investModel)
        {
            var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;

            if (id != investModel.Id)
            {
                return BadRequest();
            }

            _context.Entry(investModel).State = EntityState.Modified;
            if (investModel.InvestmentId != 0)
            {
                var investment = await _context.Investments.FindAsync(investModel.InvestmentId);
                if (investModel.StatusID == 2)
                {
                    if (investment != null)
                    {
                        if (investment.CurrentAmount.HasValue)
                        {
                            investment.CurrentAmount += Convert.ToDecimal(investModel.amount);
                        }
                        else
                        {
                            investment.CurrentAmount = Convert.ToDecimal(investModel.amount);
                        }
                        _context.Investments.Update(investment);
                    }
                }
            }

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!InvestModelExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            //            var transaction = _context.Transactions.Where(b => b.investId == investModel.Id && b.UserId == int.Parse(userId)).FirstOrDefault();

            //            var lasttransaction = _context.Transactions
            //.OrderByDescending(t => t.createdon).Last()?.balance ?? 0;

            //            if (transaction is not null)
            //            {
            //                TransactionModel transactions = new TransactionModel();
            //                transactions.id = transaction.id;
            //                transactions.debit = Convert.ToDecimal(investModel.amount);
            //                transactions.valuedate = investModel.Date;
            //                transactions.investId = investModel.Id;
            //                transactions.type = TransactionType.Investment;
            //                //transactions.createdon = DateTime.Now;
            //                //transactions.date = DateTime.Now;
            //                transactions.balance = lasttransaction - Convert.ToDecimal(investModel.amount);
            //                _context.Update(transactions);
            //                await _context.SaveChangesAsync();
            //            }

            var userIdInt = int.Parse(userId);
            var transactionsQuery = _context.Transactions.Where(b => b.UserId == userIdInt);

            decimal credit = transactionsQuery.Sum(b => b.credit ?? 0);
            decimal debit = transactionsQuery.Sum(b => b.debit ?? 0);
            decimal balance = credit - debit;

            var transactionToUpdate = transactionsQuery.FirstOrDefault(b => b.investId == investModel.InvestmentId);

            if (transactionToUpdate != null)
            {
                transactionToUpdate.debit = investModel.amount;
                transactionToUpdate.valuedate = investModel.Date;
                transactionToUpdate.investId = investModel.Id;
                transactionToUpdate.balance = balance;
                _context.Transactions.Update(transactionToUpdate);
                await _context.SaveChangesAsync();
            }
            else
            {
                TransactionModel transactions = new TransactionModel();
                transactions.debit = investModel.amount;
                transactions.valuedate = investModel.Date;
                transactions.investId = investModel.InvestmentId;
                transactions.type = TransactionType.Investment;
                transactions.balance = balance - investModel.amount;
                transactions.UserId = int.Parse(userId);
                _context.Transactions.Add(transactions);
                await _context.SaveChangesAsync();
            }

            return NoContent();
        }

        [Authorize]
        // POST: api/Invests
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<InvestModel>> PostInvestModel(InvestModel investModel)
        {
            var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            // OR if using a custom claim name:
            //var userId = User.FindFirst("userID")?.Value;

            if (investModel is null && userId is null)
            {
                return NoContent();
            }
            _context.Invests.Add(investModel);
            await _context.SaveChangesAsync();
            var investment = await _context.Investments.FindAsync(investModel.InvestmentId);
            if (investModel.StatusID == 2)
            {
                if (investment != null)
                {
                    if (investModel.StatusID == 2)
                    {
                        if (investment.CurrentAmount.HasValue)
                        {
                            investment.CurrentAmount += Convert.ToDecimal(investModel.amount);
                        }
                        else
                        {
                            investment.CurrentAmount = Convert.ToDecimal(investModel.amount);
                        }
                        _context.Investments.Update(investment);
                    }

                    var userIdInt = int.Parse(userId);
                    var transactionsQuery = _context.Transactions.Where(b => b.UserId == userIdInt);

                    decimal credit = transactionsQuery.Sum(b => b.credit ?? 0);
                    decimal debit = transactionsQuery.Sum(b => b.debit ?? 0);
                    decimal balance = credit - debit;

                    var transactionToUpdate = transactionsQuery.FirstOrDefault(b => b.investId == investModel.InvestmentId);

                    if (transactionToUpdate == null)
                    {
                        TransactionModel transactions = new TransactionModel();
                        transactions.debit = investModel.amount;
                        transactions.valuedate = investModel.Date;
                        transactions.investId = investModel.InvestmentId;
                        transactions.type = TransactionType.Investment;
                        transactions.balance = balance - investModel.amount;
                        transactions.UserId = int.Parse(userId);
                        _context.Transactions.Add(transactions);
                        await _context.SaveChangesAsync();
                    }

                }
            }
            
            await _context.SaveChangesAsync();

            if (investModel.Date >= DateTime.Now.Date && investModel.StatusID == 1)
            {
                NotificationModel notification = new NotificationModel
                {
                    userID = int.Parse(userId),
                    StatusID = 1,
                    InvestID = investModel.Id,
                    DueDate = (DateTime)investModel.Date,
                    isrecurring = false,
                };

                _context.Notification.Add(notification);
                await _context.SaveChangesAsync();
            }

            return CreatedAtAction("GetInvestModel", new { id = investModel.Id }, investModel);
        }

        [Authorize]
        // DELETE: api/Invests/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteInvestModel(int id)
        {
            var investModel = await _context.Invests.FindAsync(id);
            if (investModel == null)
            {
                return NotFound();
            }

            _context.Invests.Remove(investModel);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool InvestModelExists(int id)
        {
            return _context.Invests.Any(e => e.Id == id);
        }
    }
}
