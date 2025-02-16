using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace FinanceFlow.Server.Models
{
    public class ItemsModel
    {
        public int Id { get; set; }

        public required string Name { get; set; }

        [Precision(18, 2)]
        public required decimal Price { get; set; }
        
        public DateTime? Date { get; set; } = DateTime.UtcNow;

        [ForeignKey("ExpenseCategoryId")]
        public int ExpenseCategoryId { get; set; }

        //[JsonIgnore]
        public ExpenseCategoriesModel? ExpenseCategory { get; set; }

        public ICollection<ExpenseCategoriesModel> Categories { get; set; } = new List<ExpenseCategoriesModel>();
    }
}
