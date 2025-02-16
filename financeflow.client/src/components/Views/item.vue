<template>
  <div class="bg-white p-8 rounded-md w-full">
    <ListHeader Header="Items" SubHeader="Item List" />
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
                        Category</th>
                      <th scope="col"
                        class="px-6 py-3 text-start text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">
                        Measurements</th>
                      <th scope="col"
                        class="px-6 py-3 text-end text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">
                        Action</th>
                    </tr>
                  </thead>
                  <tbody class="divide-y divide-gray-200 dark:divide-neutral-700">
                    <tr class="hover:bg-gray-100 dark:hover:bg-neutral-500 hover:rounded" v-for="item in items" :key="item.id">
                      <!-- dark:text-neutral-200 -->
                      <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-800 ">
                        {{ item.name }}</td>
                      <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-800">{{ item.expenseCategory.name }}</td>
                      <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-800 ">{{ item.price }}</td>
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
    </div>
  </div>
</template>

<script setup>
  import ListHeader from '../Components/ListHeader.vue';
  import axios from 'axios';
import { ref, onMounted } from 'vue';

const items = ref([]);

const getItems = async () => {
  try {
    const response = await axios.get("https://localhost:7001/api/Item", {
      headers: {
        Accept: 'application/json'
      }
    });
    items.value = response.data;
    console.log(items); // Log the actual data, not the ref object
  } catch (error) {
    console.error("Error fetching items:", error);
  }
};

onMounted(() => {
  getItems(); // Ensure function is called properly
});
</script>

<style lang="scss" scoped>

</style>
