using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace FinanceFlow.Server.Models
{
    public class ItemsModel
    {
        public int Id { get; set; }

        public required string Name { get; set; }

        [Precision(18, 2)]
        public required decimal Price { get; set; }
        
        public DateTime Date { get; set; }

        [ForeignKey("ExpenseCategoryId")]
        public int ExpenseCategoryId { get; set; }
        
        public ExpenseCategoriesModel ExpenseCategory { get; set; } = new ExpenseCategoriesModel { Name = string.Empty };
    }
}
