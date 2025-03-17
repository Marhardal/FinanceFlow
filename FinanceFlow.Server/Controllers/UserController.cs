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

        [HttpPost("register")]
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

        [HttpPost("login")]
        public async Task<ActionResult<UserModel>> Login(UserDTO userDTO)
        {
            if (userDTO is null)
            {
                return NoContent();
            }

            UserModel user = new UserModel();
            var password = new PasswordHasher<UserModel>().HashPassword(user, userDTO.Password);
            user.Username = userDTO.Username;
            user.PasswordHash = password;

            IQueryable usr = _context.Users.Where(u => u.Username == user.Username).Where(u => u.PasswordHash == user.PasswordHash);

            if (user is null)
            {
                return NoContent();
            }

            return Ok();
        }
    }
}
