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

        public DbSet<ItemsModel> Items { get; set; }

        public DbSet<StatusModel> Statuses { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<ItemsModel>()
                .HasOne(i => i.ItemCategory)
                .WithMany(c => c.Items)
                .HasForeignKey(i => i.ItemCategoryId);

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
        }
    }
}
