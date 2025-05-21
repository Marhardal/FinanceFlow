using Microsoft.AspNetCore.OpenApi;
using Microsoft.AspNetCore.Http.HttpResults;
using FinanceFlow.Server.DBContext;
using Microsoft.EntityFrameworkCore;
namespace FinanceFlow.Server.Models
{
    public class StatusModel
    {
        public int id { get; set; }

        public required string Name { get; set; }

        public ICollection<IncomeModel>? Incomes { get; set; }

        public ICollection<BudgetModel>? Budgets { get; set; }
     
        public ICollection<InvestmentModel>? Investments { get; set; }
        
        public ICollection<InvestModel>? Invests { get; set; }

        public NotificationModel? Notification { get; set; }
    }
}
