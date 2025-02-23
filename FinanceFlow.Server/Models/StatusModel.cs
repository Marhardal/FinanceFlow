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
    }
}
