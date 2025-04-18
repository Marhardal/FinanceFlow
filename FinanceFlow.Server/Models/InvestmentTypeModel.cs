namespace FinanceFlow.Server.Models
{
    public class InvestmentTypeModel
    {
        public int id { get; set; }

        public required string name { get; set; }

        public ICollection<InvestmentModel>? Investments { get; set; }
    }
}
