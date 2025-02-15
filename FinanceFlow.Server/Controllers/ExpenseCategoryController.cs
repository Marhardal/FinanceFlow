using FinanceFlow.Server.DBContext;
//using FinanceFlow.Server.Migrations.FinanceDB;
using FinanceFlow.Server.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Migrations.Internal;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace FinanceFlow.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ExpenseCategoryController : ControllerBase
    {
        private readonly FinanceDBContext _dbContext;

        public ExpenseCategoryController(FinanceDBContext context)
        {
            _dbContext = context;
        }

        // GET: api/<ExpenseCategoryController>
        [HttpGet]
        public async Task<ActionResult<List<ExpenseCategoriesModel>>> Get()
        {
            return Ok(await _dbContext.ExpenseCategories.ToListAsync());
        }

        // GET api/<ExpenseCategoryController>/5
        [HttpGet("{id}")]
        public async Task<ActionResult> Get(int id)
        {
            var category = await _dbContext.ExpenseCategories.FindAsync(id);
            if (category == null)
            {
                return NotFound();
            }
            return Ok(category);
        }

        // POST api/<ExpenseCategoryController>
        [HttpPost]
        public async Task<ActionResult<ExpenseCategoriesModel>> Post(ExpenseCategoriesModel categories)
        {
            if (categories is null)
            {
                return BadRequest();
            }
            _dbContext.ExpenseCategories.Add(categories);
            await _dbContext.SaveChangesAsync();
            return CreatedAtAction(nameof(Get), new { id = categories.Id }, categories);
        }

        // PUT api/<ExpenseCategoryController>/5
        [HttpPut("{id}")]
        public async Task<ActionResult> Put(int id, ExpenseCategoriesModel expenseCategories)
        {
            var category = await _dbContext.ExpenseCategories.FindAsync(id);

            if (category is null)
                return NotFound();

            category.Name = expenseCategories.Name;

            await _dbContext.SaveChangesAsync();

            return NoContent();
        }

        // DELETE api/<ExpenseCategoryController>/5
        [HttpDelete("{id}")]
        public async Task<ActionResult> Delete(int id)
        {
            var category = await _dbContext.ExpenseCategories.FindAsync(id);

            if (category is null)
                return NotFound();

            _dbContext.ExpenseCategories.Remove(category);

            await _dbContext.SaveChangesAsync();

            return NoContent();
        }
    }
}
