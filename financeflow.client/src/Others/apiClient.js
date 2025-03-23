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

instance.interceptors.response.use(
  (response) => {
    return response;
  },
  async (error) => {
    const originalRequest = error.config;
    if (error.response.status === 401 && !originalRequest._retry) {
      const authUserID = localStorage.getItem("authUserID");
      const refreshToken = localStorage.getItem("authRefreshToken");
      console.log(authUserID + " " + refreshToken);
      originalRequest._retry = true;
      const res = await instance.post("/user/refresh-Token", {
        authUserID,
        refreshToken
      });
      if (res.status === 200) {
        localStorage.setItem("authToken", res.data.accessToken);
        return instance(originalRequest);
      }
    }
    return Promise.reject(error);
  }
);

export default instance;
