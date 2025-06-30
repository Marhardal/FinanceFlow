<template>
  <ContainerBg>
    <div v-if="Investment">
      <div class="border-b border-gray-200 p-5 rounded-lg">
        <h2 class="text-3xl md:text-2xl font-bold mb-2">{{ Investment.name }} Details</h2>
      </div>
      <div class="border-b border-gray-200 p-5 rounded-lg">
        <div class="grid grid-cols-4 gap-4">
          <div class="col-span-1">
            <h3 class="text-lg font-semibold mb-3">Investment Name</h3>
          </div>
          <div class="col-span-3">
            <p class="text-md">{{ Investment.name }}</p>
          </div>
          <div class="col-span-1">
            <h3 class="text-lg font-semibold mb-3">Investment Type</h3>
          </div>
          <div class="col-span-3" v-if="Investment.investmentType != null">
            <p class="text-md">{{ Investment.investmentType.name }}</p>
          </div>
          <div class="col-span-1">
            <h3 class="text-lg font-semibold mb-3">Investment Amount</h3>
          </div>
          <div class="col-span-3" v-if="Investment.currentAmount != null">
            <p class="text-md">{{ Investment.currentAmount.toLocaleString('en-mw', {
              minimumFractionDigits: 2, style: 'currency',
              currency: 'MWK'
            }) }}</p>
          </div>
          <div class="col-span-1">
            <h3 class="text-lg font-semibold mb-3">Company</h3>
          </div>
          <div class="col-span-3" v-if="Investment.company != null">
            <span class="text-md">{{ Investment.company }}</span>
          </div>
          <div class="col-span-1">
            <h3 class="text-lg font-semibold mb-3">Yearly Percentage</h3>
          </div>
          <div class="col-span-3" v-if="Investment.percentage != null">
            <span class="text-md">{{ Investment.percentage }}</span>
          </div>
          <div class="col-span-3"
            v-else-if="Investment.spentAmount != null && Investment.spentAmount > Investment.amount">
            <div class="bg-red-600 rounded-full text-center inline-flex items-center p-1.5 px-4 hover:bg-red-900">
              <span class="text-md">{{ Investment.spentAmount.toLocaleString('en-mw', {
                minimumFractionDigits: 2, style:
                  'currency', currency: 'MWK'
              }) }}</span>
              <XCircleIcon class="icon size-5 ml-2 text-sm" />
            </div>
          </div>
          <div class="col-span-1">
            <h3 class="text-lg font-semibold">Expected Returns</h3>
          </div>
          <div class="col-span-3">
            <h3 class="text-md">{{ formatInvestmentRange(Investment.currentAmount, Investment.percentage) }}</h3>
          </div>
          <div class="col-span-1">
            <h3 class="text-lg font-semibold">Next Investment Date</h3>
          </div>
          <div class="col-span-3">
            <h3 class="text-md">{{ getNextInvestmentDate(Investment.date) }}</h3>
          </div>
          <div class="col-span-1">
            <h3 class="text-lg font-semibold">Notes</h3>
          </div>
          <div class="col-span-3">
            <h3 class="text-md">{{ Investment.description }}</h3>
          </div>
          <div class="col-span-1">
            <h3 class="text-lg font-semibold">Created On</h3>
          </div>
          <div class="col-span-3">
            <h3 class="text-md">{{ dayjs(Investment.createdOn).fromNow() }}</h3>
          </div>

        </div>
      </div>

      <div class=" py-4">
        <div class="grid grid-cols-7 border-b border-gray-200">
          <div class="col-span-6">
            <h2 class="text-xl py-2 font-bold">Top-up Investments List</h2>
          </div>
          <div class="col-span-1">
            <router-link :to="{ path: '/investment/' + Investment.id + '/invest/create' }"
              class="inline-flex items-center gap-x-2 text-sm font-semibold rounded-lg border border-transparent text-white hover:text-black focus:outline-none focus:text-blue-800 disabled:opacity-50 disabled:pointer-events-none bg-blue-600 px-4 py-2 justify-end align-baseline">Create
            </router-link>
          </div>
        </div>
        <div v-if="Invests !== null && Invests.length > 0">
          <div class="-mx-4 sm:-mx-8 px-4 sm:px-8 py-4 overflow-x-auto">
            <div class="flex flex-col">
              <div class="-m-1.5 overflow-x-auto">
                <div class="p-1.5 min-w-full inline-block align-middle">
                  <div class="overflow-hidden">
                    <table class="min-w-full divide-y divide-gray-200 dark:divide-neutral-700">
                      <thead>
                        <tr>
                          <th scope="col"
                            class="px-6 py-3 text-start text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">
                            Source</th>
                          <th scope="col"
                            class="px-6 py-3 text-start text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">
                            Status</th>
                          <th scope="col"
                            class="px-6 py-3 text-start text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">
                            Amount</th>
                          <th scope="col"
                            class="px-6 py-3 text-start text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">
                            Date</th>
                          <th scope="col"
                            class="px-6 py-3 text-end text-xs font-medium text-gray-500 uppercase dark:text-neutral-500">
                            Action</th>
                        </tr>
                      </thead>
                      <tbody class="divide-y divide-gray-200 dark:divide-neutral-700">
                        <tr
                          class="hover:bg-gray-100 dark:hover:bg-neutral-500 hover:rounded hover:text-white text-gray-800"
                          v-for="Invest in Invests" :key="Invest.id">
                          <td class="px-6 py-4 whitespace-nowrap text-sm font-medium" v-if="Invest.incomes">
                            {{ Invest.incomes.name }}</td>
                          <td class="px-6 py-4 whitespace-nowrap text-sm font-medium" v-if="Invest.status">
                            {{ Invest.status.name }}</td>
                          <td class="px-6 py-4 whitespace-nowrap text-sm">{{
                            Invest.amount.toLocaleString('en-mw', {
                              minimumFractionDigits: 2, style: 'currency',
                              currency: 'MWK'
                            }) }}</td>
                          <td class="px-6 py-4 whitespace-nowrap text-sm" v-if="Invest.date">{{
                            dayjs(Invest.date).fromNow() }}</td>
                          <td class="px-6 py-4 whitespace-nowrap text-end text-sm font-medium">
                            <router-link :to="{ path: '/investment/' + Investment.id + '/invest/edit/' + Invest.id }"
                              class="inline-flex items-center gap-x-2 text-sm font-semibold rounded-lg border border-transparent pr-1 text-blue-600 hover:text-blue-800 focus:outline-none focus:text-blue-800 disabled:opacity-50 disabled:pointer-events-none dark:text-blue-500 dark:hover:text-blue-400 dark:focus:text-blue-400">Edit
                              |</router-link>
                            <button type="button"
                              class="inline-flex items-center gap-x-2 text-sm font-semibold rounded-lg border border-transparent text-blue-600 hover:text-blue-800 focus:outline-none focus:text-blue-800 disabled:opacity-50 disabled:pointer-events-none dark:text-blue-500 dark:hover:text-blue-400 dark:focus:text-blue-400"
                              @click="deleteInvest(Invest.id)">Delete</button>
                          </td>
                        </tr>

                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="px-5 py-5 bg-white border-t flex flex-col xs:flex-row items-center xs:justify-between ">
            <span class="text-xs xs:text-sm text-gray-900">
              Showing 1 to 4 of 50 Entries
            </span>
            <div class="inline-flex mt-2 xs:mt-0">
              <button
                class="text-sm text-indigo-50 transition duration-150 hover:bg-indigo-500 bg-indigo-600 font-semibold py-2 px-4 rounded-l">
                Prev
              </button>
              &nbsp; &nbsp;
              <button
                class="text-sm text-indigo-50 transition duration-150 hover:bg-indigo-500 bg-indigo-600 font-semibold py-2 px-4 rounded-r">
                Next
              </button>
            </div>
          </div>
        </div>

      </div>


    </div>

  </ContainerBg>

</template>

<script setup>
import ContainerBg from '../Components/ContainerBg.vue';
import apiClient from '../../Others/apiClient'
import { ref, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { useToast } from 'vue-toast-notification';
// import { CheckCircleIcon, XCircleIcon } from '@heroicons/vue/24/solid';
import 'vue-toast-notification/dist/theme-sugar.css';
import relativeTime from 'dayjs/plugin/relativeTime';
import dayjs from 'dayjs';

dayjs.extend(relativeTime);
const Investment = ref([]);
const id = useRoute().params.id;
const Invests = ref([]);
const $toast = useToast();
const router = useRouter();

const getInvestment = async (id) => {
  try {
    const response = await apiClient.get(`Investments/${id}`);
    Investment.value = response.data;

    console.log(Investment.value);
  } catch (error) {
    console.error("Error fetching Investment:", error);
  }
};

const getInvests = async (id) => {
  try {
    const response = await apiClient.get(`Invests/${id}`);
    Invests.value = response.data;
    console.log(Invests.value);
  } catch (error) {
    console.error("Error fetching Investment:", error);
  }
};
// const generatePDF = async (id) => {
//   try {
//     const response = await apiClient.get(`PDF/Generate?Investmentid=${id}`, {
//       responseType: 'blob' // Important to get binary data
//     });

//     // Create a download link
//     const blob = new Blob([response.data], { type: 'application/pdf' });
//     const link = document.createElement('a');
//     link.href = URL.createObjectURL(blob);
//     link.download = `Investment_${id}_Invests.pdf`;
//     document.body.appendChild(link);
//     link.click();
//     document.body.removeChild(link);
//     URL.revokeObjectURL(link.href);

//     $toast.success('PDF Downloaded Successfully!');
//   } catch (error) {
//     console.error("Error generating PDF:", error);
//     $toast.error('Failed to generate PDF');
//   }
// };



const deleteInvest = async (id) => {
  try {
    const response = await apiClient.delete(`Invests/${id}`);
    if (response.status === 200) {
      $toast.success('Top-up Deleted Successfully!');
      router.go(0);
      // window.location.reload();
    }
  } catch (error) {
    $toast.error('Failed to Deleted Investment!');
    console.error("Error deleting Invest:", error);
  }
};

const formatInvestmentRange = (amount, percentage) => {
  if (!percentage) return ""; // Handle empty input

  if (percentage.includes("-")) {
    const [min, max] = percentage.split("-").map(Number);

    if (!isNaN(min) && !isNaN(max)) {
      const minTotal = ((amount * min) / 100) + amount;
      const maxTotal = ((amount * max) / 100) + amount;

      return `${minTotal.toLocaleString('en-mw', { minimumFractionDigits: 2, style: 'currency', currency: 'MWK' })} - ${maxTotal.toLocaleString('en-mw', { minimumFractionDigits: 2, style: 'currency', currency: 'MWK' })}`;
    }
  } else {
    const total = ((amount * percentage) / 100) + amount;
    return total.toLocaleString('en-mw', { minimumFractionDigits: 2, style: 'currency', currency: 'MWK' });
  }

  return "Invalid Percentage";
};

const getNextInvestmentDate = (day) => {
  if (!day || isNaN(day)) return "Invalid Date";

  const now = new Date();
  const currentYear = now.getFullYear();
  const currentMonth = now.getMonth(); // 0-based index (Jan = 0, Feb = 1, ...)

  // Ensure the day is valid for the month
  const lastDayOfMonth = new Date(currentYear, currentMonth + 1, 0).getDate();
  const safeDay = Math.min(day, lastDayOfMonth); // Prevent overflow (e.g., Feb 30)

  // Create the new date object
  const nextInvestmentDate = new Date(currentYear, currentMonth, safeDay);

  return nextInvestmentDate.toLocaleDateString('en-GB', {
    weekday: 'long', year: 'numeric', month: 'long', day: 'numeric'
  });
};
onMounted(() => {
  getInvestment(id);
  getInvests(id);
});
</script>

<style lang="scss" scoped></style>
