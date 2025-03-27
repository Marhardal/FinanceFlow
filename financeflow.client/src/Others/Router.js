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
import EditExpense from '@/components/Views/EditExpense.vue'
import Register from '@/components/Views/Register.vue'
import Login from '@/components/Views/Login.vue'
import Investment from '@/components/Views/Investment.vue'


function auth(to, from) {
  if (!localStorage.getItem('authToken')) {
      return "/login";
  }
}

function guest(to, from) {
  if (localStorage.getItem('authToken')) {
      return "/register";
  }
}

const routes = [
  { path: '/', component: index, beforeEnter: auth },
      { path: '/transactions', component: Transactions, beforeEnter: auth },
      { path: '/incomes', component: Incomes, beforeEnter: auth },
      { path: '/income/create', component: CreateIncome, beforeEnter: auth },
      { path: '/income/edit/:id', component: EditIncome, beforeEnter: auth },
      { path: '/income/details/:id', component: DetailsIncome,  beforeEnter: auth },
      { path: '/expenses', component: Expenses, beforeEnter: auth },
      { path: '/Budget/:id/expense/create', component: CreateExpense, beforeEnter: auth },
      { path: '/Budget/:budgetid/expense/edit/:expenseid', component: EditExpense, beforeEnter: auth },
      { path: '/items', component: Item, beforeEnter: auth },
      { path: '/item/Create', component: CreateItem, beforeEnter: auth },
      { path: '/item/edit/:id', component: EditItem, beforeEnter: auth },
      { path: '/Budgets', component: Budgets,  beforeEnter: auth },
      { path: '/Budget/create', component: CreateBudget, beforeEnter: auth },
      { path: '/Budget/edit/:id', component: EditBudget, beforeEnter: auth },
      { path: '/Budget/details/:id', component: DetailsBudget, beforeEnter: auth },
      { path: '/investment', component: Investment, beforeEnter: auth},
      { path: '/register', component: Register, beforeEnter: guest},
      { path: '/login', component: Login, beforeEnter: guest},
];

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes,
});

// router.beforeEach((to, from, next) => {
//   const token = localStorage.getItem("authToken") // Get the token from storage (localStorage/cookies)

//   if (to.name !== 'login' && !token) {
//     router.push('login') // Redirect to login if not authenticated
//   } else {
//     next() // Allow navigation
//   }
// })


export default router;
