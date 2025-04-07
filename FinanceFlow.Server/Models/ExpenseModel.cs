using System.ComponentModel.DataAnnotations.Schema;

namespace FinanceFlow.Server.Models
{
    public class ExpenseModel
    {
        public int id { get; set; }

        public int UserID { get; set; } = 0;

        [ForeignKey("ItemID")]
        public int ItemID { get; set; }

        [ForeignKey("BudgetID")]
        public int BudgetID { get; set; }

        public required double Quantity { get; set; } = 0;

        public required double Expectedamount { get; set; } = 0;

        public required double amount { get; set; }

        public required string Description { get; set; }

        public DateTime date { get; set; }

        public DateTime createdate { get; set; } = DateTime.Now;

        public ItemsModel? Item { get; set; }

        public ICollection<ItemsModel> Items { get; set; } = new List<ItemsModel>();

        public BudgetModel? Budget { get; set; }

        public ICollection<BudgetModel> Budgets { get; set; } = new List<BudgetModel>();
    }
}
