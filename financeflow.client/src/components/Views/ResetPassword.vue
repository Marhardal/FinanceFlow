<template>
  <!-- component -->
  <div class="min-h-screen bg-gray-100 flex items-center justify-center p-4">
    <div class="max-w-md w-full bg-white rounded-xl shadow-lg p-8">
      <h2 class="text-2xl font-bold text-gray-900 mb-6 text-center">Sign In</h2>

      <FormKit type="form" submit-label="Login" @submit="Login" :submit-attrs="{
        inputClass: 'py-3 px-4 block w-full border-gray-500 rounded text-sm focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none bg-gray-300 dark:border-gray-500 dark:text-neutral-700 dark:placeholder-neutral-500 dark:focus:ring-neutral-600',
        wrapperClass: 'space-y-5',
        'data-theme': `dark`,
        ignore: false
      }">
        <FormKit label="Username" placeholder="Enter your Email Address." type="text" v-model="input.email"
          validation="required" />
        <!-- <FormKit label="Password" name="password" placeholder="Enter your Password." type="password" v-model="input.Password" validation="required" suffix-icon="eyeClosed" @suffix-icon-click="handleIconClick" suffix-icon-class="hover:text-blue-500" /> -->

        <div class="flex items-center justify-between mb-4">
          <label class="flex items-center">
            <input type="checkbox" class="rounded border-gray-300 text-indigo-600 focus:ring-indigo-500" />
            <span class="ml-2 text-sm text-gray-600">Remember me</span>
          </label>
          <Router-Link to="/register" class="text-sm text-indigo-600 hover:text-indigo-500">Forgot password?</Router-Link>
        </div>

        <!--
        <button
          class="w-full bg-indigo-600 hover:bg-indigo-700 text-white font-medium py-2.5 rounded-lg transition-colors">
          Sign In
        </button> -->
      </FormKit>
      <div class="mt-6 text-center text-sm text-gray-600">
        Don't have an account?
        <Router-Link to="/register" class="text-indigo-600 hover:text-indigo-500 font-medium">Sign up</Router-Link>
      </div>
    </div>
  </div>
</template>

<script setup>
import { reactive } from 'vue'
import { useToast } from 'vue-toast-notification';
import { useRouter } from 'vue-router';
import { useStore } from '@/Stores/Pinia';

const $toast = useToast();
const router = useRouter();

const authuseStore = useStore();

const input = reactive({
  username: "",
  Password: "",
})

const Login = async () => {
  const success = await authuseStore.Login(input.username, input.Password);
  if (!success) {
    $toast.error("Error logging in. Please try again.");
    return;
  }
  router.push({ path: '/' })
  // $toast.success("Logged in successfully.");
}

// const Login = async () => {
//   try {
//     const response = await apiClient.post('/user/login', input)
//     console.log(response)
//     $toast.success("Logged in successfully.");
//     router.push({ path: '/dashboard' })
//   } catch (error) {
//     console.error("Error logging in:", error);
//     $toast.error("Error logging in. Please try again.");
//   }
// }

const handleIconClick = (node, e) => {
  node.props.suffixIcon = node.props.suffixIcon === 'eye' ? 'eyeClosed' : 'eye'
  node.props.type = node.props.type === 'password' ? 'text' : 'password'
}
</script>

<style lang="scss" scoped></style>
