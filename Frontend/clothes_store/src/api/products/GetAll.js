import http from "../../helpers/http";

// export const getAllProducts = () => {
//   return http.get("/products/category/tops");
// };
export const getAllProducts = () => {
  return http.get("/products/category/tops");
};
export const getDetailProduct = (id) => {
  return http.get(`/products/${id}`);
};
