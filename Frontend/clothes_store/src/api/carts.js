import http from "../helpers/http";
import { getToken } from "./users";

export const getAllCartItems = () => {
  return http.get("/user/profile", {
    headers: {
      Authorization: "Bearer " + getToken(),
    },
  });
};
