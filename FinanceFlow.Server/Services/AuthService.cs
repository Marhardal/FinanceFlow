using Azure;
using FinanceFlow.Server.DBContext;
using FinanceFlow.Server.DTOs;
using FinanceFlow.Server.Models;
using iText.Commons.Actions.Contexts;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;

namespace FinanceFlow.Server.Services
{
    public class AuthService(FinanceDBContext context, IConfiguration configuration) : IAuthService
    {

        public async Task<TokenRefresh> AuthenticateAsync(UserDTO request)
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

            string claim = Claim(user);
            UserDTO userDTO = new UserDTO
            {
                Token = claim
            };

            //return userDTO;
            return await createTokenResponce(user, claim);
        }

        private async Task<TokenRefresh>  createTokenResponce(UserModel user, string token)
        {
            if (token is null)
            {
                token = generateToken();
            }
            return new TokenRefresh
            {
                AccessToken = token,
                RefrshToken = await generateAndSaveRefreshTokenasync(user),
                UserID = user.id,
                RoleID = user.RoleId
            };
        }

        public async Task<TokenRefresh> RefreshTokensAsync(RefreshTokenDTO request)
        {
            request.UserId = 1;

            var token = ValidateRefreshTokenAsync(request.UserId, request.refreshToken);

            if (token is null)
            {
                return null;
            }

            var user = await context.Users.AsNoTracking().FirstOrDefaultAsync(u => u.id == request.UserId);

            return await createTokenResponce(user, null);
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

        public string generateToken()
        {
            var randomNumber = new byte[64];
            using var rng = RandomNumberGenerator.Create();
            rng.GetBytes(randomNumber);
            return Convert.ToBase64String(randomNumber);
        }

        private async Task<UserModel?> ValidateRefreshTokenAsync(int UserId, string refreshToken)
        {
            var user = await context.Users.AsNoTracking().FirstOrDefaultAsync(u => u.id == UserId);
            if (user is null || user.refreshToken != refreshToken || user.refreshTokenExpirelyToken <= DateTime.UtcNow)
            {
                return null;
            }
            return user;
        }

        public async Task<string> generateAndSaveRefreshTokenasync(UserModel user)
        {
            var refreshToken = generateToken();
            user.refreshToken = refreshToken;
            user.refreshTokenExpirelyToken = DateTime.UtcNow.AddDays(1);
            await context.SaveChangesAsync();
            return refreshToken;
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
