<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue';
import { HomeIcon, ArrowsUpDownIcon, ChartPieIcon, WalletIcon, ShoppingCartIcon, Cog6ToothIcon, UserCircleIcon, BellIcon, ArrowTrendingUpIcon } from '@heroicons/vue/24/solid';
import { RouterLink, RouterView } from 'vue-router'
import { useStore } from '@/Stores/Pinia';
import { useToast } from 'vue-toast-notification';
import { useRouter } from 'vue-router';

const $toast = useToast();
const router = useRouter();

const authuseStore = useStore();

  const authUserID = ref("");

const getAuthUserID = () => {
  authUserID.value = localStorage.getItem('authUserID');
  return authUserID.value ? authUserID : null;
}

const Logout = async () => {
  console.log("Logout");

  localStorage.removeItem('authUserID');
  localStorage.removeItem('authRefreshToken');
  localStorage.removeItem('authRole');
  localStorage.removeItem('authToken');

  const success = await authuseStore.logout();
  if (!success) {
    $toast.error("Error logging out. Please try again.");
    return;
  }
  router.push({ path: '/login' })

  if (authUserID.value == null) {
    router.push({ path: '/login' })
  }
  // $toast.success("Logged in successfully.");
}

const showMenu = ref(false);
const dropdownRef = ref(null);

const toggleMenu = () => {
  showMenu.value = !showMenu.value;
};

const handleClickOutside = (event) => {
  if (dropdownRef.value && !dropdownRef.value.contains(event.target)) {
    showMenu.value = false;
  }
};


onMounted(() => {
  document.addEventListener('click', handleClickOutside);
  getAuthUserID();
  if (authUserID.value == null) {
    router.push({ path: '/login' })
  }
  // console.log("Auth User ID:", authUserID.value);
});

onBeforeUnmount(() => {
  document.removeEventListener('click', handleClickOutside);
});
</script>

<template>
  <div class="flex w-screen h-screen text-gray-700">

    <!-- Component Start -->
    <div class="flex flex-col items-center w-16 pb-4 overflow-auto border-r border-gray-300" v-if="authUserID !== null">
      <a class="flex items-center justify-center flex-shrink-0 w-full h-16 bg-gray-300" href="#">
        <svg class="w-8 h-8" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
            d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
        </svg>
        <!--<HomeIcon class="icon"/>-->
        <!--<img src="assets/favicon.ico"/>-->
      </a>
      <RouterLink to="/"
        class="flex items-center justify-center flex-shrink-0 w-10 h-10 mt-4 rounded hover:bg-gray-300">
        <HomeIcon class="icon size-5" />
      </RouterLink>

      <Router-link to="/transactions"
        class="flex items-center justify-center flex-shrink-0 w-10 h-10 mt-4 rounded hover:bg-gray-300">
        <arrowsUpDownIcon class="icon size-5" />
      </Router-link>

      <RouterLink to="/Budgets"
        class="flex items-center justify-center flex-shrink-0 w-10 h-10 mt-4 rounded hover:bg-gray-300">
        <ChartPieIcon class="icon size-5" />
      </RouterLink>
      <RouterLink to="/incomes"
        class="flex items-center justify-center flex-shrink-0 w-10 h-10 mt-4 rounded hover:bg-gray-300" href="#">
        <WalletIcon class="icon size-5" />
      </RouterLink>
      <RouterLink to="/items"
        class="flex items-center justify-center flex-shrink-0 w-10 h-10 mt-4 rounded hover:bg-gray-300" href="#">
        <ShoppingCartIcon class="icon size-5" />
      </RouterLink>
      <RouterLink to="/investment"
        class="flex items-center justify-center flex-shrink-0 w-10 h-10 mt-4 rounded hover:bg-gray-300" href="#">
        <ArrowTrendingUpIcon class="icon size-5" />
      </RouterLink>
      <a class="flex items-center justify-center flex-shrink-0 w-10 h-10 mt-4 rounded hover:bg-gray-300" href="#">
        <Cog6ToothIcon class="icon size-5" />
      </a>
      <router-link to="/register"
        class="flex items-center justify-center flex-shrink-0 w-10 h-10 bg-gray-200 mt-auto rounded hover:bg-gray-300"
        href="#">
        <UserCircleIcon class="icon size-5" />
      </router-link>
    </div>

    <div class="flex flex-col flex-grow" >
      <div class="flex items-center flex-shrink-0 h-16 px-8 border-b border-gray-300" v-if="authUserID !== null">
        <h1 class="text-lg font-medium">Finance Flow</h1>
        <button
          class="flex items-center justify-center h-10 px-4 ml-auto text-sm font-medium rounded hover:bg-gray-300">
          Action 1
        </button>
        <button
          class="flex items-center justify-center h-10 px-4 ml-2 text-sm font-medium rounded-full hover:bg-gray-300">
          <BellIcon class="w-5 h-5" />
        </button>
        <!-- <button class="relative ml-2 text-sm focus:outline-none group">
          <div class="flex items-center justify-between w-10 h-10 rounded-full hover:bg-gray-300 bg-gray-200">
            <UserCircleIcon class="icon size-10" />
            <svg class="w-5 h-5 mx-auto" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 5v.01M12 12v.01M12 19v.01M12 6a1 1 0 110-2 1 1 0 010 2zm0 7a1 1 0 110-2 1 1 0 010 2zm0 7a1 1 0 110-2 1 1 0 010 2z" />
            </svg>
            <span class="px-4 py-2">Martin</span>
          </div>
          <div class="absolute right-0 flex-col items-start hidden w-40 pb-1 rounded pt-2 bg-white border border-gray-300 shadow-lg group-focus:flex">
            <router-link to="/register" class="w-full px-4 py-2 text-left hover:bg-gray-300">Register</router-link>
            <a class="w-full px-4 py-2 text-left hover:bg-gray-300" href="#">Menu Item 1</a>
            <button class="w-full px-4 py-2 text-left hover:bg-gray-300" @click="Logout">Logout</button>
          </div>
        </button> -->
        <div class="relative ml-2 text-sm" ref="dropdownRef">
          <button @click="toggleMenu"
            class="flex items-center justify-between w-10 h-10 rounded-full hover:bg-gray-300 bg-gray-200">
            <UserCircleIcon class="icon size-10" />
          </button>

          <div v-if="showMenu"
            class="absolute right-0 flex flex-col w-40 pb-1 pt-2 rounded bg-white border border-gray-300 shadow-lg z-50">
            <router-link to="/register" class="w-full px-4 py-2 text-left hover:bg-gray-300">Register</router-link>
            <a class="w-full px-4 py-2 text-left hover:bg-gray-300" href="#">Menu Item 1</a>
            <button type="button" class="w-full px-4 py-2 text-left hover:bg-gray-300" @click="Logout">Logout</button>
          </div>
        </div>
      </div>
      <div class="flex-grow p-6 overflow-auto bg-gray-200">
        <Router-view />
      </div>
    </div>
    <!-- Component End  -->

  </div>

</template>

<style scoped>
header {
  line-height: 1.5;
}

.logo {
  display: block;
  margin: 0 auto 2rem;
}

@media (min-width: 1024px) {
  header {
    display: flex;
    place-items: center;
    padding-right: calc(var(--section-gap) / 2);
  }

  .logo {
    margin: 0 2rem 0 0;
  }

  header .wrapper {
    display: flex;
    place-items: flex-start;
    flex-wrap: wrap;
  }
}
</style>
