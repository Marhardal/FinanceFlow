<template>
  <div class="budget-categories-container">
    <div class="chart-wrapper">
      <Pie
        v-if="hasData"
        :data="chartData"
        :options="chartOptions"
      />
      <div v-else class="no-data-message">
        No budget data available
      </div>
    </div>

    <div class="data-table" v-if="hasData">
      <table>
        <thead>
          <tr>
            <th>Category</th>
            <th>Amount</th>
            <th>Transactions</th>
            <th>Frequency</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(item, index) in tableData" :key="index">
            <td>
              <span class="color-indicator"
                    :style="{ backgroundColor: getColor(index, item.inChart) }"></span>
              {{ item.label }}
            </td>
            <td>${{ item.amount.toLocaleString() }}</td>
            <td>{{ item.transactions }}</td>
            <td>{{ item.percentage }}%</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import { Pie } from 'vue-chartjs';
import { Chart as ChartJS, ArcElement, Tooltip, Legend } from 'chart.js';
import apiClient from '../../../Others/apiClient';

ChartJS.register(ArcElement, Tooltip, Legend);

// Chart data
const chartData = ref({
  labels: [],
  datasets: [{
    data: [],
    backgroundColor: [],
    borderWidth: 1
  }]
});

// Full data for table
const tableData = ref([]);
const loading = ref(false);

const hasData = computed(() => chartData.value.labels.length > 0);

const chartOptions = {
  responsive: true,
  maintainAspectRatio: false,
  plugins: {
    legend: {
      position: 'right',
      labels: {
        padding: 20,
        font: { size: 12 }
      }
    },
    tooltip: {
      callbacks: {
        label: (context) => {
          return [
            `${context.label}`,
            `Amount: $${context.raw.toLocaleString()}`,
            `Frequency: ${Math.round(context.raw / chartData.value.datasets[0].data.reduce((a, b) => a + b, 0) * 100)}%`
          ];
        }
      }
    }
  },
  cutout: '60%'
};

// Color generator
const colorPalette = [
  '#4bc0c0', '#ff6384', '#ffcd56', '#9966ff', '#36a2eb',
  '#ff9f40', '#8ac24a', '#607d8b', '#e91e63', '#9c27b0'
];

function getColor(index, inChart = true) {
  return inChart
    ? colorPalette[index % colorPalette.length]
    : '#cccccc';
}

async function fetchData() {
  try {
    loading.value = true;
    const response = await apiClient.get('/Home/TopBudgetCategories');

    if (response.data?.Labels && response.data?.Data) {
      // Process all data for table
      tableData.value = response.data.Labels.map((label, index) => ({
        label,
        amount: response.data.Data[index],
        transactions: response.data.TransactionCounts?.[index] || 0,
        percentage: response.data.PercentageOfTransactions?.[index] || 0,
        inChart: index < 5 // Flag for top 5 items
      }));

      // Take only top 5 for chart
      const top5Data = tableData.value.slice(0, 5);

      chartData.value = {
        labels: top5Data.map(item => item.label),
        datasets: [{
          data: top5Data.map(item => item.amount),
          backgroundColor: top5Data.map((_, index) => getColor(index)),
          borderWidth: 1
        }]
      };
    }
  } catch (error) {
    console.error("Error loading data:", error);
  } finally {
    loading.value = false;
  }
}

onMounted(fetchData);
</script>

<style scoped>
.budget-categories-container {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
}

.chart-wrapper {
  height: 400px;
  margin-bottom: 20px;
}

.no-data-message {
  height: 300px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #666;
  font-style: italic;
}

.data-table {
  margin-top: 30px;
}

table {
  width: 100%;
  border-collapse: collapse;
}

th, td {
  padding: 10px;
  text-align: left;
  border-bottom: 1px solid #eee;
}

th {
  font-weight: 500;
  background-color: #f9f9f9;
}

.color-indicator {
  display: inline-block;
  width: 12px;
  height: 12px;
  border-radius: 50%;
  margin-right: 8px;
}

tr:nth-child(n+6) td {
  opacity: 0.7;
}

@media (max-width: 768px) {
  .chart-wrapper {
    height: 300px;
  }
}
</style>
