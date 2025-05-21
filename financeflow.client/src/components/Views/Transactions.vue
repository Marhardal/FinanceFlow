<template>
  <!-- component -->
  <div class="bg-white p-8 rounded-md w-full">
    <ListHeader Header="Transactions" SubHeader="Transactions List" Navigate="" />
    <button @click="Logout">Logout</button>
    <div>
      <div class="-mx-4 sm:-mx-8 px-4 sm:px-8 py-4 overflow-x-auto">
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
                        Reference</th>
                      <th scope="col"
                        class="px-6 py-3 text-start text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">
                        Amount</th>
                      <th scope="col"
                        class="px-6 py-3 text-start text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">
                        Date</th>
                      <th scope="col"
                        class="px-6 py-3 text-end text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">
                        Action</th>
                    </tr>
                  </thead>
                  <tbody class="divide-y divide-gray-200 dark:divide-neutral-700" v-if="Transactions != null">
                    <tr class="px-6 py-4 whitespace-nowrap text-sm font-medium"
                      v-for="transition in Transactions" :key="transition.id">
                      <!-- dark:text-neutral-200 -->
                      <td class="px-6 py-4 whitespace-nowrap text-sm font-medium" v-if="transition.type == 0">Incomes
                      </td>
                      <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-800" v-else-if="transition.type == 1">
                        Budgets</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-800" v-else-if="transition.type == 2">
                          Invested</td>
                      <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-800 " v-if="transition.incomeName">{{
                        transition.incomeName }}</td>
                      <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-800 " v-if="transition.budgetName">{{
                        transition.budgetName }}</td>
                      <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-800 " v-if="transition.investmentName">{{
                        transition.investmentName }}</td>
                      <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-800 ">{{ transition.amount.toLocaleString('en-mw', { minimumFractionDigits: 2, style: 'currency', currency: 'MWK' }) }}</td>
                      <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-800 ">{{ dayjs(transition.date).fromNow()
                      }}</td>

                      <td class="px-6 py-4 whitespace-nowrap text-end text-sm font-medium">
                        <!-- <router-link to=""
                          class="inline-flex items-center gap-x-2 text-sm font-semibold rounded-lg border border-transparent pr-1 text-blue-600 hover:text-blue-800 focus:outline-none focus:text-blue-800 disabled:opacity-50 disabled:pointer-events-none dark:text-blue-500 dark:hover:text-blue-400 dark:focus:text-blue-400">Edit
                          |</router-link> -->
                        <router-link
                          class="inline-flex items-center gap-x-2 text-sm font-semibold rounded-lg border border-transparent pr-1 text-blue-600 hover:text-blue-800 focus:outline-none focus:text-blue-800 disabled:opacity-50 disabled:pointer-events-none dark:text-blue-500 dark:hover:text-blue-400 dark:focus:text-blue-400"
                          :to="{ path: 'income/details/'+transition.incomeid }" v-if="transition.incomeid != null">Details
                          |</router-link>

                          <router-link
                          class="inline-flex items-center gap-x-2 text-sm font-semibold rounded-lg border border-transparent pr-1 text-blue-600 hover:text-blue-800 focus:outline-none focus:text-blue-800 disabled:opacity-50 disabled:pointer-events-none dark:text-blue-500 dark:hover:text-blue-400 dark:focus:text-blue-400"
                          :to="{ path: 'Budget/details/'+transition.budgetid }" v-if="transition.budgetid != null">Details
                          |</router-link>
                          <router-link
                          class="inline-flex items-center gap-x-2 text-sm font-semibold rounded-lg border border-transparent pr-1 text-blue-600 hover:text-blue-800 focus:outline-none focus:text-blue-800 disabled:opacity-50 disabled:pointer-events-none dark:text-blue-500 dark:hover:text-blue-400 dark:focus:text-blue-400"
                          :to="{ path: 'Investment/details/'+transition.investmentId }" v-if="transition.investmentId != null">Details
                          |</router-link>
                        <button type="button" @click="deleteTransaction(transition.id)"
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

const $toast = useToast();
const router = useRouter();

const Logout = async () => {
    console.log("Logout");

    localStorage.removeItem('authUserID');
    localStorage.removeItem('authRefreshToken');
    localStorage.removeItem('authRole');
    localStorage.removeItem('authToken');

  // const success = await authuseStore.logout();
  // if (!success) {
  //   $toast.error("Error logging out. Please try again.");
  //   return;
  // }
  router.push({ path: '/login' })

  const authUserID = localStorage.getItem('authUserID');
  if (authUserID == null) {
    router.push({ path: '/login' })
  }
  // $toast.success("Logged in successfully.");
}


dayjs.extend(relativeTime);
const Transactions = ref([]);

const getTransactions = async () => {
  const response = await apiClient.get("transactions/");
  if (response) {
    Transactions.value = response.data;
    console.log(Transactions);
  }
}

const deleteTransaction = async (id) => {
  try {
  const response = await apiClient.delete(`transactions/${id}`);
  if (response.status === 200) {
      getTransactions();
      $toast.success('Income Deleted Successfully!');
      router.push('/incomes');
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
