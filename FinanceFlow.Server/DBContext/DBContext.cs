using FinanceFlow.Server.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;

namespace FinanceFlow.Server.DBContext
{
    public class DBContext : DbContext
    {
        public DBContext(DbContextOptions<DBContext> options) : base(options)
        {
        }

        public DbSet<ExpenseCategories> ExpenseCategories { get; set; }
    }
}
