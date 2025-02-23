<template>
  <ContainerBg>
    <div class="mx-auto max-w-xl">
      <div class="text-start mb-8">
        <h2 class="text-3xl md:text-4xl font-bold mb-2">Create an Income</h2>
        <h2 class="text-2xl md:text-2xl text-neutral-600 font-semibold mb-2">Fill in all Fields.</h2>
      </div>
      <!-- <form action="" class="space-y-5"> -->
      <FormKit type="form" submit-label="Create" @submit="createIncome" :submit-attrs="{
        inputClass: 'py-3 px-4 block w-full border-gray-500 rounded text-sm focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none bg-gray-300 dark:border-gray-500 dark:text-neutral-700 dark:placeholder-neutral-500 dark:focus:ring-neutral-600',
        wrapperClass: 'space-y-5',
        'data-theme': `dark`,
        ignore: false
      }">
        <FormKit label="Name" placeholder="Enter an Income Name." type="text" v-model="input.name"
          validation="required" />
        <FormKit type="select" label="Select Status" :options="Statuses" v-model="input.statusid"
          validation="required" />
        <FormKit type="select" label="Select Income Source" :options="IncomeCategories" v-model="input.incomeCategoryId"
          validation="required" />
        <FormKit label="Amount" placeholder="Enter Amount." type="number" v-model="input.amount"
          validation="required" />
        <FormKit label="Date" placeholder="Enter Amount." type="date" v-model="input.date" validation="required" />
        <FormKit label="Notes" placeholder="Enter Income Notes." type="textarea" v-model="input.description"
          validation="required" />
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

const Statuses = ref([]);
const IncomeCategories = ref([]);
const $toast = useToast();
const router = useRouter();


const getStatus = async () => {
  try {
    const response = await apiClient.get('status')
    Statuses.value = response.data.map((status) => ({
      value: status.id,
      label: status.name,
    })); // Log the actual data, not the ref object
  } catch (error) {
    console.error("Error fetching Statuses:", error);
  }
};

const getIncomeCategories = async () => {
  try {
    const response = await apiClient.get('IncomeCategory')
    IncomeCategories.value = response.data.map((category) => ({
      value: category.id,
      label: category.name,
    })); // Log the actual data, not the ref object
  } catch (error) {
    console.error("Error fetching category:", error);
  }
};


const createIncome = async () => {
  try {
    const response = await apiClient.post('Incomes', input);

    if (response.status === 201) {
      $toast.success('You have successfully added an Income!');
      router.push('/incomes');
    }
  } catch (error) {
    $toast.error('An error occurred. Please try again.');
    console.error("Error creating Item:", error);
    console.log(input);
  }
}
const input = reactive({
  name: '',
  statusid: '',
  incomeCategoryId: '',
  amount: '',
  date: '',
  description: '',
});

onMounted(() => {
  getStatus(); // Ensure function is called properly
  getIncomeCategories(); // Ensure function is called properly
});
</script>

<style lang="scss" scoped></style>
