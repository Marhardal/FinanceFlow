<template>
  <!-- component -->
  <div class="w-full p-8 bg-white rounded-md">
    <ListHeader Header="Transactions" SubHeader="Transactions List" />
    <!-- <button @click="Logout">Logout</button> -->
    <div>
      <div class="px-4 py-4 -mx-4 overflow-x-auto sm:-mx-8 sm:px-8">
        <div class="flex flex-col">
          <div class="-m-1.5 overflow-x-auto">
            <div class="p-1.5 min-w-full inline-block align-middle">
              <div class="overflow-hidden">
                <table class="min-w-full divide-y divide-gray-200 dark:divide-neutral-700">
                  <thead>
                    <tr>
                      <th scope="col"
                        class="px-6 py-3 text-xs font-medium text-gray-500 uppercase text-start dark:text-neutral-500">
                        Type</th>
                      <th scope="col"
                        class="px-6 py-3 text-xs font-medium text-gray-500 uppercase text-start dark:text-neutral-500">
                        Reference</th>
                      <th scope="col"
                        class="px-6 py-3 text-xs font-medium text-gray-500 uppercase text-start dark:text-neutral-500">
                        Debit</th>
                      <th scope="col"
                        class="px-6 py-3 text-xs font-medium text-gray-500 uppercase text-start dark:text-neutral-500">
                        Credit</th>
                      <th scope="col"
                        class="px-6 py-3 text-xs font-medium text-gray-500 uppercase text-start dark:text-neutral-500">
                        balance</th>
                      <th scope="col"
                        class="px-6 py-3 text-xs font-medium text-gray-500 uppercase text-start dark:text-neutral-500">
                        Date</th>
                      <th scope="col"
                        class="px-6 py-3 text-xs font-medium text-gray-500 uppercase text-end dark:text-neutral-500">
                        Action</th>
                    </tr>
                  </thead>
                  <tbody class="divide-y divide-gray-200 dark:divide-neutral-700" v-if="Transactions != null">
                    <tr class="hover:bg-gray-100 dark:hover:bg-neutral-500 hover:rounded hover:text-white text-gray-800" v-for="transition in paginatedTransaction"
                      :key="transition.id">
                      <!-- dark:text-neutral-200 -->
                      <td class="px-6 py-4 text-sm font-medium whitespace-nowrap" v-if="transition.type == 0">Incomes
                      </td>
                      <td class="px-6 py-4 text-sm text-gray-800 whitespace-nowrap" v-else-if="transition.type == 1">
                        Budgets</td>
                      <td class="px-6 py-4 text-sm text-gray-800 whitespace-nowrap" v-else-if="transition.type == 2">
                        Invested</td>
                      <td class="px-6 py-4 text-sm text-gray-800 whitespace-nowrap " v-if="transition.incomeName">{{
                        transition.incomeName }}</td>
                      <td class="px-6 py-4 text-sm text-gray-800 whitespace-nowrap " v-if="transition.budgetName">{{
                        transition.budgetName }}</td>
                      <td class="px-6 py-4 text-sm text-gray-800 whitespace-nowrap " v-if="transition.investmentName">{{
                        transition.investmentName }}</td>
                      <td class="px-6 py-4 text-sm text-gray-800 whitespace-nowrap " v-if="transition.debit">{{
                        transition.debit.toLocaleString('en-mw', {
                          minimumFractionDigits: 2, style: 'currency',
                        currency: 'MWK' }) }}</td>
                      <td class="px-6 py-4 text-sm text-gray-800 whitespace-nowrap " v-else></td>
                      <td class="px-6 py-4 text-sm text-gray-800 whitespace-nowrap " v-if="transition.credit">{{
                        transition.credit.toLocaleString('en-mw', {
                          minimumFractionDigits: 2, style: 'currency',
                        currency: 'MWK' }) }}</td>
                      <td class="px-6 py-4 text-sm text-gray-800 whitespace-nowrap " v-else></td>
                      <td class="px-6 py-4 text-sm text-gray-800 whitespace-nowrap " v-if="transition.balance != null">
                        {{ transition.balance.toLocaleString('en-mw', {
                          minimumFractionDigits: 2, style: 'currency',
                        currency: 'MWK' }) }}</td>
                      <td class="px-6 py-4 text-sm text-gray-800 whitespace-nowrap ">
                        <label :title="dayjs(transition.valuedate).format('YYYY-MM-DD')" class="">{{
                        dayjs(transition.valuedate).fromNow()
                        }}</label>
                      </td>

                      <td class="px-6 py-4 text-sm font-medium whitespace-nowrap text-end">
                        <!-- <router-link to=""
                          class="inline-flex items-center pr-1 text-sm font-semibold text-blue-600 border border-transparent rounded-lg gap-x-2 hover:text-blue-800 focus:outline-none focus:text-blue-800 disabled:opacity-50 disabled:pointer-events-none dark:text-blue-500 dark:hover:text-blue-400 dark:focus:text-blue-400">Edit
                          |</router-link> -->
                        <router-link
                          class="inline-flex items-center pr-1 text-sm font-semibold text-blue-600 border border-transparent rounded-lg gap-x-2 hover:text-blue-800 focus:outline-none focus:text-blue-800 disabled:opacity-50 disabled:pointer-events-none dark:text-blue-500 dark:hover:text-blue-400 dark:focus:text-blue-400"
                          :to="{ path: 'income/details/' + transition.incomeid }"
                          v-if="transition.incomeid != null">Details
                          |</router-link>

                        <router-link
                          class="inline-flex items-center pr-1 text-sm font-semibold text-blue-600 border border-transparent rounded-lg gap-x-2 hover:text-blue-800 focus:outline-none focus:text-blue-800 disabled:opacity-50 disabled:pointer-events-none dark:text-blue-500 dark:hover:text-blue-400 dark:focus:text-blue-400"
                          :to="{ path: 'Budget/details/' + transition.budgetid }"
                          v-if="transition.budgetid != null">Details
                          |</router-link>
                        <router-link
                          class="inline-flex items-center pr-1 text-sm font-semibold text-blue-600 border border-transparent rounded-lg gap-x-2 hover:text-blue-800 focus:outline-none focus:text-blue-800 disabled:opacity-50 disabled:pointer-events-none dark:text-blue-500 dark:hover:text-blue-400 dark:focus:text-blue-400"
                          :to="{ path: 'Investment/details/' + transition.investmentId }"
                          v-if="transition.investmentId != null">Details
                          |</router-link>
                        <button type="button" @click="deleteTransaction(transition.id)"
                          class="inline-flex items-center text-sm font-semibold text-blue-600 border border-transparent rounded-lg gap-x-2 hover:text-blue-800 focus:outline-none focus:text-blue-800 disabled:opacity-50 disabled:pointer-events-none dark:text-blue-500 dark:hover:text-blue-400 dark:focus:text-blue-400">
                          Delete</button>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
        <div class="flex flex-col items-center px-5 py-5 bg-white border-t xs:flex-row xs:justify-between ">
          <span class="text-xs text-gray-900 xs:text-sm">
            Showing {{ currentPage }} to {{ totalPages }} of {{ Transactions.length }} Transactions.
          </span>
          <div class="inline-flex mt-2 xs:mt-0">
            <button
              class="px-4 py-2 text-sm font-semibold transition duration-150 bg-indigo-600 rounded-l text-indigo-50 hover:bg-indigo-500" @click="prevPage" :disabled="currentPage == 1">
              Prev
            </button>
            &nbsp; &nbsp;
            <button
              class="px-4 py-2 text-sm font-semibold transition duration-150 bg-indigo-600 rounded-r text-indigo-50 hover:bg-indigo-500" @click="nextPage" :disabled="currentPage == totalPages">
              Next
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref, computed } from 'vue';
import ListHeader from '../Components/ListHeader.vue';
import apiClient from '../../Others/apiClient'
import dayjs from 'dayjs';
import relativeTime from 'dayjs/plugin/relativeTime';
import { useToast } from 'vue-toast-notification';
import { useRouter } from 'vue-router';

const $toast = useToast();
const router = useRouter();
const currentPage = ref(1);
const itemsPerPage = 10;

dayjs.extend(relativeTime);
const Transactions = ref([]);

const getTransactions = async () => {
  const response = await apiClient.get("transactions/");
  if (response) {
    Transactions.value = response.data;
    console.log(Transactions);
  }
}


const totalPages = computed(() =>
      Math.ceil(Transactions.value.length / itemsPerPage)
    );

    const paginatedTransaction = computed(() => {
      const start = (currentPage.value - 1) * itemsPerPage;
      return Transactions.value.slice(start, start + itemsPerPage);
    });

    const nextPage = () => {
      if (currentPage.value < totalPages.value) currentPage.value++;
    };

    const prevPage = () => {
      if (currentPage.value > 1) currentPage.value--;
    };

const deleteTransaction = async (id) => {
  try {
    const response = await apiClient.delete(`transactions/${id}`);
    if (response.status === 200) {
      getTransactions();
      $toast.success('Transaction Deleted Successfully!');
      router.push('/transactions');
      // router.replace('/transactions').then(() => window.location.reload())
    }
    console.log(response.status);
  } catch (error) {

    $toast.error('Error Deleting Income!');
    console.error("Error deleting Income:", error);
  }
}

onMounted(() => {
  getTransactions()
})
</script>

<style lang="scss" scoped></style>
