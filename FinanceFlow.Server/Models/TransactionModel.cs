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

        [Precision(18, 2)]
        public decimal? amount { get; set; }

        public DateTime date { get; set; } = DateTime.Now;

        public DateTime createdon { get; set; } = DateTime.Now;
    
        public IncomeModel? Income { get; set; }

        public BudgetModel? Budget { get; set; }
    }

    public enum TransactionType
    {
        Incomes,
        Budgets
    }
}
