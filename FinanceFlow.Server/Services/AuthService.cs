using FinanceFlow.Server.DBContext;
using FinanceFlow.Server.DTOs;
using FinanceFlow.Server.Models;
using iText.Commons.Actions.Contexts;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace FinanceFlow.Server.Services
{
    public class AuthService(FinanceDBContext context, IConfiguration configuration) : IAuthService
    {


        public async Task<string?> AuthenticateAsync(UserDTO request)
        {
            var user = await context.Users.FirstOrDefaultAsync(u => u.Username == request.Username);

            if (user is null)
            {
                return null;
            }

            if (new PasswordHasher<UserModel>().VerifyHashedPassword(user, user.PasswordHash, request.Password) == PasswordVerificationResult.Failed)
            {
                return null;
            }

            return Claim(user);
        }

        private string Claim(UserModel user)
        {
            var claims = new List<Claim>
            {
                new Claim(ClaimTypes.NameIdentifier, user.id.ToString()),
                new Claim(ClaimTypes.Name, user.Username)
            };
            string stoken = configuration.GetValue<string>("AppSettings:Token");
            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(stoken));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha512);
            var token = new JwtSecurityToken(
                issuer: configuration.GetValue<string>("AppSettings:Issuer"),
                audience: configuration.GetValue<string>("AppSettings:Audience"),
                claims: claims,
                expires: DateTime.Now.AddMinutes(30),
                signingCredentials: creds
            );
            return new JwtSecurityTokenHandler().WriteToken(token);
        }

        public async Task<UserModel?> CreateUserAsync(UserDTO request)
        {
            if (await context.Users.AnyAsync(u => u.Username == request.Username))
            {
                return null;
            }
            //var user = await _context.Users.FindAsync(id);
            
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

            context.Users.Add(user);
            await context.SaveChangesAsync();

            return user;
        }
    }
}
