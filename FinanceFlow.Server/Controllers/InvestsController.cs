using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using FinanceFlow.Server.DBContext;
using FinanceFlow.Server.Models;
using FinanceFlow.Server.Migrations;
using Microsoft.AspNetCore.Authorization;

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
            IQueryable<InvestModel> invests = _context.Invests.Include(s => s.Status).Include(i => i.Income).Where(b => b.InvestmentId == investmentid);
            // Add additional logic to handle the search parameter and return the result
            if (invests is null)
            {
                return NoContent();
            }
            if (search is not null)
            {
                invests.Where(i => i.Status.Name.Contains(search));
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

        [Authorize]
        // POST: api/Invests
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<InvestModel>> PostInvestModel(InvestModel investModel)
        {
            if (investModel is null)
            {
                return NoContent();
            }
            _context.Invests.Add(investModel);
            await _context.SaveChangesAsync();

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
