<template>
  <div class="chart-container">
    <Line :data="chartData" :options="chartOptions" />
  </div>
</template>

<script setup>
import { ref } from 'vue';
import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  LineElement,
  PointElement,
  CategoryScale,
  LinearScale
} from 'chart.js'
import { Line } from 'vue-chartjs'

// Register ChartJS components
ChartJS.register(
  Title,
  Tooltip,
  Legend,
  LineElement,
  PointElement,  // Required for points on the line
  CategoryScale,
  LinearScale
)

const chartData = ref({
  labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
  datasets: [
    {
      label: 'Sales 2023',
      data: [65, 59, 80, 81, 56, 55, 40],
      borderColor: '#4bc0c0',
      backgroundColor: '#4bc0c0',
      tension: 0.1,  // Makes the line curved (0 = straight)
      fill: false
    },
    {
      label: 'Sales 2022',
      data: [28, 48, 40, 19, 86, 27, 90],
      borderColor: '#ff6384',
      backgroundColor: '#ff6384',
      tension: 0.1
    }
  ]
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
      text: 'Monthly Sales Data'
    }
  },
  scales: {
    y: {
      beginAtZero: true
    }
  }
})
</script>

<style>
.chart-container {
  height: 400px;
  width: 100%;
}
</style>
