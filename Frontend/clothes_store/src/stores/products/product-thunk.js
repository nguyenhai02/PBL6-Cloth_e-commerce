import { createAsyncThunk } from "@reduxjs/toolkit";
import { getAllProducts } from "../../api/products/GetAll";

export const getAllProduct = createAsyncThunk(
  "products/getAllProducts",
  async () => {
    const response = await getAllProducts();
    return response.products;
  }
);
