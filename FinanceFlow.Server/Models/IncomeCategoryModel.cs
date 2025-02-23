namespace FinanceFlow.Server.Models
{
    public class IncomeCategoryModel
    {
        public int id { get; set; }

        public required string name { get; set; }

        public ICollection<IncomeModel>? Incomes { get; set; }
    }
}
