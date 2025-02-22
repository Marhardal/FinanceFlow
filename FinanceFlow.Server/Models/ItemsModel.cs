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

        [ForeignKey("ItemCategoryId")]
        public int ItemCategoryId { get; set; }

        //[JsonIgnore]
        public ItemsCategoriesModel? ItemCategory { get; set; }

        public ICollection<ItemsCategoriesModel> Categories { get; set; } = new List<ItemsCategoriesModel>();
    }
}
