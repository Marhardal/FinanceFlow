<template>
  <!-- component -->
  <div class="bg-white p-2 rounded-md w-full">
    <div class="grid grid-cols-12 gap-2 items-center justify-between">
      <div class="col-span-6">
        <h2 class="text-gray-600 font-semibold">Recent Transactions</h2>
      </div>
      <div class="col-span-6 flex justify-end">
        <router-link
          class="bg-indigo-600 px-4 py-2 my-4 rounded-md text-white font-semibold tracking-wide cursor-pointer"
          :to="transactions">Transactions</router-link>
      </div>
    </div>
  </div>
  <div>
    <div class="-mx-4 sm:-mx-8 px-4 sm:px-8 overflow-x-auto">
      <div class="flex flex-col">
        <div class="-m-1.5 overflow-x-auto">
          <div class="p-1.5 min-w-full inline-block align-middle">
            <div class="overflow-hidden">
              <table class="min-w-full divide-y divide-gray-200 dark:divide-neutral-700">
                <thead>
                  <tr>
                    <th scope="col"
                      class="px-6 py-3 text-start text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">
                      Type</th>
                    <th scope="col"
                      class="px-6 py-3 text-start text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">
                      Amount</th>
                    <th scope="col"
                      class="px-6 py-3 text-start text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">
                      Date</th>
                  </tr>
                </thead>
                <tbody class="divide-y divide-gray-200 dark:divide-neutral-700" v-if="Transactions != null">
                  <tr class="px-6 py-4 whitespace-nowrap text-sm font-medium" v-for="transition in Transactions"
                    :key="transition.id">
                    <!-- dark:text-neutral-200 -->
                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium" v-if="transition.type == 0">Incomes
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-800" v-else-if="transition.type == 1">
                      Budgets</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-800" v-else-if="transition.type == 2">
                      Invested</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-800 ">{{
                      transition.amount.toLocaleString('en-mw', {
                        minimumFractionDigits: 2, style: 'currency',
                        currency: 'MWK'
                      }) }}</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-800 ">{{ dayjs(transition.date).fromNow()
                    }}</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue';
import ListHeader from '../Components/ListHeader.vue';
import apiClient from '../../Others/apiClient'
import dayjs from 'dayjs';
import relativeTime from 'dayjs/plugin/relativeTime';
import { useToast } from 'vue-toast-notification';
import { useRouter } from 'vue-router';

const router = useRouter();

dayjs.extend(relativeTime);
const Transactions = ref([]);

const getTransactions = async () => {
  const response = await apiClient.get("Home/GetRecentTransactions");
  if (response) {
    Transactions.value = response.data;
    console.log(Transactions);
  }
}

onMounted(() => {
  getTransactions()
})
</script>

<style lang="scss" scoped></style>
