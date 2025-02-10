<template>
 <!-- dark:bg-neutral-500 dark:border-neutral-700
 dark:text-neutral-400 dark:placeholder-neutral-500 dark:focus:ring-neutral-600 -->
<div class="max-w-full">
    <label :for="props.id" class="block text-sm font-medium mb-2 dark:text-neutral-500">{{ props.name }}</label>
    <input :type="props.type" :name="props.name" :id="props.id" class="py-3 px-4 block w-full
   border-gray-500 rounded text-sm focus:border-blue-500 focus:ring-blue-500
   disabled:opacity-50 disabled:pointer-events-none bg-gray-300 dark:border-gray-500
    dark:text-neutral-700 dark:placeholder-neutral-500 dark:focus:ring-neutral-600"
      :placeholder="props.placeholder" :value="props.value" />
  </div>

<!--
  <div class="mx-auto max-w-full">
  <div>
    <label :for="props.id" class="mb-1 block text-sm font-medium text-gray-700 after:ml-0.5 after:text-red-500 after:content-['*']">{{ props.name }}</label>
    <input :type="props.type" :name="props.name" :id="props.id" class="block w-full rounded-md border-red-300 shadow-sm focus:border-red-300 focus:ring focus:ring-red-200 focus:ring-opacity-50 disabled:cursor-not-allowed disabled:bg-gray-50 disabled:text-gray-500" :placeholder="props.placeholder" :value="props.value" />
    <p class="mt-1 text-sm text-red-500">This is a error message.</p>
  </div>
</div> -->

</template>

<script setup>
const props = defineProps({
  value: {
    type: String,
    default: '',
  },
  type: {
    type: String,
    default: 'text',
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

<style lang="scss" scoped></style>
