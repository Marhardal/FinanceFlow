<template>
  <ContainerBg>
    <div class="mx-auto max-w-xl">
      <div class="text-start mb-8">
        <h2 class="text-3xl md:text-4xl font-bold mb-2">Update a Top-up</h2>
        <h2 class="text-2xl md:text-2xl text-neutral-600 font-semibold mb-2">Fill in all Fields.</h2>
      </div>
      <FormKit type="form" submit-label="Update" @submit="updateInvest" :submit-attrs="{
        inputClass: 'py-3 px-4 block w-full border-gray-500 rounded text-sm focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none bg-gray-300 dark:border-gray-500 dark:text-neutral-700 dark:placeholder-neutral-500 dark:focus:ring-neutral-600',
        wrapperClass: 'space-y-5',
        'data-theme': `dark`,
        ignore: false
      }">
      <FormKit type="select" label="Select Income" :options="Incomes" v-model="input.incomeID"
      validation="required" />
        <FormKit type="select" label="Select Top-Up Status." :options="status" validation="required" v-model="input.statusId" />
        <FormKit label="Amount" placeholder="Enter Top-up Amount." type="number" validation="required" v-model="input.amount" />
        <FormKit label="Date" placeholder="Enter Top-up Amount." type="date" validation="required" v-model="input.date" />
        <!-- <FormKit label="Description" placeholder="Enter Top-up description." type="textarea" validation="required" v-model="input.description" /> -->
      </FormKit>
    </div>

  </ContainerBg>

</template>

<script setup>
import ContainerBg from '../Components/ContainerBg.vue';
import apiClient from '../../Others/apiClient'
import { useRoute, useRouter } from 'vue-router';
import { onMounted, reactive, ref } from 'vue';
import { useToast } from 'vue-toast-notification';
import 'vue-toast-notification/dist/theme-sugar.css';

const id = useRoute().params.investId;
const investmentId = useRoute().params.investmentId;
const $toast = useToast();
const router = useRouter();
const status = ref([]);
const Incomes = ref([]);

const input = reactive({
  id: id,
  incomeID: '',
  statusId: '',
  date: '',
  amount: '',
  investmentId: investmentId
})

const getinvest = async (id) => {
  try {
    const response = await apiClient.get(`Invests/${id}/${investmentId}`);
    input.amount = response.data.amount;
    input.date = new Date(response.data.date).toISOString().slice(0, 10);
    input.statusId = response.data.statusID;
    input.incomeID = response.data.incomeID;
    console.log(input);
  } catch (error) {
    console.error("Error fetching Budget:", error);
  }
};


const updateInvest = async () => {
  console.log(input)
  try {
    const response = await apiClient.put('Invests/'+id, input);
    if (response.status === 201) {
      $toast.success('You Toped-up Investment Successfully!');
      router.push(`Budget/details/${id}`);
    }
  } catch (error) {
    console.error("Error creating Top-up:", error);
    $toast.error('Failed to update a Top-up!');
  }
}

const getIncomes = async () => {
  try {
    const response = await apiClient.get('Incomes')
    Incomes.value =[{ value: '', label: 'Select Income.'}, ...response.data.map((income) => ({
      value: income.id,
      label: income.name,
    }))]; // Log the actual data, not the ref object
  } catch (error) {
    console.error("Error fetching income:", error);
  }
};

const getStatuses = async () => {
  try {
    const response = await apiClient.get('/status');
    if (response.data) {
      status.value = response.data;
      status.value = [{value: '', label: 'Select a Top-Up Status' }, ...response.data.map((status) => ({
        value: status.id,
        label: status.name
      }))];
      console.log(response.data)
    }
  } catch (error) {
    console.error(error)
  }
}

onMounted(() => {
  getStatuses()
  getIncomes()
  getinvest(id)
})
</script>

<style lang="scss" scoped></style>
