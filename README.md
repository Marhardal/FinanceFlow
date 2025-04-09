# FinanceFlow — Personal Finance Management System

**FinanceFlow** is a personal financial management system designed to help users easily track income, budgets, investments, and overall financial performance. Built with modern technologies, it provides insightful dashboards and intelligent reminders to support better money management.

---

## 🔧 Features

### 1. Income Management
- Add and categorize multiple income sources.
- Track monthly income with fallback to previous months if the current month has no data.
- Filter income by status and creation date.

### 2. Budget Tracking
- Create, update, and manage budgets.
- Track total budget per month and compare with income.
- Monitor budget status to ensure financial goals are met.

### 3. Investment Management
- Add investment records with fixed or ranged percentage returns.
- Automatically calculate projected return amounts.
- Assign next investment dates and set automated reminders.
- Associate investments with income sources for tracking.

### 4. Transactions
- Record all transactions linked to income, budget, or investments.
- Each transaction includes amount, type, date, and relationships.
- Seamlessly fetch related data like IncomeName, BudgetName, and InvestmentName.

### 5. Reminders and Notifications
- Send reminders for upcoming investment dates.
- Export reminders as calendar (.ics) files.
- Notify users via email/SMS or integrated app alerts (future feature).

### 6. Dashboard
- Visualize financial performance at a glance.
- Display graphs and stats such as:
  - Income vs Expenses
  - Budget Utilization
  - Monthly Investment Summary
- Highlight gaps like missing income for the month.

---

## 🚀 Technologies Used
- **Backend:** ASP.NET Core (.NET 9)
- **Frontend:** Vue.js with FormKit
- **Database:** SQL Server (EF Core ORM)
- **Styling:** Tailwind CSS
- **Notifications:** Calendar ICS export, Email (planned)
- **Validation & UX:** FormKit with custom input handling

---

## 📆 Use Case
- Individual users tracking personal finances
- Students managing allowances
- Freelancers keeping tabs on inconsistent incomes
- Anyone investing small amounts regularly and needing reminders

---

## 📊 Future Enhancements
- SMS/email reminder system
- Advanced analytics and prediction tools
- User authentication and multi-user support
- Export to Excel/PDF

---

## 🌟 Summary
FinanceFlow is a practical and scalable finance assistant built to simplify personal financial planning. With automated tracking, visual dashboards, and intelligent reminders, users are empowered to take control of their financial lives with clarity and confidence.

