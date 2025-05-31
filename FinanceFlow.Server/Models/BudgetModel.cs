using System.ComponentModel.DataAnnotations.Schema;

namespace FinanceFlow.Server.Models
{
    public class BudgetModel
    {
        public int Id { get; set; }

        public string? Name { get; set; }

        [ForeignKey("statusID")]
        public int statusID { get; set; }

        public int? UserID { get; set; } = null;

        [ForeignKey("IncomeID")]
        public int? IncomeID { get; set; } = null;

        public string? Description { get; set; }

        public double spentAmount { get; set; } = 0;

        public double Amount { get; set; }

        public DateTime createdon { get; set; } = DateTime.Now;

        public DateTime remindon { get; set; }
    
        public StatusModel? status { get; set; }

        public ICollection<StatusModel> Statuses { get; set; } = new List<StatusModel>();
    
        public IncomeModel? Income { get; set; }

        public ICollection<IncomeModel> Incomes { get; set; } = new List<IncomeModel>();

        public ICollection<ExpenseModel> Expenses { get; set; } = new List<ExpenseModel>();
    
        public TransactionModel? Transaction { get; set; }

        public NotificationModel? Notification { get; set; }

        public UserModel? User { get; set; }
    }
}
