import React, { useEffect, useState } from "react";
import "./Cart.scss";
import CartItemPreview from "./CartItemPreview";
import { useNavigate } from "react-router-dom";
import { useSelector } from "react-redux";
const Cart = (props) => {
  const [cartItem] = useState([]);
  const navigate = useNavigate();
  const { items, totalAmount } = useSelector((state) => state.cart);
  useEffect(() => {
    const cartContainer = document.querySelector(".cart__container");
    if (items.length > 3) {
      cartContainer.classList.add("cart_scroll");
    } else cartContainer.classList.remove("cart_scroll");
  }, [items]);

  const checkoutsHandler = () => {
    if (props.drawer) {
      props?.drawer(false);
    }
    navigate("/checkouts");
  };
  const cartHandler = () => {
    if (props.drawer) {
      props?.drawer(false);
    }
    navigate("/cart");
  };
  const renderCartItem = items.map((item) => {
    return <CartItemPreview product={item} />;
  });

  return (
    <div className="cart">
      <div className="cart__title">CART</div>
      <div className="cart__content">
        {!cartItem && <p className="cart__alert">BUY SOMETHING.</p>}
        <div className="cart__container">{renderCartItem}</div>
      </div>
      <div className="cart__total">
        <span className="cart__total_title">TOTAL:</span>
        <span className="cart__total_number">{totalAmount} $</span>
      </div>
      <div className="cart__btn">
        <div className="cart__btn_w" onClick={cartHandler}>
          MY CART
        </div>
        <div className="cart__btn_checkout" onClick={checkoutsHandler}>
          CHECKOUTS
        </div>
      </div>
    </div>
  );
};

export default Cart;
