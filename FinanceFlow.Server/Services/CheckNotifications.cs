
using FinanceFlow.Server.DBContext;
using FinanceFlow.Server.Migrations;
using Humanizer;
using iText.Forms.Form.Element;
using iText.Kernel.Geom;
using iText.Layout.Borders;
using iText.Layout.Element;
using iText.Layout.Properties;
using iText.Layout;
using Microsoft.AspNetCore.Components.Routing;
using Microsoft.CodeAnalysis.Elfie.Serialization;
using Microsoft.EntityFrameworkCore;
using Microsoft.VisualBasic;
using static System.Net.Mime.MediaTypeNames;
using System.Drawing;

namespace FinanceFlow.Server.Services
{
    public class CheckNotifications : BackgroundService
    {
        private readonly IServiceProvider _services;
        private readonly TimeSpan span = TimeSpan.FromHours(6);

        public CheckNotifications(IServiceProvider services)
        {
            _services = services;
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            while (!stoppingToken.IsCancellationRequested)
            {
                using (var scope = _services.CreateScope())
                {
                    var dbContext = scope.ServiceProvider.GetRequiredService<FinanceDBContext>();

                    var upcomingnotifications = await dbContext.Notification.Where(n => n.DueDate.Date == DateTime.UtcNow.Date || n.StatusID == 1).ToListAsync();

                    foreach (var task in upcomingnotifications)
                    {
                        var income = await dbContext.Incomes.FindAsync(task.IncomeID);
                        var user = await dbContext.Users.FindAsync(task.userID);
                        string body = @"Hello " + user.Username + @", <br>
                        This is a friendly reminder that your income " + income.Name + @" is due today.<br/>
                        Amount: MK " + income.Amount.ToString("#,###0.00") + @"
                        You're receiving this email because you have notifications enabled in FinanceFlow.<br/>
                        Manage notification preferences";
                        Utilities.SendMail(user.Email, "💰 Income Reminder: Action Required", body);
                        //task.LastReminderSentAt = DateTime.UtcNow;
                        //task.ReminderCount++;
                        //await dbContext.SaveChangesAsync();
                    }
                    await Task.Delay(span, stoppingToken);
                }
            }
        }
    }
}
