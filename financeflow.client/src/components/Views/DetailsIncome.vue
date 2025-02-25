<template>
  <ContainerBg>

  </ContainerBg>
</template>

<script setup>
import apiClient from '../../Others/apiClient';
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import ContainerBg from '../Components/ContainerBg.vue';

const income = ref({});
const id = useRoute().params.id;

const getIncome = async () => {
  try {
    const response = await apiClient.get('Incomes/' + id);
    income.value = response.data;
    console.log(income); // Log the actual data, not the ref object
  } catch (error) {
    console.error("Error fetching Income:", error);
  }
}

onMounted(() => {
  getIncome(id);
});

</script>

<style lang="scss" scoped>

</style>
