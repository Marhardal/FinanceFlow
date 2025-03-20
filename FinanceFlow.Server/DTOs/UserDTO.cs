using FinanceFlow.Server.Models;
using System.ComponentModel.DataAnnotations;

namespace FinanceFlow.Server.DTOs
{
    public class UserDTO
    {
        public int id { get; set; }

        public string? FirstName { get; set; } = null;

        public string? Surname { get; set; } = null;

        public string? Email { get; set; } = null;

        public string? Username { get; set; } = null;

        public string? Password { get; set; } = null;

        public DateOnly DOB { get; set; } = DateOnly.MinValue;

        public DateTime createat { get; set; } = DateTime.Now;

        public string? Token { get; set; }

        public UserModel? User { get; set; }
    }
}
