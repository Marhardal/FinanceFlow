import './assets/main.css'

import { createApp } from 'vue'
import App from './App.vue'

import { createRouter, createWebHistory } from 'vue-router'

import formkitconfig from './Others/formkit.config'
import { plugin, defaultConfig} from "@formkit/vue"
// import '@formkit/themes/genesis'
// import { createProPlugin, inputs } from '@formkit/pro'

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

const app = createApp(App);

app.use(plugin, defaultConfig(formkitconfig));

app.use(router).mount('#app');

