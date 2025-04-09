<template>
  <Pie :data="chartData" :options="chartOptions" />
</template>

<script setup>
import { ref } from 'vue';
import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  ArcElement
} from 'chart.js'
import { Pie } from 'vue-chartjs'

// Register ChartJS components - NOTE DIFFERENT ELEMENTS FOR PIE CHART
ChartJS.register(
  Title,
  Tooltip,
  Legend,
  ArcElement // This is specific to Pie charts
)

const chartData = ref({
  labels: ['January', 'February', 'March'],
  datasets: [{
    data: [40, 20, 12],
    backgroundColor: [
      '#FF6384',
      '#36A2EB',
      '#FFCE56'
    ],
    hoverBackgroundColor: [
      '#FF6384',
      '#36A2EB',
      '#FFCE56'
    ]
  }]
})

const chartOptions = ref({
  responsive: true,
  maintainAspectRatio: false,
  plugins: {
    legend: {
      position: 'top'
    },
    title: {
      display: true,
      text: 'Monthly Data'
    }
  }
})
</script>
