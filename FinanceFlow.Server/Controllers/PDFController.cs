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
            BudgetModel? budgetModel = _context.Budgets.Include(e => e.Expenses).Include(i => i.Income).FirstOrDefault(b => b.Id == Budgetid);
            if (budgetModel == null)
            {
                return BadRequest();
            }
            using (var stream = new MemoryStream())
            {
                // Create a PDF document
                PdfWriter writer = new PdfWriter(stream);
                var pdf = new PdfDocument(writer);
                var document = new Document(pdf);

                // Add a title
                document.Add(new Paragraph($"Budget Details: {budgetModel.Name}"));

                // Create a table for budget expenses
                var table = new Table(3); // 3 columns: Item, Amount, Quantity
                table.AddHeaderCell("Item");
                table.AddHeaderCell("Quantity");
                table.AddHeaderCell("Price");
                table.AddHeaderCell("Amount");

                // Loop through the expenses
                foreach (var expense in budgetModel.Expenses)
                {
                    table.AddCell(expense.Item?.Name ?? "N/A");
                    table.AddCell(expense.Item?.Price.ToString("C", new CultureInfo("en-MW")) ?? "N/A");
                    table.AddCell(expense.amount.ToString("C", new CultureInfo("en-MW")) ?? "N/A");
                    table.AddCell(expense.Quantity.ToString() ?? "N/A");
                }

                // Add table to the document
                document.Add(table);
                document.Close();

                // Save the PDF file to the specified location
                var filePath = Path.Combine(budgetModel.Name + " Expenses.pdf");
                System.IO.File.WriteAllBytes(filePath, stream.ToArray());

                // Return success response
                return Ok(new { FilePath = filePath });
            }
        }
    }
}
