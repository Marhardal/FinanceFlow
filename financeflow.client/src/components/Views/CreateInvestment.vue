<template>
  <ContainerBg>
    <div class="mx-auto max-w-xl">
      <div class="text-start mb-8">
        <h2 class="text-3xl md:text-4xl font-bold mb-2">Create an Investment</h2>
        <h2 class="text-2xl md:text-2xl text-neutral-600 font-semibold mb-2">Fill in all Fields.</h2>
      </div>
      <FormKit type="form" submit-label="Create" @submit="createInvestment" :submit-attrs="{
        inputClass: 'py-3 px-4 block w-full border-gray-500 rounded text-sm focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none bg-gray-300 dark:border-gray-500 dark:text-neutral-700 dark:placeholder-neutral-500 dark:focus:ring-neutral-600',
        wrapperClass: 'space-y-5',
        'data-theme': `dark`,
        ignore: false
      }">
        <FormKit label="Name" placeholder="Enter a Investment Name." type="text" v-model="input.name"
          validation="required" />
        <FormKit type="select" label="Select Investment Type." :options="InvestmentTypes" v-model="input.investTypeID"
          validation="required" />
        <FormKit label="Amount" placeholder="Enter Investment Amount." type="number" v-model="input.currentAmount"
          validation="required" />
        <FormKit label="Company" placeholder="Enter Investment Company." type="text" v-model="input.company"
          validation="required" />
        <FormKit label="Reference" placeholder="Enter Investment Reference." type="text" v-model="input.Reference"
          validation="required" />
          <FormKit
  label="Percentage"
  placeholder="Enter Investment Percentage (e.g., 15 or 17-20)"
  type="text"
  v-model="input.percentage"
  validation="required|regex:/^\\d{1,3}(-\\d{1,3})?$/"
  validation-messages="{ regex: 'Enter a valid percentage (e.g., 15 or 17-20).' }"
  help="Enter a single number (e.g., 15) or a range (e.g., 17-20)."
/>
        <FormKit label="Date" placeholder="Enter Investment Date." type="number" min="1" max="31" v-model="input.date" validation="required" />
        <FormKit label="Notes" placeholder="Enter Investment Notes." type="textarea" v-model="input.description"
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
const InvestmentTypes = ref([]);
const $toast = useToast();
const router = useRouter();

const getStatus = async () => {
  try {
    const response = await apiClient.get('status')
    Statuses.value = [{ value: '', label: 'Select Status.' }, ...response.data.map((status) => ({
      value: status.id,
      label: status.name,
    }))]; // Log the actual data, not the ref object
  } catch (error) {
    console.error("Error fetching Statuses:", error);
  }
};

const getInvestmentTypes = async () => {
  try {
    const response = await apiClient.get('InvestmentTypes')
    InvestmentTypes.value =[{ value: '', label: 'Select Investment Type.'}, ...response.data.map((invest) => ({
      value: invest.id,
      label: invest.name,
    }))]; // Log the actual data, not the ref object
  } catch (error) {
    console.error("Error fetching Investment Types:", error);
  }
};

const createInvestment = async () => {
  try {
    const response = await apiClient.post('Investments', input);

    if (response.status === 201) {
      $toast.success('You have successfully added a Investment!');
      router.push('/Investment');
    }
  } catch (error) {
    $toast.error('An error occurred. Please try again.');
    console.error("Error creating Item:", error);
    console.log(input);
  }
}

const userID = localStorage.getItem("authUserID");

const input = reactive({
  name: '',
  company: '',
  Reference: '',
  investTypeID: '',
  amount: '',
  description: '',
  userId: userID,
  currentAmount: 0,
  percentage: '',
  date: '',
});

onMounted(() => {
  getStatus(); // Ensure function is called properly
  getInvestmentTypes(); // Ensure function is called properly
});
</script>

<style lang="scss" scoped></style>
