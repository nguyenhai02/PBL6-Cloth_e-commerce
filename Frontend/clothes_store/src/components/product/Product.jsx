import { Col, Image, Space, Typography } from "antd";
import React from "react";
import "./Product.scss";
import { useNavigate } from "react-router-dom";
import { useDispatch } from "react-redux";
import { addToCart } from "../../stores/cart/cart-slice";
const { Text } = Typography;
const Product = (props) => {
  const navigate = useNavigate();
  const dispatch = useDispatch();
  const buyNowHandler = () => {
    dispatch(addToCart({ ...product, quantity: 1, size: "S" }));
  };
  const detailHandler = (id) => {
    navigate(`/products/${id}`);
  };
  const product = props?.product.product;
  return (
    <Col xs={12} md={8}>
      <Space
        className="product"
        direction="vertical"
        style={{
          height: 525,
          display: "flex",
          justifyContent: "space-between",
        }}
        align="center"
        justify="space-between"
        onClick={() => detailHandler(product?.id)}
      >
        <Space className="" style={{ position: "relative", width: 243 }}>
          <Image
            width={243}
            src={product?.image}
            preview={false}
            className="product__image"
            style={{ objectFit: "contain" }}
            height={295}
          />
        </Space>

        <Space className="product__infor" direction="vertical" align="center">
          <Text className="product__title font-Mont">{product?.name}</Text>
          <Text className="product__price font-Mont" strong>
            {product?.price} VNĐ
          </Text>
        </Space>
      </Space>
      <div className="buy">
        <div
          className="buy__now buy-product__btn"
          title="Buy now"
          onClick={() => buyNowHandler()}
        >
          Buy Now
        </div>
        <div
          className="buy__detail buy-product__btn"
          title="Detail"
          onClick={() => detailHandler(product?.id)}
        >
          Detail
        </div>
      </div>
    </Col>
  );
};

export default Product;
