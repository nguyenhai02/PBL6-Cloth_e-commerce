import { createSlice } from "@reduxjs/toolkit";
import { createAsyncThunk } from "@reduxjs/toolkit";
import { getAllProducts, getDetailProduct } from "../../api/products";

export const getAllProduct = createAsyncThunk("getAllProducts", async () => {
  const response = await getAllProducts();
  return response;
});

export const getProductDetail = createAsyncThunk(
  "getDetailProduct",
  async (id) => {
    const response = await getDetailProduct(id);
    return response;
  }
);

const initialState = {
  products: null,
  productDetail: null,
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
        state.products = action.payload.content;
      })
      .addCase(getAllProduct.rejected, (state, action) => {
        state.loading = false;
        state.error = action.error.message;
      })
      .addCase(getProductDetail.pending, (state) => {
        state.loading = true;
        state.error = null;
      })
      .addCase(getProductDetail.fulfilled, (state, action) => {
        state.loading = false;
        state.productDetail = action.payload;
      })
      .addCase(getProductDetail.rejected, (state, action) => {
        state.loading = false;
        state.error = action.error.message;
      });
  },
});
export default productsSlice.reducer;
export const productsAction = {
  ...productsSlice.actions,
  getAllProduct,
  getProductDetail,
};
