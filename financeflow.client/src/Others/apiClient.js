import axios from "axios";

const instance = axios.create({
  baseURL: "https://localhost:7001/api",
  headers: {
    Accept: "application/json",
  },
});

const token = localStorage.getItem("authToken");

instance.interceptors.request.use((config) => {
  if (token != null) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

export default instance;
