namespace FinanceFlow.Server.Models
{
    public class IncomeRequestDTO
    {
        public IncomeModel? Income { get; set; }

        public List<IncomePaymentModel>? Payment { get; set; }
    }
}
