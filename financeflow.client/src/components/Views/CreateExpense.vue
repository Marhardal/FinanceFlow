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
