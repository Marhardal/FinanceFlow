using Microsoft.EntityFrameworkCore;
using Org.BouncyCastle.Bcpg;
using System.ComponentModel.DataAnnotations.Schema;

namespace FinanceFlow.Server.Models
{
    public class InvestmentModel
    {
        public int id { get; set; }

        public required string? Name { get; set; }

        [ForeignKey("userId")]
        public required int UserId { get; set; }

        [ForeignKey("investTypeID")]
        public required int investTypeID { get; set; }

        [Precision(18, 2)]
        public required decimal? CurrentAmount { get; set; }

        public required string Percentage { get; set; }

        public required string Company { get; set; }

        public required string Reference { get; set; }

        public string? Description { get; set; }

        public string? Date { get; set; }

        public DateTime createdOn { get; set; } = DateTime.Now;

        public InvestmentTypeModel? investmentType { get; set; }

        public ICollection<InvestmentTypeModel>? InvestmentTypes { get; set; }

        public InvestModel? Invest { get; set; }

        public ICollection<InvestModel> Invests { get; set; } = new List<InvestModel>();

        public UserModel? User { get; set; }

        public TransactionModel? Transaction { get; set; }
    }

}
