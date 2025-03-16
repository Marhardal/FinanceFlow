using Microsoft.Build.Framework;

namespace FinanceFlow.Server.Models
{
    public class UserModel
    {
        public int id { get; set; }

        [Required]
        public string? FirstName { get; set; }

        [Required]
        public string? Surname { get; set; }

        [Required]
        public string? Email { get; set; }

        [Required]
        public string? Username { get; set; }

        [Required]
        public string? PasswordHash { get; set; }

        public DateOnly DOB { get; set; } = DateOnly.MinValue;

        public DateTime createat { get; set; } = DateTime.Now;
    }
}
