import axios from "axios";

const instance = axios.create({
  baseURL: "https://localhost:7001/api",
  headers: {
    Accept: "application/json",
  }
});

export default instance;

