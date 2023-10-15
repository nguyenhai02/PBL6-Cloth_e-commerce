import { MinusOutlined, PlusOutlined } from "@ant-design/icons";
import { Col, Form, Image, InputNumber, Row, Space } from "antd";
import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import { getDetailProduct } from "../../api/products/GetAll";
import "./Detail.scss";
import { useDispatch } from "react-redux";
import { addToCart } from "../../stores/cart/cart-slice";
const Detail = (props) => {
  const { idProduct } = useParams();
  const [product, setProduct] = useState();
  const [mainImage, setMainImage] = useState();
  const [size, setSize] = useState("S");
  const [quantity, setQuantity] = useState(1);
  const [form] = Form.useForm();
  const dispatch = useDispatch();
  useEffect(() => {
    const _getDetailProduct = async () => {
      const res = await getDetailProduct(idProduct);
      setProduct(res);
      setMainImage(res.images[res.images.length - 1]);
    };
    _getDetailProduct();
    return () => {};
  }, [idProduct]);

  const onSizeSelectHandler = (e) => {
    const selectedSize = document.querySelector(".selected-size");
    selectedSize.classList.remove("selected-size");
    e.target.classList.add("selected-size");
    setSize(e.target.innerHTML.toString());
  };
  const addToCartHandler = () => {
    const item = {
      ...product,
      size: size,
      quantity: quantity,
    };
    dispatch(addToCart(item));
  };
  const changeQuantityHandler = (e) => {
    setQuantity(e);
  };
  const renderImage = product?.images.map((image, index) => {
    return (
      <Space
        className={image === mainImage ? "clothes__selected" : ""}
        key={index}
      >
        <Image
          preview={false}
          width={64}
          src={image}
          onClick={() => setMainImage(image)}
          style={{ cursor: "pointer" }}
        />
      </Space>
    );
  });
  return (
    <Row gutter={16} style={{ marginTop: 64 }}>
      <Col md={4} style={{ position: "relative" }}>
        <Space className="image__box">{renderImage}</Space>
      </Col>
      <Col md={10}>
        <Space className="image__main">
          <Image height={700} src={mainImage} preview={false} />
        </Space>
      </Col>
      <Col md={10} style={{ position: "relative" }}>
        <Space className="product__information" direction="vertical">
          <div className="product__name ">{product?.title.toUpperCase()}</div>
          <div className="product__id border-bot-dashed">ID: {product?.id}</div>
          <div className="product__price border-bot-dashed">
            {product?.price} $
          </div>
          <div>Size:</div>
          <Space className="product__size border-bot-dashed">
            <div
              className="size__option selected-size"
              onClick={onSizeSelectHandler}
            >
              S
            </div>
            <div className="size__option" onClick={onSizeSelectHandler}>
              M
            </div>
            <div className="size__option" onClick={onSizeSelectHandler}>
              L
            </div>
          </Space>
          <div>Quantity:</div>
          <Space.Compact className="product__quantity border-bot-dashed" block>
            <Form form={form}>
              <InputNumber
                min={1}
                keyboard={true}
                defaultValue={1}
                controls={{
                  upIcon: <PlusOutlined />,
                  downIcon: <MinusOutlined />,
                }}
                size="large"
                onChange={changeQuantityHandler}
                className="inputNumber"
              />
            </Form>
          </Space.Compact>
          <Space className="btn">
            <div className="btn__cart btn__normal" onClick={addToCartHandler}>
              Add to cart
            </div>
            <div className="btn__buy btn__normal">Buy now</div>
          </Space>
        </Space>
      </Col>
    </Row>
  );
};

export default Detail;
// brand: "Soft Cotton";
// category: "tops";
// description: "PACK OF 3 CAMISOLES ,VERY COMFORTABLE SOFT COTTON STUFF, COMFORTABLE IN ALL FOUR SEASONS";
// discountPercentage: 12.05;
// id: 37;
// images: (5)[
//   ("https://i.dummyjson.com/data/products/37/1.jpg",
//   "https://i.dummyjson.com/data/products/37/2.jpg",
//   "https://i.dummyjson.com/data/products/37/3.jpg",
//   "https://i.dummyjson.com/data/products/37/4.jpg",
//   "https://i.dummyjson.com/data/products/37/thumbnail.jpg")
// ];
// price: 50;
// rating: 4.52;
// stock: 107;
// thumbnail: "https://i.dummyjson.com/data/products/37/thumbnail.jpg";
// title: "ank Tops for Womens/Girls";
