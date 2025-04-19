using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace FinanceFlow.Server.Models
{
    public class IncomeModel
    {
        public int Id { get; set; }  // Standard PascalCase for public properties

        public required string Name { get; set; }

        [ForeignKey("UserID")]
        public required int UserID { get; set; }

        public required int StatusID { get; set; }  // Foreign key property

        public required int IncomeCategoryID { get; set; }  // Foreign key property

        public required string Description { get; set; }

        [Precision(18, 2)]
        public required decimal Amount { get; set; }

        public DateTime? Date { get; set; }

        public DateTime CreateDate { get; set; }

        // Navigation Properties
        [ForeignKey(nameof(StatusID))]  // Correct FK annotation
        public StatusModel? Status {get; set; }

        [ForeignKey(nameof(IncomeCategoryID))]  // Correct FK annotation
        public IncomeCategoryModel? IncomeCategory { get; set; }

        public ICollection<BudgetModel>? Budgets { get; set; }

        public ICollection<IncomePaymentModel>? IncomePayment { get; set; } = new List<IncomePaymentModel>();

        public TransactionModel? Transaction { get; set; }

        public InvestModel? Invest { get; set; }

        public UserModel? User { get; set; }
    }
}
