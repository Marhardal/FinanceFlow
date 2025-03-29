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
    public class InvestmentTypesController : ControllerBase
    {
        private readonly FinanceDBContext _context;

        public InvestmentTypesController(FinanceDBContext context)
        {
            _context = context;
        }

        // GET: api/InvestmentTypes
        [HttpGet]
        public async Task<ActionResult<IEnumerable<InvestmentTypeModel>>> GetinvestmentTypes()
        {
            return await _context.investmentTypes.ToListAsync();
        }

        // GET: api/InvestmentTypes/5
        [HttpGet("{id}")]
        public async Task<ActionResult<InvestmentTypeModel>> GetInvestmentTypeModel(int id)
        {
            var investmentTypeModel = await _context.investmentTypes.FindAsync(id);

            if (investmentTypeModel == null)
            {
                return NotFound();
            }

            return investmentTypeModel;
        }

        // PUT: api/InvestmentTypes/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutInvestmentTypeModel(int id, InvestmentTypeModel investmentTypeModel)
        {
            if (id != investmentTypeModel.id)
            {
                return BadRequest();
            }

            _context.Entry(investmentTypeModel).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!InvestmentTypeModelExists(id))
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

        // POST: api/InvestmentTypes
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<InvestmentTypeModel>> PostInvestmentTypeModel(InvestmentTypeModel investmentTypeModel)
        {
            _context.investmentTypes.Add(investmentTypeModel);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetInvestmentTypeModel", new { id = investmentTypeModel.id }, investmentTypeModel);
        }

        // DELETE: api/InvestmentTypes/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteInvestmentTypeModel(int id)
        {
            var investmentTypeModel = await _context.investmentTypes.FindAsync(id);
            if (investmentTypeModel == null)
            {
                return NotFound();
            }

            _context.investmentTypes.Remove(investmentTypeModel);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool InvestmentTypeModelExists(int id)
        {
            return _context.investmentTypes.Any(e => e.id == id);
        }
    }
}
