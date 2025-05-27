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
                    string body = @"Hello " + user.Username + @", <br>
                                    This is a friendly reminder that your income " + income.Name + @" is due today.<br/>
                                    Amount: MK " + income.Amount.ToString("#,###0.00") + @"
                                    You're receiving this email because you have notifications enabled in FinanceFlow.<br/>
                                    Manage notification preferences";
                    Utilities.SendMail(user.Email, "💰 Income Reminder: Action Required", body);
                }
            }
        }

        public async void InvestReminder(int id)
        {
            var invest = await _dbContext.Invests.FindAsync(id);
            if (invest is not null)
            {
                string userid = string.Empty; // Initialize userid to avoid CS0165
                if (invest.Investment is not null)
                {
                    userid = invest.Investment.UserId.ToString();
                }

                if (!string.IsNullOrEmpty(userid)) // Ensure userid is not empty before parsing
                {
                    var user = await _dbContext.Users.FindAsync(int.Parse(userid));
                    if (user is not null) // Ensure user and Email are not null
                    {
                        string body = @"Hello " + invest.Investment.User.Username + @", <br>
                                This is a friendly reminder that your invest " + invest.Incomes.Name + @" is due today.<br/>
                                Amount: MK " + invest.amount.ToString("#,###0.00") + @"
                                You're receiving this email because you have notifications enabled in FinanceFlow.<br/>
                                Manage notification preferences";
                        Utilities.SendMail(invest.Investment.User.Email, "💰 Income Reminder: Action Required", body);
                    }
                }
            }
        }


        public async void BudgetReminder(int id)
        {
            var budget = await _dbContext.Budgets.FindAsync(id);
            if (budget is not null)
            {
                var user = await _dbContext.Users.FindAsync(budget.UserID);
                if (user is not null) // Ensure user and Email are not null
                {
                    string body = @"Hello " + user.Username + @", <br>
                            This is a friendly reminder that your budget " + budget.Income + @" is due today.<br/>
                            Amount: MK " + budget.Amount.ToString("#,###0.00") + @"
                            You're receiving this email because you have notifications enabled in FinanceFlow.<br/>
                            Manage notification preferences";
                Utilities.SendMail(user.Email, "💰 Income Reminder: Action Required", body);
                }
            }
        }
    }
}
