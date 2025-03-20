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
    public class IncomeCategoryController : ControllerBase
    {
        private readonly FinanceDBContext _context;

        public IncomeCategoryController(FinanceDBContext context)
        {
            _context = context;
        }

        [Authorize]
        // GET: api/IncomeCategory
        [HttpGet]
        public async Task<ActionResult<IEnumerable<IncomeCategoryModel>>> GetincomeCategories()
        {
            return await _context.incomeCategories.ToListAsync();
        }

        [Authorize]
        // GET: api/IncomeCategory/5
        [HttpGet("{id}")]
        public async Task<ActionResult<IncomeCategoryModel>> GetIncomeCategoryModel(int id)
        {
            var incomeCategoryModel = await _context.incomeCategories.FindAsync(id);

            if (incomeCategoryModel == null)
            {
                return NotFound();
            }

            return incomeCategoryModel;
        }

        [Authorize]
        // PUT: api/IncomeCategory/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutIncomeCategoryModel(int id, IncomeCategoryModel incomeCategoryModel)
        {
            if (id != incomeCategoryModel.id)
            {
                return BadRequest();
            }

            _context.Entry(incomeCategoryModel).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!IncomeCategoryModelExists(id))
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
        // POST: api/IncomeCategory
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<IncomeCategoryModel>> PostIncomeCategoryModel(IncomeCategoryModel incomeCategoryModel)
        {
            _context.incomeCategories.Add(incomeCategoryModel);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetIncomeCategoryModel", new { id = incomeCategoryModel.id }, incomeCategoryModel);
        }

        [Authorize]
        // DELETE: api/IncomeCategory/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteIncomeCategoryModel(int id)
        {
            var incomeCategoryModel = await _context.incomeCategories.FindAsync(id);
            if (incomeCategoryModel == null)
            {
                return NotFound();
            }

            _context.incomeCategories.Remove(incomeCategoryModel);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool IncomeCategoryModelExists(int id)
        {
            return _context.incomeCategories.Any(e => e.id == id);
        }
    }
}
