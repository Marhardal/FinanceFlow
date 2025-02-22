import { createMemoryHistory, createRouter } from 'vue-router'

import index from '../components/Views/index.vue'
import Transactions from '../components/Views/Transactions.vue'
import Incomes from '../components/Views/Incomes.vue'
import Expenses from '../components/Views/Expenses.vue'
import Item from '../components/Views/item.vue'
import CreateExpense from '../components/Views/CreateExpense.vue'
import CreateItem from '../components/Views/CreateItem.vue'
import EditItem from '@/components/Views/EditItem.vue'

const routes = [
  { path: '/', component: index },
      { path: '/transactions', component: Transactions },
      { path: '/incomes', component: Incomes },
      { path: '/expenses', component: Expenses },
      { path: '/expense/create', component: CreateExpense },
      { path: '/items', component: Item },
      { path: '/item/Create', component: CreateItem },
      { path: '/item/edit/:id', component: EditItem },
];

const router = createRouter({
  history: createMemoryHistory(),
  routes,
});

export default router;
