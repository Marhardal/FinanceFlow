using FinanceFlow.Server.DBContext;
using FinanceFlow.Server.DTOs;
using FinanceFlow.Server.Models;
using FinanceFlow.Server.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace FinanceFlow.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController(FinanceDBContext context, IAuthService service) : ControllerBase
    {

        [HttpPost("register")]
        public async Task<ActionResult<UserModel>> Register(UserDTO request)
        {
            var User = await service.CreateUserAsync(request);

            if (User is null)
            {
                return BadRequest("Username already exist.");
            }

            return Ok(User);
        }

        [HttpPost("login")]
        public async Task<ActionResult<TokenRefresh>> Login(UserDTO userDTO)
        {
            var user = await context.Users.ToListAsync();

            var token = await service.AuthenticateAsync(userDTO);

            if (token is null)
            {
                return BadRequest("Either Password or Username is wrong");
            }

            return Ok(token);
        }

        [Authorize]
        [HttpGet("{id}")]
        public async Task<ActionResult> GetUser(int userid = 1)
        {
            var user = await context.Users.FindAsync(userid);
            var identity = (ClaimsIdentity)User.Identity;
            var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            // Or if you used a custom claim:
            //var userId = User.FindFirst("userId")?.Value;
            if (user == null)
            {
                return NotFound("User not found.");
            }

            return Ok(user);
        }

        [HttpPost("refresh-token")]
        public async Task<ActionResult<TokenRefresh>> RefreshToken(RefreshTokenDTO request)
        {
            var result = await service.RefreshTokensAsync(request);
            if (result is null || result.AccessToken is null || request.refreshToken is null)
            {
                return Unauthorized();
            }
            return Ok(result);
        }
    }
 }
