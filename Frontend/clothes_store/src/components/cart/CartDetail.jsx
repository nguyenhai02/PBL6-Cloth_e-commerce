import { Col, Row } from "antd";
import React from "react";
import { useSelector } from "react-redux";
import { useNavigate } from "react-router-dom";
import "./CartDetail.scss";
import CartItem from "./CartItem";
import { ArrowRightOutlined } from "@ant-design/icons";
const CartDetail = (props) => {
  const navigate = useNavigate();
  const { items, totalAmount } = useSelector((state) => state.cart);

  const checkoutsHandler = () => {
    if (props.drawer) {
      props?.drawer(false);
    }
    navigate("/checkouts");
  };

  const renderCartItem = items.map((item) => {
    return <CartItem key={item.id} product={item} />;
  });

  return (
    <Row gutter={64} style={{ marginTop: 32 }}>
      <Col md={18}>
        <div className="item__title">YOUR CART</div>
        <div className="item" direction={"vertical"} size={0}>
          <div className="item__count">
            You have <span>{items.length} products</span> in your cart
          </div>
          <div>{renderCartItem}</div>
        </div>
      </Col>
      <Col md={6} style={{ position: "relative" }}>
        <div className="item__bill">
          <div className="item__bill_title border-bottom-solid">
            CART INFORMATION
          </div>
          <div className="item__total border-bottom-solid">
            <span className="item__total_title">Total:</span>
            <span className="item__total_number">{totalAmount} $</span>
          </div>
          <div className="item__sub" onClick={() => navigate("/")}>
            You can buy more{" "}
            <ArrowRightOutlined style={{ margin: "0px 4px" }} />
          </div>
          <div className="item__btn_group">
            <div className="item__btn" onClick={checkoutsHandler}>
              CHECKOUTS
            </div>
          </div>
        </div>
      </Col>
    </Row>
  );
};

export default CartDetail;
