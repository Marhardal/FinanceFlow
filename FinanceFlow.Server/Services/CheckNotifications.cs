
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
using FinanceFlow.Server.Classes;

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
                        Reminder reminder = new Reminder(dbContext);

                        if (task.IncomeID is not null)
                        {
                            reminder.IncomeReminder(task.IncomeID.Value);
                        }
                        else if (task.InvestID is not null)
                        {
                            reminder.InvestReminder(task.InvestID.Value);
                        }
                        else
                        {
                            reminder.BudgetReminder(task.BudgetID.Value);
                        }
                    }
                    await Task.Delay(span, stoppingToken);
                }
            }
        }
    }
}
