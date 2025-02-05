<template>

<div class="mx-auto max-w-xl">
  <form action="" class="space-y-5">
    <Inputbox id="amount" type="Number" placeholder="Price" name="Amount"/>
    <Inputbox id="quantity" type="Number" placeholder="Quantity" name="Quantity"/>
    <Textarea id="notes" placeholder="Notes" name="Notes"/>
    <!-- <div>
      <label for="example2" class="mb-1 block text-sm font-medium text-gray-700">Password</label>
      <input type="password" id="example2" class="block w-full rounded-md border-gray-300 shadow-sm focus:border-primary-400 focus:ring focus:ring-primary-200 focus:ring-opacity-50 disabled:cursor-not-allowed disabled:bg-gray-50 disabled:text-gray-500" placeholder="Password" />
    </div> -->
    <div class="flex items-center space-x-2">
      <input type="checkbox" id="example3" class="h-4 w-4 rounded border-gray-300 text-primary-600 shadow-sm focus:border-primary-300 focus:ring focus:ring-primary-200 focus:ring-opacity-50 focus:ring-offset-0 disabled:cursor-not-allowed disabled:text-gray-400" />
      <label for="example3" class="text-sm font-medium text-gray-700">Remember me</label>
    </div>
    <button type="button" class="rounded-lg border border-primary-500 bg-primary-500 px-5 py-2.5 text-center text-sm font-medium text-white shadow-sm transition-all hover:border-primary-700 hover:bg-primary-700 focus:ring focus:ring-primary-200 disabled:cursor-not-allowed disabled:border-primary-300 disabled:bg-primary-300">Submit</button>
  </form>
</div>

</template>

<script setup>
import Inputbox from '../Components/Forms/inputbox.vue';
import Textarea from '../Components/Forms/textarea.vue';


</script>

<style lang="scss" scoped>

</style>
