import http from "../helpers/http";
import { getToken } from "./users";

export const createPaymentVNPay = (orderInfo) => {
  return http.post("/payment/createPayment", orderInfo, {
    headers: {
      Authorization: "Bearer " + getToken(),
    },
  });
};

export const createOrderCOD = (orderInfo) => {
  return http.post("/order/createOrder", orderInfo, {
    headers: {
      Authorization: "Bearer " + getToken(),
    },
  });
};

export const getAllOrders = () => {
  return http.get("/order/getOrders", {
    headers: {
      Authorization: "Bearer " + getToken(),
    },
  });
};
