using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using NuGet.Packaging.Signing;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace FinanceFlow.Server.Models
{
    public class NotificationModel
    {
        public int Id { get; set; }

        public int reminderCount { get; set; } = 0;

        //[ForeignKey("userID")]

        [Required]
        public int userID { get; set; }

        //[ForeignKey("StatusID")]
        public int? StatusID { get; set; }

        //[ForeignKey("IncomeID")]
        public int? IncomeID { get; set; }

        //[ForeignKey("BudgetID")]
        public int? BudgetID { get; set; }

        //[ForeignKey("InvestID")]
        //public int? InvestID { get; set; }

        public DateTime DueDate { get; set; }

        public DateTime completedat { get; set; }

        public bool isrecurring { get; set; }

        public DateTime createdAt { get; set; } = DateTime.Now;

        public DateTime updatedAt { get; set; } = DateTime.UtcNow;

        public StatusModel? Status { get; set; }

        //public InvestModel? Invest { get; set; }

        public BudgetModel? Budget { get; set; }

        public IncomeModel? Income { get; set; }

        public UserModel? User { get; set; }
    }
}
