<template>
  <label :for="id" class="block text-sm font-medium mb-2 dark:text-neatral-500">{{ name }}</label>
<select :id="id" class="py-3 px-4 pe-9 block w-full border-gray-200 rounded-lg text-sm focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none dark:bg-gray-300 dark:border-neutral-700 dark:text-neutral-700 dark:placeholder-neutral-500 dark:focus:ring-neutral-600">
  <option selected :value="value">{{ display }}</option>
  <option>1</option>
  <option>2</option>
  <option>3</option>
</select>
</template>

<script setup>
  defineProps({
    options: {
      type: [],
      default: '',
    },
    display: {
      type: String,
      default: 'Select'
    },
    id: {
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
