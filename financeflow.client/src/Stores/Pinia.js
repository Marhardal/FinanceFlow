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
    authUser: ref([]),
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
        this.authRefreshToken = data.data.refreshToken;
        localStorage.setItem("authToken", data.data.accessToken);
        localStorage.setItem("authUserID", data.data.userID);
        localStorage.setItem("authRole", data.data.roleID);
        localStorage.setItem("authRefreshToken", data.data.refreshToken);

        return true;
      } catch (error) {
        this.authErrors.value = error.response;
        return false;
      }
    },
    async getUser() {
      try {
        const userId = localStorage.getItem("authUserID");
        if (!userId) {
          console.warn("No userId found in localStorage");
          return null;
        }

        const response = await apiClient.get(`/User/${userId}`);
        this.authUser.value = response.data;
        return true;
        // }
      }
      catch (error) {
        this.authErrors.value = error.response;
        return false;
      }
    },
    logout() {
      this.authUser.value = null;
      this.authToken = null;
      localStorage.removeItem("authToken");
      localStorage.removeItem("authUser");
    },
  },
});
