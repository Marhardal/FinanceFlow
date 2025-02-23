using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace FinanceFlow.Server.Models
{
    public class IncomeModel
    {
        public int id { get; set; }

        public required string name { get; set; }

        [ForeignKey("StatusID")]
        public int StatusID { get; set; }

        [ForeignKey("IncomeCategoryID")]
        public int IncomeCategoryID { get; set; }

        public required string description { get; set; }

        [Precision(18, 2)]
        public required decimal amount { get; set; }

        public required DateTime date { get; set; } = DateTime.Now;

        public required DateTime createdate { get; set; } = DateTime.Now;

        public StatusModel? Status { get; set; }

        public IncomeCategoryModel? IncomeCategory { get; set; }

        public ICollection<IncomeCategoryModel> Items { get; set; } = new List<IncomeCategoryModel>();

        public ICollection<StatusModel> Statuses { get; set; } = new List<StatusModel>();
    }
}
