namespace FinanceFlow.Server.Models
{
    public class IncomePaymentModel
    {
        public int id { get; set; }

        public int PaymentMethodID { get; set; }

        public int IncomeID { get; set; }

        public IncomeModel? IncomeModel { get; set; }

        public PaymentMethodModel? PaymentMethodModel { get; set; }
    }
}
