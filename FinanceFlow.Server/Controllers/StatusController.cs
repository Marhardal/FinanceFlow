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
    public class StatusController : ControllerBase
    {
        private readonly FinanceDBContext _context;

        public StatusController(FinanceDBContext context)
        {
            _context = context;
        }

        // GET: api/Status
        [HttpGet]
        public async Task<ActionResult<IEnumerable<StatusModel>>> GetStatuses()
        {
            return await _context.Statuses.ToListAsync();
        }

        // GET: api/Status/5
        [HttpGet("{id}")]
        public async Task<ActionResult<StatusModel>> GetStatusModel(int id)
        {
            var statusModel = await _context.Statuses.FindAsync(id);

            if (statusModel == null)
            {
                return NotFound();
            }

            return statusModel;
        }

        // PUT: api/Status/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutStatusModel(int id, StatusModel statusModel)
        {
            if (id != statusModel.id)
            {
                return BadRequest();
            }

            _context.Entry(statusModel).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!StatusModelExists(id))
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

        // POST: api/Status
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<StatusModel>> PostStatusModel(StatusModel statusModel)
        {
            _context.Statuses.Add(statusModel);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetStatusModel", new { id = statusModel.id }, statusModel);
        }

        // DELETE: api/Status/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteStatusModel(int id)
        {
            var statusModel = await _context.Statuses.FindAsync(id);
            if (statusModel == null)
            {
                return NotFound();
            }

            _context.Statuses.Remove(statusModel);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool StatusModelExists(int id)
        {
            return _context.Statuses.Any(e => e.id == id);
        }
    }
}
