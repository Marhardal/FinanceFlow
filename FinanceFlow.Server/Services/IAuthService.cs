using FinanceFlow.Server.DTOs;
using FinanceFlow.Server.Models;

namespace FinanceFlow.Server.Services
{
    public interface IAuthService
    {
        Task<UserDTO> AuthenticateAsync(UserDTO user);

        Task<UserModel?> CreateUserAsync(UserDTO user);
    }
}
