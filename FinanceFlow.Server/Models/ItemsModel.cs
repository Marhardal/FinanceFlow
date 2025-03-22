using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace FinanceFlow.Server.Models
{
    public class ItemsModel
    {
        public int Id { get; set; }

        [ForeignKey("ItemCategoryId")]
        public int ItemCategoryId { get; set; }

        public required string Name { get; set; }

        public required string? Measurement { get; set; } = null;
        
        public DateTime? Date { get; set; } = DateTime.UtcNow;

        //[JsonIgnore]
        public ItemsCategoriesModel? ItemCategory { get; set; }

        public ICollection<ItemsCategoriesModel> ItemCategories { get; set; } = new List<ItemsCategoriesModel>();

        public ICollection<ExpenseModel> Expenses { get; set; } = new List<ExpenseModel>();
    }
}
