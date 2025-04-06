<template>
  <main>
    <div class="grid grid-cols-4 gap-5">
      <DashMincard title="Balance" subtitle="Your Balance is "/>
      <DashMincard title="Monthly Income" subtitle="Your Monthly Income is "/>
      <DashMincard title="Nonthly Expenses" subtitle="Your Monthly Expenses are "/>
      <DashMincard title="Monthly Budget" subtitle="Your Monthly Budget is "/>
      <div class="h-24 col-span-2 bg-white border border-gray-300">
        <BarChart />
      </div>
      <div class="h-24 col-span-1 bg-white border border-gray-300">
        <FinanceChart
      type="bar"
      :data="expenseChartData"
      :options="chartOptions"
    />
      </div>
      <!-- <div class="h-24 col-span-1 bg-white border border-gray-300"></div>
      <div class="h-24 col-span-2 bg-white border border-gray-300"></div>
      <div class="h-24 col-span-3 bg-white border border-gray-300"></div>
      <div class="h-24 col-span-1 bg-white border border-gray-300"></div>
      <div class="h-24 col-span-1 bg-white border border-gray-300"></div>
      <div class="h-24 col-span-1 bg-white border border-gray-300"></div>
      <div class="h-24 col-span-2 bg-white border border-gray-300"></div>
      <div class="h-24 col-span-1 bg-white border border-gray-300"></div>
      <div class="h-24 col-span-1 bg-white border border-gray-300"></div>
      <div class="h-24 col-span-2 bg-white border border-gray-300"></div>
      <div class="h-24 col-span-3 bg-white border border-gray-300"></div>
      <div class="h-24 col-span-1 bg-white border border-gray-300"></div>
      <div class="h-24 col-span-1 bg-white border border-gray-300"></div>
      <div class="h-24 col-span-1 bg-white border border-gray-300"></div>
      <div class="h-24 col-span-2 bg-white border border-gray-300"></div>
      <div class="h-24 col-span-1 bg-white border border-gray-300"></div>
      <div class="h-24 col-span-1 bg-white border border-gray-300"></div>
      <div class="h-24 col-span-2 bg-white border border-gray-300"></div>
      <div class="h-24 col-span-3 bg-white border border-gray-300"></div> -->
    </div>
  </main>
</template>

<script setup>
import { ref } from 'vue';
import DashMincard from '../Components/DashMincard.vue';

const values = ref({
  balance: 0,
  monthlyIncome: 0,
  monthlyExpenses: 0,
  monthlyBudget: 0
})
// const darkMode = ref(false)

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

const chartOptions = ref({
  plugins: {
    title: {
      display: true,
      text: 'Monthly Expenses Breakdown'
    }
  }
})

</script>

<style></style>
