namespace FinanceFlow.Server.Models
{
    public class IncomeCategoryModel
    {
        public int id { get; set; }
        public string name { get; set; } = string.Empty;

        // Navigation Property
        public ICollection<IncomeModel>? Incomes { get; set; }
    }

}
