import './assets/main.css'

import { createApp } from 'vue'
import App from './App.vue'
import axios from './Others/apiClient.js'

import { createRouter, createWebHistory } from 'vue-router'

import index from './components/Views/index.vue'
import Transactions from './components/Views/Transactions.vue'
import Incomes from './components/Views/Incomes.vue'
import Expenses from './components/Views/Expenses.vue'
import Item from './components/Views/item.vue'
import CreateExpense from './components/Views/CreateExpense.vue'
import CreateItem from './components/Views/CreateItem.vue'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/', component: index },
    { path: '/transactions', component: Transactions },
    { path: '/incomes', component: Incomes },
    { path: '/expenses', component: Expenses },
    { path: '/expense/create', component: CreateExpense },
    { path: '/items', component: Item },
    { path: '/item/Create', component: CreateItem },
  ],
});

createApp(App).use(router).mount('#app')
