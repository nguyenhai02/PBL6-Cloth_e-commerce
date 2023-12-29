import { createSlice, createAsyncThunk } from "@reduxjs/toolkit";
import {
  getAllProducts,
  getDetailProduct,
  getProductByCategory,
} from "../../api/products";

export const getAllProduct = createAsyncThunk(
  "getAllProducts",
  async ({ page, size = 6, sort }) => {
    const response = await getAllProducts(page, size, sort);
    return response;
  }
);

export const getAllProductByCategory = createAsyncThunk(
  "getAllProductByCategory",
  async ({ category, page, size = 6, sort }) => {
    const response = await getProductByCategory(category, page, size, sort);
    return response;
  }
);

export const getAllProductByName = createAsyncThunk(
  "getAllProductByName",
  async ({ name, page, size = 6, sort }) => {
    const response = await getAllProductByName(name, page, size, sort);
    return response;
  }
);

export const getProductDetail = createAsyncThunk(
  "getDetailProduct",
  async (id) => {
    const response = await getDetailProduct(id);
    return response;
  }
);

const initialState = {
  products: [],
  productDetail: null,
  loading: false,
  error: null,
  total: 0, // new line
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
        state.total = action.payload.totalElements; // new line
      })
      .addCase(getAllProduct.rejected, (state, action) => {
        state.loading = false;
        state.error = action.error.message;
      })
      // //////////////////////////////////////////
      .addCase(getAllProductByCategory.pending, (state) => {
        state.loading = true;
        state.error = null;
      })
      .addCase(getAllProductByCategory.fulfilled, (state, action) => {
        state.loading = false;
        state.products = action.payload.content;
        state.total = action.payload.totalElements; // new line
      })
      .addCase(getAllProductByCategory.rejected, (state, action) => {
        state.loading = false;
        state.error = action.error.message;
      })
      //////////////////////////////////////////
      .addCase(getAllProductByName.pending, (state) => {
        state.loading = true;
        state.error = null;
      })
      .addCase(getAllProductByName.fulfilled, (state, action) => {
        state.loading = false;
        state.products = action.payload.content;
        state.total = action.payload.totalElements; // new line
      })
      .addCase(getAllProductByName.rejected, (state, action) => {
        state.loading = false;
        state.error = action.error.message;
      })
      // //////////////////////////////////////////
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
  getAllProductByCategory,
};
