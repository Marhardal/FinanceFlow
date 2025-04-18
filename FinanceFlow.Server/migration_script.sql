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
    WHERE [MigrationId] = N'20250406072239_itemCategories'
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
    WHERE [MigrationId] = N'20250406072239_itemCategories'
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
    WHERE [MigrationId] = N'20250406072239_itemCategories'
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
    WHERE [MigrationId] = N'20250406072239_itemCategories'
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
        [DOB] date NOT NULL,
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
    WHERE [MigrationId] = N'20250406072239_itemCategories'
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
    WHERE [MigrationId] = N'20250406072239_itemCategories'
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
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    CREATE TABLE [incomePayment] (
        [id] int NOT NULL IDENTITY,
        [PaymentMethodID] int NOT NULL,
        [IncomeID] int NOT NULL,
        [PaymentMethodModelid] int NULL,
        CONSTRAINT [PK_incomePayment] PRIMARY KEY ([id]),
        CONSTRAINT [FK_incomePayment_paymentMethods_PaymentMethodModelid] FOREIGN KEY ([PaymentMethodModelid]) REFERENCES [paymentMethods] ([id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
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
    WHERE [MigrationId] = N'20250406072239_itemCategories'
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
        [StatusModelid] int NULL,
        CONSTRAINT [PK_Investments] PRIMARY KEY ([id]),
        CONSTRAINT [FK_Investments_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [Users] ([id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
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
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    CREATE TABLE [Invests] (
        [Id] int NOT NULL IDENTITY,
        [InvestmentId] int NOT NULL,
        [StatusID] int NOT NULL,
        [IncomeID] int NOT NULL,
        [amount] decimal(18,2) NOT NULL,
        [description] nvarchar(max) NULL,
        [Date] date NOT NULL,
        [createdOn] datetime2 NOT NULL,
        CONSTRAINT [PK_Invests] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Invests_Incomes_IncomeID] FOREIGN KEY ([IncomeID]) REFERENCES [Incomes] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_Invests_Investments_InvestmentId] FOREIGN KEY ([InvestmentId]) REFERENCES [Investments] ([id]) ON DELETE NO ACTION
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
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
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    CREATE TABLE [Transactions] (
        [id] int NOT NULL IDENTITY,
        [type] int NOT NULL,
        [incomeid] int NULL,
        [budgetid] int NULL,
        [investid] int NULL,
        [amount] decimal(18,2) NULL,
        [date] datetime2 NOT NULL,
        [createdon] datetime2 NOT NULL,
        CONSTRAINT [PK_Transactions] PRIMARY KEY ([id]),
        CONSTRAINT [FK_Transactions_Budgets_budgetid] FOREIGN KEY ([budgetid]) REFERENCES [Budgets] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_Transactions_Incomes_incomeid] FOREIGN KEY ([incomeid]) REFERENCES [Incomes] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_Transactions_Invests_investid] FOREIGN KEY ([investid]) REFERENCES [Invests] ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
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
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    CREATE TABLE [Items] (
        [Id] int NOT NULL IDENTITY,
        [ItemCategoryId] int NOT NULL,
        [Name] nvarchar(max) NOT NULL,
        [Measurement] nvarchar(max) NULL,
        [Date] datetime2 NULL,
        [ExpenseModelid] int NULL,
        CONSTRAINT [PK_Items] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Items_Expenses_ExpenseModelid] FOREIGN KEY ([ExpenseModelid]) REFERENCES [Expenses] ([id]),
        CONSTRAINT [FK_Items_itemCategories_ItemCategoryId] FOREIGN KEY ([ItemCategoryId]) REFERENCES [itemCategories] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
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
    WHERE [MigrationId] = N'20250406072239_itemCategories'
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
    WHERE [MigrationId] = N'20250406072239_itemCategories'
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
    WHERE [MigrationId] = N'20250406072239_itemCategories'
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
    WHERE [MigrationId] = N'20250406072239_itemCategories'
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
    WHERE [MigrationId] = N'20250406072239_itemCategories'
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
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Date', N'ExpenseModelid', N'ItemCategoryId', N'Measurement', N'Name') AND [object_id] = OBJECT_ID(N'[Items]'))
        SET IDENTITY_INSERT [Items] ON;
    EXEC(N'INSERT INTO [Items] ([Id], [Date], [ExpenseModelid], [ItemCategoryId], [Measurement], [Name])
    VALUES (1, ''2025-04-06T07:22:37.2613308Z'', NULL, 1, N''Monthly'', N''Rent''),
    (2, ''2025-04-06T07:22:37.2624553Z'', NULL, 1, N''Monthly'', N''Mortgage''),
    (3, ''2025-04-06T07:22:37.2624564Z'', NULL, 1, N''Yearly'', N''Home Insurance''),
    (4, ''2025-04-06T07:22:37.2624568Z'', NULL, 1, N''One-time'', N''Furniture''),
    (5, ''2025-04-06T07:22:37.2624572Z'', NULL, 2, N''kWh'', N''Electricity''),
    (6, ''2025-04-06T07:22:37.2624574Z'', NULL, 2, N''Gallons'', N''Water Bill''),
    (7, ''2025-04-06T07:22:37.2624578Z'', NULL, 2, N''Monthly'', N''Internet''),
    (8, ''2025-04-06T07:22:37.2624581Z'', NULL, 2, N''Monthly'', N''Mobile Plan''),
    (9, ''2025-04-06T07:22:37.2624584Z'', NULL, 3, N''Liters'', N''Milk''),
    (10, ''2025-04-06T07:22:37.2624588Z'', NULL, 3, N''Dozen'', N''Eggs''),
    (11, ''2025-04-06T07:22:37.2624590Z'', NULL, 3, N''kg'', N''Vegetables''),
    (12, ''2025-04-06T07:22:37.2624594Z'', NULL, 3, N''USD'', N''Snacks''),
    (13, ''2025-04-06T07:22:37.2624596Z'', NULL, 4, N''Liters'', N''Gasoline''),
    (14, ''2025-04-06T07:22:37.2624600Z'', NULL, 4, N''Monthly'', N''Bus Pass''),
    (15, ''2025-04-06T07:22:37.2624603Z'', NULL, 4, N''USD'', N''Car Maintenance''),
    (16, ''2025-04-06T07:22:37.2624606Z'', NULL, 4, N''Daily'', N''Parking Fees''),
    (17, ''2025-04-06T07:22:37.2624608Z'', NULL, 5, N''USD'', N''Doctor Visit''),
    (18, ''2025-04-06T07:22:37.2624612Z'', NULL, 5, N''Monthly'', N''Prescription''),
    (19, ''2025-04-06T07:22:37.2624614Z'', NULL, 5, N''Monthly'', N''Gym Membership''),
    (20, ''2025-04-06T07:22:37.2624617Z'', NULL, 5, N''One-time'', N''First Aid Kit''),
    (21, ''2025-04-06T07:22:37.2624620Z'', NULL, 6, N''Bottle'', N''Shampoo''),
    (22, ''2025-04-06T07:22:37.2624690Z'', NULL, 6, N''USD'', N''Haircut''),
    (23, ''2025-04-06T07:22:37.2624693Z'', NULL, 6, N''Tube'', N''Toothpaste''),
    (24, ''2025-04-06T07:22:37.2624696Z'', NULL, 6, N''Bottle'', N''Perfume''),
    (25, ''2025-04-06T07:22:37.2624699Z'', NULL, 7, N''Pair'', N''Shirts/T-shirts''),
    (26, ''2025-04-06T07:22:37.2624702Z'', NULL, 7, N''One-time'', N''Coat''),
    (27, ''2025-04-06T07:22:37.2624704Z'', NULL, 7, N''Pair'', N''Shoes''),
    (28, ''2025-04-06T07:22:37.2624707Z'', NULL, 7, N''Pack'', N''Socks''),
    (29, ''2025-04-06T07:22:37.2624710Z'', NULL, 8, N''Monthly'', N''Netflix''),
    (30, ''2025-04-06T07:22:37.2624712Z'', NULL, 8, N''USD'', N''Concert Tickets''),
    (31, ''2025-04-06T07:22:37.2624715Z'', NULL, 8, N''USD'', N''Video Games''),
    (32, ''2025-04-06T07:22:37.2624718Z'', NULL, 8, N''USD'', N''Books''),
    (33, ''2025-04-06T07:22:37.2624721Z'', NULL, 9, N''USD'', N''Online Course''),
    (34, ''2025-04-06T07:22:37.2624723Z'', NULL, 9, N''USD'', N''Textbook''),
    (35, ''2025-04-06T07:22:37.2624726Z'', NULL, 9, N''USD'', N''Workshop''),
    (36, ''2025-04-06T07:22:37.2624729Z'', NULL, 9, N''Yearly'', N''Software License''),
    (37, ''2025-04-06T07:22:37.2624860Z'', NULL, 10, N''Monthly'', N''Credit Card''),
    (38, ''2025-04-06T07:22:37.2624864Z'', NULL, 10, N''Monthly'', N''Student Loan''),
    (39, ''2025-04-06T07:22:37.2624867Z'', NULL, 10, N''Monthly'', N''Car Loan''),
    (40, ''2025-04-06T07:22:37.2624870Z'', NULL, 11, N''USD'', N''Birthday Gift''),
    (41, ''2025-04-06T07:22:37.2624872Z'', NULL, 11, N''USD'', N''Charity Donation''),
    (42, ''2025-04-06T07:22:37.2624875Z'', NULL, 11, N''USD'', N''Wedding Gift'');
    INSERT INTO [Items] ([Id], [Date], [ExpenseModelid], [ItemCategoryId], [Measurement], [Name])
    VALUES (43, ''2025-04-06T07:22:37.2624878Z'', NULL, 12, N''USD'', N''Flight Ticket''),
    (44, ''2025-04-06T07:22:37.2624880Z'', NULL, 12, N''Nights'', N''Hotel Stay''),
    (45, ''2025-04-06T07:22:37.2624883Z'', NULL, 12, N''Trip'', N''Travel Insurance''),
    (46, ''2025-04-06T07:22:37.2624918Z'', NULL, 13, N''Pack'', N''Lightbulbs''),
    (47, ''2025-04-06T07:22:37.2624922Z'', NULL, 13, N''USD'', N''Cleaning Supplies''),
    (48, ''2025-04-06T07:22:37.2624925Z'', NULL, 13, N''USD'', N''Plumber Visit''),
    (49, ''2025-04-06T07:22:37.2624928Z'', NULL, 14, N''Monthly'', N''Spotify''),
    (50, ''2025-04-06T07:22:37.2624931Z'', NULL, 14, N''Monthly'', N''Cloud Storage''),
    (51, ''2025-04-06T07:22:37.2624935Z'', NULL, 14, N''Yearly'', N''Magazine''),
    (52, ''2025-04-06T07:22:37.2624938Z'', NULL, 15, N''kg'', N''Pet Food''),
    (53, ''2025-04-06T07:22:37.2624941Z'', NULL, 15, N''Pack'', N''Postage Stamps''),
    (54, ''2025-04-06T07:22:37.2624944Z'', NULL, 15, N''One-time'', N''Umbrella'')');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Date', N'ExpenseModelid', N'ItemCategoryId', N'Measurement', N'Name') AND [object_id] = OBJECT_ID(N'[Items]'))
        SET IDENTITY_INSERT [Items] OFF;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    CREATE INDEX [IX_Budgets_ExpenseModelid] ON [Budgets] ([ExpenseModelid]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    CREATE INDEX [IX_Budgets_IncomeID] ON [Budgets] ([IncomeID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    CREATE INDEX [IX_Budgets_statusID] ON [Budgets] ([statusID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    CREATE INDEX [IX_Expenses_BudgetID] ON [Expenses] ([BudgetID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    CREATE INDEX [IX_Expenses_ItemID] ON [Expenses] ([ItemID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    CREATE INDEX [IX_incomePayment_IncomeID] ON [incomePayment] ([IncomeID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    CREATE INDEX [IX_incomePayment_PaymentMethodModelid] ON [incomePayment] ([PaymentMethodModelid]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    CREATE INDEX [IX_Incomes_BudgetModelId] ON [Incomes] ([BudgetModelId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    CREATE INDEX [IX_Incomes_IncomeCategoryID] ON [Incomes] ([IncomeCategoryID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    CREATE INDEX [IX_Incomes_InvestModelId] ON [Incomes] ([InvestModelId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    CREATE INDEX [IX_Incomes_StatusID] ON [Incomes] ([StatusID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    CREATE INDEX [IX_Incomes_UserID] ON [Incomes] ([UserID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    CREATE INDEX [IX_Investments_InvestId] ON [Investments] ([InvestId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    CREATE INDEX [IX_Investments_investTypeID] ON [Investments] ([investTypeID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    CREATE INDEX [IX_Investments_StatusModelid] ON [Investments] ([StatusModelid]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    CREATE INDEX [IX_Investments_UserId] ON [Investments] ([UserId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    CREATE INDEX [IX_investmentTypes_InvestmentModelid] ON [investmentTypes] ([InvestmentModelid]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    CREATE UNIQUE INDEX [IX_Invests_IncomeID] ON [Invests] ([IncomeID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    CREATE INDEX [IX_Invests_InvestmentId] ON [Invests] ([InvestmentId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    CREATE INDEX [IX_Invests_StatusID] ON [Invests] ([StatusID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    CREATE INDEX [IX_itemCategories_ItemsModelId] ON [itemCategories] ([ItemsModelId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    CREATE INDEX [IX_Items_ExpenseModelid] ON [Items] ([ExpenseModelid]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    CREATE INDEX [IX_Items_ItemCategoryId] ON [Items] ([ItemCategoryId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    CREATE INDEX [IX_Statuses_BudgetModelId] ON [Statuses] ([BudgetModelId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    CREATE INDEX [IX_Statuses_InvestModelId] ON [Statuses] ([InvestModelId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    EXEC(N'CREATE UNIQUE INDEX [IX_Transactions_budgetid] ON [Transactions] ([budgetid]) WHERE [budgetid] IS NOT NULL');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    EXEC(N'CREATE UNIQUE INDEX [IX_Transactions_incomeid] ON [Transactions] ([incomeid]) WHERE [incomeid] IS NOT NULL');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    EXEC(N'CREATE UNIQUE INDEX [IX_Transactions_investid] ON [Transactions] ([investid]) WHERE [investid] IS NOT NULL');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    CREATE INDEX [IX_Users_Rolesid] ON [Users] ([Rolesid]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    ALTER TABLE [Budgets] ADD CONSTRAINT [FK_Budgets_Expenses_ExpenseModelid] FOREIGN KEY ([ExpenseModelid]) REFERENCES [Expenses] ([id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    ALTER TABLE [Budgets] ADD CONSTRAINT [FK_Budgets_Incomes_IncomeID] FOREIGN KEY ([IncomeID]) REFERENCES [Incomes] ([Id]) ON DELETE NO ACTION;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    ALTER TABLE [Budgets] ADD CONSTRAINT [FK_Budgets_Statuses_statusID] FOREIGN KEY ([statusID]) REFERENCES [Statuses] ([id]) ON DELETE NO ACTION;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    ALTER TABLE [Expenses] ADD CONSTRAINT [FK_Expenses_Items_ItemID] FOREIGN KEY ([ItemID]) REFERENCES [Items] ([Id]) ON DELETE CASCADE;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    ALTER TABLE [incomePayment] ADD CONSTRAINT [FK_incomePayment_Incomes_IncomeID] FOREIGN KEY ([IncomeID]) REFERENCES [Incomes] ([Id]) ON DELETE CASCADE;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    ALTER TABLE [Incomes] ADD CONSTRAINT [FK_Incomes_Invests_InvestModelId] FOREIGN KEY ([InvestModelId]) REFERENCES [Invests] ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    ALTER TABLE [Incomes] ADD CONSTRAINT [FK_Incomes_Statuses_StatusID] FOREIGN KEY ([StatusID]) REFERENCES [Statuses] ([id]) ON DELETE NO ACTION;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    ALTER TABLE [Investments] ADD CONSTRAINT [FK_Investments_Invests_InvestId] FOREIGN KEY ([InvestId]) REFERENCES [Invests] ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    ALTER TABLE [Investments] ADD CONSTRAINT [FK_Investments_Statuses_StatusModelid] FOREIGN KEY ([StatusModelid]) REFERENCES [Statuses] ([id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    ALTER TABLE [Investments] ADD CONSTRAINT [FK_Investments_investmentTypes_investTypeID] FOREIGN KEY ([investTypeID]) REFERENCES [investmentTypes] ([id]) ON DELETE NO ACTION;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    ALTER TABLE [Invests] ADD CONSTRAINT [FK_Invests_Statuses_StatusID] FOREIGN KEY ([StatusID]) REFERENCES [Statuses] ([id]) ON DELETE NO ACTION;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    ALTER TABLE [itemCategories] ADD CONSTRAINT [FK_itemCategories_Items_ItemsModelId] FOREIGN KEY ([ItemsModelId]) REFERENCES [Items] ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072239_itemCategories'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250406072239_itemCategories', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1114047Z''
    WHERE [Id] = 1;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115757Z''
    WHERE [Id] = 2;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115763Z''
    WHERE [Id] = 3;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115765Z''
    WHERE [Id] = 4;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115804Z''
    WHERE [Id] = 5;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115806Z''
    WHERE [Id] = 6;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115808Z''
    WHERE [Id] = 7;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115810Z''
    WHERE [Id] = 8;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115812Z''
    WHERE [Id] = 9;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115814Z''
    WHERE [Id] = 10;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115816Z''
    WHERE [Id] = 11;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115817Z''
    WHERE [Id] = 12;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115819Z''
    WHERE [Id] = 13;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115821Z''
    WHERE [Id] = 14;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115822Z''
    WHERE [Id] = 15;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115824Z''
    WHERE [Id] = 16;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115825Z''
    WHERE [Id] = 17;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115827Z''
    WHERE [Id] = 18;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115829Z''
    WHERE [Id] = 19;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115830Z''
    WHERE [Id] = 20;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115832Z''
    WHERE [Id] = 21;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115834Z''
    WHERE [Id] = 22;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115835Z''
    WHERE [Id] = 23;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115837Z''
    WHERE [Id] = 24;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115839Z''
    WHERE [Id] = 25;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115840Z''
    WHERE [Id] = 26;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115842Z''
    WHERE [Id] = 27;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115843Z''
    WHERE [Id] = 28;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115863Z''
    WHERE [Id] = 29;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115865Z''
    WHERE [Id] = 30;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115867Z''
    WHERE [Id] = 31;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115868Z''
    WHERE [Id] = 32;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115870Z''
    WHERE [Id] = 33;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115872Z''
    WHERE [Id] = 34;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115873Z''
    WHERE [Id] = 35;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115875Z''
    WHERE [Id] = 36;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115876Z''
    WHERE [Id] = 37;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115878Z''
    WHERE [Id] = 38;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115880Z''
    WHERE [Id] = 39;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115881Z''
    WHERE [Id] = 40;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115883Z''
    WHERE [Id] = 41;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115884Z''
    WHERE [Id] = 42;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115886Z''
    WHERE [Id] = 43;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115888Z''
    WHERE [Id] = 44;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115889Z''
    WHERE [Id] = 45;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115950Z''
    WHERE [Id] = 46;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115952Z''
    WHERE [Id] = 47;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115953Z''
    WHERE [Id] = 48;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115955Z''
    WHERE [Id] = 49;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115956Z''
    WHERE [Id] = 50;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115958Z''
    WHERE [Id] = 51;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115960Z''
    WHERE [Id] = 52;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115961Z''
    WHERE [Id] = 53;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:23:16.1115983Z''
    WHERE [Id] = 54;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072317_incomeCategories'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250406072317_incomeCategories', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1619747Z''
    WHERE [Id] = 1;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626388Z''
    WHERE [Id] = 2;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626394Z''
    WHERE [Id] = 3;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626397Z''
    WHERE [Id] = 4;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626399Z''
    WHERE [Id] = 5;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626400Z''
    WHERE [Id] = 6;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626402Z''
    WHERE [Id] = 7;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626404Z''
    WHERE [Id] = 8;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626406Z''
    WHERE [Id] = 9;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626408Z''
    WHERE [Id] = 10;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626410Z''
    WHERE [Id] = 11;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626412Z''
    WHERE [Id] = 12;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626414Z''
    WHERE [Id] = 13;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626415Z''
    WHERE [Id] = 14;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626417Z''
    WHERE [Id] = 15;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626419Z''
    WHERE [Id] = 16;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626420Z''
    WHERE [Id] = 17;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626422Z''
    WHERE [Id] = 18;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626424Z''
    WHERE [Id] = 19;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626425Z''
    WHERE [Id] = 20;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626427Z''
    WHERE [Id] = 21;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626468Z''
    WHERE [Id] = 22;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626470Z''
    WHERE [Id] = 23;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626471Z''
    WHERE [Id] = 24;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626473Z''
    WHERE [Id] = 25;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626475Z''
    WHERE [Id] = 26;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626476Z''
    WHERE [Id] = 27;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626597Z''
    WHERE [Id] = 28;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626599Z''
    WHERE [Id] = 29;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626601Z''
    WHERE [Id] = 30;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626602Z''
    WHERE [Id] = 31;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626604Z''
    WHERE [Id] = 32;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626606Z''
    WHERE [Id] = 33;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626608Z''
    WHERE [Id] = 34;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626609Z''
    WHERE [Id] = 35;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626611Z''
    WHERE [Id] = 36;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626612Z''
    WHERE [Id] = 37;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626614Z''
    WHERE [Id] = 38;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626616Z''
    WHERE [Id] = 39;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626618Z''
    WHERE [Id] = 40;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626620Z''
    WHERE [Id] = 41;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626622Z''
    WHERE [Id] = 42;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626623Z''
    WHERE [Id] = 43;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626625Z''
    WHERE [Id] = 44;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626627Z''
    WHERE [Id] = 45;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626649Z''
    WHERE [Id] = 46;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626651Z''
    WHERE [Id] = 47;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626652Z''
    WHERE [Id] = 48;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626654Z''
    WHERE [Id] = 49;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626656Z''
    WHERE [Id] = 50;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626657Z''
    WHERE [Id] = 51;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626659Z''
    WHERE [Id] = 52;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626661Z''
    WHERE [Id] = 53;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:09.1626662Z''
    WHERE [Id] = 54;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072411_Statuses'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250406072411_Statuses', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4510632Z''
    WHERE [Id] = 1;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513003Z''
    WHERE [Id] = 2;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513010Z''
    WHERE [Id] = 3;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513013Z''
    WHERE [Id] = 4;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513067Z''
    WHERE [Id] = 5;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513069Z''
    WHERE [Id] = 6;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513071Z''
    WHERE [Id] = 7;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513073Z''
    WHERE [Id] = 8;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513076Z''
    WHERE [Id] = 9;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513078Z''
    WHERE [Id] = 10;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513080Z''
    WHERE [Id] = 11;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513082Z''
    WHERE [Id] = 12;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513084Z''
    WHERE [Id] = 13;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513086Z''
    WHERE [Id] = 14;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513089Z''
    WHERE [Id] = 15;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513091Z''
    WHERE [Id] = 16;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513093Z''
    WHERE [Id] = 17;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513096Z''
    WHERE [Id] = 18;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513098Z''
    WHERE [Id] = 19;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513100Z''
    WHERE [Id] = 20;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513102Z''
    WHERE [Id] = 21;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513104Z''
    WHERE [Id] = 22;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513107Z''
    WHERE [Id] = 23;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513108Z''
    WHERE [Id] = 24;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513110Z''
    WHERE [Id] = 25;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513112Z''
    WHERE [Id] = 26;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513114Z''
    WHERE [Id] = 27;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513116Z''
    WHERE [Id] = 28;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513140Z''
    WHERE [Id] = 29;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513142Z''
    WHERE [Id] = 30;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513144Z''
    WHERE [Id] = 31;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513146Z''
    WHERE [Id] = 32;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513148Z''
    WHERE [Id] = 33;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513227Z''
    WHERE [Id] = 34;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513230Z''
    WHERE [Id] = 35;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513232Z''
    WHERE [Id] = 36;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513234Z''
    WHERE [Id] = 37;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513236Z''
    WHERE [Id] = 38;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513238Z''
    WHERE [Id] = 39;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513241Z''
    WHERE [Id] = 40;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513243Z''
    WHERE [Id] = 41;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513245Z''
    WHERE [Id] = 42;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513247Z''
    WHERE [Id] = 43;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513249Z''
    WHERE [Id] = 44;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513252Z''
    WHERE [Id] = 45;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513254Z''
    WHERE [Id] = 46;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513256Z''
    WHERE [Id] = 47;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513258Z''
    WHERE [Id] = 48;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513260Z''
    WHERE [Id] = 49;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513262Z''
    WHERE [Id] = 50;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513264Z''
    WHERE [Id] = 51;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513266Z''
    WHERE [Id] = 52;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513268Z''
    WHERE [Id] = 53;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:24:51.4513297Z''
    WHERE [Id] = 54;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072452_Items'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250406072452_Items', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7045410Z''
    WHERE [Id] = 1;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7047722Z''
    WHERE [Id] = 2;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7047731Z''
    WHERE [Id] = 3;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7047734Z''
    WHERE [Id] = 4;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7047736Z''
    WHERE [Id] = 5;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7047739Z''
    WHERE [Id] = 6;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7047741Z''
    WHERE [Id] = 7;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7047744Z''
    WHERE [Id] = 8;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7047746Z''
    WHERE [Id] = 9;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7047749Z''
    WHERE [Id] = 10;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7047751Z''
    WHERE [Id] = 11;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7047754Z''
    WHERE [Id] = 12;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7047756Z''
    WHERE [Id] = 13;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7047759Z''
    WHERE [Id] = 14;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7047761Z''
    WHERE [Id] = 15;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7047763Z''
    WHERE [Id] = 16;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7047765Z''
    WHERE [Id] = 17;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7047767Z''
    WHERE [Id] = 18;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7047769Z''
    WHERE [Id] = 19;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7047771Z''
    WHERE [Id] = 20;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7047773Z''
    WHERE [Id] = 21;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7047833Z''
    WHERE [Id] = 22;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7047835Z''
    WHERE [Id] = 23;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7047838Z''
    WHERE [Id] = 24;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7047840Z''
    WHERE [Id] = 25;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7047842Z''
    WHERE [Id] = 26;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7047844Z''
    WHERE [Id] = 27;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7047846Z''
    WHERE [Id] = 28;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7047848Z''
    WHERE [Id] = 29;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7047850Z''
    WHERE [Id] = 30;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7047852Z''
    WHERE [Id] = 31;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7048027Z''
    WHERE [Id] = 32;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7048031Z''
    WHERE [Id] = 33;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7048033Z''
    WHERE [Id] = 34;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7048035Z''
    WHERE [Id] = 35;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7048037Z''
    WHERE [Id] = 36;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7048039Z''
    WHERE [Id] = 37;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7048041Z''
    WHERE [Id] = 38;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7048042Z''
    WHERE [Id] = 39;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7048044Z''
    WHERE [Id] = 40;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7048045Z''
    WHERE [Id] = 41;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7048047Z''
    WHERE [Id] = 42;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7048049Z''
    WHERE [Id] = 43;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7048050Z''
    WHERE [Id] = 44;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7048052Z''
    WHERE [Id] = 45;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7048077Z''
    WHERE [Id] = 46;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7048079Z''
    WHERE [Id] = 47;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7048081Z''
    WHERE [Id] = 48;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7048083Z''
    WHERE [Id] = 49;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7048085Z''
    WHERE [Id] = 50;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7048087Z''
    WHERE [Id] = 51;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7048088Z''
    WHERE [Id] = 52;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7048090Z''
    WHERE [Id] = 53;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:25:46.7048092Z''
    WHERE [Id] = 54;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072548_Expenses'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250406072548_Expenses', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5367089Z''
    WHERE [Id] = 1;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368647Z''
    WHERE [Id] = 2;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368653Z''
    WHERE [Id] = 3;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368655Z''
    WHERE [Id] = 4;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368658Z''
    WHERE [Id] = 5;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368660Z''
    WHERE [Id] = 6;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368662Z''
    WHERE [Id] = 7;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368663Z''
    WHERE [Id] = 8;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368665Z''
    WHERE [Id] = 9;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368667Z''
    WHERE [Id] = 10;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368669Z''
    WHERE [Id] = 11;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368670Z''
    WHERE [Id] = 12;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368672Z''
    WHERE [Id] = 13;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368674Z''
    WHERE [Id] = 14;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368675Z''
    WHERE [Id] = 15;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368677Z''
    WHERE [Id] = 16;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368679Z''
    WHERE [Id] = 17;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368680Z''
    WHERE [Id] = 18;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368682Z''
    WHERE [Id] = 19;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368684Z''
    WHERE [Id] = 20;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368685Z''
    WHERE [Id] = 21;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368723Z''
    WHERE [Id] = 22;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368725Z''
    WHERE [Id] = 23;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368726Z''
    WHERE [Id] = 24;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368728Z''
    WHERE [Id] = 25;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368730Z''
    WHERE [Id] = 26;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368731Z''
    WHERE [Id] = 27;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368733Z''
    WHERE [Id] = 28;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368734Z''
    WHERE [Id] = 29;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368736Z''
    WHERE [Id] = 30;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368738Z''
    WHERE [Id] = 31;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368740Z''
    WHERE [Id] = 32;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368741Z''
    WHERE [Id] = 33;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368743Z''
    WHERE [Id] = 34;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368745Z''
    WHERE [Id] = 35;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368746Z''
    WHERE [Id] = 36;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368748Z''
    WHERE [Id] = 37;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368749Z''
    WHERE [Id] = 38;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368751Z''
    WHERE [Id] = 39;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368753Z''
    WHERE [Id] = 40;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368754Z''
    WHERE [Id] = 41;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368756Z''
    WHERE [Id] = 42;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368757Z''
    WHERE [Id] = 43;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368759Z''
    WHERE [Id] = 44;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368761Z''
    WHERE [Id] = 45;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368779Z''
    WHERE [Id] = 46;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368781Z''
    WHERE [Id] = 47;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368783Z''
    WHERE [Id] = 48;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368784Z''
    WHERE [Id] = 49;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368903Z''
    WHERE [Id] = 50;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368905Z''
    WHERE [Id] = 51;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368907Z''
    WHERE [Id] = 52;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368908Z''
    WHERE [Id] = 53;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:26:20.5368910Z''
    WHERE [Id] = 54;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072622_Budgets'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250406072622_Budgets', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6542067Z''
    WHERE [Id] = 1;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545085Z''
    WHERE [Id] = 2;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545094Z''
    WHERE [Id] = 3;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545098Z''
    WHERE [Id] = 4;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545100Z''
    WHERE [Id] = 5;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545102Z''
    WHERE [Id] = 6;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545104Z''
    WHERE [Id] = 7;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545106Z''
    WHERE [Id] = 8;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545108Z''
    WHERE [Id] = 9;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545110Z''
    WHERE [Id] = 10;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545112Z''
    WHERE [Id] = 11;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545114Z''
    WHERE [Id] = 12;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545116Z''
    WHERE [Id] = 13;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545118Z''
    WHERE [Id] = 14;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545120Z''
    WHERE [Id] = 15;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545123Z''
    WHERE [Id] = 16;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545125Z''
    WHERE [Id] = 17;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545127Z''
    WHERE [Id] = 18;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545129Z''
    WHERE [Id] = 19;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545132Z''
    WHERE [Id] = 20;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545134Z''
    WHERE [Id] = 21;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545199Z''
    WHERE [Id] = 22;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545201Z''
    WHERE [Id] = 23;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545203Z''
    WHERE [Id] = 24;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545205Z''
    WHERE [Id] = 25;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545207Z''
    WHERE [Id] = 26;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545209Z''
    WHERE [Id] = 27;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545211Z''
    WHERE [Id] = 28;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545213Z''
    WHERE [Id] = 29;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545215Z''
    WHERE [Id] = 30;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545217Z''
    WHERE [Id] = 31;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545219Z''
    WHERE [Id] = 32;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545221Z''
    WHERE [Id] = 33;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545224Z''
    WHERE [Id] = 34;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545318Z''
    WHERE [Id] = 35;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545320Z''
    WHERE [Id] = 36;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545322Z''
    WHERE [Id] = 37;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545324Z''
    WHERE [Id] = 38;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545326Z''
    WHERE [Id] = 39;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545328Z''
    WHERE [Id] = 40;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545330Z''
    WHERE [Id] = 41;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545332Z''
    WHERE [Id] = 42;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545334Z''
    WHERE [Id] = 43;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545337Z''
    WHERE [Id] = 44;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545339Z''
    WHERE [Id] = 45;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545369Z''
    WHERE [Id] = 46;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545372Z''
    WHERE [Id] = 47;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545374Z''
    WHERE [Id] = 48;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545376Z''
    WHERE [Id] = 49;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545378Z''
    WHERE [Id] = 50;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545380Z''
    WHERE [Id] = 51;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545382Z''
    WHERE [Id] = 52;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545384Z''
    WHERE [Id] = 53;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:09.6545386Z''
    WHERE [Id] = 54;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072711_Incomes'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250406072711_Incomes', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2655866Z''
    WHERE [Id] = 1;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657491Z''
    WHERE [Id] = 2;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657497Z''
    WHERE [Id] = 3;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657500Z''
    WHERE [Id] = 4;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657541Z''
    WHERE [Id] = 5;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657544Z''
    WHERE [Id] = 6;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657546Z''
    WHERE [Id] = 7;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657548Z''
    WHERE [Id] = 8;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657550Z''
    WHERE [Id] = 9;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657552Z''
    WHERE [Id] = 10;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657553Z''
    WHERE [Id] = 11;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657555Z''
    WHERE [Id] = 12;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657557Z''
    WHERE [Id] = 13;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657558Z''
    WHERE [Id] = 14;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657560Z''
    WHERE [Id] = 15;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657561Z''
    WHERE [Id] = 16;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657563Z''
    WHERE [Id] = 17;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657565Z''
    WHERE [Id] = 18;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657566Z''
    WHERE [Id] = 19;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657568Z''
    WHERE [Id] = 20;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657570Z''
    WHERE [Id] = 21;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657571Z''
    WHERE [Id] = 22;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657573Z''
    WHERE [Id] = 23;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657575Z''
    WHERE [Id] = 24;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657576Z''
    WHERE [Id] = 25;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657578Z''
    WHERE [Id] = 26;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657580Z''
    WHERE [Id] = 27;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657581Z''
    WHERE [Id] = 28;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657601Z''
    WHERE [Id] = 29;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657602Z''
    WHERE [Id] = 30;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657604Z''
    WHERE [Id] = 31;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657606Z''
    WHERE [Id] = 32;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657607Z''
    WHERE [Id] = 33;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657609Z''
    WHERE [Id] = 34;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657610Z''
    WHERE [Id] = 35;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657612Z''
    WHERE [Id] = 36;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657614Z''
    WHERE [Id] = 37;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657615Z''
    WHERE [Id] = 38;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657617Z''
    WHERE [Id] = 39;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657619Z''
    WHERE [Id] = 40;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657620Z''
    WHERE [Id] = 41;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657622Z''
    WHERE [Id] = 42;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657623Z''
    WHERE [Id] = 43;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657625Z''
    WHERE [Id] = 44;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657627Z''
    WHERE [Id] = 45;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657628Z''
    WHERE [Id] = 46;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657630Z''
    WHERE [Id] = 47;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657632Z''
    WHERE [Id] = 48;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657633Z''
    WHERE [Id] = 49;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657635Z''
    WHERE [Id] = 50;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657775Z''
    WHERE [Id] = 51;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657777Z''
    WHERE [Id] = 52;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657778Z''
    WHERE [Id] = 53;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:27:59.2657802Z''
    WHERE [Id] = 54;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072800_Transactions'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250406072800_Transactions', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4185397Z''
    WHERE [Id] = 1;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4410948Z''
    WHERE [Id] = 2;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4410957Z''
    WHERE [Id] = 3;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4410960Z''
    WHERE [Id] = 4;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411006Z''
    WHERE [Id] = 5;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411007Z''
    WHERE [Id] = 6;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411009Z''
    WHERE [Id] = 7;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411011Z''
    WHERE [Id] = 8;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411012Z''
    WHERE [Id] = 9;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411013Z''
    WHERE [Id] = 10;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411018Z''
    WHERE [Id] = 11;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411019Z''
    WHERE [Id] = 12;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411020Z''
    WHERE [Id] = 13;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411021Z''
    WHERE [Id] = 14;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411022Z''
    WHERE [Id] = 15;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411024Z''
    WHERE [Id] = 16;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411026Z''
    WHERE [Id] = 17;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411027Z''
    WHERE [Id] = 18;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411028Z''
    WHERE [Id] = 19;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411029Z''
    WHERE [Id] = 20;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411030Z''
    WHERE [Id] = 21;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411031Z''
    WHERE [Id] = 22;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411033Z''
    WHERE [Id] = 23;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411034Z''
    WHERE [Id] = 24;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411035Z''
    WHERE [Id] = 25;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411036Z''
    WHERE [Id] = 26;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411038Z''
    WHERE [Id] = 27;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411039Z''
    WHERE [Id] = 28;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411054Z''
    WHERE [Id] = 29;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411055Z''
    WHERE [Id] = 30;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411056Z''
    WHERE [Id] = 31;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411058Z''
    WHERE [Id] = 32;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411059Z''
    WHERE [Id] = 33;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411060Z''
    WHERE [Id] = 34;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411061Z''
    WHERE [Id] = 35;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411063Z''
    WHERE [Id] = 36;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411064Z''
    WHERE [Id] = 37;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411065Z''
    WHERE [Id] = 38;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411066Z''
    WHERE [Id] = 39;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411067Z''
    WHERE [Id] = 40;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411068Z''
    WHERE [Id] = 41;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411070Z''
    WHERE [Id] = 42;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411071Z''
    WHERE [Id] = 43;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411072Z''
    WHERE [Id] = 44;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411073Z''
    WHERE [Id] = 45;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411074Z''
    WHERE [Id] = 46;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411075Z''
    WHERE [Id] = 47;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411077Z''
    WHERE [Id] = 48;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411078Z''
    WHERE [Id] = 49;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411338Z''
    WHERE [Id] = 50;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411339Z''
    WHERE [Id] = 51;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411340Z''
    WHERE [Id] = 52;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411342Z''
    WHERE [Id] = 53;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:05.4411358Z''
    WHERE [Id] = 54;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072907_Users'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250406072907_Users', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1004260Z''
    WHERE [Id] = 1;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005833Z''
    WHERE [Id] = 2;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005839Z''
    WHERE [Id] = 3;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005841Z''
    WHERE [Id] = 4;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005882Z''
    WHERE [Id] = 5;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005884Z''
    WHERE [Id] = 6;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005886Z''
    WHERE [Id] = 7;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005888Z''
    WHERE [Id] = 8;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005890Z''
    WHERE [Id] = 9;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005892Z''
    WHERE [Id] = 10;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005894Z''
    WHERE [Id] = 11;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005895Z''
    WHERE [Id] = 12;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005897Z''
    WHERE [Id] = 13;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005898Z''
    WHERE [Id] = 14;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005900Z''
    WHERE [Id] = 15;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005902Z''
    WHERE [Id] = 16;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005903Z''
    WHERE [Id] = 17;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005905Z''
    WHERE [Id] = 18;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005907Z''
    WHERE [Id] = 19;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005908Z''
    WHERE [Id] = 20;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005910Z''
    WHERE [Id] = 21;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005911Z''
    WHERE [Id] = 22;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005913Z''
    WHERE [Id] = 23;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005915Z''
    WHERE [Id] = 24;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005916Z''
    WHERE [Id] = 25;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005918Z''
    WHERE [Id] = 26;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005919Z''
    WHERE [Id] = 27;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005921Z''
    WHERE [Id] = 28;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005940Z''
    WHERE [Id] = 29;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005941Z''
    WHERE [Id] = 30;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005943Z''
    WHERE [Id] = 31;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005945Z''
    WHERE [Id] = 32;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005947Z''
    WHERE [Id] = 33;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005948Z''
    WHERE [Id] = 34;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005950Z''
    WHERE [Id] = 35;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005951Z''
    WHERE [Id] = 36;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1005953Z''
    WHERE [Id] = 37;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1006081Z''
    WHERE [Id] = 38;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1006082Z''
    WHERE [Id] = 39;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1006084Z''
    WHERE [Id] = 40;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1006086Z''
    WHERE [Id] = 41;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1006087Z''
    WHERE [Id] = 42;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1006089Z''
    WHERE [Id] = 43;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1006090Z''
    WHERE [Id] = 44;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1006092Z''
    WHERE [Id] = 45;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1006094Z''
    WHERE [Id] = 46;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1006095Z''
    WHERE [Id] = 47;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1006097Z''
    WHERE [Id] = 48;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1006098Z''
    WHERE [Id] = 49;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1006100Z''
    WHERE [Id] = 50;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1006102Z''
    WHERE [Id] = 51;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1006103Z''
    WHERE [Id] = 52;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1006105Z''
    WHERE [Id] = 53;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:24.1006126Z''
    WHERE [Id] = 54;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072925_Roles'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250406072925_Roles', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1724632Z''
    WHERE [Id] = 1;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726212Z''
    WHERE [Id] = 2;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726218Z''
    WHERE [Id] = 3;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726221Z''
    WHERE [Id] = 4;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726260Z''
    WHERE [Id] = 5;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726263Z''
    WHERE [Id] = 6;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726264Z''
    WHERE [Id] = 7;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726266Z''
    WHERE [Id] = 8;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726268Z''
    WHERE [Id] = 9;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726271Z''
    WHERE [Id] = 10;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726273Z''
    WHERE [Id] = 11;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726275Z''
    WHERE [Id] = 12;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726277Z''
    WHERE [Id] = 13;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726278Z''
    WHERE [Id] = 14;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726280Z''
    WHERE [Id] = 15;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726282Z''
    WHERE [Id] = 16;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726284Z''
    WHERE [Id] = 17;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726285Z''
    WHERE [Id] = 18;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726287Z''
    WHERE [Id] = 19;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726288Z''
    WHERE [Id] = 20;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726290Z''
    WHERE [Id] = 21;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726292Z''
    WHERE [Id] = 22;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726293Z''
    WHERE [Id] = 23;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726295Z''
    WHERE [Id] = 24;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726296Z''
    WHERE [Id] = 25;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726298Z''
    WHERE [Id] = 26;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726300Z''
    WHERE [Id] = 27;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726301Z''
    WHERE [Id] = 28;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726321Z''
    WHERE [Id] = 29;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726322Z''
    WHERE [Id] = 30;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726324Z''
    WHERE [Id] = 31;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726326Z''
    WHERE [Id] = 32;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726327Z''
    WHERE [Id] = 33;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726329Z''
    WHERE [Id] = 34;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726330Z''
    WHERE [Id] = 35;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726332Z''
    WHERE [Id] = 36;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726334Z''
    WHERE [Id] = 37;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726335Z''
    WHERE [Id] = 38;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726337Z''
    WHERE [Id] = 39;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726338Z''
    WHERE [Id] = 40;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726340Z''
    WHERE [Id] = 41;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726342Z''
    WHERE [Id] = 42;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726343Z''
    WHERE [Id] = 43;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726345Z''
    WHERE [Id] = 44;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726346Z''
    WHERE [Id] = 45;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726410Z''
    WHERE [Id] = 46;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726412Z''
    WHERE [Id] = 47;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726414Z''
    WHERE [Id] = 48;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726416Z''
    WHERE [Id] = 49;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726417Z''
    WHERE [Id] = 50;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726419Z''
    WHERE [Id] = 51;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726420Z''
    WHERE [Id] = 52;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726422Z''
    WHERE [Id] = 53;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:29:50.1726443Z''
    WHERE [Id] = 54;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406072953_investmentTypes'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250406072953_investmentTypes', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5730092Z''
    WHERE [Id] = 1;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732006Z''
    WHERE [Id] = 2;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732012Z''
    WHERE [Id] = 3;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732016Z''
    WHERE [Id] = 4;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732064Z''
    WHERE [Id] = 5;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732067Z''
    WHERE [Id] = 6;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732069Z''
    WHERE [Id] = 7;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732072Z''
    WHERE [Id] = 8;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732074Z''
    WHERE [Id] = 9;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732077Z''
    WHERE [Id] = 10;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732079Z''
    WHERE [Id] = 11;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732081Z''
    WHERE [Id] = 12;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732083Z''
    WHERE [Id] = 13;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732085Z''
    WHERE [Id] = 14;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732088Z''
    WHERE [Id] = 15;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732090Z''
    WHERE [Id] = 16;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732092Z''
    WHERE [Id] = 17;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732094Z''
    WHERE [Id] = 18;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732096Z''
    WHERE [Id] = 19;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732098Z''
    WHERE [Id] = 20;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732100Z''
    WHERE [Id] = 21;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732102Z''
    WHERE [Id] = 22;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732104Z''
    WHERE [Id] = 23;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732107Z''
    WHERE [Id] = 24;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732109Z''
    WHERE [Id] = 25;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732111Z''
    WHERE [Id] = 26;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732113Z''
    WHERE [Id] = 27;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732115Z''
    WHERE [Id] = 28;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732138Z''
    WHERE [Id] = 29;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732140Z''
    WHERE [Id] = 30;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732142Z''
    WHERE [Id] = 31;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732144Z''
    WHERE [Id] = 32;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732146Z''
    WHERE [Id] = 33;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732148Z''
    WHERE [Id] = 34;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732150Z''
    WHERE [Id] = 35;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732152Z''
    WHERE [Id] = 36;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732154Z''
    WHERE [Id] = 37;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732156Z''
    WHERE [Id] = 38;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732158Z''
    WHERE [Id] = 39;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732342Z''
    WHERE [Id] = 40;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732344Z''
    WHERE [Id] = 41;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732347Z''
    WHERE [Id] = 42;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732349Z''
    WHERE [Id] = 43;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732351Z''
    WHERE [Id] = 44;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732353Z''
    WHERE [Id] = 45;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732355Z''
    WHERE [Id] = 46;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732357Z''
    WHERE [Id] = 47;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732359Z''
    WHERE [Id] = 48;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732361Z''
    WHERE [Id] = 49;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732363Z''
    WHERE [Id] = 50;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732365Z''
    WHERE [Id] = 51;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732367Z''
    WHERE [Id] = 52;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732369Z''
    WHERE [Id] = 53;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:30:32.5732395Z''
    WHERE [Id] = 54;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073035_Investments'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250406073035_Investments', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4371727Z''
    WHERE [Id] = 1;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379245Z''
    WHERE [Id] = 2;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379253Z''
    WHERE [Id] = 3;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379256Z''
    WHERE [Id] = 4;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379258Z''
    WHERE [Id] = 5;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379260Z''
    WHERE [Id] = 6;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379262Z''
    WHERE [Id] = 7;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379264Z''
    WHERE [Id] = 8;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379266Z''
    WHERE [Id] = 9;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379269Z''
    WHERE [Id] = 10;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379270Z''
    WHERE [Id] = 11;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379272Z''
    WHERE [Id] = 12;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379275Z''
    WHERE [Id] = 13;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379277Z''
    WHERE [Id] = 14;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379279Z''
    WHERE [Id] = 15;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379280Z''
    WHERE [Id] = 16;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379282Z''
    WHERE [Id] = 17;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379285Z''
    WHERE [Id] = 18;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379287Z''
    WHERE [Id] = 19;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379289Z''
    WHERE [Id] = 20;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379291Z''
    WHERE [Id] = 21;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379355Z''
    WHERE [Id] = 22;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379357Z''
    WHERE [Id] = 23;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379359Z''
    WHERE [Id] = 24;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379361Z''
    WHERE [Id] = 25;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379363Z''
    WHERE [Id] = 26;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379365Z''
    WHERE [Id] = 27;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379367Z''
    WHERE [Id] = 28;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379369Z''
    WHERE [Id] = 29;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379371Z''
    WHERE [Id] = 30;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379373Z''
    WHERE [Id] = 31;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379375Z''
    WHERE [Id] = 32;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379377Z''
    WHERE [Id] = 33;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379379Z''
    WHERE [Id] = 34;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379493Z''
    WHERE [Id] = 35;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379496Z''
    WHERE [Id] = 36;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379498Z''
    WHERE [Id] = 37;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379500Z''
    WHERE [Id] = 38;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379502Z''
    WHERE [Id] = 39;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379504Z''
    WHERE [Id] = 40;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379506Z''
    WHERE [Id] = 41;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379508Z''
    WHERE [Id] = 42;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379510Z''
    WHERE [Id] = 43;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379512Z''
    WHERE [Id] = 44;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379514Z''
    WHERE [Id] = 45;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379543Z''
    WHERE [Id] = 46;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379545Z''
    WHERE [Id] = 47;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379547Z''
    WHERE [Id] = 48;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379549Z''
    WHERE [Id] = 49;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379551Z''
    WHERE [Id] = 50;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379553Z''
    WHERE [Id] = 51;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379555Z''
    WHERE [Id] = 52;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379557Z''
    WHERE [Id] = 53;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:32:24.4379559Z''
    WHERE [Id] = 54;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406073226_Invests'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250406073226_Invests', N'9.0.3');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1630843Z''
    WHERE [Id] = 1;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1639961Z''
    WHERE [Id] = 2;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1639967Z''
    WHERE [Id] = 3;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1639970Z''
    WHERE [Id] = 4;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1639971Z''
    WHERE [Id] = 5;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1639973Z''
    WHERE [Id] = 6;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1639975Z''
    WHERE [Id] = 7;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1639977Z''
    WHERE [Id] = 8;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1639978Z''
    WHERE [Id] = 9;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1639980Z''
    WHERE [Id] = 10;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1639982Z''
    WHERE [Id] = 11;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1639983Z''
    WHERE [Id] = 12;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1639985Z''
    WHERE [Id] = 13;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1639987Z''
    WHERE [Id] = 14;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1639988Z''
    WHERE [Id] = 15;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1639990Z''
    WHERE [Id] = 16;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1639991Z''
    WHERE [Id] = 17;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1639993Z''
    WHERE [Id] = 18;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1639995Z''
    WHERE [Id] = 19;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1639996Z''
    WHERE [Id] = 20;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1639998Z''
    WHERE [Id] = 21;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640063Z''
    WHERE [Id] = 22;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640066Z''
    WHERE [Id] = 23;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640068Z''
    WHERE [Id] = 24;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640070Z''
    WHERE [Id] = 25;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640072Z''
    WHERE [Id] = 26;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640074Z''
    WHERE [Id] = 27;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640076Z''
    WHERE [Id] = 28;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640078Z''
    WHERE [Id] = 29;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640080Z''
    WHERE [Id] = 30;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640082Z''
    WHERE [Id] = 31;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640085Z''
    WHERE [Id] = 32;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640087Z''
    WHERE [Id] = 33;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640089Z''
    WHERE [Id] = 34;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640091Z''
    WHERE [Id] = 35;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640093Z''
    WHERE [Id] = 36;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640234Z''
    WHERE [Id] = 37;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640236Z''
    WHERE [Id] = 38;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640238Z''
    WHERE [Id] = 39;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640240Z''
    WHERE [Id] = 40;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640241Z''
    WHERE [Id] = 41;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640243Z''
    WHERE [Id] = 42;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640245Z''
    WHERE [Id] = 43;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640247Z''
    WHERE [Id] = 44;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640249Z''
    WHERE [Id] = 45;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640271Z''
    WHERE [Id] = 46;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640273Z''
    WHERE [Id] = 47;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640275Z''
    WHERE [Id] = 48;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640276Z''
    WHERE [Id] = 49;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640278Z''
    WHERE [Id] = 50;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640280Z''
    WHERE [Id] = 51;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640281Z''
    WHERE [Id] = 52;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640283Z''
    WHERE [Id] = 53;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    EXEC(N'UPDATE [Items] SET [Date] = ''2025-04-06T07:40:25.1640285Z''
    WHERE [Id] = 54;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'id', N'DOB', N'Email', N'FirstName', N'PasswordHash', N'RoleId', N'Rolesid', N'Surname', N'Username', N'createat', N'refreshToken', N'refreshTokenExpirelyToken') AND [object_id] = OBJECT_ID(N'[Users]'))
        SET IDENTITY_INSERT [Users] ON;
    EXEC(N'INSERT INTO [Users] ([id], [DOB], [Email], [FirstName], [PasswordHash], [RoleId], [Rolesid], [Surname], [Username], [createat], [refreshToken], [refreshTokenExpirelyToken])
    VALUES (1, ''9999-12-31'', N''martindharawa@gmail.com'', N''Martin'', N''AQAAAAIAAYagAAAAEMD4Z+obGef5CiAT9Ff7bD/KQ462KWi9kQVyTjFJOx3N0Z80XHXChcfCnIr621TbHQ=='', 1, NULL, N''Harawa'', N''Martin'', ''2025-04-06T09:40:25.1649214+02:00'', NULL, NULL)');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'id', N'DOB', N'Email', N'FirstName', N'PasswordHash', N'RoleId', N'Rolesid', N'Surname', N'Username', N'createat', N'refreshToken', N'refreshTokenExpirelyToken') AND [object_id] = OBJECT_ID(N'[Users]'))
        SET IDENTITY_INSERT [Users] OFF;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250406074026_addseeddata'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250406074026_addseeddata', N'9.0.3');
END;

COMMIT;
GO

