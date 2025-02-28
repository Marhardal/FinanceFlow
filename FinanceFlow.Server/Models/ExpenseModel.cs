using System.ComponentModel.DataAnnotations.Schema;

namespace FinanceFlow.Server.Models
{
    public class ExpenseModel
    {
        public int id { get; set; }

        public int UserID { get; set; } = 0;

        [ForeignKey("ItemID")]
        public int ItemID { get; set; }

        [ForeignKey("IncomeID")]
        public int IncomeID { get; set; }

        public required double Quantity { get; set; }

        public required double amount { get; set; }

        public required string Description { get; set; }

        public DateTime createdate { get; set; } = DateTime.Now;

        public ItemsModel? Item { get; set; }

        public ICollection<ItemsModel> Items { get; set; } = new List<ItemsModel>();

        public IncomeModel? Income { get; set; }

        public ICollection<IncomeModel> Incomes { get; set; } = new List<IncomeModel>();
    }
}
