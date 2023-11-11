import http from "../helpers/http";
import { getToken } from "./users";

export const getAllCartItems = () => {
  return http.get("/cart", {
    headers: {
      Authorization: "Bearer " + getToken(),
    },
  });
};

export const addCartItem = (cartItem) => {
  return http.post("/user/add", cartItem, {
    headers: {
      Authorization: "Bearer " + getToken(),
    },
  });
};
