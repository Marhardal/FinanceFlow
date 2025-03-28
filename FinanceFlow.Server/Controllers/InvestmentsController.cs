﻿using System;
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
    public class InvestmentsController : ControllerBase
    {
        private readonly FinanceDBContext _context;

        public InvestmentsController(FinanceDBContext context)
        {
            _context = context;
        }

        // GET: api/Investments
        [HttpGet]
        public async Task<ActionResult<IEnumerable<InvestmentModel>>> GetInvestments()
        {
            return await _context.Investments.ToListAsync();
        }

        // GET: api/Investments/5
        [HttpGet("{id}")]
        public async Task<ActionResult<InvestmentModel>> GetInvestmentModel(int id)
        {
            var investmentModel = await _context.Investments.FindAsync(id);

            if (investmentModel == null)
            {
                return NotFound();
            }

            return investmentModel;
        }

        // PUT: api/Investments/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutInvestmentModel(int id, InvestmentModel investmentModel)
        {
            if (id != investmentModel.id)
            {
                return BadRequest();
            }

            _context.Entry(investmentModel).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!InvestmentModelExists(id))
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

        // POST: api/Investments
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<InvestmentModel>> PostInvestmentModel(InvestmentModel investmentModel)
        {
            _context.Investments.Add(investmentModel);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetInvestmentModel", new { id = investmentModel.id }, investmentModel);
        }

        // DELETE: api/Investments/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteInvestmentModel(int id)
        {
            var investmentModel = await _context.Investments.FindAsync(id);
            if (investmentModel == null)
            {
                return NotFound();
            }

            _context.Investments.Remove(investmentModel);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool InvestmentModelExists(int id)
        {
            return _context.Investments.Any(e => e.id == id);
        }
    }
}
