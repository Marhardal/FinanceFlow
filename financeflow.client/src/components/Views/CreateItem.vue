<template>
  <ContainerBg>
    <div class="mx-auto max-w-xl">
      <div class="text-start mb-8">
        <h2 class="text-3xl md:text-4xl font-bold mb-2">Create an Item</h2>
        <h2 class="text-2xl md:text-2xl text-neutral-600 font-semibold mb-2">Fill in all Fields.</h2>
      </div>
      <!-- <form action="" class="space-y-5"> -->
      <FormKit type="form" submit-label="Create" @submit="createItem" :submit-attrs="{
        inputClass: 'py-3 px-4 block w-full border-gray-500 rounded text-sm focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none bg-gray-300 dark:border-gray-500 dark:text-neutral-700 dark:placeholder-neutral-500 dark:focus:ring-neutral-600',
        wrapperClass: 'space-y-5',
        'data-theme': `dark`,
        ignore: false
      }">
        <FormKit label="Item Name" placeholder="Enter an Item Name." type="text" help="Enter an Item Name." value=""
          v-model="input.name" />
        <FormKit type="select" label="Select Item Category" :options="Categories" v-model="input.expenseCategoryId"
          help="Select an Item Category" />
        <FormKit label="Item Price" placeholder="Enter an Item Price." type="number" v-model="input.price"
          help="Enter an Item Name." value="" />
      </FormKit>
    </div>
  </ContainerBg>
</template>

<script setup>
import ContainerBg from '../Components/ContainerBg.vue';
import apiClient from '../../Others/apiClient'
import { ref, onMounted, reactive } from 'vue';
import { useToast } from 'vue-toast-notification';
import 'vue-toast-notification/dist/theme-sugar.css';
import { useRouter } from 'vue-router';

const Categories = ref([]);
const $toast = useToast();
const router = useRouter();


const getCategories = async () => {
  try {
    const response = await apiClient.get('ExpenseCategory')
    Categories.value = response.data.map((category) => ({
      value: category.id,
      label: category.name,
    }));
    console.log(Categories); // Log the actual data, not the ref object
  } catch (error) {
    console.error("Error fetching Categories:", error);
  }
};


const createItem = async () => {
  try {
    const response = await apiClient.post('Item', input);

    if (response.status === 201) {
      $toast.success('You did it!');
      router.push('/items');
    }
  } catch (error) {
    console.error("Error creating Item:", error);
  }
}
const input = reactive({
  name,
  price: 0,
  expenseCategoryId: '',
});




onMounted(() => {
  getCategories(); // Ensure function is called properly
});
</script>

<style lang="scss" scoped></style>
