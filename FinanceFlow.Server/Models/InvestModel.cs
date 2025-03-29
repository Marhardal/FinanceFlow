using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace FinanceFlow.Server.Models
{
    public class InvestModel
    {
        public int Id { get; set; }

        [ForeignKey("InvestmentID")]
        public required int InvestmentId { get; set; }

        [ForeignKey("StatusID")]
        public required int StatusID { get; set; }

        [Precision(18, 2)]
        public required decimal amount { get; set; }

        public string? description { get; set; }

        public required DateOnly Date { get; set; }
       
        public DateTime createdOn { get; set; }

        public InvestmentModel? Investment { get; set; }

        public StatusModel? Status { get; set; }
    }
}
