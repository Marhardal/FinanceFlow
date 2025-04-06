<script setup>
import { ref } from 'vue';

  const expenseChartData = ref({
  labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May'],
  datasets: [
    {
      label: 'Expenses',
      data: [1200, 1900, 1500, 2000, 1800],
      backgroundColor: '#3b82f6',
      borderColor: '#2563eb',
      borderWidth: 1
    }
  ]
})
</script>

<template>
  <div class="flex flex-col items-center justify-center w-full h-full p-4">
    <div class="w-full h-full bg-white rounded-lg shadow-md">
      <BarChart :data="expenseChartData" />
      <!-- <BarChart :data="expenseChartData" :options="chartOptions" /> -->
    </div>
  </div>
</template>

