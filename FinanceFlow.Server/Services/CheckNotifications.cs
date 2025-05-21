
namespace FinanceFlow.Server.Services
{
    public class CheckNotifications : BackgroundService
    {
        private readonly IServiceProvider _service;
        private readonly TimeSpan span = TimeSpan.FromHours(6);

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            while (!stoppingToken.IsCancellationRequested)
            {
                using (var scope = _service.CreateScope())
                {
                    var dbconte 
                }
            }
        }
    }
}
