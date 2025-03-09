using FinanceFlow.Server.DBContext;
using FinanceFlow.Server.Models;
using iText.Kernel.Pdf;
using iText.Layout;
using iText.Layout.Element;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Globalization;

namespace FinanceFlow.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PDFController : ControllerBase
    {
        private readonly FinanceDBContext _context;

        public PDFController(FinanceDBContext context)
        {
            _context = context;
        }
        [HttpGet("Generate")]
        public IActionResult BudgetedExpenseListPDF(int Budgetid)
        {
            // Get the budget
            BudgetModel? budgetModel = _context.Budgets
                .Include(e => e.Expenses)
                .ThenInclude(e => e.Item) // Ensure Item is included
                .FirstOrDefault(b => b.Id == Budgetid);

            if (budgetModel == null)
            {
                return BadRequest("Budget not found.");
            }

            using (var stream = new MemoryStream())
            {
                // Create a PDF document
                PdfWriter writer = new PdfWriter(stream);
                var pdf = new PdfDocument(writer);
                var document = new Document(pdf);

                // Add a title
                document.Add(new Paragraph($"Budget Details: {budgetModel.Name}").SetFontSize(16));

                // Create a table for budget expenses
                var table = new Table(4); // 4 columns: Item, Quantity, Price, Amount
                table.AddHeaderCell("Item");
                table.AddHeaderCell("Quantity");
                table.AddHeaderCell("Price");
                table.AddHeaderCell("Amount");
                double sum = 0;
                // Loop through the expenses
                foreach (var expense in budgetModel.Expenses)
                {
                    table.AddCell(expense.Item?.Name ?? "N/A");
                    table.AddCell(expense.Quantity.ToString());
                    table.AddCell(expense.Item?.Measurement ?? "N/A");
                    table.AddCell(expense.Quantity.ToString() ?? "N/A");
                    
                }
                table.AddCell("");
                table.AddCell("");
                table.AddCell("Total");
                table.AddCell(budgetModel.spentAmount.ToString("C", new CultureInfo("en-MW")));

                // Add table to the document
                document.Add(table);
                document.Close();

                // Return PDF as a file
                return File(stream.ToArray(), "application/pdf", $"{budgetModel.Name}_Expenses.pdf");
            }
        }

    }
}
