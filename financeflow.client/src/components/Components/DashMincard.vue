<template>
  <div class="h-24 col-span-1 bg-white border border-gray-300 rounded shadow-sm p-1.5">
    <div class="flex flex-row bg-white ">
      <div class="flex items-center justify-center flex-shrink-0 h-15 w-15 rounded-xl bg-blue-100 text-blue-500">
        <slot name="icon"></slot>
      </div>
      <div class="flex flex-col flex-grow ml-4 p-2 border-l border-gray-300">
        <div class="pl-2 text-sm text-gray-500">{{ title }}</div>
        <div class="pl-2 font-semibold text-md">{{ subtitle }}</div>
      </div>
    </div>
  </div>
</template>

<script setup>
  defineProps(['title', 'subtitle']);
</script>

<style lang="scss" scoped></style>
