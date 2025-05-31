using Microsoft.Build.Framework;
using System.ComponentModel.DataAnnotations.Schema;

namespace FinanceFlow.Server.Models
{
    public class UserModel
    {
        public int id { get; set; }

        [ForeignKey("ReleId")]
        public int RoleId { get; set; }
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

        public DateTime DOB { get; set; } = DateTime.Now;

        public DateTime createat { get; set; } = DateTime.Now;

        public string? refreshToken { get; set; }

        public DateTime? refreshTokenExpirelyToken { get; set; }

        public ICollection<IncomeModel>? Incomes { get; set; }

        public ICollection<BudgetModel>? Budgets { get; set; }

        public ICollection<NotificationModel>? Notification { get; set; }

        public RolesModel? Roles { get; set; }

    }
}
