using FinanceFlow.Server.DBContext;
using FinanceFlow.Server.Services;
using iText.Commons.Actions.Contexts;
using Microsoft.EntityFrameworkCore;
using System.Threading.Tasks;

namespace FinanceFlow.Server.Classes
{
    public class Reminder
    {
        private readonly FinanceDBContext _dbContext;

        public Reminder(FinanceDBContext dbContext)
        {
            _dbContext = dbContext;
        }

        public void IncomeReminder(int id)
        {
            var incomeTask = _dbContext.Incomes.FindAsync(id);

            var income = incomeTask.Result; // Await or access the result of the ValueTask
            if (income is not null)
            {
                var user = _dbContext.Users.Find(income.UserID);
                if (user is not null)
                {
                    string body = "Hi " + user.Username + ", <br>" +
                    "Your expected income of MK " + income.Amount.ToString("#,###0.00") + " from" +
                     income.Name + " is scheduled for today. <br>" +
                     "Log in to Finance Flow to review your financial overview and plan your funds." +
                     "Best regards, <br>" +
                     "Finance Flow";
                    //string body = @"Hello " + user.Username + @", <br>
                    //                This is a friendly reminder that your income " + income.Name + @" is due today.<br/>
                    //                Amount: MK " + income.Amount.ToString("#,###0.00") + @"
                    //                You're receiving this email because you have notifications enabled in FinanceFlow.<br/>
                    //                Manage notification preferences";
                    Utilities.SendMail(user.Email, "💰 Income Alert: Funds Arriving Soon!", body);
                }
            }
        }

        public async void InvestReminder(int id)
        {
            var invest = await _dbContext.Invests
                .Include(i => i.Investment)
                .FirstOrDefaultAsync(i => i.Id == id);

            if (invest?.Investment != null)
            {
                string body = "Hello " + invest.Investment.User.Username + ", <br>" +
                "Time to check your investment in " + invest.Investment.Name + "! Your next review or action " + GetRelativeDayString(invest.Date) + ".Review performance, upcoming payments, or rebalance your portfolio in Finance Flow. " +
                "<br> Sincerely, <br> Finance Flow.";
                //@"Hello " + invest.Investment.User.Username + @", <br>
                //           This is a friendly reminder that your investment topup for " + invest.Investment.Name + @" is due today.<br/>
                //           Amount: MK " + invest.amount.ToString("#,###0.00") + @"
                //           You're receiving this email because you have notifications enabled in FinanceFlow.<br/>
                //           Manage notification preferences";
                Utilities.SendMail(invest.Investment.User.Email, "📈 Investment Check-in: Review Your Portfolio!", body);
            }
        }

        public async void BudgetReminder(int id)
        {
            var budget = await _dbContext.Budgets.Include(i => i.User).FirstOrDefaultAsync(i => i.Id == id);
            if (budget is not null)
            {
                string body = "Hi " + budget.User.Username + " ,  <br>" +
                "Your " + budget.remindon.Month + " budget update: So far " +
                "you have spent MK " + budget.spentAmount.ToString("#,###0.00") +
                " and this amount is " + (budget.Amount - budget.spentAmount).ToString("#,###0.00") + 
                " left for these Categories. Log in to Finance Flow for details and action. <br> Warmly, <br> Finance Flow";

                //string body = @"Hello " + budget.User.Username + @", <br>
                //            This is a friendly reminder that your budget " + budget.Income + @" is due today.<br/>
                //            Amount: MK " + budget.Amount.ToString("#,###0.00") + @"
                //            You're receiving this email because you have notifications enabled in FinanceFlow.<br/>
                //            Manage notification preferences";
                Utilities.SendMail(budget.User.Email, "Your Budget: Action Required!", body);
            }
        }

        public static string GetRelativeDayString(DateTime date)
        {
            var today = DateTime.Today;
            if (date.Date == today)
                return "is today";
            if (date.Date == today.AddDays(1))
                return "is tomorrow";
            if (date.Date == today.AddDays(-1))
                return "was yesterday";
            if (date.Date > today)
                return $"in {(date.Date - today).Days} days";
            return $"{(today - date.Date).Days} days ago ({date})";
        }
    }
}
