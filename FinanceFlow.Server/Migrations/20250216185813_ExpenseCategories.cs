using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace FinanceFlow.Server.Migrations
{
    /// <inheritdoc />
    public partial class ExpenseCategories : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "ExpenseCategories",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    ItemsModelId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ExpenseCategories", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Items",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Price = table.Column<decimal>(type: "decimal(18,2)", precision: 18, scale: 2, nullable: false),
                    Date = table.Column<DateTime>(type: "datetime2", nullable: true),
                    ExpenseCategoryId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Items", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Items_ExpenseCategories_ExpenseCategoryId",
                        column: x => x.ExpenseCategoryId,
                        principalTable: "ExpenseCategories",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.InsertData(
                table: "ExpenseCategories",
                columns: new[] { "Id", "ItemsModelId", "Name" },
                values: new object[,]
                {
                    { 1, null, "Housing" },
                    { 2, null, "Utilities" },
                    { 3, null, "Groceries" },
                    { 4, null, "Transportation" },
                    { 5, null, "Healthcare" },
                    { 6, null, "Debt and Savings" },
                    { 7, null, "Personal Care" },
                    { 8, null, "Entertainment" },
                    { 9, null, "Education" },
                    { 10, null, "Miscellaneous" }
                });

            migrationBuilder.CreateIndex(
                name: "IX_ExpenseCategories_ItemsModelId",
                table: "ExpenseCategories",
                column: "ItemsModelId");

            migrationBuilder.CreateIndex(
                name: "IX_Items_ExpenseCategoryId",
                table: "Items",
                column: "ExpenseCategoryId");

            migrationBuilder.AddForeignKey(
                name: "FK_ExpenseCategories_Items_ItemsModelId",
                table: "ExpenseCategories",
                column: "ItemsModelId",
                principalTable: "Items",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ExpenseCategories_Items_ItemsModelId",
                table: "ExpenseCategories");

            migrationBuilder.DropTable(
                name: "Items");

            migrationBuilder.DropTable(
                name: "ExpenseCategories");
        }
    }
}
