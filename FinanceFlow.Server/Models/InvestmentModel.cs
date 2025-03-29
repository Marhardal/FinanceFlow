using Microsoft.EntityFrameworkCore;
using Org.BouncyCastle.Bcpg;
using System.ComponentModel.DataAnnotations.Schema;

namespace FinanceFlow.Server.Models
{
    public class InvestmentModel
    {
        public int id { get; set; }

        public required string? Name { get; set; }

        public required int UserId { get; set; }

        [ForeignKey("investTypeID")]
        public required int investTypeID { get; set; }

        public required Status Status { get; set; }

        [Precision(18, 2)]
        public required decimal? CurrentAmount { get; set; }

        public required decimal Percentage { get; set; }

        public required DateOnly Date { get; set; }

        public DateTime createdOn { get; set; } = DateTime.Now;

        public InvestmentModel? Investment { get; set; }


    }

    public enum Status
    {
        Pending,
        Approval
    }

    //public enum Type
    //{
    //    Stock,
    //    Bond,
    //    MutualFund,
    //    ETF,
    //    Crypto,
    //    RealEstate,
    //}
}
