<template>

  <ContainerBg>
    <div v-if="Budget">
      <div class="border-b border-gray-200 p-5 rounded-lg">
        <h2 class="text-3xl md:text-4xl font-bold mb-2">{{ Budget.name }} Details</h2>
      </div>
      <div class="border-b border-gray-200 p-5 rounded-lg">
        <div class="grid grid-cols-4 gap-4">
          <div class="col-span-1">
            <h3 class="text-lg font-semibold mb-3">Budget Name</h3>
          </div>
          <div class="col-span-3">
            <p class="text-md">{{ Budget.name }}</p>
          </div>
          <div class="col-span-1">
            <h3 class="text-lg font-semibold mb-3">Budgeted Amount</h3>
          </div>
          <div class="col-span-3">
            <p class="text-md">{{ Budget.amount }}</p>
          </div>
          <div class="col-span-1">
            <h3 class="text-lg font-semibold mb-3">Budgeted Income</h3>
          </div>
          <div class="col-span-3">
            <p class="text-md">{{ Budget.income.name + "->" + Budget.income.amount }}</p>
          </div>
          <div class="col-span-1">
            <h3 class="text-lg font-semibold mb-3">Budgeted Status</h3>
          </div>
          <div class="col-span-3">
            <p class="text-md">{{ Budget.status.name }}</p>
          </div>
          <div class="col-span-1">
            <h3 class="text-lg font-semibold mb-3">Spent Amount</h3>
          </div>
          <div class="col-span-3">
            <p class="text-md">{{ Budget.spentAmount }}</p>
          </div>
          <div class="col-span-1">
            <h3 class="text-lg font-semibold">Remind on</h3>
          </div>
          <div class="col-span-3">
            <h3 class="text-md">{{ dayjs(Budget.remindon).fromNow() }}</h3>
          </div>
          <div class="col-span-1">
            <h3 class="text-lg font-semibold">Notes</h3>
          </div>
          <div class="col-span-3">
            <h3 class="text-md">{{ Budget.description }}</h3>
          </div>
        </div>
      </div>
    </div>
  </ContainerBg>

</template>

<script setup>
import ContainerBg from '../Components/ContainerBg.vue';
import apiClient from '../../Others/apiClient'
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import dayjs from 'dayjs';
import relativeTime from 'dayjs/plugin/relativeTime';

dayjs.extend(relativeTime);
const Budget = ref([]);
const id = useRoute().params.id;

const getBudget = async (id) => {
  try {
    const response = await apiClient.get(`Budgets/${id}`);
    Budget.value = response.data;
  } catch (error) {
    console.error("Error fetching Budget:", error);
  }
};

onMounted(() => {
  getBudget(id);
});
</script>

<style lang="scss" scoped></style>
