<template>
  <ContainerBg>
    <div class="mx-auto max-w-xl">
      <div class="text-start mb-8">
        <h2 class="text-3xl md:text-4xl font-bold mb-2">Create an Expense</h2>
        <h2 class="text-2xl md:text-2xl text-neutral-600 font-semibold mb-2">Fill in all Fields.</h2>
      </div>
      <FormKit type="form" submit-label="Create" @submit="createExpense" :submit-attrs="{
        inputClass: 'py-3 px-4 block w-full border-gray-500 rounded text-sm focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none bg-gray-300 dark:border-gray-500 dark:text-neutral-700 dark:placeholder-neutral-500 dark:focus:ring-neutral-600',
        wrapperClass: 'space-y-5',
        'data-theme': `dark`,
        ignore: false
      }">
        <FormKit type="select" label="Select an Item Name." searchable :options="items" validation="required" v-model="input.itemID" />
        <FormKit label="Quantity" placeholder="Enter Item Quantity." type="number" validation="required" v-model="input.quantity" />
        <FormKit label="Expected Amount" placeholder="Enter the Expected Amount." type="number" v-model="input.Expectedamount" />
        <FormKit label="Amount" placeholder="Enter Item Amount." type="number" validation="required" v-model="input.amount" />
        <FormKit label="Description" placeholder="Enter Item description." type="textarea" validation="required" v-model="input.description" />
      </FormKit><router-link class="text-blue-500 hover:text-blue-700" :to="{ path: '/Budget/details/' + id }">
  Back to Budget Details
</router-link>

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

const id = useRoute().params.id;
const $toast = useToast();
const router = useRouter();
const items = ref([]);

const input = reactive({
  budgetID: id,
  itemID: '',
  quantity: '',
  amount: '',
  description: '',
  Expectedamount: ''
})

const createExpense = async () => {
  try {
    if (input.Expectedamount == '') {
      input.Expectedamount = input.amount;
    }
    const response = await apiClient.post('Expense', input);
    if (response.status === 201) {
      $toast.success('You Created an Expense Sucessfully!');
      router.push(`Budget/details/`+ id);
    }
  } catch (error) {
    console.error("Error creating Item:", error);
    $toast.error('Failed to create an Expense!');
  }
}

const getItems = async () => {
  try {
    const response = await apiClient.get('/item');
    if (response.data) {
      items.value = response.data;
      items.value = [{value: '', label: 'Select Item Name' }, ...response.data.map((item) => ({
        value: item.id,
        label: item.name
      }))];
      console.log(response.data)
    }
  } catch (error) {
    console.error(error)
  }
}

onMounted(() => {
  getItems()
})
</script>

<style lang="scss" scoped></style>
