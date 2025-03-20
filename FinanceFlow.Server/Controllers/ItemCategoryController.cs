using FinanceFlow.Server.DBContext;
//using FinanceFlow.Server.Migrations.FinanceDB;
using FinanceFlow.Server.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Migrations.Internal;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace FinanceFlow.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ItemCategoryController : ControllerBase
    {
        private readonly FinanceDBContext _dbContext;

        public ItemCategoryController(FinanceDBContext context)
        {
            _dbContext = context;
        }

        [Authorize]
        // GET: api/<ExpenseCategoryController>
        [HttpGet]
        public async Task<ActionResult<List<ItemsCategoriesModel>>> Get()
        {
            return Ok(await _dbContext.ItemCategories.ToListAsync());
        }

        [Authorize]
        // GET api/<ExpenseCategoryController>/5
        [HttpGet("{id}")]
        public async Task<ActionResult> Get(int id)
        {
            var category = await _dbContext.ItemCategories.FindAsync(id);
            if (category == null)
            {
                return NotFound();
            }
            return Ok(category);
        }

        [Authorize]
        // POST api/<ExpenseCategoryController>
        [HttpPost]
        public async Task<ActionResult<ItemsCategoriesModel>> Post(ItemsCategoriesModel categories)
        {
            if (categories is null)
            {
                return BadRequest();
            }
            _dbContext.ItemCategories.Add(categories);
            await _dbContext.SaveChangesAsync();
            return CreatedAtAction(nameof(Get), new { id = categories.Id }, categories);
        }

        [Authorize]
        // PUT api/<ExpenseCategoryController>/5
        [HttpPut("{id}")]
        public async Task<ActionResult> Put(int id, ItemsCategoriesModel expenseCategories)
        {
            var category = await _dbContext.ItemCategories.FindAsync(id);

            if (category is null)
                return NotFound();

            category.Name = expenseCategories.Name;

            await _dbContext.SaveChangesAsync();

            return NoContent();
        }

        [Authorize]
        // DELETE api/<ExpenseCategoryController>/5
        [HttpDelete("{id}")]
        public async Task<ActionResult> Delete(int id)
        {
            var category = await _dbContext.ItemCategories.FindAsync(id);

            if (category is null)
                return NotFound();

            _dbContext.ItemCategories.Remove(category);

            await _dbContext.SaveChangesAsync();

            return NoContent();
        }
    }
}
