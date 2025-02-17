<template>
  <ContainerBg>
    <div class="mx-auto max-w-xl">
      <div class="text-start mb-8">
        <h2 class="text-3xl md:text-4xl font-bold mb-2">Create an Item</h2>
        <h2 class="text-2xl md:text-2xl text-neutral-600 font-semibold mb-2">Fill in all Fields.</h2>
      </div>
      <form action="" class="space-y-5">
        <Inputbox id="name" placeholder="Enter Item Name" name="Name" />
        <Select :options="Categories" id="Category" name="Category" display="Select an Item Category" />
        <Inputbox id="price" type="Number" placeholder="Enter Item Price" name="Price" />
        <Inputbox id="measurement" type="Number" placeholder="Enter Item measurement" name="Measurement" />
        <Button name="Create" />
      </form>
    </div>

  </ContainerBg>


</template>

<script setup>
import Inputbox from '../Components/Forms/inputbox.vue';
import Button from '../Components/Forms/Button.vue';
import Select from '../Components/Forms/Select.vue';
import ContainerBg from '../Components/ContainerBg.vue';

import apiClient from '../../Others/apiClient'
import { ref, onMounted } from 'vue';

const Categories = ref([]);

const getCategories = async () => {
  try {
    const response = await apiClient.get('ExpenseCategory')
    Categories.value = response.data;
    console.log(Categories); // Log the actual data, not the ref object
  } catch (error) {
    console.error("Error fetching Categories:", error);
  }
};

onMounted(() => {
  getCategories(); // Ensure function is called properly
});
</script>

<style lang="scss" scoped></style>
