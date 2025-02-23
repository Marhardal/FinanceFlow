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

        public required string description { get; set; }

        [Precision(18, 2)]
        public required decimal amount { get; set; }

        public required DateTime createdate { get; set; } = DateTime.Now;

        public StatusModel? Status { get; set; }

        public ICollection<StatusModel> Statuses { get; set; } = new List<StatusModel>();
    }
}
