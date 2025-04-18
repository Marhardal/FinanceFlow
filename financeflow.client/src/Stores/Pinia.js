import { defineStore } from "pinia";
import apiClient from "../Others/apiClient";
import { ref } from "vue";

export const useStore = defineStore("store", {
  state: () => ({
    authUserID: ref([]),
    authToken: ref([]),
    authRefreshToken: ref([]),
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
        console.log(data.data)
        this.authToken = data.data.accessToken;
        this.authUserID = data.data.userID;
        this.authRole = data.data.roleID;
        this.authRefreshToken = data.data.refrshToken;
        localStorage.setItem("authToken", this.authToken);
        localStorage.setItem("authUserID", this.authUserID);
        localStorage.setItem("authRole", this.authRole);
        localStorage.setItem("authRefreshToken", this.authRefreshToken);

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
