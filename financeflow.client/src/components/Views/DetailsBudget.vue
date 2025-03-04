<template>

  <ContainerBg>
    <div v-if="Budget">
      <div class="border-b border-gray-200 p-5 rounded-lg">
        <h2 class="text-3xl md:text-2xl font-bold mb-2">{{ Budget.name }} Details</h2>
      </div>
      <div class="border-b border-gray-200 p-5 rounded-lg">
        <div class="grid grid-cols-4 gap-4">
          <div class="col-span-1">
            <h3 class="text-lg font-semibold mb-3">Budget Name</h3>
          </div>
          <div class="col-span-3">
            <p class="text-md">{{ Budget.name }}</p>
          </div>
          <div class="col-span-1">
            <h3 class="text-lg font-semibold mb-3">Budgeted Amount</h3>
          </div>
          <div class="col-span-3">
            <p class="text-md">{{ Budget.amount }}</p>
          </div>
          <div class="col-span-1">
            <h3 class="text-lg font-semibold mb-3">Budgeted Income</h3>
          </div>
          <div class="col-span-3" v-if="Budget.income">
            <p class="text-md">{{ Budget.income.name + "->" + Budget.income.amount }}</p>
          </div>
          <div class="col-span-1">
            <h3 class="text-lg font-semibold mb-3">Budgeted Status</h3>
          </div>
          <div class="col-span-3" v-if="Budget.status">
            <p class="text-md">{{ Budget.status.name }}</p>
          </div>
          <div class="col-span-1">
            <h3 class="text-lg font-semibold mb-3">Spent Amount</h3>
          </div>
          <div class="col-span-3">
            <p class="text-md">{{ Budget.spentAmount }}</p>
          </div>
          <div class="col-span-1">
            <h3 class="text-lg font-semibold">Remind on</h3>
          </div>
          <div class="col-span-3">
            <h3 class="text-md">{{ dayjs(Budget.remindon).fromNow() }}</h3>
          </div>
          <div class="col-span-1">
            <h3 class="text-lg font-semibold">Notes</h3>
          </div>
          <div class="col-span-3">
            <h3 class="text-md">{{ Budget.description }}</h3>
          </div>
        </div>
      </div>

      <div class=" py-4">
        <div class="grid grid-cols-7 border-b border-gray-200">
          <div class="col-span-5">
            <h2 class="text-xl py-2 font-bold">Expense List</h2>
          </div>
          <div class="col-span-1">
            <button type="button" class="inline-flex items-center gap-x-2 text-sm font-semibold rounded-lg border border-transparent text-blue-600 hover:text-blue-800 focus:outline-none focus:text-blue-800 disabled:opacity-50 disabled:pointer-events-none bg-gray-800 px-4 py-2">Download</button>
          </div>
          <div class="col-span-1">
            <router-link :to="{ path: '/Budget/'+Budget.id+'/expense/create' }" class="inline-flex items-center gap-x-2 text-sm font-semibold rounded-lg border border-transparent text-white hover:text-black focus:outline-none focus:text-blue-800 disabled:opacity-50 disabled:pointer-events-none bg-blue-600 px-4 py-2 justify-end align-baseline">Create
            </router-link>
          </div>
        </div>
        <div>
          <div class="-mx-4 sm:-mx-8 px-4 sm:px-8 py-4 overflow-x-auto" v-if="Expenses">
            <div class="flex flex-col">
              <div class="-m-1.5 overflow-x-auto">
                <div class="p-1.5 min-w-full inline-block align-middle">
                  <div class="overflow-hidden">
                    <table class="min-w-full divide-y divide-gray-200 dark:divide-neutral-700">
                      <thead>
                        <tr>
                          <th scope="col"
                            class="px-6 py-3 text-start text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">
                            Item Name</th>
                            <th scope="col"
                              class="px-6 py-3 text-start text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">
                              Quantity</th>
                              <th scope="col"
                                class="px-6 py-3 text-start text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">
                                Price</th>
                          <th scope="col"
                            class="px-6 py-3 text-start text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">
                            Amount</th>
                          <th scope="col"
                            class="px-6 py-3 text-end text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">
                            Action</th>
                        </tr>
                      </thead>
                      <tbody class="divide-y divide-gray-200 dark:divide-neutral-700">
                        <tr class="hover:bg-gray-100 dark:hover:bg-neutral-500 hover:rounded" v-for="expense in Expenses" :key="expense.id">
                          <!-- dark:text-neutral-200 -->
                          <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-800" v-if="expense.item">{{ expense.item.name }}</td>
                          <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-800 ">{{ expense.quantity }}</td>
                          <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-800" v-if="expense.item">{{ expense.item.Price }}</td>
                          <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-800 ">{{ expense.amount }}</td>
                          <td class="px-6 py-4 whitespace-nowrap text-end text-sm font-medium">
                            <router-link to=""
                              class="inline-flex items-center gap-x-2 text-sm font-semibold rounded-lg border border-transparent pr-1 text-blue-600 hover:text-blue-800 focus:outline-none focus:text-blue-800 disabled:opacity-50 disabled:pointer-events-none dark:text-blue-500 dark:hover:text-blue-400 dark:focus:text-blue-400">Edit
                              |</router-link>
                            <router-link to=""
                              class="inline-flex items-center gap-x-2 text-sm font-semibold rounded-lg border border-transparent pr-1 text-blue-600 hover:text-blue-800 focus:outline-none focus:text-blue-800 disabled:opacity-50 disabled:pointer-events-none dark:text-blue-500 dark:hover:text-blue-400 dark:focus:text-blue-400">Details
                              |</router-link>
                            <button type="button"
                              class="inline-flex items-center gap-x-2 text-sm font-semibold rounded-lg border border-transparent text-blue-600 hover:text-blue-800 focus:outline-none focus:text-blue-800 disabled:opacity-50 disabled:pointer-events-none dark:text-blue-500 dark:hover:text-blue-400 dark:focus:text-blue-400">
                              Delete</button>
                          </td>
                        </tr>

                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
            <div class="px-5 py-5 bg-white border-t flex flex-col xs:flex-row items-center xs:justify-between ">
              <span class="text-xs xs:text-sm text-gray-900">
                Showing 1 to 4 of 50 Entries
              </span>
              <div class="inline-flex mt-2 xs:mt-0">
                <button
                  class="text-sm text-indigo-50 transition duration-150 hover:bg-indigo-500 bg-indigo-600 font-semibold py-2 px-4 rounded-l">
                  Prev
                </button>
                &nbsp; &nbsp;
                <button
                  class="text-sm text-indigo-50 transition duration-150 hover:bg-indigo-500 bg-indigo-600 font-semibold py-2 px-4 rounded-r">
                  Next
                </button>
              </div>
            </div>
          </div>
          <div class=" py-5" v-else>
            <p class="text-center text-lg font-semibold">No Expenses Found</p>
          </div>
        </div>
      </div>
    </div>
  </ContainerBg>

</template>

<script setup>
import ContainerBg from '../Components/ContainerBg.vue';
import apiClient from '../../Others/apiClient'
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import dayjs from 'dayjs';
import relativeTime from 'dayjs/plugin/relativeTime';

dayjs.extend(relativeTime);
const Budget = ref([]);
const id = useRoute().params.id;
const Expenses = ref([]);

const getBudget = async (id) => {
  try {
    const response = await apiClient.get(`Budgets/${id}`);
    Budget.value = response.data;

    console.log(Budget.value.income);
  } catch (error) {
    console.error("Error fetching Budget:", error);
  }
};


const getBudgetedExpenses = async (id) => {
  try {
    const response = await apiClient.get(`Expense/${id}`);
    Expenses.value = response.data;
    console.log(Expenses.value);
  } catch (error) {
    console.error("Error fetching Budget:", error);
  }
};

onMounted(() => {
  getBudget(id);
  getBudgetedExpenses(id);
});
</script>

<style lang="scss" scoped></style>
