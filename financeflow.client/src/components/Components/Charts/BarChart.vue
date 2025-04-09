<template>
  <Bar :data="chartData" :options="chartOptions" />
</template>

<script setup>
import { ref } from 'vue';
import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  BarElement,
  CategoryScale,
  LinearScale
} from 'chart.js'
import { Bar } from 'vue-chartjs'

// Register ChartJS components
ChartJS.register(
  CategoryScale,
  LinearScale,
  BarElement,
  Title,
  Tooltip,
  Legend
)

// Chart data and options using ref
const chartData = ref({
  labels: ['January', 'February', 'March'],
  datasets: [{
    data: [40, 20, 12],
    backgroundColor: [
      'rgba(75, 192, 192, 0.2)',
      'rgba(54, 162, 235, 0.2)',
      'rgba(255, 99, 132, 0.2)'
    ],
    borderColor: [
      'rgba(75, 192, 192, 1)',
      'rgba(54, 162, 235, 1)',
      'rgba(255, 99, 132, 1)'
    ],
    borderWidth: 1
  }]
})

const chartOptions = ref({
  responsive: true,
  plugins: {
    legend: {
      display: false // Hide legend if you don't need it
    },
    title: {
      display: true,
      text: 'Monthly Data'
    }
  },
  scales: {
    y: {
      beginAtZero: true
    }
  }
})
</script>
