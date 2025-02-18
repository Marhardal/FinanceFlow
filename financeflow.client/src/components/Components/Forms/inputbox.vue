<template>
 <!-- dark:bg-neutral-500 dark:border-neutral-700
 dark:text-neutral-400 dark:placeholder-neutral-500 dark:focus:ring-neutral-600 -->
<div class="max-w-full">
    <label :for="id" class="block text-sm font-medium mb-2 dark:text-neutral-500">{{ name }}</label>
    <input :type="type" :name="name" :id="id" class="py-3 px-4 block w-full
   border-gray-500 rounded text-sm focus:border-blue-500 focus:ring-blue-500
   disabled:opacity-50 disabled:pointer-events-none bg-gray-300 dark:border-gray-500
    dark:text-neutral-700 dark:placeholder-neutral-500 dark:focus:ring-neutral-600"
      :placeholder="placeholder" :value="modelvalue" @input="handleInput"/>
  </div>
</template>

<script setup>
defineProps({
  modelvalue:{
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

const emit = defineEmits(['update:modelValue']);

// Function to handle input changes
function handleInput(event) {
  emit('update:modelValue', event.target.value);
}
</script>

<style lang="scss" scoped></style>
