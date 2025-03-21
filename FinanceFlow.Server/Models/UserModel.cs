using Microsoft.Build.Framework;
using System.ComponentModel.DataAnnotations.Schema;

namespace FinanceFlow.Server.Models
{
    public class UserModel
    {
        public Guid id { get; set; }

        [ForeignKey("ReleId")]
        public string? RoleId { get; set; }
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

        public ICollection<IncomeModel>? Incomes { get; set; }

        public RolesModel? Roles { get; set; }
    }
}
