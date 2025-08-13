using FinanceFlow.Server.DBContext;
using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;

namespace FinanceFlow.Server.Classes
{
    public class FinAccess
    {
        private readonly FinanceDBContext context;

        public FinAccess(FinanceDBContext context)
        {
            this.context = context ?? throw new ArgumentNullException(nameof(context));
        }

        public double GetBalance(string userId)
        {
            //if (string.IsNullOrWhiteSpace(userId))
            //{
            //    throw new ArgumentException("UserId cannot be null or empty", nameof(userId));
            //}

            try
            {
                // Parse userId to int since UserId is int in the model
                if (!int.TryParse(userId, out int userIdInt))
                {
                    throw new ArgumentException("Invalid userId format", nameof(userId));
                }

                // Use LINQ for better performance and type safety
                var transactions = context.Transactions
                    .Where(t => t.UserId == userIdInt);

                // Calculate total credit and debit
                decimal totalCredit = transactions
                    .Where(t => t.credit.HasValue)
                    .Sum(t => t.credit.Value);

                decimal totalDebit = transactions
                    .Where(t => t.debit.HasValue)
                    .Sum(t => t.debit.Value);

                return (double)(totalCredit - totalDebit);
            }
            catch (Exception ex)
            {
                // Log the exception (you can add proper logging here)
                Console.WriteLine($"Error calculating balance for user {userId}: {ex.Message}");
                return 0;
            }
        }

        // Async version for better performance in async contexts
        public async Task<double> GetBalanceAsync(string userId)
        {
            if (string.IsNullOrWhiteSpace(userId))
            {
                throw new ArgumentException("UserId cannot be null or empty", nameof(userId));
            }

            try
            {
                if (!int.TryParse(userId, out int userIdInt))
                {
                    throw new ArgumentException("Invalid userId format", nameof(userId));
                }

                var transactions = context.Transactions
                    .Where(t => t.UserId == userIdInt);

                var totalCreditTask = transactions
                    .Where(t => t.credit.HasValue)
                    .SumAsync(t => t.credit.Value);

                var totalDebitTask = transactions
                    .Where(t => t.debit.HasValue)
                    .SumAsync(t => t.debit.Value);

                await Task.WhenAll(totalCreditTask, totalDebitTask);

                return (double)(totalCreditTask.Result - totalDebitTask.Result);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error calculating balance for user {userId}: {ex.Message}");
                return 0;
            }
        }
    }
}
