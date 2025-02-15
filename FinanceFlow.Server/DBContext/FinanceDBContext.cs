using FinanceFlow.Server.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;

namespace FinanceFlow.Server.DBContext
{
    public class FinanceDBContext : DbContext
    {
        public FinanceDBContext(DbContextOptions<FinanceDBContext> options) : base(options)
        {
        }

        public DbSet<ExpenseCategoriesModel> ExpenseCategories { get; set; }

        public DbSet<ItemsModel> Items { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<ExpenseCategoriesModel>().HasData(
                new ExpenseCategoriesModel { Id = 1, Name = "Housing" },
                new ExpenseCategoriesModel { Id = 2, Name = "Utilities" },
                new ExpenseCategoriesModel { Id = 3, Name = "Groceries" },
                new ExpenseCategoriesModel { Id = 4, Name = "Transportation" },
                new ExpenseCategoriesModel { Id = 5, Name = "Healthcare" },
                new ExpenseCategoriesModel { Id = 6, Name = "Debt and Savings" },
                new ExpenseCategoriesModel { Id = 7, Name = "Personal Care" },
                new ExpenseCategoriesModel { Id = 8, Name = "Entertainment" },
                new ExpenseCategoriesModel { Id = 9, Name = "Education" },
                new ExpenseCategoriesModel { Id = 10, Name = "Miscellaneous" }
            );
        }
    }
}
