﻿namespace FinanceFlow.Server.Models
{
    public class ExpenseCategories
    {
        public int Id { get; set; }

        public required string Name { get; set; } = string.Empty;

        //public ICollection<ItemsModel>? Items { get; set; }

    }
}
