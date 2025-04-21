using FinanceFlow.Server.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.Extensions.Options;

namespace FinanceFlow.Server.DBContext
{
    public class FinanceDBContext : DbContext
    {
        public FinanceDBContext(DbContextOptions<FinanceDBContext> options) : base(options)
        {

        }

        public DbSet<IncomeCategoryModel> incomeCategories { get; set; }

        public DbSet<ItemsCategoriesModel> itemCategories { get; set; }

        public DbSet<PaymentMethodModel> paymentMethods { get; set; }

        public DbSet<StatusModel> Statuses { get; set; }

        public DbSet<ItemsModel> Items { get; set; }

        public DbSet<ExpenseModel> Expenses { get; set; }

        public DbSet<IncomePaymentModel> incomePayment { get; set; }
        public DbSet<RolesModel> Roles { get; set; }

        public DbSet<UserModel> Users { get; set; }
        
        public DbSet<InvestModel> Invests { get; set; }

        public DbSet<InvestmentTypeModel> investmentTypes { get; set; } 

        public DbSet<InvestmentModel> Investments { get; set; }

        public DbSet<BudgetModel> Budgets { get; set; }

        public DbSet<IncomeModel> Incomes { get; set; }

        public DbSet<TransactionModel> Transactions { get; set; }

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

            //modelBuilder.Entity<IncomePaymentModel>()
            //    .HasOne(i => i.IncomeModel)
            //    .WithMany(p => p.IncomePayment)
            //    .HasForeignKey(i => i.IncomeID);

            modelBuilder.Entity<TransactionModel>()
                .HasOne(i => i.Income)
                .WithOne(t => t.Transaction)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<TransactionModel>()
                .HasOne(b => b.Budget)
                .WithOne(t => t.Transaction)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<TransactionModel>()
                .HasOne(t => t.Invest)
                .WithOne(i => i.Transaction)
                .OnDelete(DeleteBehavior.Restrict); // or DeleteBehavior.NoAction

            modelBuilder.Entity<IncomeModel>()
                .HasOne(i => i.User)
                .WithMany(u => u.Incomes)
                .HasForeignKey(i => i.UserID)
                .OnDelete(DeleteBehavior.Cascade);


            //modelBuilder.Entity<InvestmentModel>()
            //    .HasOne(s => s.Status)
            //    .WithMany(e => e.Investments)
            //    .HasForeignKey(s => s.StatusID)
            //    .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<InvestmentModel>()
                .HasOne(i => i.investmentType)
                .WithMany(c => c.Investments)
                .HasForeignKey(i => i.investTypeID)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<InvestModel>()
                .HasOne(i => i.Income)
                .WithOne(e => e.Invest);

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
                // Essential Living
                new ItemsCategoriesModel { Id = 1, Name = "Housing" },
                new ItemsCategoriesModel { Id = 2, Name = "Utilities" },
                new ItemsCategoriesModel { Id = 3, Name = "Groceries" },
                new ItemsCategoriesModel { Id = 4, Name = "Transportation" },
                new ItemsCategoriesModel { Id = 5, Name = "Healthcare" },

                // Personal & Lifestyle
                new ItemsCategoriesModel { Id = 6, Name = "Personal Care" },
                new ItemsCategoriesModel { Id = 7, Name = "Clothing & Apparel" },
                new ItemsCategoriesModel { Id = 8, Name = "Entertainment" },
                new ItemsCategoriesModel { Id = 9, Name = "Education" },

                // Financial
                new ItemsCategoriesModel { Id = 10, Name = "Debt Payments" },

                // Occasional/Other
                new ItemsCategoriesModel { Id = 11, Name = "Gifts & Donations" },
                new ItemsCategoriesModel { Id = 12, Name = "Travel" },
                new ItemsCategoriesModel { Id = 13, Name = "Home Maintenance" },
                new ItemsCategoriesModel { Id = 14, Name = "Subscriptions" },
                new ItemsCategoriesModel { Id = 15, Name = "Miscellaneous" }
            );

            #region
            modelBuilder.Entity<ItemsModel>().HasData(
                // 1. Housing
                new ItemsModel { Id = 1, Name = "Rent", ItemCategoryId = 1, Measurement = "Monthly" },
                new ItemsModel { Id = 2, Name = "Mortgage", ItemCategoryId = 1, Measurement = "Monthly" },
                new ItemsModel { Id = 3, Name = "Home Insurance", ItemCategoryId = 1, Measurement = "Yearly" },
                new ItemsModel { Id = 4, Name = "Furniture", ItemCategoryId = 1, Measurement = "One-time" },

                // 2. Utilities
                new ItemsModel { Id = 5, Name = "Electricity", ItemCategoryId = 2, Measurement = "kWh" },
                new ItemsModel { Id = 6, Name = "Water Bill", ItemCategoryId = 2, Measurement = "Gallons" },
                new ItemsModel { Id = 7, Name = "Internet", ItemCategoryId = 2, Measurement = "Monthly" },
                new ItemsModel { Id = 8, Name = "Mobile Plan", ItemCategoryId = 2, Measurement = "Monthly" },
                new ItemsModel { Id = 58, Name = "Voice Bundle", ItemCategoryId = 2, Measurement = "One-time" },

                // 3. Groceries
                new ItemsModel { Id = 9, Name = "Grains & Staples", ItemCategoryId = 3, Measurement = "Liters" },
                new ItemsModel { Id = 10, Name = "Meat & Seafood", ItemCategoryId = 3, Measurement = "Dozen" },
                new ItemsModel { Id = 11, Name = "Fruits and Vegetables", ItemCategoryId = 3, Measurement = "kg" },
                new ItemsModel { Id = 12, Name = "Snacks", ItemCategoryId = 3, Measurement = "USD" },
                new ItemsModel { Id = 59, Name = "Condiments & Spices", ItemCategoryId = 3, Measurement = "USD" },
                new ItemsModel { Id = 60, Name = "Household & Cleaning", ItemCategoryId = 3, Measurement = "USD" },
                new ItemsModel { Id = 61, Name = "Baby Products", ItemCategoryId = 3, Measurement = "USD" },
                new ItemsModel { Id = 62, Name = "Beverages", ItemCategoryId = 3, Measurement = "USD" },
                new ItemsModel { Id = 63, Name = "Dairy & Protein", ItemCategoryId = 3, Measurement = "USD" },
                new ItemsModel { Id = 64, Name = "Produce", ItemCategoryId = 3, Measurement = "USD" },
                new ItemsModel { Id = 65, Name = "Snacks & Processed", ItemCategoryId = 3, Measurement = "USD" },
                new ItemsModel { Id = 66, Name = "Canned & Preserved", ItemCategoryId = 3, Measurement = "USD" },

                // 4. Transportation
                new ItemsModel { Id = 13, Name = "Gasoline", ItemCategoryId = 4, Measurement = "Liters" },
                new ItemsModel { Id = 14, Name = "Bus Pass", ItemCategoryId = 4, Measurement = "Monthly" },
                new ItemsModel { Id = 15, Name = "Car Maintenance", ItemCategoryId = 4, Measurement = "USD" },
                new ItemsModel { Id = 16, Name = "Parking Fees", ItemCategoryId = 4, Measurement = "Daily" },

                // 5. Healthcare
                new ItemsModel { Id = 17, Name = "Doctor Visit", ItemCategoryId = 5, Measurement = "USD" },
                new ItemsModel { Id = 18, Name = "Prescription", ItemCategoryId = 5, Measurement = "Monthly" },
                new ItemsModel { Id = 19, Name = "Gym Membership", ItemCategoryId = 5, Measurement = "Monthly" },
                new ItemsModel { Id = 20, Name = "First Aid Kit", ItemCategoryId = 5, Measurement = "One-time" },

                // 6. Personal Care
                new ItemsModel { Id = 21, Name = "Shampoo", ItemCategoryId = 6, Measurement = "Bottle" },
                new ItemsModel { Id = 22, Name = "Haircut", ItemCategoryId = 6, Measurement = "USD" },
                new ItemsModel { Id = 23, Name = "Toothpaste", ItemCategoryId = 6, Measurement = "Tube" },
                new ItemsModel { Id = 24, Name = "Perfume", ItemCategoryId = 6, Measurement = "Bottle" },
                new ItemsModel { Id = 56, Name = "Body Lotion and Glycerine", ItemCategoryId = 6, Measurement = "Bottle" },

                // 7. Clothing & Apparel
                new ItemsModel { Id = 25, Name = "Tops", ItemCategoryId = 7, Measurement = "Pair" },
                new ItemsModel { Id = 55, Name = "Bottoms", ItemCategoryId = 7, Measurement = "Pair" },
                new ItemsModel { Id = 26, Name = "Full-body", ItemCategoryId = 7, Measurement = "One-time" },
                new ItemsModel { Id = 27, Name = "Footwear", ItemCategoryId = 7, Measurement = "Pair" },
                new ItemsModel { Id = 28, Name = "Accessories", ItemCategoryId = 7, Measurement = "Pack" },

                // 8. Entertainment
                new ItemsModel { Id = 29, Name = "Netflix", ItemCategoryId = 8, Measurement = "Monthly" },
                new ItemsModel { Id = 30, Name = "Concert Tickets", ItemCategoryId = 8, Measurement = "USD" },
                new ItemsModel { Id = 31, Name = "Video Games", ItemCategoryId = 8, Measurement = "USD" },
                new ItemsModel { Id = 32, Name = "Books", ItemCategoryId = 8, Measurement = "USD" },

                // 9. Education
                new ItemsModel { Id = 33, Name = "Online Course", ItemCategoryId = 9, Measurement = "USD" },
                new ItemsModel { Id = 34, Name = "Textbook", ItemCategoryId = 9, Measurement = "USD" },
                new ItemsModel { Id = 35, Name = "Workshop", ItemCategoryId = 9, Measurement = "USD" },
                new ItemsModel { Id = 36, Name = "Software License", ItemCategoryId = 9, Measurement = "Yearly" },

                // 10. Debt Payments
                new ItemsModel { Id = 37, Name = "Credit Card", ItemCategoryId = 10, Measurement = "Monthly" },
                new ItemsModel { Id = 38, Name = "Student Loan", ItemCategoryId = 10, Measurement = "Monthly" },
                new ItemsModel { Id = 39, Name = "Car Loan", ItemCategoryId = 10, Measurement = "Monthly" },

                // 11. Gifts & Donations
                new ItemsModel { Id = 40, Name = "Gift", ItemCategoryId = 11, Measurement = "USD" },
                new ItemsModel { Id = 41, Name = "Donation", ItemCategoryId = 11, Measurement = "USD" },
                new ItemsModel { Id = 42, Name = "Offering", ItemCategoryId = 11, Measurement = "USD" },

                // 12. Travel
                new ItemsModel { Id = 43, Name = "Flight Ticket", ItemCategoryId = 12, Measurement = "USD" },
                new ItemsModel { Id = 44, Name = "Hotel Stay", ItemCategoryId = 12, Measurement = "Nights" },
                new ItemsModel { Id = 45, Name = "Travel", ItemCategoryId = 12, Measurement = "Trip" },

                // 13. Home Maintenance
                new ItemsModel { Id = 46, Name = "Lightbulbs", ItemCategoryId = 13, Measurement = "Pack" },
                new ItemsModel { Id = 47, Name = "Cleaning Supplies", ItemCategoryId = 13, Measurement = "USD" },
                new ItemsModel { Id = 48, Name = "Plumber Visit", ItemCategoryId = 13, Measurement = "USD" },

                // 14. Subscriptions
                new ItemsModel { Id = 49, Name = "Spotify", ItemCategoryId = 14, Measurement = "Monthly" },
                new ItemsModel { Id = 50, Name = "Cloud Storage", ItemCategoryId = 14, Measurement = "Monthly" },
                new ItemsModel { Id = 51, Name = "Magazine", ItemCategoryId = 14, Measurement = "Yearly" },

                // 15. Miscellaneous
                new ItemsModel { Id = 52, Name = "Pet Food", ItemCategoryId = 15, Measurement = "kg" },
                new ItemsModel { Id = 53, Name = "Postage Stamps", ItemCategoryId = 15, Measurement = "Pack" },
                new ItemsModel { Id = 54, Name = "Umbrella", ItemCategoryId = 15, Measurement = "One-time" }
            );
            #endregion
            //
            //     

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

            //modelBuilder.Entity<UserModel>().HasData(
            //    new UserModel
            //    {
            //        id = 1,
            //        FirstName = "Martin",
            //        Surname = "Harawa",
            //        RoleId = 1,
            //        DOB = new DateTime(2000, 11, 21),
            //        Email = "martindharawa@gmail.com",
            //        Username = "Martin",
            //        PasswordHash = new PasswordHasher<UserModel>().HashPassword(null, "Martin21*"),
            //        createat = new DateTime(2000, 11, 21)
            //    }
            //);

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
