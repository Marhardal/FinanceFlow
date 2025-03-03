<template>
  <ContainerBg>
    <div class="mx-auto max-w-xl">
      <div class="text-start mb-8">
        <h2 class="text-3xl md:text-4xl font-bold mb-2">Update a Budget</h2>
        <h2 class="text-2xl md:text-2xl text-neutral-600 font-semibold mb-2">Fill in all Fields.</h2>
      </div>
      <!-- <form action="" class="space-y-5"> -->
      <FormKit type="form" submit-label="Update" @submit="updateBudget" :submit-attrs="{
        inputClass: 'py-3 px-4 block w-full border-gray-500 rounded text-sm focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none bg-gray-300 dark:border-gray-500 dark:text-neutral-700 dark:placeholder-neutral-500 dark:focus:ring-neutral-600',
        wrapperClass: 'space-y-5',
        'data-theme': `dark`,
        ignore: false
      }">
        <FormKit label="Name" placeholder="Enter a Budget Name." type="text" v-model="input.name"
          validation="required" />
        <FormKit type="select" label="Select Status" :options="Statuses" v-model="input.statusID"
          validation="required" />
        <FormKit type="select" label="Select Income" :options="Incomes" v-model="input.incomeID"
          validation="required" />
        <FormKit label="Amount" placeholder="Enter Budget Amount." type="number" v-model="input.amount"
          validation="required" />
          <FormKit label="Spent Amount" placeholder="Enter the Spent Amount on the Budget." type="number" v-model="input.spentAmount"
          validation="required" />
        <FormKit label="Date" placeholder="Enter Budget Date." type="date" v-model="input.remindon" validation="required" />
        <FormKit label="Notes" placeholder="Enter Budget Notes." type="textarea" v-model="input.description"
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
import { useRoute, useRouter } from 'vue-router';

const Statuses = ref([]);
const Incomes = ref([]);
const $toast = useToast();
const router = useRouter();
const id = useRoute().params.id;

const getBudget = async (id) => {
  try {
    const response = await apiClient.get(`Budgets/${id}`);
    input.name = response.data.name;
    input.amount = response.data.amount;
    input.spentAmount = response.data.spentAmount;
    input.remindon = new Date(response.data.remindon).toISOString().slice(0, 10);
    input.description = response.data.description;
    input.statusID = response.data.statusID;
    input.incomeID = response.data.incomeID;
    console.log(input);
  } catch (error) {
    console.error("Error fetching Budget:", error);
  }
};

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

const getIncomes = async () => {
  try {
    const response = await apiClient.get('Incomes')
    Incomes.value = response.data.map((income) => ({
      value: income.id,
      label: income.name,
    })); // Log the actual data, not the ref object
  } catch (error) {
    console.error("Error fetching income:", error);
  }
};

const updateBudget = async () => {
  try {
    const response = await apiClient.put('Budgets/'+id, input);

    if (response.status === 201) {
      $toast.success('You have successfully updated a Budget!');
      router.push('/Budgets');
    }
  } catch (error) {
    $toast.error('An error occurred. Please try again.');
    console.error("Error creating Item:", error);
    console.log(input);
  }
}
const input = reactive({
  id: id,
  name: '',
  statusID: '',
  incomeID: '',
  amount: '',
  spentAmount: '',
  remindon: '',
  description: '',
});

onMounted(() => {
  getStatus(); // Ensure function is called properly
  getIncomes(); // Ensure function is called properly
  if (id) {
    getBudget(id);
  }
});
</script>

<style lang="scss" scoped></style>
