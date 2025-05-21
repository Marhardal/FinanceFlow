<template>
  <div class="min-h-screen bg-gray-100 flex items-center justify-center p-4">
    <div class="max-w-md w-full bg-white rounded-xl shadow-lg p-8">
      <h2 class="text-2xl font-bold text-gray-900 mb-6 text-center">Reset Password</h2>

      <FormKit type="form" @submit="Reset">
        <FormKit
          name="email"
          label="Email"
          placeholder="Enter your Email Address."
          type="email"
          validation="required|email"
          v-model="input.email"
        />
        <button
          class="w-full bg-blue-500 hover:bg-blue-600 text-white font-medium py-2.5 rounded transition-colors mt-4"
        >
          Reset Password
        </button>
      </FormKit>

      <div class="mt-6 text-center text-sm text-gray-600">
        <Router-Link to="/login" class="text-indigo-600 hover:text-indigo-500 font-medium flex items-center justify-center gap-2">
          <ArrowLeftIcon class="size-5" />
          <span>Back to Login</span>
        </Router-Link>
      </div>
    </div>
  </div>
</template>

<script setup>
import { reactive } from 'vue'
import { useToast } from 'vue-toast-notification'
import { useRouter } from 'vue-router'
import { ArrowLeftIcon } from '@heroicons/vue/24/solid'

const $toast = useToast()
const router = useRouter()

const input = reactive({
  email: ''
})

const Reset = async () => {
}
</script>
