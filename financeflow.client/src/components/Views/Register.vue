<template>
  <ContainerBg>
    <div class="mx-auto max-w-xl">
      <div class="text-start mb-8">
        <h2 class="text-3xl md:text-4xl font-bold mb-2">Create an Account</h2>
        <h2 class="text-2xl md:text-2xl text-neutral-600 font-semibold mb-2">Fill in all Fields.</h2>
      </div>
      <!-- <form action="" class="space-y-5"> -->
      <FormKit type="form" submit-label="Create" @submit="createAccount" :submit-attrs="{
        inputClass: 'py-3 px-4 block w-full border-gray-500 rounded text-sm focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none bg-gray-300 dark:border-gray-500 dark:text-neutral-700 dark:placeholder-neutral-500 dark:focus:ring-neutral-600',
        wrapperClass: 'space-y-5',
        'data-theme': `dark`,
        ignore: false
      }">
        <FormKit label="First Name" placeholder="Enter your First Name." type="text" v-model="input.firstname"
          validation="required" />
        <FormKit label="Surname" placeholder="Enter your Surname." type="text" v-model="input.surname"
          validation="required" />
        <FormKit label="Email" placeholder="Enter your Email Address." type="text" v-model="input.email"
          validation="required" />
        <FormKit label="Username" placeholder="Enter your Username." type="email" v-model="input.username"
          validation="required" />
        <FormKit label="Date of Birth" type="date" v-model="input.dob"
          validation="required" />
        <FormKit label="Password" placeholder="Enter your Password." type="password" v-model="input.Password"
          validation="required" />
      </FormKit>
    </div>
  </ContainerBg>
</template>

<script setup>
import { reactive } from 'vue';
import ContainerBg from '../Components/ContainerBg.vue';
import { useToast } from 'vue-toast-notification';
import { useRouter } from 'vue-router';
import apiClient from '../../Others/apiClient'

const $toast = useToast();
const router = useRouter();

const input = reactive({
  firstname: "",
  surname: "",
  username: "",
  email: "",
  dob: "",
  password: ""
});

const createAccount = async() => {
  try {
    const response = await apiClient.post('/user', input);
    if (response) {
      $toast.success('An Account has been created!');
      router.push('/login');
}
  } catch (error) {
    console.error("Error creating Account:", error);
    $toast.error('An error occurred while creating an Account!');
  }
}
</script>

<style lang="scss"></style>
