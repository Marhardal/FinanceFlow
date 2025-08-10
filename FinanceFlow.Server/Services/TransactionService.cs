using FinanceFlow.Server.DBContext;
using FinanceFlow.Server.Models;
using System;

namespace FinanceFlow.Server.Services
{
    public class TransactionService
    {
        private readonly FinanceDBContext _context;

        public TransactionService(FinanceDBContext context)
        {
            _context = context;
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
                var transactions = _context.Transactions
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


        public void addTransaction(TransactionModel transaction)
        {
            _context.Transactions.Add(transaction);
            _context.SaveChangesAsync();
        }
        
        public void updateTransaction(TransactionModel transaction)
        {
            RecalculateBalances((int)transaction.UserId, transaction.valuedate);
            _context.Transactions.Update(transaction);
            _context.SaveChangesAsync();
        }

        private void RecalculateBalances(int userId, DateTime startDate)
        {
            var transactions = _context.Transactions
                .Where(t => t.UserId == userId && t.valuedate >= startDate)
                .OrderBy(t => t.valuedate)
                .ToList();

            decimal previousBalance = _context.Transactions
                .Where(t => t.UserId == userId && t.valuedate < startDate)
                .OrderByDescending(t => t.valuedate)
                .Select(t => t.balance)
                .FirstOrDefault() ?? 0m;

            foreach (var t in transactions)
            {
                previousBalance = previousBalance
                    + (t.credit ?? 0m)
                    - (t.debit ?? 0m);
                t.balance = previousBalance;
            }
        }
    }
}
