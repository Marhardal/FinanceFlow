<template>
<div class="mx-auto max-w-full">
  <div>
    <label :for="id" class="mb-1 block text-sm font-medium text-gray-700 after:ml-0.5 after:text-red-500 after:content-['*']">{{ name }}</label>
    <textarea :id="id" class="block w-full rounded-md border-red-300 shadow-sm focus:border-red-300 focus:ring focus:ring-red-200 focus:ring-opacity-50 disabled:cursor-not-allowed disabled:bg-gray-50 disabled:text-gray-500 p-2" rows="3" :placeholder="placeholder" :value="value"></textarea>
    <p class="mt-1 text-sm text-red-500">This is a error message.</p>
  </div>
</div>

</template>

<script setup>
    defineProps({
  value: {
    type: String,
    default: '',
  },
  id: {
    type: String,
    required: true
  },
  placeholder: {
    type: String,
    required: true
  },
  name: {
    type: String,
    required: true
  }
});
</script>

<style lang="scss" scoped>

</style>
