﻿using FinanceFlow.Server.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;

namespace FinanceFlow.Server.DBContext
{
    public class FinanceDBContext : DbContext
    {
        public FinanceDBContext(DbContextOptions<FinanceDBContext> options) : base(options)
        {

        }

        public DbSet<ItemsCategoriesModel> itemCategories { get; set; }

        public DbSet<IncomeCategoryModel> incomeCategories { get; set; }

        public DbSet<PaymentMethodModel> paymentMethods { get; set; }

        public DbSet<StatusModel> Statuses { get; set; }

        public DbSet<ItemsModel> Items { get; set; }

        public DbSet<ExpenseModel> Expenses { get; set; }

        public DbSet<BudgetModel> Budgets { get; set; }

        public DbSet<IncomeModel> Incomes { get; set; }

        public DbSet<IncomePaymentModel> incomePayment { get; set; }

        public DbSet<TransactionModel> Transactions { get; set; }

        public DbSet<UserModel> Users { get; set; }

        public DbSet<RolesModel> Roles { get; set; }

        public DbSet<InvestmentTypeModel> investmentTypes { get; set; } 

        public DbSet<InvestmentModel> Investments { get; set; }
        
        public DbSet<InvestModel> Invests { get; set; }

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

            modelBuilder.Entity<IncomePaymentModel>()
                .HasOne(i => i.IncomeModel)
                .WithMany(p => p.IncomePayment)
                .HasForeignKey(i => i.IncomeID);

            modelBuilder.Entity<TransactionModel>()
                .HasOne(i => i.Income)
                .WithOne(t => t.Transaction)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<TransactionModel>()
                .HasOne(b => b.Budget)
                .WithOne(t => t.Transaction)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<IncomeModel>()
                .HasOne(i => i.User)
                .WithMany(u => u.Incomes)
                .HasForeignKey(i => i.UserID)
                .OnDelete(DeleteBehavior.Cascade);


            modelBuilder.Entity<InvestmentModel>()
                .HasOne(s => s.Status)
                .WithMany(e => e.Investments)
                .HasForeignKey(s => s.StatusID)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<InvestmentModel>()
                .HasOne(i => i.investmentType)
                .WithMany(c => c.Investments)
                .HasForeignKey(i => i.investTypeID)
                .OnDelete(DeleteBehavior.Restrict);


            modelBuilder.Entity<InvestModel>()
                .HasOne(s => s.Status)
                .WithMany(e => e.Invests)
                .HasForeignKey(s => s.StatusID)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<InvestModel>()
                .HasOne(i => i.Investment)
                .WithMany(c => c.Invests)
                .HasForeignKey(i => i.InvestmentId)
                .OnDelete(DeleteBehavior.Restrict);

            //modelBuilder.Entity<UserModel>()
            //    .HasOne(u => u.Roles)
            //    .WithOne(r => r.User);

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

            modelBuilder.Entity<RolesModel>().HasData(
                new RolesModel { id = 1, name = "Admin" },
                new RolesModel { id = 2, name = "Subscribed" },
                new RolesModel { id = 3, name = "Freemium" }
            );

            modelBuilder.Entity<PaymentMethodModel>().HasData(
                new PaymentMethodModel { id = 1, Name = "Cash", },
                new PaymentMethodModel { id = 2, Name = "Credit Card", },
                new PaymentMethodModel { id = 3, Name = "Debit Card", },
                new PaymentMethodModel { id = 4, Name = "Bank Transfer", },
                new PaymentMethodModel { id = 5, Name = "Mobile Money", },
                new PaymentMethodModel { id = 6, Name = "Cheque", },
                new PaymentMethodModel { id = 7, Name = "Cryptocurrency", },
                new PaymentMethodModel { id = 8, Name = "Digital Wallets", },
                new PaymentMethodModel { id = 9, Name = "Prepaid Card", },
                new PaymentMethodModel { id = 10, Name = "Online Payment Gateways", }
            );

            modelBuilder.Entity<InvestmentTypeModel>().HasData(
                new InvestmentTypeModel { id = 1, name = "Stock and Equities" },
                new InvestmentTypeModel { id = 2, name = "Bond" },
                new InvestmentTypeModel { id = 3, name = "Mutual Fund" },
                new InvestmentTypeModel { id = 4, name = "Cryptocurrency" },
                new InvestmentTypeModel { id = 5, name = "Real Estate" },
                new InvestmentTypeModel { id = 6, name = "Money Morket" },
                new InvestmentTypeModel { id = 7, name = "Pension Funds" },
                new InvestmentTypeModel { id = 8, name = "Agriculture" }
                );
        }


    }
}
