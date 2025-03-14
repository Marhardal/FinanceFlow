﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using FinanceFlow.Server.DBContext;
using FinanceFlow.Server.Models;
using FinanceFlow.Server.Migrations;

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

        // GET: api/Incomes
        [HttpGet]
        public async Task<ActionResult<IEnumerable<IncomeModel>>> GetIncomeModel(string search = null)
        {
            
            IQueryable<IncomeModel> query = _context.IncomeModel.Include(s => s.Status).Include(c => c.IncomeCategory);
            if (!string.IsNullOrEmpty(search))
            {
                query = query.Where(i => i.Name.Contains(search) || i.Status.Name.Contains(search) || i.IncomeCategory.name.Contains(search));
            }
            List<IncomeModel> incomes = await query.ToListAsync();
            return Ok(incomes);
        }

        // GET: api/Incomes/5
        [HttpGet("{id}")]
        public async Task<ActionResult<IncomeModel>> GetIncomeModel(int id)
        {
            var incomeModel = await _context.IncomeModel.FindAsync(id);

            if (incomeModel == null)
            {
                return NotFound();
            }

            return incomeModel;
        }

        // PUT: api/Incomes/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutIncomeModel(int id, IncomeModel incomeModel)
        {
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

            if (incomeModel.Status is not null || incomeModel.StatusID is 2)
            {
                TransactionModel transactions = new TransactionModel();

                transactions.amount = incomeModel.Amount;
                transactions.date = DateTime.Now;
                transactions.incomeid = incomeModel.Id;
                transactions.type = TransactionType.Incomes;
                transactions.createdon = DateTime.Now;
                transactions.date = DateTime.Now;
                transactions.incomeid = incomeModel.Id;

                _context.Transactions.Add(transactions);
                await _context.SaveChangesAsync();
            }

            return NoContent();
        }

        // POST: api/Incomes
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<IncomeModel>> PostIncomeModel(IncomeModel incomeModel)
        {
            if (incomeModel is null)
            {
                return NoContent();
            }
            
            incomeModel.CreateDate = DateTime.Now;
            _context.IncomeModel.Add(incomeModel);

            await _context.SaveChangesAsync();

            //foreach (var item in incomePayment)
            //{
            //    item.IncomeID = incomeModel.Id;
            //    _context.incomePayment.Add(item);

            //}

            await _context.SaveChangesAsync();

            if (incomeModel.Status is not null || incomeModel.Status.Name is "Approved")
            {
                TransactionModel transactions = new TransactionModel();

                transactions.amount = incomeModel.Amount;
                transactions.date = DateTime.Now;
                transactions.incomeid = incomeModel.Id;
                transactions.type = TransactionType.Incomes;
                transactions.createdon = DateTime.Now;
                transactions.date = DateTime.Now;
                transactions.incomeid = incomeModel.Id;

                _context.Transactions.Add(transactions);
                await _context.SaveChangesAsync();
            }

            return CreatedAtAction("GetIncomeModel", new { id = incomeModel.Id }, incomeModel);
        }

        // DELETE: api/Incomes/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteIncomeModel(int id)
        {
            var incomeModel = await _context.IncomeModel.FindAsync(id);
            if (incomeModel == null)
            {
                return NotFound();
            }

            _context.IncomeModel.Remove(incomeModel);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool IncomeModelExists(int id)
        {
            return _context.IncomeModel.Any(e => e.Id == id);
        }
    }
}
