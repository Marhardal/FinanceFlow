using FinanceFlow.Server.DBContext;
using FinanceFlow.Server.DTOs;
using FinanceFlow.Server.Models;
using FinanceFlow.Server.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace FinanceFlow.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController(IAuthService service) : ControllerBase
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
        public async Task<ActionResult<string>> Login(UserDTO userDTO)
        {
            var usertoken = await service.AuthenticateAsync(userDTO);

            if (usertoken is null)
            {
                return BadRequest("Either Password or Username is wrong");
            }

            return Ok(usertoken);
        }

    }
}
