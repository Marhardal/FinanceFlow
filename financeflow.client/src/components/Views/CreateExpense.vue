<template>

  <ContainerBg>
    <div class="mx-auto max-w-xl">
      <div class="text-start mb-8">
        <h2 class="text-3xl md:text-4xl font-bold mb-2">Create an Expense</h2>
        <h2 class="text-2xl md:text-2xl text-neutral-600 font-semibold mb-2">Fill in all Fields.</h2>
      </div>
      <form action="" class="space-y-5">
        <Select id="Category" name="Category" />
        <Inputbox id="amount" type="Number" placeholder="Price" name="Amount" />
        <Inputbox id="quantity" type="Number" placeholder="Quantity" name="Quantity" />
        <Textarea id="notes" placeholder="Notes" name="Notes" />
        <!-- <div>
      <label for="example2" class="mb-1 block text-sm font-medium text-gray-700">Password</label>
      <input type="password" id="example2" class="block w-full rounded-md border-gray-300 shadow-sm focus:border-primary-400 focus:ring focus:ring-primary-200 focus:ring-opacity-50 disabled:cursor-not-allowed disabled:bg-gray-50 disabled:text-gray-500" placeholder="Password" />
    </div> -->
        <!-- <div class="flex items-center space-x-2">
          <input type="checkbox" id="example3"
            class="h-4 w-4 rounded border-gray-300 text-primary-600 shadow-sm focus:border-primary-300 focus:ring focus:ring-primary-200 focus:ring-opacity-50 focus:ring-offset-0 disabled:cursor-not-allowed disabled:text-gray-400" />
          <label for="example3" class="text-sm font-medium text-gray-700">Remember me</label>
        </div> -->
        <Button name="Create" />
      </form>
    </div>

  </ContainerBg>


</template>

<script setup>
import Inputbox from '../Components/Forms/inputbox.vue';
import Textarea from '../Components/Forms/Textarea.vue';
import Button from '../Components/Forms/Button.vue';
import Select from '../Components/Forms/Select.vue';
import ContainerBg from '../Components/ContainerBg.vue';
</script>

<style lang="scss" scoped></style>
