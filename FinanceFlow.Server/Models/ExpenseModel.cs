using System.ComponentModel.DataAnnotations.Schema;

namespace FinanceFlow.Server.Models
{
    public class ExpenseModel
    {
        public int id { get; set; }

        public int UserID { get; set; }

        [ForeignKey("ItemID")]
        public int ItemID { get; set; }

        public required double Quantity { get; set; }

        public required double amount { get; set; }

        public required string Description { get; set; }

        public DateTime createdate { get; set; } = DateTime.Now;

        public ItemsModel? Item { get; set; }

        public ICollection<ItemsModel> Items { get; set; } = new List<ItemsModel>();
    }
}
