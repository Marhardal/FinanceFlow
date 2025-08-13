<template>
  <!-- component -->
  <div class="w-full p-8 bg-white rounded-md">
    <ListHeader Header="Investment" SubHeader="Investments List" Navigate="investment/Create">
      <div class="flex items-center w-full p-2 rounded-md bg-gray-50 outline-2">
        <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-gray-400" viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd"
            d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z"
            clip-rule="evenodd" />
        </svg>
        <input class="flex-grow block ml-1 outline-none bg-gray-50" type="text" name="" id=""
          placeholder="Search for Investments." v-model="search" @keyup="getSearchedInvestments()">
      </div>
    </ListHeader>
    <div>
      <div class="px-4 py-4 -mx-4 overflow-x-auto sm:-mx-8 sm:px-8">
        <div class="flex flex-col">
          <div class="-m-1.5 overflow-x-auto">
            <div class="p-1.5 min-w-full inline-block align-middle">
                  <DataTable :data="Investments" class="display">
        <thead>
            <tr>
                <th>A</th>
                <th>B</th>
            </tr>
        </thead>
    </DataTable>
              <div class="overflow-hidden">
              <!--   <table class="min-w-full divide-y divide-gray-200 dark:divide-neutral-700">
                  <thead>
                    <tr>
                      <th scope="col"
                        class="px-6 py-3 text-xs font-medium text-gray-500 uppercase text-start dark:text-neutral-500">
                        Name</th>
                      <th scope="col"
                        class="px-6 py-3 text-xs font-medium text-gray-500 uppercase text-start dark:text-neutral-500">
                        Amount</th>
                      <th scope="col"
                        class="px-6 py-3 text-xs font-medium text-gray-500 uppercase text-start dark:text-neutral-500">
                        Category</th>
                      <th scope="col"
                        class="px-6 py-3 text-xs font-medium text-gray-500 uppercase text-start dark:text-neutral-500">
                        Date</th>
                      <th scope="col"
                        class="px-6 py-3 text-xs font-medium text-gray-500 uppercase text-end dark:text-neutral-500">
                        Action</th>
                    </tr>
                  </thead>
                  <tbody class="divide-y divide-gray-200 dark:divide-neutral-700">
                    <tr class="text-gray-800 hover:bg-gray-100 dark:hover:bg-neutral-500 hover:rounded hover:text-white" v-for="Investment in Investments"
                      :key="Investment.id">
                      <td class="px-6 py-4 text-sm font-medium whitespace-nowrap">
                        {{ Investment.name }}</td>
                      <td class="px-6 py-4 text-sm font-medium whitespace-nowrap">
                      {{ Investment.currentAmount.toLocaleString('en-mw', { minimumFractionDigits: 2, style: 'currency', currency: 'MWK' }) }}</td>
                      <td class="px-6 py-4 text-sm font-medium whitespace-nowrap" v-if="Investment.investmentType">
                        {{ Investment.investmentType.name }}</td>
                      <td class="px-6 py-4 text-sm font-medium whitespace-nowrap">
                        {{ dayjs(Investment.createdOn).fromNow() }}</td>
                      <td class="px-6 py-4 text-sm font-medium whitespace-nowrap text-end">
                        <router-link :to="{ path: 'Investment/edit/' + Investment.id }"
                          class="inline-flex items-center pr-1 text-sm font-semibold text-blue-600 border border-transparent rounded-lg gap-x-2 hover:text-blue-800 focus:outline-none focus:text-blue-800 disabled:opacity-50 disabled:pointer-events-none dark:text-blue-500 dark:hover:text-blue-400 dark:focus:text-blue-400">Edit
                          |</router-link>
                        <router-link :to="{ path: 'Investment/details/'+ Investment.id }"
                          class="inline-flex items-center pr-1 text-sm font-semibold text-blue-600 border border-transparent rounded-lg gap-x-2 hover:text-blue-800 focus:outline-none focus:text-blue-800 disabled:opacity-50 disabled:pointer-events-none dark:text-blue-500 dark:hover:text-blue-400 dark:focus:text-blue-400">Details
                          |</router-link>
                        <button type="button" @click="deleteInvestment(Investment.id)"
                          class="inline-flex items-center text-sm font-semibold text-blue-600 border border-transparent rounded-lg gap-x-2 hover:text-blue-800 focus:outline-none focus:text-blue-800 disabled:opacity-50 disabled:pointer-events-none dark:text-blue-500 dark:hover:text-blue-400 dark:focus:text-blue-400">
                          Delete</button>
                      </td>
                    </tr>
                  </tbody>
                </table> -->
              </div>
            </div>
          </div>
        </div>
        <div class="flex flex-col items-center px-5 py-5 bg-white border-t xs:flex-row xs:justify-between ">
          <span class="text-xs text-gray-900 xs:text-sm">
            Showing 1 to 4 of 50 Entries
          </span>
          <div class="inline-flex mt-2 xs:mt-0">
            <button
              class="px-4 py-2 text-sm font-semibold transition duration-150 bg-indigo-600 rounded-l text-indigo-50 hover:bg-indigo-500">
              Prev
            </button>
            &nbsp; &nbsp;
            <button
              class="px-4 py-2 text-sm font-semibold transition duration-150 bg-indigo-600 rounded-r text-indigo-50 hover:bg-indigo-500">
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
import DataTable from 'datatables.net-vue3';
import DataTablesCore from 'datatables.net-dt';

DataTable.use(DataTablesCore);
dayjs.extend(relativeTime);
const $toast = useToast();
const router = useRouter();

const search = ref('');
const Investments = ref([]);

const getInvestments = async () => {
  try {
    const response = await apiClient.get('Investments')
    Investments.value = response.data;
    // console.log(Investments.value);
  } catch (error) {
    console.error("Error fetching Investments:", error);
  }
};

const getSearchedInvestments = async () => {
  try {
    const response = await apiClient.get('Investments?search=' + search.value)
    Investments.value = response.data;
  } catch (error) {
    console.error("Error fetching Investments:", error);
  }
};



const deleteInvestment = async (id) => {
  try {
    const response = await apiClient.delete('Investments/' + id);
    if (response.status === 200) {
      getInvestments();
      $toast.success('Investment Deleted Successfully!');
      router.push('/Investments');
    }
    console.log(response.status);
  } catch (error) {

    $toast.error('Error Deleting Investment!');
    console.error("Error deleting Investment:", error);
  }
};

onMounted(() => {
  getInvestments();
});
</script>

<style lang="scss" scoped></style>
