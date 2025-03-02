import { createWebHistory, createRouter } from 'vue-router'

import index from '../components/Views/index.vue'
import Transactions from '../components/Views/Transactions.vue'
import Incomes from '../components/Views/Incomes.vue'
import Expenses from '../components/Views/Expenses.vue'
import Item from '../components/Views/item.vue'
import CreateExpense from '../components/Views/CreateExpense.vue'
import CreateItem from '../components/Views/CreateItem.vue'
import EditItem from '@/components/Views/EditItem.vue'
import CreateIncome from '@/components/Views/CreateIncome.vue'
import EditIncome from '@/components/Views/EditIncome.vue'
import DetailsIncome from '@/components/Views/DetailsIncome.vue'
import Budgets from '@/components/Views/Budgets.vue'
import CreateBudget from '@/components/Views/CreateBudget.vue'
import EditBudget from '@/components/Views/EditBudget.vue'
import DetailsBudget from '@/components/Views/DetailsBudget.vue'

const routes = [
  { path: '/', component: index },
      { path: '/transactions', component: Transactions },
      { path: '/incomes', component: Incomes },
      { path: '/income/create', component: CreateIncome },
      { path: '/income/edit/:id', component: EditIncome },
      { path: '/income/details/:id', component: DetailsIncome },
      { path: '/expenses', component: Expenses },
      { path: '/expense/create', component: CreateExpense },
      { path: '/items', component: Item },
      { path: '/item/Create', component: CreateItem },
      { path: '/item/edit/:id', component: EditItem },
      { path: '/Budgets', component: Budgets },
      { path: '/Budget/create', component: CreateBudget },
      { path: '/Budget/edit/:id', component: EditBudget },
      { path: '/Budget/details/:id', component: DetailsBudget },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
