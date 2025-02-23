using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace FinanceFlow.Server.Models
{
    public class IncomeModel
    {
        public int Id { get; set; }  // Standard PascalCase for public properties

        public required string Name { get; set; }

        public int StatusID { get; set; }  // Foreign key property

        public int IncomeCategoryID { get; set; }  // Foreign key property

        public required string Description { get; set; }

        [Precision(18, 2)]
        public required decimal Amount { get; set; }

        public required DateTime Date { get; set; } = DateTime.Now;

        public required DateTime CreateDate { get; set; } = DateTime.Now;

        // Navigation Properties
        [ForeignKey(nameof(StatusID))]  // Correct FK annotation
        public required StatusModel Status { get; set; }

        [ForeignKey(nameof(IncomeCategoryID))]  // Correct FK annotation
        public required IncomeCategoryModel IncomeCategory { get; set; }
    }
}
