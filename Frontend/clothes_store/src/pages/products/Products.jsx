import { Row, Select, Space, theme } from "antd";
import Sider from "antd/es/layout/Sider";
import { Content } from "antd/es/layout/layout";
import React, { useEffect, useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import Product from "../../components/product/Product";
import SideBar from "../../components/sidebar/SideMenu";
import { productsAction } from "../../stores/products/product-slice";
import LoadingPage from "../loading/LoadingPage";
const Products = (props) => {
  const dispatch = useDispatch();
  const { products, loading } = useSelector((state) => state.products);
  const [productSort, setProductSort] = useState([]);
  useEffect(() => {
    dispatch(productsAction.getAllProduct());
  }, [dispatch]);
  useEffect(() => {
    setProductSort(products);
  }, [products]);

  const {
    token: { colorBgContainer },
  } = theme.useToken();

  const renderProducts = productSort?.map((product, index) => {
    return <Product key={product.id} product={product} />;
  });
  const onSelectedKeyHandler = (e) => {
    let res = [];
    const newArr = [...products];
    switch (e) {
      case "none":
        setProductSort(products);
        break;
      case "sortAZ":
        res = newArr.sort((a, b) =>
          a.title.toLowerCase().localeCompare(b.title.toLowerCase())
        );
        setProductSort(res);
        break;
      case "sortZA":
        res = newArr.sort((a, b) =>
          b.title.toLowerCase().localeCompare(a.title.toLowerCase())
        );
        setProductSort(res);
        break;
      case "Decrease":
        res = newArr.sort((a, b) => b.price - a.price);
        setProductSort(res);
        break;
      case "Increase":
        res = newArr.sort((a, b) => a.price - b.price);
        setProductSort(res);
        break;
      default:
        break;
    }
  };

  return (
    <>
      <Sider
        width={"256px"}
        style={{
          background: colorBgContainer,
        }}
        className="sidebox"
      >
        <SideBar />
      </Sider>
      <Content
        style={{
          padding: "0 24px",
          minHeight: 280,
          marginTop: 30,
        }}
      >
        <Space style={{ float: "right", padding: "0px 16px" }}>
          <Select
            defaultValue="none"
            style={{
              width: 120,
            }}
            onChange={onSelectedKeyHandler}
            options={[
              {
                value: "none",
                label: "Sort",
              },
              {
                value: "sortAZ",
                label: "A-Z",
              },
              {
                value: "sortZA",
                label: "Z-A",
              },
              {
                value: "Decrease",
                label: "Decrease",
              },
              {
                value: "Increase",
                label: "Increase",
              },
            ]}
          />
        </Space>
        <Space style={{ marginTop: 32 }}>
          {loading ? <LoadingPage /> : <Row gutter={16}>{renderProducts}</Row>}
          {/* {console.log(products)} */}
        </Space>
      </Content>
    </>
  );
};

export default Products;
