IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE TABLE [incomeCategories] (
        [id] int NOT NULL IDENTITY,
        [name] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_incomeCategories] PRIMARY KEY ([id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE TABLE [paymentMethods] (
        [id] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_paymentMethods] PRIMARY KEY ([id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE TABLE [Roles] (
        [id] int NOT NULL IDENTITY,
        [name] nvarchar(max) NULL,
        CONSTRAINT [PK_Roles] PRIMARY KEY ([id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE TABLE [Users] (
        [id] int NOT NULL IDENTITY,
        [RoleId] int NOT NULL,
        [FirstName] nvarchar(max) NULL,
        [Surname] nvarchar(max) NULL,
        [Email] nvarchar(max) NULL,
        [Username] nvarchar(max) NULL,
        [PasswordHash] nvarchar(max) NULL,
        [DOB] datetime2 NOT NULL,
        [createat] datetime2 NOT NULL,
        [refreshToken] nvarchar(max) NULL,
        [refreshTokenExpirelyToken] datetime2 NULL,
        [Rolesid] int NULL,
        CONSTRAINT [PK_Users] PRIMARY KEY ([id]),
        CONSTRAINT [FK_Users_Roles_Rolesid] FOREIGN KEY ([Rolesid]) REFERENCES [Roles] ([id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE TABLE [Budgets] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NULL,
        [statusID] int NOT NULL,
        [UserID] int NULL,
        [IncomeID] int NULL,
        [Description] nvarchar(max) NULL,
        [spentAmount] float NOT NULL,
        [Amount] float NOT NULL,
        [createdon] datetime2 NOT NULL,
        [remindon] datetime2 NOT NULL,
        [ExpenseModelid] int NULL,
        CONSTRAINT [PK_Budgets] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE TABLE [Expenses] (
        [id] int NOT NULL IDENTITY,
        [UserID] int NOT NULL,
        [ItemID] int NOT NULL,
        [BudgetID] int NOT NULL,
        [Quantity] float NOT NULL,
        [Expectedamount] float NOT NULL,
        [amount] float NOT NULL,
        [Description] nvarchar(max) NOT NULL,
        [date] datetime2 NOT NULL,
        [createdate] datetime2 NOT NULL,
        CONSTRAINT [PK_Expenses] PRIMARY KEY ([id]),
        CONSTRAINT [FK_Expenses_Budgets_BudgetID] FOREIGN KEY ([BudgetID]) REFERENCES [Budgets] ([Id]) ON DELETE NO ACTION
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE TABLE [incomePayment] (
        [id] int NOT NULL IDENTITY,
        [PaymentMethodID] int NOT NULL,
        [IncomeID] int NOT NULL,
        [IncomeModelId] int NULL,
        [PaymentMethodModelid] int NULL,
        CONSTRAINT [PK_incomePayment] PRIMARY KEY ([id]),
        CONSTRAINT [FK_incomePayment_paymentMethods_PaymentMethodModelid] FOREIGN KEY ([PaymentMethodModelid]) REFERENCES [paymentMethods] ([id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE TABLE [Incomes] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NOT NULL,
        [UserID] int NOT NULL,
        [StatusID] int NOT NULL,
        [IncomeCategoryID] int NOT NULL,
        [Description] nvarchar(max) NOT NULL,
        [Amount] decimal(18,2) NOT NULL,
        [Date] datetime2 NULL,
        [CreateDate] datetime2 NOT NULL,
        [BudgetModelId] int NULL,
        [InvestModelId] int NULL,
        CONSTRAINT [PK_Incomes] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Incomes_Budgets_BudgetModelId] FOREIGN KEY ([BudgetModelId]) REFERENCES [Budgets] ([Id]),
        CONSTRAINT [FK_Incomes_Users_UserID] FOREIGN KEY ([UserID]) REFERENCES [Users] ([id]) ON DELETE CASCADE,
        CONSTRAINT [FK_Incomes_incomeCategories_IncomeCategoryID] FOREIGN KEY ([IncomeCategoryID]) REFERENCES [incomeCategories] ([id]) ON DELETE NO ACTION
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE TABLE [Investments] (
        [id] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NULL,
        [UserId] int NOT NULL,
        [investTypeID] int NOT NULL,
        [CurrentAmount] decimal(18,2) NULL,
        [Percentage] nvarchar(max) NOT NULL,
        [Company] nvarchar(max) NOT NULL,
        [Reference] nvarchar(max) NOT NULL,
        [Description] nvarchar(max) NULL,
        [Date] nvarchar(max) NULL,
        [createdOn] datetime2 NOT NULL,
        [InvestId] int NULL,
        [Transactionid] int NULL,
        [StatusModelid] int NULL,
        CONSTRAINT [PK_Investments] PRIMARY KEY ([id]),
        CONSTRAINT [FK_Investments_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [Users] ([id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE TABLE [investmentTypes] (
        [id] int NOT NULL IDENTITY,
        [name] nvarchar(max) NOT NULL,
        [InvestmentModelid] int NULL,
        CONSTRAINT [PK_investmentTypes] PRIMARY KEY ([id]),
        CONSTRAINT [FK_investmentTypes_Investments_InvestmentModelid] FOREIGN KEY ([InvestmentModelid]) REFERENCES [Investments] ([id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE TABLE [Invests] (
        [Id] int NOT NULL IDENTITY,
        [InvestmentId] int NOT NULL,
        [StatusID] int NOT NULL,
        [IncomeID] int NOT NULL,
        [amount] decimal(18,2) NOT NULL,
        [description] nvarchar(max) NULL,
        [Date] datetime2 NOT NULL,
        [createdOn] datetime2 NOT NULL,
        CONSTRAINT [PK_Invests] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Invests_Incomes_IncomeID] FOREIGN KEY ([IncomeID]) REFERENCES [Incomes] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_Invests_Investments_InvestmentId] FOREIGN KEY ([InvestmentId]) REFERENCES [Investments] ([id]) ON DELETE NO ACTION
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE TABLE [Statuses] (
        [id] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NOT NULL,
        [BudgetModelId] int NULL,
        [InvestModelId] int NULL,
        CONSTRAINT [PK_Statuses] PRIMARY KEY ([id]),
        CONSTRAINT [FK_Statuses_Budgets_BudgetModelId] FOREIGN KEY ([BudgetModelId]) REFERENCES [Budgets] ([Id]),
        CONSTRAINT [FK_Statuses_Invests_InvestModelId] FOREIGN KEY ([InvestModelId]) REFERENCES [Invests] ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE TABLE [Transactions] (
        [id] int NOT NULL IDENTITY,
        [type] int NOT NULL,
        [incomeid] int NULL,
        [budgetid] int NULL,
        [investId] int NULL,
        [amount] decimal(18,2) NULL,
        [date] datetime2 NOT NULL,
        [createdon] datetime2 NOT NULL,
        CONSTRAINT [PK_Transactions] PRIMARY KEY ([id]),
        CONSTRAINT [FK_Transactions_Budgets_budgetid] FOREIGN KEY ([budgetid]) REFERENCES [Budgets] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_Transactions_Incomes_incomeid] FOREIGN KEY ([incomeid]) REFERENCES [Incomes] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_Transactions_Invests_investId] FOREIGN KEY ([investId]) REFERENCES [Invests] ([Id]) ON DELETE NO ACTION
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE TABLE [itemCategories] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NOT NULL,
        [ItemsModelId] int NULL,
        CONSTRAINT [PK_itemCategories] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE TABLE [Items] (
        [Id] int NOT NULL IDENTITY,
        [ItemCategoryId] int NOT NULL,
        [Name] nvarchar(max) NOT NULL,
        [Measurement] nvarchar(max) NULL,
        [Date] date NOT NULL,
        [ExpenseModelid] int NULL,
        CONSTRAINT [PK_Items] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Items_Expenses_ExpenseModelid] FOREIGN KEY ([ExpenseModelid]) REFERENCES [Expenses] ([id]),
        CONSTRAINT [FK_Items_itemCategories_ItemCategoryId] FOREIGN KEY ([ItemCategoryId]) REFERENCES [itemCategories] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'id', N'name') AND [object_id] = OBJECT_ID(N'[Roles]'))
        SET IDENTITY_INSERT [Roles] ON;
    EXEC(N'INSERT INTO [Roles] ([id], [name])
    VALUES (1, N''Admin''),
    (2, N''Subscribed''),
    (3, N''Freemium'')');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'id', N'name') AND [object_id] = OBJECT_ID(N'[Roles]'))
        SET IDENTITY_INSERT [Roles] OFF;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'id', N'BudgetModelId', N'InvestModelId', N'Name') AND [object_id] = OBJECT_ID(N'[Statuses]'))
        SET IDENTITY_INSERT [Statuses] ON;
    EXEC(N'INSERT INTO [Statuses] ([id], [BudgetModelId], [InvestModelId], [Name])
    VALUES (1, NULL, NULL, N''Pending''),
    (2, NULL, NULL, N''Approved''),
    (3, NULL, NULL, N''Rejected'')');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'id', N'BudgetModelId', N'InvestModelId', N'Name') AND [object_id] = OBJECT_ID(N'[Statuses]'))
        SET IDENTITY_INSERT [Statuses] OFF;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'id', N'name') AND [object_id] = OBJECT_ID(N'[incomeCategories]'))
        SET IDENTITY_INSERT [incomeCategories] ON;
    EXEC(N'INSERT INTO [incomeCategories] ([id], [name])
    VALUES (1, N''Salary''),
    (2, N''Freelance''),
    (3, N''Investments''),
    (4, N''Bonus''),
    (5, N''Commissions''),
    (6, N''Gifts'')');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'id', N'name') AND [object_id] = OBJECT_ID(N'[incomeCategories]'))
        SET IDENTITY_INSERT [incomeCategories] OFF;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'id', N'InvestmentModelid', N'name') AND [object_id] = OBJECT_ID(N'[investmentTypes]'))
        SET IDENTITY_INSERT [investmentTypes] ON;
    EXEC(N'INSERT INTO [investmentTypes] ([id], [InvestmentModelid], [name])
    VALUES (1, NULL, N''Stock and Equities''),
    (2, NULL, N''Bond''),
    (3, NULL, N''Mutual Fund''),
    (4, NULL, N''Cryptocurrency''),
    (5, NULL, N''Real Estate''),
    (6, NULL, N''Money Morket''),
    (7, NULL, N''Pension Funds''),
    (8, NULL, N''Agriculture'')');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'id', N'InvestmentModelid', N'name') AND [object_id] = OBJECT_ID(N'[investmentTypes]'))
        SET IDENTITY_INSERT [investmentTypes] OFF;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ItemsModelId', N'Name') AND [object_id] = OBJECT_ID(N'[itemCategories]'))
        SET IDENTITY_INSERT [itemCategories] ON;
    EXEC(N'INSERT INTO [itemCategories] ([Id], [ItemsModelId], [Name])
    VALUES (1, NULL, N''Housing''),
    (2, NULL, N''Utilities''),
    (3, NULL, N''Groceries''),
    (4, NULL, N''Transportation''),
    (5, NULL, N''Healthcare''),
    (6, NULL, N''Personal Care''),
    (7, NULL, N''Clothing & Apparel''),
    (8, NULL, N''Entertainment''),
    (9, NULL, N''Education''),
    (10, NULL, N''Debt Payments''),
    (11, NULL, N''Gifts & Donations''),
    (12, NULL, N''Travel''),
    (13, NULL, N''Home Maintenance''),
    (14, NULL, N''Subscriptions''),
    (15, NULL, N''Miscellaneous'')');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ItemsModelId', N'Name') AND [object_id] = OBJECT_ID(N'[itemCategories]'))
        SET IDENTITY_INSERT [itemCategories] OFF;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'id', N'Name') AND [object_id] = OBJECT_ID(N'[paymentMethods]'))
        SET IDENTITY_INSERT [paymentMethods] ON;
    EXEC(N'INSERT INTO [paymentMethods] ([id], [Name])
    VALUES (1, N''Cash''),
    (2, N''Credit Card''),
    (3, N''Debit Card''),
    (4, N''Bank Transfer''),
    (5, N''Mobile Money''),
    (6, N''Cheque''),
    (7, N''Cryptocurrency''),
    (8, N''Digital Wallets''),
    (9, N''Prepaid Card''),
    (10, N''Online Payment Gateways'')');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'id', N'Name') AND [object_id] = OBJECT_ID(N'[paymentMethods]'))
        SET IDENTITY_INSERT [paymentMethods] OFF;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Date', N'ExpenseModelid', N'ItemCategoryId', N'Measurement', N'Name') AND [object_id] = OBJECT_ID(N'[Items]'))
        SET IDENTITY_INSERT [Items] ON;
    EXEC(N'INSERT INTO [Items] ([Id], [Date], [ExpenseModelid], [ItemCategoryId], [Measurement], [Name])
    VALUES (1, ''0001-01-01'', NULL, 1, N''Monthly'', N''Rent''),
    (2, ''0001-01-01'', NULL, 1, N''Monthly'', N''Mortgage''),
    (3, ''0001-01-01'', NULL, 1, N''Yearly'', N''Home Insurance''),
    (4, ''0001-01-01'', NULL, 1, N''One-time'', N''Furniture''),
    (5, ''0001-01-01'', NULL, 2, N''kWh'', N''Electricity''),
    (6, ''0001-01-01'', NULL, 2, N''Gallons'', N''Water Bill''),
    (7, ''0001-01-01'', NULL, 2, N''Monthly'', N''Internet''),
    (8, ''0001-01-01'', NULL, 2, N''Monthly'', N''Mobile Plan''),
    (9, ''0001-01-01'', NULL, 3, N''Liters'', N''Milk''),
    (10, ''0001-01-01'', NULL, 3, N''Dozen'', N''Eggs''),
    (11, ''0001-01-01'', NULL, 3, N''kg'', N''Vegetables''),
    (12, ''0001-01-01'', NULL, 3, N''USD'', N''Snacks''),
    (13, ''0001-01-01'', NULL, 4, N''Liters'', N''Gasoline''),
    (14, ''0001-01-01'', NULL, 4, N''Monthly'', N''Bus Pass''),
    (15, ''0001-01-01'', NULL, 4, N''USD'', N''Car Maintenance''),
    (16, ''0001-01-01'', NULL, 4, N''Daily'', N''Parking Fees''),
    (17, ''0001-01-01'', NULL, 5, N''USD'', N''Doctor Visit''),
    (18, ''0001-01-01'', NULL, 5, N''Monthly'', N''Prescription''),
    (19, ''0001-01-01'', NULL, 5, N''Monthly'', N''Gym Membership''),
    (20, ''0001-01-01'', NULL, 5, N''One-time'', N''First Aid Kit''),
    (21, ''0001-01-01'', NULL, 6, N''Bottle'', N''Shampoo''),
    (22, ''0001-01-01'', NULL, 6, N''USD'', N''Haircut''),
    (23, ''0001-01-01'', NULL, 6, N''Tube'', N''Toothpaste''),
    (24, ''0001-01-01'', NULL, 6, N''Bottle'', N''Perfume''),
    (25, ''0001-01-01'', NULL, 7, N''Pair'', N''Shirts/T-shirts''),
    (26, ''0001-01-01'', NULL, 7, N''One-time'', N''Coat''),
    (27, ''0001-01-01'', NULL, 7, N''Pair'', N''Shoes''),
    (28, ''0001-01-01'', NULL, 7, N''Pack'', N''Socks''),
    (29, ''0001-01-01'', NULL, 8, N''Monthly'', N''Netflix''),
    (30, ''0001-01-01'', NULL, 8, N''USD'', N''Concert Tickets''),
    (31, ''0001-01-01'', NULL, 8, N''USD'', N''Video Games''),
    (32, ''0001-01-01'', NULL, 8, N''USD'', N''Books''),
    (33, ''0001-01-01'', NULL, 9, N''USD'', N''Online Course''),
    (34, ''0001-01-01'', NULL, 9, N''USD'', N''Textbook''),
    (35, ''0001-01-01'', NULL, 9, N''USD'', N''Workshop''),
    (36, ''0001-01-01'', NULL, 9, N''Yearly'', N''Software License''),
    (37, ''0001-01-01'', NULL, 10, N''Monthly'', N''Credit Card''),
    (38, ''0001-01-01'', NULL, 10, N''Monthly'', N''Student Loan''),
    (39, ''0001-01-01'', NULL, 10, N''Monthly'', N''Car Loan''),
    (40, ''0001-01-01'', NULL, 11, N''USD'', N''Birthday Gift''),
    (41, ''0001-01-01'', NULL, 11, N''USD'', N''Charity Donation''),
    (42, ''0001-01-01'', NULL, 11, N''USD'', N''Wedding Gift'');
    INSERT INTO [Items] ([Id], [Date], [ExpenseModelid], [ItemCategoryId], [Measurement], [Name])
    VALUES (43, ''0001-01-01'', NULL, 12, N''USD'', N''Flight Ticket''),
    (44, ''0001-01-01'', NULL, 12, N''Nights'', N''Hotel Stay''),
    (45, ''0001-01-01'', NULL, 12, N''Trip'', N''Travel Insurance''),
    (46, ''0001-01-01'', NULL, 13, N''Pack'', N''Lightbulbs''),
    (47, ''0001-01-01'', NULL, 13, N''USD'', N''Cleaning Supplies''),
    (48, ''0001-01-01'', NULL, 13, N''USD'', N''Plumber Visit''),
    (49, ''0001-01-01'', NULL, 14, N''Monthly'', N''Spotify''),
    (50, ''0001-01-01'', NULL, 14, N''Monthly'', N''Cloud Storage''),
    (51, ''0001-01-01'', NULL, 14, N''Yearly'', N''Magazine''),
    (52, ''0001-01-01'', NULL, 15, N''kg'', N''Pet Food''),
    (53, ''0001-01-01'', NULL, 15, N''Pack'', N''Postage Stamps''),
    (54, ''0001-01-01'', NULL, 15, N''One-time'', N''Umbrella''),
    (55, ''0001-01-01'', NULL, 7, N''Pair'', N''Trousers''),
    (56, ''0001-01-01'', NULL, 6, N''Bottle'', N''Body Lotion and Glycerine''),
    (57, ''0001-01-01'', NULL, 3, N''USD'', N''Fruits'')');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Date', N'ExpenseModelid', N'ItemCategoryId', N'Measurement', N'Name') AND [object_id] = OBJECT_ID(N'[Items]'))
        SET IDENTITY_INSERT [Items] OFF;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE INDEX [IX_Budgets_ExpenseModelid] ON [Budgets] ([ExpenseModelid]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE INDEX [IX_Budgets_IncomeID] ON [Budgets] ([IncomeID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE INDEX [IX_Budgets_statusID] ON [Budgets] ([statusID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE INDEX [IX_Expenses_BudgetID] ON [Expenses] ([BudgetID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE INDEX [IX_Expenses_ItemID] ON [Expenses] ([ItemID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE INDEX [IX_incomePayment_IncomeModelId] ON [incomePayment] ([IncomeModelId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE INDEX [IX_incomePayment_PaymentMethodModelid] ON [incomePayment] ([PaymentMethodModelid]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE INDEX [IX_Incomes_BudgetModelId] ON [Incomes] ([BudgetModelId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE INDEX [IX_Incomes_IncomeCategoryID] ON [Incomes] ([IncomeCategoryID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE INDEX [IX_Incomes_InvestModelId] ON [Incomes] ([InvestModelId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE INDEX [IX_Incomes_StatusID] ON [Incomes] ([StatusID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE INDEX [IX_Incomes_UserID] ON [Incomes] ([UserID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE INDEX [IX_Investments_InvestId] ON [Investments] ([InvestId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE INDEX [IX_Investments_investTypeID] ON [Investments] ([investTypeID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE INDEX [IX_Investments_StatusModelid] ON [Investments] ([StatusModelid]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE INDEX [IX_Investments_Transactionid] ON [Investments] ([Transactionid]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE INDEX [IX_Investments_UserId] ON [Investments] ([UserId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE INDEX [IX_investmentTypes_InvestmentModelid] ON [investmentTypes] ([InvestmentModelid]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE UNIQUE INDEX [IX_Invests_IncomeID] ON [Invests] ([IncomeID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE INDEX [IX_Invests_InvestmentId] ON [Invests] ([InvestmentId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE INDEX [IX_Invests_StatusID] ON [Invests] ([StatusID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE INDEX [IX_itemCategories_ItemsModelId] ON [itemCategories] ([ItemsModelId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE INDEX [IX_Items_ExpenseModelid] ON [Items] ([ExpenseModelid]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE INDEX [IX_Items_ItemCategoryId] ON [Items] ([ItemCategoryId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE INDEX [IX_Statuses_BudgetModelId] ON [Statuses] ([BudgetModelId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE INDEX [IX_Statuses_InvestModelId] ON [Statuses] ([InvestModelId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    EXEC(N'CREATE UNIQUE INDEX [IX_Transactions_budgetid] ON [Transactions] ([budgetid]) WHERE [budgetid] IS NOT NULL');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    EXEC(N'CREATE UNIQUE INDEX [IX_Transactions_incomeid] ON [Transactions] ([incomeid]) WHERE [incomeid] IS NOT NULL');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    EXEC(N'CREATE UNIQUE INDEX [IX_Transactions_investId] ON [Transactions] ([investId]) WHERE [investId] IS NOT NULL');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    CREATE INDEX [IX_Users_Rolesid] ON [Users] ([Rolesid]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    ALTER TABLE [Budgets] ADD CONSTRAINT [FK_Budgets_Expenses_ExpenseModelid] FOREIGN KEY ([ExpenseModelid]) REFERENCES [Expenses] ([id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    ALTER TABLE [Budgets] ADD CONSTRAINT [FK_Budgets_Incomes_IncomeID] FOREIGN KEY ([IncomeID]) REFERENCES [Incomes] ([Id]) ON DELETE NO ACTION;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    ALTER TABLE [Budgets] ADD CONSTRAINT [FK_Budgets_Statuses_statusID] FOREIGN KEY ([statusID]) REFERENCES [Statuses] ([id]) ON DELETE NO ACTION;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    ALTER TABLE [Expenses] ADD CONSTRAINT [FK_Expenses_Items_ItemID] FOREIGN KEY ([ItemID]) REFERENCES [Items] ([Id]) ON DELETE CASCADE;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    ALTER TABLE [incomePayment] ADD CONSTRAINT [FK_incomePayment_Incomes_IncomeModelId] FOREIGN KEY ([IncomeModelId]) REFERENCES [Incomes] ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    ALTER TABLE [Incomes] ADD CONSTRAINT [FK_Incomes_Invests_InvestModelId] FOREIGN KEY ([InvestModelId]) REFERENCES [Invests] ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    ALTER TABLE [Incomes] ADD CONSTRAINT [FK_Incomes_Statuses_StatusID] FOREIGN KEY ([StatusID]) REFERENCES [Statuses] ([id]) ON DELETE NO ACTION;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    ALTER TABLE [Investments] ADD CONSTRAINT [FK_Investments_Invests_InvestId] FOREIGN KEY ([InvestId]) REFERENCES [Invests] ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    ALTER TABLE [Investments] ADD CONSTRAINT [FK_Investments_Statuses_StatusModelid] FOREIGN KEY ([StatusModelid]) REFERENCES [Statuses] ([id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    ALTER TABLE [Investments] ADD CONSTRAINT [FK_Investments_Transactions_Transactionid] FOREIGN KEY ([Transactionid]) REFERENCES [Transactions] ([id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    ALTER TABLE [Investments] ADD CONSTRAINT [FK_Investments_investmentTypes_investTypeID] FOREIGN KEY ([investTypeID]) REFERENCES [investmentTypes] ([id]) ON DELETE NO ACTION;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    ALTER TABLE [Invests] ADD CONSTRAINT [FK_Invests_Statuses_StatusID] FOREIGN KEY ([StatusID]) REFERENCES [Statuses] ([id]) ON DELETE NO ACTION;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    ALTER TABLE [itemCategories] ADD CONSTRAINT [FK_itemCategories_Items_ItemsModelId] FOREIGN KEY ([ItemsModelId]) REFERENCES [Items] ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161100_incomeCategories'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250420161100_incomeCategories', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161119_itemCategories'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250420161119_itemCategories', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161640_Statuses'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250420161640_Statuses', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161701_Items'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250420161701_Items', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161717_Expenses'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250420161717_Expenses', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161736_Roles'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250420161736_Roles', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161800_Users'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250420161800_Users', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161814_Invests'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250420161814_Invests', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161907_investmentTypes'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250420161907_investmentTypes', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161929_Investments'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250420161929_Investments', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420161947_Budgets'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250420161947_Budgets', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420162005_Incomes'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250420162005_Incomes', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250420162027_Transactions'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250420162027_Transactions', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250421091514_updateitemcategoryseed'
)
BEGIN
    EXEC(N'DELETE FROM [Items]
    WHERE [Id] = 57;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250421091514_updateitemcategoryseed'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Name] = N''Grains & Staples''
    WHERE [Id] = 9;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250421091514_updateitemcategoryseed'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Name] = N''Meat & Seafood''
    WHERE [Id] = 10;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250421091514_updateitemcategoryseed'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Name] = N''Fruits and Vegetables''
    WHERE [Id] = 11;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250421091514_updateitemcategoryseed'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Name] = N''Tops''
    WHERE [Id] = 25;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250421091514_updateitemcategoryseed'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Name] = N''Full-body''
    WHERE [Id] = 26;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250421091514_updateitemcategoryseed'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Name] = N''Footwear''
    WHERE [Id] = 27;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250421091514_updateitemcategoryseed'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Name] = N''Accessories''
    WHERE [Id] = 28;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250421091514_updateitemcategoryseed'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Name] = N''Gift''
    WHERE [Id] = 40;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250421091514_updateitemcategoryseed'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Name] = N''Donation''
    WHERE [Id] = 41;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250421091514_updateitemcategoryseed'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Name] = N''Offering''
    WHERE [Id] = 42;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250421091514_updateitemcategoryseed'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Name] = N''Travel''
    WHERE [Id] = 45;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250421091514_updateitemcategoryseed'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Name] = N''Bottoms''
    WHERE [Id] = 55;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250421091514_updateitemcategoryseed'
)
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Date', N'ExpenseModelid', N'ItemCategoryId', N'Measurement', N'Name') AND [object_id] = OBJECT_ID(N'[Items]'))
        SET IDENTITY_INSERT [Items] ON;
    EXEC(N'INSERT INTO [Items] ([Id], [Date], [ExpenseModelid], [ItemCategoryId], [Measurement], [Name])
    VALUES (58, ''0001-01-01'', NULL, 2, N''One-time'', N''Voice Bundle''),
    (59, ''0001-01-01'', NULL, 3, N''USD'', N''Condiments & Spices''),
    (60, ''0001-01-01'', NULL, 3, N''USD'', N''Household & Cleaning''),
    (61, ''0001-01-01'', NULL, 3, N''USD'', N''Baby Products''),
    (62, ''0001-01-01'', NULL, 3, N''USD'', N''Beverages''),
    (63, ''0001-01-01'', NULL, 3, N''USD'', N''Dairy & Protein''),
    (64, ''0001-01-01'', NULL, 3, N''USD'', N''Produce''),
    (65, ''0001-01-01'', NULL, 3, N''USD'', N''Snacks & Processed''),
    (66, ''0001-01-01'', NULL, 3, N''USD'', N''Canned & Preserved'')');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Date', N'ExpenseModelid', N'ItemCategoryId', N'Measurement', N'Name') AND [object_id] = OBJECT_ID(N'[Items]'))
        SET IDENTITY_INSERT [Items] OFF;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250421091514_updateitemcategoryseed'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250421091514_updateitemcategoryseed', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250521030737_notification'
)
BEGIN
    CREATE TABLE [Notification] (
        [Id] int NOT NULL IDENTITY,
        [reminderCount] int NOT NULL,
        [userID] int NOT NULL,
        [StatusID] int NULL,
        [IncomeID] int NULL,
        [BudgetID] int NULL,
        [DueDate] datetime2 NOT NULL,
        [completedat] datetime2 NOT NULL,
        [isrecurring] bit NOT NULL,
        [createdAt] datetime2 NOT NULL,
        [updatedAt] datetime2 NOT NULL,
        CONSTRAINT [PK_Notification] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Notification_Budgets_BudgetID] FOREIGN KEY ([BudgetID]) REFERENCES [Budgets] ([Id]),
        CONSTRAINT [FK_Notification_Incomes_IncomeID] FOREIGN KEY ([IncomeID]) REFERENCES [Incomes] ([Id]),
        CONSTRAINT [FK_Notification_Statuses_StatusID] FOREIGN KEY ([StatusID]) REFERENCES [Statuses] ([id]),
        CONSTRAINT [FK_Notification_Users_userID] FOREIGN KEY ([userID]) REFERENCES [Users] ([id]) ON DELETE NO ACTION
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250521030737_notification'
)
BEGIN
    EXEC(N'CREATE UNIQUE INDEX [IX_Notification_BudgetID] ON [Notification] ([BudgetID]) WHERE [BudgetID] IS NOT NULL');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250521030737_notification'
)
BEGIN
    EXEC(N'CREATE UNIQUE INDEX [IX_Notification_IncomeID] ON [Notification] ([IncomeID]) WHERE [IncomeID] IS NOT NULL');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250521030737_notification'
)
BEGIN
    EXEC(N'CREATE UNIQUE INDEX [IX_Notification_StatusID] ON [Notification] ([StatusID]) WHERE [StatusID] IS NOT NULL');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250521030737_notification'
)
BEGIN
    CREATE UNIQUE INDEX [IX_Notification_userID] ON [Notification] ([userID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250521030737_notification'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250521030737_notification', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250525171259_addinvesttonotifications'
)
BEGIN
    ALTER TABLE [Notification] ADD [InvestID] int NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250525171259_addinvesttonotifications'
)
BEGIN
    CREATE INDEX [IX_Notification_InvestID] ON [Notification] ([InvestID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250525171259_addinvesttonotifications'
)
BEGIN
    ALTER TABLE [Notification] ADD CONSTRAINT [FK_Notification_Invests_InvestID] FOREIGN KEY ([InvestID]) REFERENCES [Invests] ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250525171259_addinvesttonotifications'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250525171259_addinvesttonotifications', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250527052427_updaterelationofnotificatinsandstatus'
)
BEGIN
    ALTER TABLE [Notification] DROP CONSTRAINT [FK_Notification_Statuses_StatusID];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250527052427_updaterelationofnotificatinsandstatus'
)
BEGIN
    DROP INDEX [IX_Notification_InvestID] ON [Notification];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250527052427_updaterelationofnotificatinsandstatus'
)
BEGIN
    DROP INDEX [IX_Notification_StatusID] ON [Notification];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250527052427_updaterelationofnotificatinsandstatus'
)
BEGIN
    EXEC(N'CREATE UNIQUE INDEX [IX_Notification_InvestID] ON [Notification] ([InvestID]) WHERE [InvestID] IS NOT NULL');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250527052427_updaterelationofnotificatinsandstatus'
)
BEGIN
    CREATE INDEX [IX_Notification_StatusID] ON [Notification] ([StatusID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250527052427_updaterelationofnotificatinsandstatus'
)
BEGIN
    ALTER TABLE [Notification] ADD CONSTRAINT [FK_Notification_Statuses_StatusID] FOREIGN KEY ([StatusID]) REFERENCES [Statuses] ([id]) ON DELETE NO ACTION;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250527052427_updaterelationofnotificatinsandstatus'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250527052427_updaterelationofnotificatinsandstatus', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250527052932_updaterelationofnotificatinsanduser'
)
BEGIN
    DROP INDEX [IX_Notification_userID] ON [Notification];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250527052932_updaterelationofnotificatinsanduser'
)
BEGIN
    CREATE INDEX [IX_Notification_userID] ON [Notification] ([userID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250527052932_updaterelationofnotificatinsanduser'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250527052932_updaterelationofnotificatinsanduser', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250527061716_updaterelationofincomeandinvest'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250527061716_updaterelationofincomeandinvest', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250527145946_updaterelationofincomeandinvest2'
)
BEGIN
    DROP INDEX [IX_Notification_IncomeID] ON [Notification];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250527145946_updaterelationofincomeandinvest2'
)
BEGIN
    CREATE INDEX [IX_Notification_IncomeID] ON [Notification] ([IncomeID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250527145946_updaterelationofincomeandinvest2'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250527145946_updaterelationofincomeandinvest2', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250527150926_updaterelationofincomeandinvest3'
)
BEGIN
    DROP INDEX [IX_Notification_IncomeID] ON [Notification];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250527150926_updaterelationofincomeandinvest3'
)
BEGIN
    DROP INDEX [IX_Notification_InvestID] ON [Notification];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250527150926_updaterelationofincomeandinvest3'
)
BEGIN
    EXEC(N'CREATE UNIQUE INDEX [IX_Notification_IncomeID] ON [Notification] ([IncomeID]) WHERE [IncomeID] IS NOT NULL');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250527150926_updaterelationofincomeandinvest3'
)
BEGIN
    CREATE INDEX [IX_Notification_InvestID] ON [Notification] ([InvestID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250527150926_updaterelationofincomeandinvest3'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250527150926_updaterelationofincomeandinvest3', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250527174959_updaterelationofincomeandinvest4'
)
BEGIN
    DROP INDEX [IX_Invests_IncomeID] ON [Invests];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250527174959_updaterelationofincomeandinvest4'
)
BEGIN
    CREATE UNIQUE INDEX [IX_Invests_IncomeID] ON [Invests] ([IncomeID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250527174959_updaterelationofincomeandinvest4'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250527174959_updaterelationofincomeandinvest4', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250527180506_updaterelationofincomeandinvest5'
)
BEGIN
    ALTER TABLE [Incomes] DROP CONSTRAINT [FK_Incomes_Invests_InvestModelId];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250527180506_updaterelationofincomeandinvest5'
)
BEGIN
    ALTER TABLE [Invests] DROP CONSTRAINT [FK_Invests_Incomes_IncomeID];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250527180506_updaterelationofincomeandinvest5'
)
BEGIN
    DROP INDEX [IX_Invests_IncomeID] ON [Invests];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250527180506_updaterelationofincomeandinvest5'
)
BEGIN
    DROP INDEX [IX_Incomes_InvestModelId] ON [Incomes];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250527180506_updaterelationofincomeandinvest5'
)
BEGIN
    DECLARE @var sysname;
    SELECT @var = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Incomes]') AND [c].[name] = N'InvestModelId');
    IF @var IS NOT NULL EXEC(N'ALTER TABLE [Incomes] DROP CONSTRAINT [' + @var + '];');
    ALTER TABLE [Incomes] DROP COLUMN [InvestModelId];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250527180506_updaterelationofincomeandinvest5'
)
BEGIN
    CREATE INDEX [IX_Invests_IncomeID] ON [Invests] ([IncomeID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250527180506_updaterelationofincomeandinvest5'
)
BEGIN
    ALTER TABLE [Invests] ADD CONSTRAINT [FK_Invests_Incomes_IncomeID] FOREIGN KEY ([IncomeID]) REFERENCES [Incomes] ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250527180506_updaterelationofincomeandinvest5'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250527180506_updaterelationofincomeandinvest5', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250611160140_updatetransactionmodel'
)
BEGIN
    EXEC sp_rename N'[Transactions].[amount]', N'debit', 'COLUMN';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250611160140_updatetransactionmodel'
)
BEGIN
    ALTER TABLE [Transactions] ADD [balance] decimal(18,2) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250611160140_updatetransactionmodel'
)
BEGIN
    ALTER TABLE [Transactions] ADD [credit] decimal(18,2) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250611160140_updatetransactionmodel'
)
BEGIN
    CREATE INDEX [IX_Budgets_UserID] ON [Budgets] ([UserID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250611160140_updatetransactionmodel'
)
BEGIN
    ALTER TABLE [Budgets] ADD CONSTRAINT [FK_Budgets_Users_UserID] FOREIGN KEY ([UserID]) REFERENCES [Users] ([id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250611160140_updatetransactionmodel'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250611160140_updatetransactionmodel', N'9.0.3');
END;

COMMIT;
GO

