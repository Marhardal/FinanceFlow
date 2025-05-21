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
    public class NotificationController : ControllerBase
    {
        private readonly FinanceDBContext _context;

        public NotificationController(FinanceDBContext context)
        {
            _context = context;
        }

        // GET: api/Notification
        [HttpGet]
        public async Task<ActionResult<IEnumerable<NotificationModel>>> GetNotification()
        {
            return await _context.Notification.ToListAsync();
        }

        // GET: api/Notification/5
        [HttpGet("{id}")]
        public async Task<ActionResult<NotificationModel>> GetNotificationModel(int id)
        {
            var notificationModel = await _context.Notification.FindAsync(id);

            if (notificationModel == null)
            {
                return NotFound();
            }

            return notificationModel;
        }

        // PUT: api/Notification/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutNotificationModel(int id, NotificationModel notificationModel)
        {
            if (id != notificationModel.Id)
            {
                return BadRequest();
            }

            _context.Entry(notificationModel).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!NotificationModelExists(id))
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

        // POST: api/Notification
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<NotificationModel>> PostNotificationModel(NotificationModel notificationModel)
        {
            _context.Notification.Add(notificationModel);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetNotificationModel", new { id = notificationModel.Id }, notificationModel);
        }

        // DELETE: api/Notification/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteNotificationModel(int id)
        {
            var notificationModel = await _context.Notification.FindAsync(id);
            if (notificationModel == null)
            {
                return NotFound();
            }

            _context.Notification.Remove(notificationModel);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool NotificationModelExists(int id)
        {
            return _context.Notification.Any(e => e.Id == id);
        }
    }
}
