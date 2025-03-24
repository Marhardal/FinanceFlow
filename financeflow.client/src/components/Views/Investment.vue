<template>
  <!-- component -->
  <div class="bg-white p-8 rounded-md w-full">
    <ListHeader Header="Investment" SubHeader="Incomes List" Navigate="invest/create">
      <div class="flex bg-gray-50 items-center p-2 rounded-md outline-2 w-full">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400" viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd"
            d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z"
            clip-rule="evenodd" />
        </svg>
        <input class="bg-gray-50 ml-1 block outline-none flex-grow" type="text" name="" id=""
          placeholder="Search for items" v-model="search" @keyup="getSearchedIncomes()">
      </div>
    </ListHeader>
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
                        Name</th>
                      <th scope="col"
                        class="px-6 py-3 text-start text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">
                        Amount</th>
                      <th scope="col"
                        class="px-6 py-3 text-start text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">
                        Status</th>
                      <th scope="col"
                        class="px-6 py-3 text-start text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">
                        Category</th>
                      <th scope="col"
                        class="px-6 py-3 text-start text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">
                        Date</th>
                      <th scope="col"
                        class="px-6 py-3 text-end text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">
                        Action</th>
                    </tr>
                  </thead>
                  <tbody class="divide-y divide-gray-200 dark:divide-neutral-700">
                    <tr class="hover:bg-gray-100 dark:hover:bg-neutral-500 hover:rounded hover:text-white text-gray-800" v-for="Income in Incomes"
                      :key="Income.id">
                      <!-- dark:text-neutral-200 -->
                      <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                        {{ Income.name }}</td>
                      <td class="px-6 py-4 whitespace-nowrap text-sm">
                      {{ Income.amount.toLocaleString('en-mw', { minimumFractionDigits: 2, style: 'currency', currency: 'MWK' }) }}</td>
                      <td class="px-6 py-4 whitespace-nowrap text-sm">
                        <span v-if="Income.status.name == 'Approved'"
                          class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-300">
                          {{ Income.status.name }}
                        </span>
                        <span v-else-if="Income.status.name == 'Pending'"
                          class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-gray-300">
                          {{ Income.status.name }}
                        </span>
                        <span v-else-if="Income.status.name == 'Rejected'"
                          class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-red-400">
                          {{ Income.status.name }}
                        </span>
                      </td>
                      <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                        {{ Income.incomeCategory.name }}</td>
                      <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                        {{ dayjs(Income.date).fromNow() }}</td>
                      <td class="px-6 py-4 whitespace-nowrap text-end text-sm font-medium">
                        <router-link :to="{ path: 'income/edit/' + Income.id }"
                          class="inline-flex items-center gap-x-2 text-sm font-semibold rounded-lg border border-transparent pr-1 text-blue-600 hover:text-blue-800 focus:outline-none focus:text-blue-800 disabled:opacity-50 disabled:pointer-events-none dark:text-blue-500 dark:hover:text-blue-400 dark:focus:text-blue-400">Edit
                          |</router-link>
                        <router-link :to="{ path: 'income/details/'+ Income.id }"
                          class="inline-flex items-center gap-x-2 text-sm font-semibold rounded-lg border border-transparent pr-1 text-blue-600 hover:text-blue-800 focus:outline-none focus:text-blue-800 disabled:opacity-50 disabled:pointer-events-none dark:text-blue-500 dark:hover:text-blue-400 dark:focus:text-blue-400">Details
                          |</router-link>
                        <button type="button" @click="deleteIncome(Income.id)"
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
import ListHeader from '../Components/ListHeader.vue';
import apiClient from '../../Others/apiClient';
import { ref, onMounted } from 'vue';
import relativeTime from 'dayjs/plugin/relativeTime';
import { useToast } from 'vue-toast-notification';
import { useRouter } from 'vue-router';
import 'vue-toast-notification/dist/theme-sugar.css';
import dayjs from 'dayjs';

dayjs.extend(relativeTime);
const $toast = useToast();
const router = useRouter();

const search = ref('');
const Incomes = ref([]);

const getIncomes = async () => {
  try {
    const response = await apiClient.get('incomes')
    Incomes.value = response.data;
  } catch (error) {
    console.error("Error fetching Incomes:", error);
  }
};

const getSearchedIncomes = async () => {
  try {
    const response = await apiClient.get('incomes?search=' + search.value)
    Incomes.value = response.data;
  } catch (error) {
    console.error("Error fetching Incomes:", error);
  }
};

const deleteIncome = async (id) => {
  try {
    const response = await apiClient.delete('incomes/' + id);
    if (response.status === 200) {
      getIncomes();
      $toast.success('Income Deleted Successfully!');
      router.push('/incomes');
    }
    console.log(response.status);
  } catch (error) {

    $toast.error('Error Deleting Income!');
    console.error("Error deleting Income:", error);
  }
};

onMounted(() => {
  getIncomes();
});
</script>

<style lang="scss" scoped></style>
