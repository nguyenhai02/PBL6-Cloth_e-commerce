import { createSlice } from "@reduxjs/toolkit";

const loadCartFromLocalStorage = () => {
  const cartData = localStorage.getItem("cart");
  if (cartData) {
    return JSON.parse(cartData);
  }
  return initialState;
};
const initialState = {
  items: [],
  totalAmount: 0,
};
const cartSlice = createSlice({
  name: "cart",
  initialState: loadCartFromLocalStorage(),
  reducers: {
    addToCart: (state, action) => {
      const newItem = action.payload;
      const existedItem = state.items.find((item) => {
        return item.id === newItem.id && item.size === newItem.size;
      });
      if (existedItem) {
        existedItem.quantity += action.payload.quantity;
      } else {
        state.items.push({ ...newItem, quantity: action.payload.quantity });
      }
      const money = newItem.price * newItem.quantity;
      state.totalAmount += money;
    },
    deleteCartItem: (state, action) => {
      const itemID = action.payload.id;
      const existedItem = state.items.find((item) => {
        return item.id === itemID;
      });
      if (existedItem.quantity === 1) {
        state.items = state.items.filter((item) => item.id !== itemID);
      } else {
        existedItem.quantity--;
      }
      // const itemPrice = existedItem.price;
      state.totalAmount -= existedItem.price;
    },
    deleteProduct: (state, action) => {
      const crrItem = action.payload;
      const existedItem = state.items.find((item) => {
        return item.id === crrItem.id && item.size === crrItem.size;
      });
      if (existedItem) {
        state.items = state.items.filter((item) => item !== existedItem);
      }
      state.totalAmount -= existedItem.price * existedItem.quantity;
    },
    changeSize: (state, action) => {
      const itemID = action.payload;
      const existedItem = state.items.find((item) => {
        return item.id === itemID;
      });
      if (existedItem) {
        existedItem.size = action.payload.size;
      }
    },
  },
  extraReducers: [],
});
const cartMiddleware = (store) => (next) => (action) => {
  const result = next(action); // Thực hiện action và lấy kết quả

  // Lấy state hiện tại sau khi action thực hiện
  const currentState = store.getState().cart;

  // Lưu trữ state mới vào localStorage
  localStorage.setItem("cart", JSON.stringify(currentState));

  return result;
};
export const Middleware = [cartMiddleware];
export const { addToCart, deleteCartItem, deleteProduct, changeSize } =
  cartSlice.actions;
export default cartSlice.reducer;
