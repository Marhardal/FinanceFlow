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
                .HasAnnotation("ProductVersion", "9.0.2")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder);

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

                    b.Property<int>("ItemCategoryId")
                        .HasColumnType("int");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<decimal>("Price")
                        .HasPrecision(18, 2)
                        .HasColumnType("decimal(18,2)");

                    b.HasKey("Id");

                    b.HasIndex("ItemCategoryId");

                    b.ToTable("Items");
                });

            modelBuilder.Entity("FinanceFlow.Server.Models.StatusModel", b =>
                {
                    b.Property<int>("id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("id"));

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("id");

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

            modelBuilder.Entity("FinanceFlow.Server.Models.ItemsCategoriesModel", b =>
                {
                    b.HasOne("FinanceFlow.Server.Models.ItemsModel", null)
                        .WithMany("Categories")
                        .HasForeignKey("ItemsModelId");
                });

            modelBuilder.Entity("FinanceFlow.Server.Models.ItemsModel", b =>
                {
                    b.HasOne("FinanceFlow.Server.Models.ItemsCategoriesModel", "ItemCategory")
                        .WithMany("Items")
                        .HasForeignKey("ItemCategoryId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("ItemCategory");
                });

            modelBuilder.Entity("FinanceFlow.Server.Models.ItemsCategoriesModel", b =>
                {
                    b.Navigation("Items");
                });

            modelBuilder.Entity("FinanceFlow.Server.Models.ItemsModel", b =>
                {
                    b.Navigation("Categories");
                });
#pragma warning restore 612, 618
        }
    }
}
