<template>
  <ContainerBg>
    <div class="grid grid-cols-3 gap-4">
      <DashMincard v-if="currentMonth.income != 0" title="Balance"
        :subtitle="'Your total income is ' + currentMonth.income + '.'">

      </DashMincard>
      <DashMincard title="Income"
        v-else-if="fallBack.income && fallBack.income.month && fallBack.income.amount && currentMonth.income == 0"
        :subtitle="'Your total income from ' + fallBack.income.month + ' was ' + fallBack.income.amount.toLocaleString('en-mw', { minimumFractionDigits: 2, style: 'currency', currency: 'MWK' }) + '.'">

      </DashMincard>

      <DashMincard v-if="currentMonth.budget != 0" title="Budgeted"
        :subtitle="'You have budgeted ' + currentMonth.budget.toLocaleString('en-mw', { minimumFractionDigits: 2, style: 'currency', currency: 'MWK' }) + '.'">
        <ChartPieIcon class="icon size-5" />
      </DashMincard>
      <DashMincard
        v-if="fallBack.budget && fallBack.budget.month && fallBack.budget.spend && fallBack.budget.amount && currentMonth.budget == 0"
        title="Budgeted"
        :subtitle="'You budgeted ' + fallBack.budget.amount.toLocaleString('en-mw', { minimumFractionDigits: 2, style: 'currency', currency: 'MWK' }) + ' and spent ' + fallBack.budget.spend.toLocaleString('en-mw', { minimumFractionDigits: 2, style: 'currency', currency: 'MWK' }) + ' in ' + fallBack.budget.month + '.'">
        <ChartPieIcon class="icon size-5" />
      </DashMincard>
      <DashMincard v-if="currentMonth.investment != 0" title="Investments"
        :subtitle="'You have Invested ' + currentMonth.investment.toLocaleString('en-mw', { minimumFractionDigits: 2, style: 'currency', currency: 'MWK' }) + '.'" />
      <DashMincard v-else-if="fallBack.Investment && fallBack.Investment.month && fallBack.Investment.amount"
        title="Investments"
        :subtitle="'You invested ' + fallBack.Investment.amount.toLocaleString('en-mw', { minimumFractionDigits: 2, style: 'currency', currency: 'MWK' }) + ' in ' + fallBack.Investment.month + '.'" />
      <DashMincard v-if="currentMonth.balance != null" title="Balance" :subtitle="'Your balance is ' + currentMonth.balance.toLocaleString('en-mw', { minimumFractionDigits: 2, style: 'currency', currency: 'MWK' }) + '.'" />
      <DashMincard v-if="currentMonth.balance != null" title="Balance" :subtitle="'Your balance is ' + currentMonth.balance.toLocaleString('en-mw', { minimumFractionDigits: 2, style: 'currency', currency: 'MWK' }) + '.'" />
      <DashMincard v-if="currentMonth.balance != null" title="Balance" :subtitle="'Your balance is ' + currentMonth.balance.toLocaleString('en-mw', { minimumFractionDigits: 2, style: 'currency', currency: 'MWK' }) + '.'" />
      <div class="col-span-2 bg-white border border-gray-300">
        <BarChart />
      </div>
      <div class="col-span-1  bg-white border border-gray-300">
        <Pie />
      </div>
      <div class="col-span-3  bg-white border border-gray-300">
        <LineChart />
      </div>
      <div class="col-span-1 bg-white border border-gray-300">
        <RecentTransactions/>
      </div>
    </div>
  </ContainerBg>
</template>

<script setup>
import { onMounted, reactive, } from 'vue';
import DashMincard from '../Components/DashMincard.vue';
import apiClient from '../../Others/apiClient'
// import { Bar, Pie } from 'vue-chartjs'
import { Chart as ChartJS, ArcElement, Tooltip, Legend } from 'chart.js'
import ContainerBg from '../Components/ContainerBg.vue';
import BarChart from '../Components/Charts/BarChart.vue';
import Pie from '../Components/Charts/Pie.vue';
import LineChart from '../Components/Charts/lineChart.vue';
import RecentTransactions from '../Components/recentTransactions.vue';

ChartJS.register(ArcElement, Tooltip, Legend)

const currentMonth = reactive({
  income: 0,
  budget: 0,
  investment: 0,
  balance: 0,
});

const fallBack = reactive({
  income: {},
  budget: {},
  Investment: {},
});

const headerBars = async () => {
  const response = await apiClient.get('/Home/Header');
  if (response.status === 200) {
    fallBack.budget = response.data.fallbacks.budget;
    currentMonth.Investment = response.data.current.Investment;
    fallBack.Investment = response.data.fallbacks.investments;
    currentMonth.income = response.data.current.income;
    fallBack.income = response.data.fallbacks.income;
    currentMonth.balance = response.data.current.balance;
    // console.log(currentMonth.income);
    console.log(response.data.fallbacks.investments);
  }
};

onMounted(() => {
  headerBars();
});


</script>

<style></style>
