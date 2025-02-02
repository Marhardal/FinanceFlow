import './assets/main.css'

import { createApp } from 'vue'
import App from './App.vue'

import { createRouter, createWebHistory } from 'vue-router'

import index from './components/Views/index.vue'
import Transactions from './components/Views/Transactions.vue'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/', component: index },
    { path: '/transactions', component: Transactions }
  ],
});

createApp(App).use(router).mount('#app')
