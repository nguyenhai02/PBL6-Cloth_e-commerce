import React from "react";
import { EditOutlined, EllipsisOutlined } from "@ant-design/icons";
import { Card, Space, Image } from "antd";
import "./Item.scss";

const { Meta } = Card;

const Item = (props) => {
  const product = props?.product.product;
  const productVariants = props?.product.productVariants;
  const totalQuantity = productVariants.reduce(
    (total, variant) => total + variant.quantity,
    0
  );

  return (
    <Space>
      <Card
        className="card_container"
        cover={
          <div className="card_container-image">
            <Image
              width={300}
              height={295}
              src={product?.image}
              preview={true}
              className="product__image"
              style={{
                objectFit: "cover",
              }}
            />
          </div>
        }
        actions={[
          <EditOutlined key="edit" />,
          <EllipsisOutlined key="ellipsis" />,
        ]}
      >
        <Meta title={product.name} />
        <Meta description={product.description} style={{ paddingTop: 5 }} />
        <Meta
          description={"Giá: " + product.price.toLocaleString("vi-VN") + " VNĐ"}
          style={{ paddingTop: 5 }}
        />
        <Meta description={"Kho: " + totalQuantity} style={{ paddingTop: 5 }} />
      </Card>
    </Space>
  );
};
export default Item;
