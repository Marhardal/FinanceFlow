<template>
  <!-- component -->
  <div class="min-h-screen bg-gray-100 flex items-center justify-center p-4">
    <div class="max-w-md w-full bg-white rounded-xl shadow-lg p-8">
      <h2 class="text-2xl font-bold text-gray-900 mb-6 text-center">Reset Password</h2>

      <FormKit type="form">
        <FormKit label="Email" placeholder="Enter your Email Address." type="text" v-model="input.email"
          validation="required" />
        <button type="submit" @click="Reset" class="w-full bg-blue-500 hover:bg-blue-500 text-white font-medium py-2.5 rounded transition-colors">
          class="w-full bg-blue-500 hover:bg-blue-500 text-white font-medium py-2.5 rounded transition-colors">
          Reset Password
        </button>
      </FormKit>
      <div class="mt-6 text-center text-sm text-gray-600">
        <Router-Link to="/login" class="text-indigo-600 hover:text-indigo-500 font-medium">
          <ArrowLeftIcon class="icon size-5"/> <span>Back to Login</span>
        </Router-Link>
      </div>
    </div>
  </div>
</template>

<script setup>
import { reactive } from 'vue'
import { useToast } from 'vue-toast-notification';
import { useRouter } from 'vue-router';
import { useStore } from '@/Stores/Pinia';
import { ArrowLeftIcon } from '@heroicons/vue/24/solid';


const $toast = useToast();
const router = useRouter();

const authuseStore = useStore();

const input = reactive({
  username: "",
  Password: "",
})

const Reset = async () => {
  const success = await authuseStore.Login(input.username, input.Password);
  if (!success) {
    $toast.error("Error logging in. Please try again.");
    return;
  }
  router.push({ path: '/' })
}
</script>

<style lang="scss" scoped></style>
