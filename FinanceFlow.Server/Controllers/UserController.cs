using FinanceFlow.Server.DBContext;
using FinanceFlow.Server.DTOs;
using FinanceFlow.Server.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace FinanceFlow.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly FinanceDBContext _context;

        public UserController(FinanceDBContext context)
        {
            _context = context;
        }

        public async Task<ActionResult<UserModel>> Register(UserDTO request)
        {
            //var user = await _context.Users.FindAsync(id);
            if (request == null)
            {
                return NotFound();
            }

            var user = new UserModel
            {
                FirstName = request.FirstName,
                Surname = request.Surname,
                Email = request.Email,
                Username = request.Username,
                DOB = request.DOB,
                createat = request.createat
            };

            var hashed = new PasswordHasher<UserModel>().HashPassword(user, request.Password);

            user.PasswordHash = hashed;

            _context.Users.Add(user);
            await _context.SaveChangesAsync();
            
            return Ok();
        }
    }
}
