import { configureStore } from "@reduxjs/toolkit";
import cartSlice, { Middleware } from "./cart/cart-slice";
import productSlice from "./products/product-slice";

const store = configureStore({
  reducer: {
    cart: cartSlice,
    products: productSlice,
  },
  middleware: (getDefaultMiddleware) =>
    getDefaultMiddleware().concat(Middleware),
});
export default store;
