using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using FinanceFlow.Server.DBContext;
using FinanceFlow.Server.Models;
using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;

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

        [Authorize]
        // GET: api/Investments
        [HttpGet]
        public async Task<ActionResult<IEnumerable<InvestmentModel>>> GetInvestments(string search = null)
        {
            string userId = "3";
            //string userId = HttpContext.User.Claims.FirstOrDefault(ClaimTypes.NameIdentifier.ToString())
            if (userId is null)
            {
                return NoContent();
            }
            IQueryable<InvestmentModel> queryable = _context.Investments.Include(t => t.investmentType).Where(i => i.UserId == int.Parse(userId));
            if (queryable is null)
            {
                return NoContent();
            }
            if (search is not null)
            {
                queryable = queryable.Where(i =>
           i.Company.Contains(search) ||
           i.Name.Contains(search) ||
           i.Reference.Contains(search) ||
           i.investmentType.name.Contains(search)
       );
            }
            List<InvestmentModel> investments = await queryable.ToListAsync();
            return investments;
        }

        [Authorize]
        // GET: api/Investments/5
        [HttpGet("{id}")]
        public async Task<ActionResult<InvestmentModel>> GetInvestmentModel(int id)
        {
            var investmentModel = await _context.Investments.Include(t => t.investmentType).FirstOrDefaultAsync(i => i.id == id);

            if (investmentModel == null)
            {
                return NotFound();
            }

            return investmentModel;
        }

        [Authorize]
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

        [Authorize]
        // POST: api/Investments
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<InvestmentModel>> PostInvestmentModel(InvestmentModel investmentModel)
        {
            _context.Investments.Add(investmentModel);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetInvestmentModel", new { id = investmentModel.id }, investmentModel);
        }

        [Authorize]
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
