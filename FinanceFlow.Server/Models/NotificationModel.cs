using System.ComponentModel.DataAnnotations.Schema;

namespace FinanceFlow.Server.Models
{
    public class NotificationModel
    {
        public int Id { get; set; }

        public NotifyType Type { get; set; }

        [ForeignKey("IncomeID")]
        public int IncomeID { get; set; }

        [ForeignKey("BudgetID")]
        public int BudgetID { get; set; }

        public string? Message { get; set; }

        public DateTime Date { get; set; }

        public DateTime createdOn { get; set; } = DateTime.UtcNow;

        public IncomeModel? Income { get; set; }

        public BudgetModel? Budget { get; set; }
        public enum NotifyType
        {
            Income,
            Budget,
        }
    }
}
