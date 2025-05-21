namespace FinanceFlow.Server.DTOs
{
    public class InvestDTO
    {
        public int InvestmentId { get; set; }

        public int StatusID { get; set; }

        public int IncomeID { get; set; }

        public DateTime Date { get; set; }

        public Decimal amount { get; set; }

        public string? Name { get; set; }

        public string Type { get; set; }
    }
}
