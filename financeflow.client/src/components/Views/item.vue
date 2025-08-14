<template>
  <div class="bg-white p-8 rounded-md w-full">
    <ListHeader Header="Items" SubHeader="Item List" Navigate="item/create">
      <!-- <FormKit type="search" label="Search" placeholder="Search for items" v-model="search" @keyup="getSearchedItems()"/> -->

      <div class="flex bg-gray-50 items-center p-2 rounded-md outline-2 w-full">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400" viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd"
            d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z"
            clip-rule="evenodd" />
        </svg>
        <input class="bg-gray-50 ml-1 block outline-none flex-grow" type="text" name="" id="" placeholder="Search for items"
          v-model="search" @keyup="getSearchedItems()">
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
                    <tr class="hover:bg-gray-100 dark:hover:bg-neutral-500 hover:rounded hover:text-white text-gray-800" v-for="item in paginatedItems"
                      :key="item.id">
                      <!-- dark:text-neutral-200 -->
                      <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                        {{ item.name }}</td>
                      <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">{{ item.itemCategory.name }}</td>
                      <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">{{ item.measurement }}</td>
                      <td class="px-6 py-4 whitespace-nowrap text-end text-sm font-medium">
                        <router-link :to="{ path: 'item/edit/' + item.id }"
                          class="inline-flex items-center gap-x-2 text-sm font-semibold rounded-lg border border-transparent pr-1 text-blue-600 hover:text-blue-800 focus:outline-none focus:text-blue-800 disabled:opacity-50 disabled:pointer-events-none dark:text-blue-500 dark:hover:text-blue-400 dark:focus:text-blue-400">Edit
                          |</router-link>
                        <router-link :to="{ path: 'item/edit', params: { id: item.id } }"
                          class="inline-flex items-center gap-x-2 text-sm font-semibold rounded-lg border border-transparent pr-1 text-blue-600 hover:text-blue-800 focus:outline-none focus:text-blue-800 disabled:opacity-50 disabled:pointer-events-none dark:text-blue-500 dark:hover:text-blue-400 dark:focus:text-blue-400">Details
                          |</router-link>
                        <button @click="deleteItem(item.id)"
                          class="inline-flex items-center gap-x-2 text-sm font-semibold rounded-lg border border-transparent pr-1 text-blue-600 hover:text-blue-800 focus:outline-none focus:text-blue-800 disabled:opacity-50 disabled:pointer-events-none dark:text-blue-500 dark:hover:text-blue-400 dark:focus:text-blue-400">Delete
                          |</button>
                      </td>
                    </tr>

                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
        <PaginateVue :total-items="items.length" :items-per-page="5"
  :max-pages-shown="10"
  @click="onClickHandler" />
  <!-- Hide Breakpoint Buttons -->

<vue-awesome-paginate
  :total-items="50"
  v-model="currentPage"
  :items-per-page="5"
  :max-pages-shown="5"
  :show-breakpoint-buttons="false"
  @click="onClickHandler"
/>

<!-- Disable Breakpoint Buttons -->

        <div class="px-5 py-5 bg-white border-t flex flex-col xs:flex-row items-center xs:justify-between ">
          <span class="text-xs xs:text-sm text-gray-900">
            Showing {{ currentPage }} to {{ totalPages }} of {{ items.length }} Items
          </span>
          <div class="inline-flex mt-2 xs:mt-0">
            <button
              class="text-sm text-indigo-50 transition duration-150 hover:bg-indigo-500 bg-indigo-600 font-semibold py-2 px-4 rounded-l" @click="prevPage">
              Prev
            </button>
            &nbsp; &nbsp;
<button
              class="text-sm text-indigo-50 transition duration-150 hover:bg-indigo-500 bg-indigo-600 font-semibold py-2 px-4 rounded-l" @click="nextPage">
              Next
            </button>
            <!-- <RouterLink
              class="text-sm text-indigo-50 transition duration-150 hover:bg-indigo-500 bg-indigo-600 font-semibold py-2 px-4 rounded-r">
              <nuxt-link :to="{path: `/`, query: {page, previousPage} }">Next</nuxt-link>
            </RouterLink> -->
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import ListHeader from '../Components/ListHeader.vue';
import apiClient from '../../Others/apiClient'
import { ref, onMounted, computed } from 'vue';
import { useToast } from 'vue-toast-notification';
import { useRoute, useRouter } from 'vue-router';
import PaginateVue from '../PaginateVue.vue';

const items = ref([]);
const $toast = useToast();
const router = useRouter();
const currentPage = ref(1);
const itemsPerPage = 10;


const search = ref('');

const route = useRoute();

const totalPages = computed(() =>
      Math.ceil(items.value.length / itemsPerPage)
    );

    const paginatedItems = computed(() => {
      const start = (currentPage.value - 1) * itemsPerPage;
      return items.value.slice(start, start + itemsPerPage);
    });

    const nextPage = () => {
      if (currentPage.value < totalPages.value) currentPage.value++;
    };

    const prevPage = () => {
      if (currentPage.value > 1) currentPage.value--;
    };




const getItems = async () => {
  try {
    const response = await apiClient.get('Item');
    items.value = response.data;
    console.log(items); // Log the actual data, not the ref object
  } catch (error) {
    console.error("Error fetching items:", error);
  }
};


const getSearchedItems = async () => {
  try {
    const response = await apiClient.get('Item?search=' + search.value);
    items.value = response.data;
    console.log(items); // Log the actual data, not the ref object
  } catch (error) {
    console.error("Error fetching items:", error);
  }
};

const deleteItem = async (id) => {
  try {
    const response = await apiClient.delete(`Item/${id}`);
    if (response.status === 200) {
      $toast.success('Item deleted successfully!');
      router.push('/items');
    }
  } catch (error) {
    console.error("Error deleting item:", error);
  }
};

onMounted(() => {
  getItems(); // Ensure function is called properly
});
</script>

<style lang="scss" scoped></style>
