using FinanceFlow.Server.DTOs;
using FinanceFlow.Server.Models;

namespace FinanceFlow.Server.Services
{
    public interface IAuthService
    {
        Task<TokenRefresh> AuthenticateAsync(UserDTO user);
        Task<TokenRefresh> RefreshTokensAsync(RefreshTokenDTO token);
        Task<UserModel?> CreateUserAsync(UserDTO user);
    }
}
