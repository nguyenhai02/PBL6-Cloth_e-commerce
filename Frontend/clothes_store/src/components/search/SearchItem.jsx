import { Image, Space } from "antd";
import React from "react";
import { useNavigate } from "react-router-dom";
import "./SearchItem.scss";
const SearchItem = (props) => {
  const navigate = useNavigate();

  const handleClick = () => {
    navigate(`/products/${props.product.product.id}`);
  };

  return (
    <Space
      style={{ margin: "8px 0", position: "relative" }}
      onClick={handleClick}
    >
      <Space>
        <Image src={props?.product.product.image} width={64}></Image>
        <Space className="clothes wrapper" style={{ alignItems: "flex-start" }}>
          <div className="clothes__name" style={{ cursor: "pointer" }}>
            {props?.product.product.name}
          </div>
          <span
            className="clothes__size"
            style={{ color: "#333", fontSize: 12, fontWeight: "bold" }}
          ></span>
          <Space>
            <span
              className="clothes__price"
              style={{ color: "#333", fontSize: 12 }}
            >
              {props?.product.product.price.toLocaleString("vi-VN")} VNĐ
            </span>
          </Space>
        </Space>
      </Space>
    </Space>
  );
};

export default SearchItem;
