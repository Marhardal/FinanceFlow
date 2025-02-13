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

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<ExpenseCategories>().HasData(
                new ExpenseCategories { Id = 1, Name = "Housing" },
                new ExpenseCategories { Id = 2, Name = "Utilities" },
                new ExpenseCategories { Id = 3, Name = "Groceries" },
                new ExpenseCategories { Id = 4, Name = "Transportation" },
                new ExpenseCategories { Id = 5, Name = "Healthcare" },
                new ExpenseCategories { Id = 6, Name = "Debt and Savings" },
                new ExpenseCategories { Id = 7, Name = "Personal Care" },
                new ExpenseCategories { Id = 8, Name = "Entertainment" },
                new ExpenseCategories { Id = 9, Name = "Education" },
                new ExpenseCategories { Id = 10, Name = "Miscellaneous" }
            );
        }
    }
}
