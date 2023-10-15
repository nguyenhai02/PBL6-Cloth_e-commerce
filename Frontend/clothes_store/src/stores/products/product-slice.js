import { createSlice } from "@reduxjs/toolkit";
import { getAllProduct } from "./product-thunk";

const initialState = {
  products: null,
  loading: false,
  error: null,
};
const productsSlice = createSlice({
  name: "products",
  initialState: initialState,
  extraReducers: (builder) => {
    builder
      .addCase(getAllProduct.pending, (state) => {
        state.loading = true;
        state.error = null;
      })
      .addCase(getAllProduct.fulfilled, (state, action) => {
        state.loading = false;
        state.products = action.payload;
      })
      .addCase(getAllProduct.rejected, (state, action) => {
        state.loading = false;
        state.error = action.error.message;
      });
  },
});
export default productsSlice.reducer;
export const productsAction = {
  ...productsSlice.actions,
  getAllProduct,
};
