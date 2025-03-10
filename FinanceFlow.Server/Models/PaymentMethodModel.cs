using System.ComponentModel.DataAnnotations;

namespace FinanceFlow.Server.Models
{
    public class PaymentMethodModel
    {
        public int id { get; set; }

        [Required]
        public string? Name { get; set; }


    }

}
