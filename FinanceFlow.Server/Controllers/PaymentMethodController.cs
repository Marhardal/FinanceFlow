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
    public class PaymentMethodController : ControllerBase
    {
        private readonly FinanceDBContext _context;

        public PaymentMethodController(FinanceDBContext context)
        {
            _context = context;
        }

        [Authorize]
        // GET: api/PaymentMethod
        [HttpGet]
        public async Task<ActionResult<IEnumerable<PaymentMethodModel>>> GetpaymentMethods()
        {
            return await _context.paymentMethods.ToListAsync();
        }

        [Authorize]
        // GET: api/PaymentMethod/5
        [HttpGet("{id}")]
        public async Task<ActionResult<PaymentMethodModel>> GetPaymentMethodModel(int id)
        {
            var paymentMethodModel = await _context.paymentMethods.FindAsync(id);

            if (paymentMethodModel == null)
            {
                return NotFound();
            }

            return paymentMethodModel;
        }

        [Authorize]
        // PUT: api/PaymentMethod/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutPaymentMethodModel(int id, PaymentMethodModel paymentMethodModel)
        {
            if (id != paymentMethodModel.id)
            {
                return BadRequest();
            }

            _context.Entry(paymentMethodModel).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!PaymentMethodModelExists(id))
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
        // POST: api/PaymentMethod
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<PaymentMethodModel>> PostPaymentMethodModel(PaymentMethodModel paymentMethodModel)
        {
            _context.paymentMethods.Add(paymentMethodModel);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetPaymentMethodModel", new { id = paymentMethodModel.id }, paymentMethodModel);
        }

        [Authorize]
        // DELETE: api/PaymentMethod/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeletePaymentMethodModel(int id)
        {
            var paymentMethodModel = await _context.paymentMethods.FindAsync(id);
            if (paymentMethodModel == null)
            {
                return NotFound();
            }

            _context.paymentMethods.Remove(paymentMethodModel);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool PaymentMethodModelExists(int id)
        {
            return _context.paymentMethods.Any(e => e.id == id);
        }
    }
}
