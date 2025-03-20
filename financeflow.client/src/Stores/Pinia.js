import { defineStore } from "pinia";
import apiClient from "../Others/apiClient";
import { ref } from "vue";

export const useStore = defineStore("store", {
  state: () => ({
    authUser: ref([]),
    authToken: ref([]),
    authRole: ref([]),
    authErrors: ref([]),
  }),

  getters: {},

  actions: {
    async Login(username, password) {
      try {
        const data = await apiClient.post("/user/login", {
          username,
          password,
        });
        console.log(data.data.user)
        this.authUser = data.data.user;
        this.authToken = data.data.token;
        localStorage.setItem("authToken", this.authToken);
        localStorage.setItem("authUser", this.authUser);

        return true;
      } catch (error) {
        this.authErrors = error.response;
        return false;
      }
    },
    logout() {
      this.authUser = null;
      this.authToken = null;
      localStorage.removeItem("authToken");
      localStorage.removeItem("authUser");
    },
  },
});
