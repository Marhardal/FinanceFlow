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

        public DbSet<ItemsCategoriesModel> ItemCategories { get; set; }

        public DbSet<IncomeCategoryModel> incomeCategories { get; set; }

        public DbSet<StatusModel> Statuses { get; set; }

        public DbSet<ItemsModel> Items { get; set; }
        
        public DbSet<IncomeCategoryModel> Incomes { get; set; }

        public DbSet<ExpenseModel> Expenses { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<ItemsModel>()
                .HasOne(i => i.ItemCategory)
                .WithMany(c => c.Items)
                .HasForeignKey(i => i.ItemCategoryId);

            modelBuilder.Entity<IncomeModel>()
        .HasOne(i => i.Status)
        .WithMany(s => s.Incomes)
        .HasForeignKey(i => i.StatusID)
        .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<IncomeModel>()
                .HasOne(i => i.IncomeCategory)
                .WithMany(c => c.Incomes)
                .HasForeignKey(i => i.IncomeCategoryID)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<ExpenseModel>().
                HasOne(e => e.Item)
                .WithMany(c => c.Expenses)
                .HasForeignKey(e => e.ItemID);

            modelBuilder.Entity<ExpenseModel>()
                .HasOne(e => e.Budget)
                .WithMany(b => b.Expenses)
                .HasForeignKey(e => e.BudgetID)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<BudgetModel>()
                .HasOne(i => i.status)
                .WithMany(s => s.Budgets)
                .HasForeignKey(i => i.statusID)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<BudgetModel>()
                .HasOne(i => i.Income)
                .WithMany(b => b.Budgets)
                .HasForeignKey(i => i.IncomeID)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<ItemsCategoriesModel>().HasData(
                new ItemsCategoriesModel { Id = 1, Name = "Housing" },
                new ItemsCategoriesModel { Id = 2, Name = "Utilities" },
                new ItemsCategoriesModel { Id = 3, Name = "Groceries" },
                new ItemsCategoriesModel { Id = 4, Name = "Transportation" },
                new ItemsCategoriesModel { Id = 5, Name = "Healthcare" },
                new ItemsCategoriesModel { Id = 6, Name = "Debt and Savings" },
                new ItemsCategoriesModel { Id = 7, Name = "Personal Care" },
                new ItemsCategoriesModel { Id = 8, Name = "Entertainment" },
                new ItemsCategoriesModel { Id = 9, Name = "Education" },
                new ItemsCategoriesModel { Id = 10, Name = "Miscellaneous" }
            );

            modelBuilder.Entity<StatusModel>().HasData(
                new StatusModel { id = 1, Name = "Pending" },
                new StatusModel { id = 2, Name = "Approved" },
                new StatusModel { id = 3, Name = "Rejected" }
            );


            modelBuilder.Entity<IncomeCategoryModel>().HasData(
                new IncomeCategoryModel { id = 1, name = "Salary"/*, Description = "Monthly salary from employment" */},
                new IncomeCategoryModel { id = 2, name = "Freelance"/*, Description = "Income from freelance work"*/ },
                new IncomeCategoryModel { id = 3, name = "Investments" },
                new IncomeCategoryModel { id = 4, name = "Bonus" },
                new IncomeCategoryModel { id = 5, name = "Commissions" },
                new IncomeCategoryModel { id = 6, name = "Gifts" }
            );

        }
        public DbSet<FinanceFlow.Server.Models.IncomeModel> IncomeModel { get; set; } = default!;
    }
}
