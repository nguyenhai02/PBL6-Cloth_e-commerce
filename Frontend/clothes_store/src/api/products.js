import http from "../helpers/http";

// export const getAllProducts = () => {
//   return http.get("/products/category/tops");
// };
// export const getAllProducts = () => {
//   return http.get("/product/all");
// };
export const getAllProducts = (page, size = 6, sort) => {
  return http.get("/product/all", {
    params: {
      page: page,
      size: size,
      sort: sort,
    },
  });
};
export const getDetailProduct = (id) => {
  return http.get(`/product/detail/${id}`);
};
