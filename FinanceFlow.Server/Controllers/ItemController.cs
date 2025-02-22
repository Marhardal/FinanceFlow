using FinanceFlow.Server.DBContext;
using FinanceFlow.Server.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace FinanceFlow.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ItemController : ControllerBase
    {
        private readonly FinanceDBContext _dbContext;

        public ItemController(FinanceDBContext context)
        {
            _dbContext = context;
        }

        // GET: api/<ItemController>
        [HttpGet]
        public async Task<ActionResult<List<ItemsModel>>> Get(string search = null)
        {
            if (_dbContext.Items is null)
            {
                return NotFound();
            }

            IQueryable<ItemsModel> query = _dbContext.Items.Include(i => i.ItemCategory);

            if (!string.IsNullOrEmpty(search))
            {
                query = query.Where(i => i.Name.Contains(search) || i.ItemCategory.Name.Contains(search));
            }

            List<ItemsModel> items = await query.ToListAsync();

            return Ok(items);
        }


        [HttpGet("{id}")]
        public async Task<ActionResult> Get(int id)
        {
            var items = await _dbContext.Items.FindAsync(id);
            if (items == null)
            {
                return NotFound();
            }
            return Ok(items);
        }

        // POST api/<ItemController>
        [HttpPost]
        public async Task<ActionResult> Post(ItemsModel items)
        {
            if (items is null)
            {
                return NoContent();
            }
            items.Date = DateTime.UtcNow;
            _dbContext.Items.Add(items);
            await _dbContext.SaveChangesAsync();
            return CreatedAtAction(nameof(Get), new { id = items.Id }, items);
        }

        // PUT api/<ItemController>/5
        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, [FromBody] ItemsModel items)
        {
            if (id != items.Id)
            {
                return BadRequest();
            }

            _dbContext.Entry(items).State = EntityState.Modified;

            try
            {
                await _dbContext.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!_dbContext.Items.Any(e => e.Id == id))
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

        // DELETE api/<ItemController>/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            var item = await _dbContext.Items.FindAsync(id);
            if (item == null)
            {
                return NotFound();
            }

            _dbContext.Items.Remove(item);
            await _dbContext.SaveChangesAsync();

            return NoContent();
        }
    }
}
