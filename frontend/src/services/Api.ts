import axios from "axios";

export const createAxiosApi = () =>
  axios.create({
    baseURL: process.env.VUE_APP_API_URL
  });
