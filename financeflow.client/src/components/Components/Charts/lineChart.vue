<template>
  <div class="chart-container">
    <Line
      v-if="!loading && chartData.labels.length"
      :data="chartData"
      :options="chartOptions"
    />
    <div v-else-if="loading" class="loading-message">
      Loading data...
    </div>
    <div v-else class="no-data-message">
      No transaction data available
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import axios from 'axios';
import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  LineElement,
  PointElement,
  CategoryScale,
  LinearScale
} from 'chart.js';
import { Line } from 'vue-chartjs';
import apiClient from '../../../Others/apiClient'

ChartJS.register(
  Title, Tooltip, Legend,
  LineElement, PointElement,
  CategoryScale, LinearScale
);

const chartData = ref({
  labels: [],
  datasets: []
});
const loading = ref(false);

const chartOptions = {
  responsive: true,
  maintainAspectRatio: false,
  plugins: {
    legend: {
      position: 'top',
    },
    tooltip: {
      callbacks: {
        label: (context) => {
          return `${context.dataset.label}: $${context.parsed.y.toLocaleString()}`;
        }
      }
    }
  },
  scales: {
    y: {
      beginAtZero: true,
      ticks: {
        callback: (value) => `$${value.toLocaleString()}`
      }
    }
  }
};

async function fetchData() {
  try {
    loading.value = true;
    const response = await apiClient.get('/Home/last12months');

    // Debug: Log the exact API response
    console.log('API Response:', response.data);

    // Transform the data to match Chart.js expected format
    chartData.value = {
      labels: response.data.labels, // Note lowercase 'labels'
      datasets: response.data.datasets.map(dataset => ({ // Note lowercase 'datasets'
        label: dataset.label,
        data: dataset.data,
        borderColor: dataset.borderColor,
        backgroundColor: dataset.backgroundColor,
        tension: 0.3,
        borderWidth: 2,
        pointRadius: (ctx) => ctx.raw > 0 ? 5 : 0, // Only show points for values > 0
        pointHoverRadius: 7,
        pointBackgroundColor: '#fff'
      }))
    };

    // Debug: Log the transformed data
    console.log('Chart Data:', chartData.value);

  } catch (error) {
    console.error('Error loading data:', error);
  } finally {
    loading.value = false;
  }
}

onMounted(fetchData);
</script>

<style>
.chart-container {
  height: 400px;
  width: 100%;
  position: relative;
}
.loading-message, .no-data-message {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
  color: #666;
}
</style>
