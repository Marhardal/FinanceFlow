using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace FinanceFlow.Server.Models
{
    public class TransactionModel
    {
        public int id{ get; set; }

        public TransactionType type { get; set; }

        public int? incomeid { get; set; }

        public int? budgetid { get; set; }
        public int? investId { get; set; }

        [Precision(18, 2)]
        public decimal? debit { get; set; }

        [Precision(18, 2)]
        public decimal? credit { get; set; }

        [Precision(18, 2)]
        public decimal? balance { get; set; }

        public DateTime vdate { get; set; } = DateTime.Now;

        public DateTime createdon { get; set; } = DateTime.Now;
    
        public IncomeModel? Income { get; set; }

        public BudgetModel? Budget { get; set; }

        public InvestModel? Invest { get; set; }
    }

    public enum TransactionType
    {
        Incomes,
        Budgets,
        Investment
    }
}
