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
    public class InvestsController : ControllerBase
    {
        private readonly FinanceDBContext _context;

        public InvestsController(FinanceDBContext context)
        {
            _context = context;
        }

        // GET: api/Invests
        [HttpGet]
        public async Task<ActionResult<IEnumerable<InvestModel>>> GetInvests()
        {
            return await _context.Invests.ToListAsync();
        }

        // GET: api/Invests/5
        [HttpGet("{id}")]
        public async Task<ActionResult<InvestModel>> GetInvestModel(int id)
        {
            var investModel = await _context.Invests.FindAsync(id);

            if (investModel == null)
            {
                return NotFound();
            }

            return investModel;
        }

        // PUT: api/Invests/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutInvestModel(int id, InvestModel investModel)
        {
            if (id != investModel.Id)
            {
                return BadRequest();
            }

            _context.Entry(investModel).State = EntityState.Modified;

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

            return NoContent();
        }

        // POST: api/Invests
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<InvestModel>> PostInvestModel(InvestModel investModel)
        {
            _context.Invests.Add(investModel);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetInvestModel", new { id = investModel.Id }, investModel);
        }

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
