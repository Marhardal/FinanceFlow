<template>
  <div class="grid grid-cols-12 gap-2 items-center justify-between pb-6">
    <div class="col-span-6">
      <h2 class="text-gray-600 font-semibold">{{ props.Header }}</h2>
      <span class="text-xs">{{ props.SubHeader }}</span>
    </div>
    <div class="col-span-6 flex justify-end">

      <div class="grid grid-cols-6 gap-2">
      <div class="col-span-5">
        <slot></slot>
      </div>
      <div class="col-span-1 space-x-8 py-2" v-if="props.Navigate">
        <router-link class="bg-indigo-600 px-4 py-2 my-4 rounded-md text-white font-semibold tracking-wide cursor-pointer" :to="props.Navigate">Create</router-link>
      </div>
    </div>
      </div>
  </div>
</template>

<script setup>
  const props = defineProps({
    Header: {
      type: String
    },
    SubHeader : {
      type: String,
      required: true
    },
    Navigate : {
      type: String,
      required: true
    }
  })
</script>

<style lang="scss" scoped></style>
