<template>
  <div class="max-w-full">
    <label :for="props.id" class="block text-sm font-medium mb-2 dark:text-white">{{ props.name }}</label>
    <input :type="props.type" :name="props.name" :id="props.id" class="py-3 px-4 block w-full
   border-gray-200 rounded-lg text-sm focus:border-blue-500 focus:ring-blue-500
   disabled:opacity-50 disabled:pointer-events-none dark:bg-neutral-900 dark:border-neutral-700
    dark:text-neutral-400 dark:placeholder-neutral-500 dark:focus:ring-neutral-600"
      :placeholder="props.placeholder" :value="props.value" />
  </div>
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
