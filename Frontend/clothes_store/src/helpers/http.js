import axios from "axios";
class Http {
  constructor() {
    this.instance = axios.create({
      // baseURL: "http://localhost:8080",
      // baseURL: "https://pbl6.up.railway.app",
      baseURL: "https://clothesshop.up.railway.app",
      name: "Clothes shop",
      timeout: 10000,
      headers: {
        "Content-Type": "application/json",
      },
    });
    this.instance.interceptors.response.use(
      (response) => {
        return response.data;
      },
      ({ response }) => {
        if (response && response.status === 401) {
        }
        const result = response
          ? { ...response.data, status: response.status }
          : {};
        return Promise.reject(result);
      }
    );
    this.instance.interceptors.request.use(
      (config) => {
        return config;
      },
      (error) => {
        return Promise.reject(error.response);
      }
    );
  }
  get(url, config = null) {
    return this.instance.get(url, config);
  }
  post(url, data, config = null) {
    return this.instance.post(url, data, config);
  }
  put(url, data, config = null) {
    return this.instance.put(url, data, config);
  }
  delete(url, data, config = null) {
    return this.instance.delete(url, {
      data,
      ...config,
    });
  }
}

const http = new Http();

export default http;
