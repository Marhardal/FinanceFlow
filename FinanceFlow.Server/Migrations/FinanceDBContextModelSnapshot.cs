﻿// <auto-generated />
using System;
using FinanceFlow.Server.DBContext;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

#nullable disable

namespace FinanceFlow.Server.Migrations
{
    [DbContext(typeof(FinanceDBContext))]
    partial class FinanceDBContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "9.0.3")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder);

            modelBuilder.Entity("FinanceFlow.Server.Models.BudgetModel", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<double>("Amount")
                        .HasColumnType("float");

                    b.Property<string>("Description")
                        .HasColumnType("nvarchar(max)");

                    b.Property<int?>("ExpenseModelid")
                        .HasColumnType("int");

                    b.Property<int?>("IncomeID")
                        .HasColumnType("int");

                    b.Property<string>("Name")
                        .HasColumnType("nvarchar(max)");

                    b.Property<int?>("UserID")
                        .HasColumnType("int");

                    b.Property<DateTime>("createdon")
                        .HasColumnType("datetime2");

                    b.Property<DateTime>("remindon")
                        .HasColumnType("datetime2");

                    b.Property<double>("spentAmount")
                        .HasColumnType("float");

                    b.Property<int>("statusID")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("ExpenseModelid");

                    b.HasIndex("IncomeID");

                    b.HasIndex("statusID");

                    b.ToTable("Budgets");
                });

            modelBuilder.Entity("FinanceFlow.Server.Models.ExpenseModel", b =>
                {
                    b.Property<int>("id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("id"));

                    b.Property<int>("BudgetID")
                        .HasColumnType("int");

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<double>("Expectedamount")
                        .HasColumnType("float");

                    b.Property<int>("ItemID")
                        .HasColumnType("int");

                    b.Property<double>("Quantity")
                        .HasColumnType("float");

                    b.Property<int>("UserID")
                        .HasColumnType("int");

                    b.Property<double>("amount")
                        .HasColumnType("float");

                    b.Property<DateTime>("createdate")
                        .HasColumnType("datetime2");

                    b.HasKey("id");

                    b.HasIndex("BudgetID");

                    b.HasIndex("ItemID");

                    b.ToTable("Expenses");
                });

            modelBuilder.Entity("FinanceFlow.Server.Models.IncomeCategoryModel", b =>
                {
                    b.Property<int>("id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("id"));

                    b.Property<string>("name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("id");

                    b.ToTable("IncomeCategoryModel");

                    b.HasData(
                        new
                        {
                            id = 1,
                            name = "Salary"
                        },
                        new
                        {
                            id = 2,
                            name = "Freelance"
                        },
                        new
                        {
                            id = 3,
                            name = "Investments"
                        },
                        new
                        {
                            id = 4,
                            name = "Bonus"
                        },
                        new
                        {
                            id = 5,
                            name = "Commissions"
                        },
                        new
                        {
                            id = 6,
                            name = "Gifts"
                        });
                });

            modelBuilder.Entity("FinanceFlow.Server.Models.IncomeModel", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<decimal>("Amount")
                        .HasPrecision(18, 2)
                        .HasColumnType("decimal(18,2)");

                    b.Property<int?>("BudgetModelId")
                        .HasColumnType("int");

                    b.Property<DateTime?>("CreateDate")
                        .HasColumnType("datetime2");

                    b.Property<DateTime?>("Date")
                        .HasColumnType("datetime2");

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("IncomeCategoryID")
                        .HasColumnType("int");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("StatusID")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("BudgetModelId");

                    b.HasIndex("IncomeCategoryID");

                    b.HasIndex("StatusID");

                    b.ToTable("IncomeModel");
                });

            modelBuilder.Entity("FinanceFlow.Server.Models.IncomePaymentModel", b =>
                {
                    b.Property<int>("id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("id"));

                    b.Property<int>("IncomeID")
                        .HasColumnType("int");

                    b.Property<int>("PaymentMethodID")
                        .HasColumnType("int");

                    b.Property<int?>("PaymentMethodModelid")
                        .HasColumnType("int");

                    b.HasKey("id");

                    b.HasIndex("IncomeID");

                    b.HasIndex("PaymentMethodModelid");

                    b.ToTable("incomePayment");
                });

            modelBuilder.Entity("FinanceFlow.Server.Models.ItemsCategoriesModel", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int?>("ItemsModelId")
                        .HasColumnType("int");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex("ItemsModelId");

                    b.ToTable("ItemCategories");

                    b.HasData(
                        new
                        {
                            Id = 1,
                            Name = "Housing"
                        },
                        new
                        {
                            Id = 2,
                            Name = "Utilities"
                        },
                        new
                        {
                            Id = 3,
                            Name = "Groceries"
                        },
                        new
                        {
                            Id = 4,
                            Name = "Transportation"
                        },
                        new
                        {
                            Id = 5,
                            Name = "Healthcare"
                        },
                        new
                        {
                            Id = 6,
                            Name = "Debt and Savings"
                        },
                        new
                        {
                            Id = 7,
                            Name = "Personal Care"
                        },
                        new
                        {
                            Id = 8,
                            Name = "Entertainment"
                        },
                        new
                        {
                            Id = 9,
                            Name = "Education"
                        },
                        new
                        {
                            Id = 10,
                            Name = "Miscellaneous"
                        });
                });

            modelBuilder.Entity("FinanceFlow.Server.Models.ItemsModel", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<DateTime?>("Date")
                        .HasColumnType("datetime2");

                    b.Property<int?>("ExpenseModelid")
                        .HasColumnType("int");

                    b.Property<int>("ItemCategoryId")
                        .HasColumnType("int");

                    b.Property<string>("Measurement")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex("ExpenseModelid");

                    b.HasIndex("ItemCategoryId");

                    b.ToTable("Items");
                });

            modelBuilder.Entity("FinanceFlow.Server.Models.PaymentMethodModel", b =>
                {
                    b.Property<int>("id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("id"));

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("id");

                    b.ToTable("paymentMethods");

                    b.HasData(
                        new
                        {
                            id = 1,
                            Name = "Cash"
                        },
                        new
                        {
                            id = 2,
                            Name = "Credit Card"
                        },
                        new
                        {
                            id = 3,
                            Name = "Debit Card"
                        },
                        new
                        {
                            id = 4,
                            Name = "Bank Transfer"
                        },
                        new
                        {
                            id = 5,
                            Name = "Mobile Money"
                        },
                        new
                        {
                            id = 6,
                            Name = "Cheque"
                        },
                        new
                        {
                            id = 7,
                            Name = "Cryptocurrency"
                        },
                        new
                        {
                            id = 8,
                            Name = "Digital Wallets"
                        },
                        new
                        {
                            id = 9,
                            Name = "Prepaid Card"
                        },
                        new
                        {
                            id = 10,
                            Name = "Online Payment Gateways"
                        });
                });

            modelBuilder.Entity("FinanceFlow.Server.Models.StatusModel", b =>
                {
                    b.Property<int>("id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("id"));

                    b.Property<int?>("BudgetModelId")
                        .HasColumnType("int");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("id");

                    b.HasIndex("BudgetModelId");

                    b.ToTable("Statuses");

                    b.HasData(
                        new
                        {
                            id = 1,
                            Name = "Pending"
                        },
                        new
                        {
                            id = 2,
                            Name = "Approved"
                        },
                        new
                        {
                            id = 3,
                            Name = "Rejected"
                        });
                });

            modelBuilder.Entity("FinanceFlow.Server.Models.TransactionModel", b =>
                {
                    b.Property<int>("id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("id"));

                    b.Property<decimal?>("amount")
                        .HasPrecision(18, 2)
                        .HasColumnType("decimal(18,2)");

                    b.Property<int?>("budgetid")
                        .HasColumnType("int");

                    b.Property<DateTime>("createdon")
                        .HasColumnType("datetime2");

                    b.Property<DateTime>("date")
                        .HasColumnType("datetime2");

                    b.Property<int?>("incomeid")
                        .HasColumnType("int");

                    b.Property<int>("type")
                        .HasColumnType("int");

                    b.HasKey("id");

                    b.HasIndex("budgetid")
                        .IsUnique()
                        .HasFilter("[budgetid] IS NOT NULL");

                    b.HasIndex("incomeid")
                        .IsUnique()
                        .HasFilter("[incomeid] IS NOT NULL");

                    b.ToTable("Transactions");
                });

            modelBuilder.Entity("FinanceFlow.Server.Models.UserModel", b =>
                {
                    b.Property<int>("id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("id"));

                    b.Property<DateOnly>("DOB")
                        .HasColumnType("date");

                    b.Property<string>("Email")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("FirstName")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("PasswordHash")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Surname")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Username")
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("createat")
                        .HasColumnType("datetime2");

                    b.HasKey("id");

                    b.ToTable("Users");
                });

            modelBuilder.Entity("FinanceFlow.Server.Models.BudgetModel", b =>
                {
                    b.HasOne("FinanceFlow.Server.Models.ExpenseModel", null)
                        .WithMany("Budgets")
                        .HasForeignKey("ExpenseModelid");

                    b.HasOne("FinanceFlow.Server.Models.IncomeModel", "Income")
                        .WithMany("Budgets")
                        .HasForeignKey("IncomeID")
                        .OnDelete(DeleteBehavior.Restrict);

                    b.HasOne("FinanceFlow.Server.Models.StatusModel", "status")
                        .WithMany("Budgets")
                        .HasForeignKey("statusID")
                        .OnDelete(DeleteBehavior.Restrict)
                        .IsRequired();

                    b.Navigation("Income");

                    b.Navigation("status");
                });

            modelBuilder.Entity("FinanceFlow.Server.Models.ExpenseModel", b =>
                {
                    b.HasOne("FinanceFlow.Server.Models.BudgetModel", "Budget")
                        .WithMany("Expenses")
                        .HasForeignKey("BudgetID")
                        .OnDelete(DeleteBehavior.Restrict)
                        .IsRequired();

                    b.HasOne("FinanceFlow.Server.Models.ItemsModel", "Item")
                        .WithMany("Expenses")
                        .HasForeignKey("ItemID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Budget");

                    b.Navigation("Item");
                });

            modelBuilder.Entity("FinanceFlow.Server.Models.IncomeModel", b =>
                {
                    b.HasOne("FinanceFlow.Server.Models.BudgetModel", null)
                        .WithMany("Incomes")
                        .HasForeignKey("BudgetModelId");

                    b.HasOne("FinanceFlow.Server.Models.IncomeCategoryModel", "IncomeCategory")
                        .WithMany("Incomes")
                        .HasForeignKey("IncomeCategoryID")
                        .OnDelete(DeleteBehavior.Restrict)
                        .IsRequired();

                    b.HasOne("FinanceFlow.Server.Models.StatusModel", "Status")
                        .WithMany("Incomes")
                        .HasForeignKey("StatusID")
                        .OnDelete(DeleteBehavior.Restrict)
                        .IsRequired();

                    b.Navigation("IncomeCategory");

                    b.Navigation("Status");
                });

            modelBuilder.Entity("FinanceFlow.Server.Models.IncomePaymentModel", b =>
                {
                    b.HasOne("FinanceFlow.Server.Models.IncomeModel", "IncomeModel")
                        .WithMany("IncomePayment")
                        .HasForeignKey("IncomeID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("FinanceFlow.Server.Models.PaymentMethodModel", "PaymentMethodModel")
                        .WithMany()
                        .HasForeignKey("PaymentMethodModelid");

                    b.Navigation("IncomeModel");

                    b.Navigation("PaymentMethodModel");
                });

            modelBuilder.Entity("FinanceFlow.Server.Models.ItemsCategoriesModel", b =>
                {
                    b.HasOne("FinanceFlow.Server.Models.ItemsModel", null)
                        .WithMany("ItemCategories")
                        .HasForeignKey("ItemsModelId");
                });

            modelBuilder.Entity("FinanceFlow.Server.Models.ItemsModel", b =>
                {
                    b.HasOne("FinanceFlow.Server.Models.ExpenseModel", null)
                        .WithMany("Items")
                        .HasForeignKey("ExpenseModelid");

                    b.HasOne("FinanceFlow.Server.Models.ItemsCategoriesModel", "ItemCategory")
                        .WithMany("Items")
                        .HasForeignKey("ItemCategoryId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("ItemCategory");
                });

            modelBuilder.Entity("FinanceFlow.Server.Models.StatusModel", b =>
                {
                    b.HasOne("FinanceFlow.Server.Models.BudgetModel", null)
                        .WithMany("Statuses")
                        .HasForeignKey("BudgetModelId");
                });

            modelBuilder.Entity("FinanceFlow.Server.Models.TransactionModel", b =>
                {
                    b.HasOne("FinanceFlow.Server.Models.BudgetModel", "Budget")
                        .WithOne("Transaction")
                        .HasForeignKey("FinanceFlow.Server.Models.TransactionModel", "budgetid")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.HasOne("FinanceFlow.Server.Models.IncomeModel", "Income")
                        .WithOne("Transaction")
                        .HasForeignKey("FinanceFlow.Server.Models.TransactionModel", "incomeid")
                        .OnDelete(DeleteBehavior.Cascade);

                    b.Navigation("Budget");

                    b.Navigation("Income");
                });

            modelBuilder.Entity("FinanceFlow.Server.Models.BudgetModel", b =>
                {
                    b.Navigation("Expenses");

                    b.Navigation("Incomes");

                    b.Navigation("Statuses");

                    b.Navigation("Transaction");
                });

            modelBuilder.Entity("FinanceFlow.Server.Models.ExpenseModel", b =>
                {
                    b.Navigation("Budgets");

                    b.Navigation("Items");
                });

            modelBuilder.Entity("FinanceFlow.Server.Models.IncomeCategoryModel", b =>
                {
                    b.Navigation("Incomes");
                });

            modelBuilder.Entity("FinanceFlow.Server.Models.IncomeModel", b =>
                {
                    b.Navigation("Budgets");

                    b.Navigation("IncomePayment");

                    b.Navigation("Transaction");
                });

            modelBuilder.Entity("FinanceFlow.Server.Models.ItemsCategoriesModel", b =>
                {
                    b.Navigation("Items");
                });

            modelBuilder.Entity("FinanceFlow.Server.Models.ItemsModel", b =>
                {
                    b.Navigation("Expenses");

                    b.Navigation("ItemCategories");
                });

            modelBuilder.Entity("FinanceFlow.Server.Models.StatusModel", b =>
                {
                    b.Navigation("Budgets");

                    b.Navigation("Incomes");
                });
#pragma warning restore 612, 618
        }
    }
}
