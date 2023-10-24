import http from "../../helpers/http";

const getToken = () => {
  return localStorage.getItem("USER_KEY");
};

export const register = (authRequest) => {
  return http.post("/user/register", authRequest);
};

export const login = (authRequest) => {
  return http.post("/user/login", authRequest);
};

export const getProfile = () => {
  return http.get("/user/profile", {
    headers: {
      Authorization: "Bearer " + getToken(),
    },
  });
};
