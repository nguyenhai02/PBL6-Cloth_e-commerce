import { Pagination, Row, Select, Space, theme } from "antd";
import Sider from "antd/es/layout/Sider";
import { Content } from "antd/es/layout/layout";
import React, { useEffect, useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import Product from "../../components/product/Product";
import SideBar from "../../components/sidebar/SideMenu";
import {
  getAllProduct,
  getAllProductByCategory,
} from "../../stores/products/product-slice";
import LoadingPage from "../loading/LoadingPage";
import { useLocation } from "react-router-dom";
import { get } from "lodash";
import { ArrowDownOutlined, ArrowUpOutlined } from "@ant-design/icons";
const Products = (props) => {
  const dispatch = useDispatch();
  const { products, loading } = useSelector((state) => state.products);
  const [currentCategory, setCurrentCategory] = useState("");
  const [currentPage, setCurrentPage] = useState(1); // new line
  const [total, setTotal] = useState(0); // Add this line

  const location = useLocation();
  useEffect(() => {
    const endpoint = location.pathname.split("/")[2];

    if (endpoint !== currentCategory) {
      setCurrentPage(1);
      setCurrentCategory(endpoint);
    }

    if (endpoint === "all") {
      dispatch(getAllProduct({ page: currentPage - 1 })).then((response) => {
        setTotal(response.payload.totalElements);
      });
    } else {
      dispatch(
        getAllProductByCategory({ category: endpoint, page: currentPage - 1 })
      ).then((response) => {
        setTotal(response.payload.totalElements);
      });
    }
  }, [dispatch, currentPage, location, currentCategory]);

  const {
    token: { colorBgContainer },
  } = theme.useToken();

  const renderProducts = products?.map((product, index) => {
    return <Product key={product.id} product={product} />;
  });

  const handlePageChange = (page) => {
    setCurrentPage(page);
  };

  const onSelectedKeyHandler = (e) => {
    let sortParam = "";
    switch (e) {
      case "none":
        sortParam = "";
        break;
      case "sortAZ":
        sortParam = "name,asc";
        break;
      case "sortZA":
        sortParam = "name,desc";
        break;
      case "Decrease":
        sortParam = "price,desc";
        break;
      case "Increase":
        sortParam = "price,asc";
        break;
      default:
        break;
    }
    dispatch(
      getAllProductByCategory({
        // page: currentPage - 1,
        sort: sortParam,
        category: location.pathname.split("/")[2],
      })
    );
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
                label: "Default",
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
                label: (
                  <Space>
                    <ArrowDownOutlined /> Price
                  </Space>
                ),
              },
              {
                value: "Increase",
                label: (
                  <Space>
                    <ArrowUpOutlined /> Price
                  </Space>
                ),
              },
            ]}
          />
        </Space>
        <Space style={{ marginTop: 32 }}>
          {loading ? (
            <div>
              <LoadingPage />
            </div>
          ) : (
            <>
              {products && products.length > 0 ? (
                <Row gutter={16}>{renderProducts}</Row>
              ) : (
                <div style={{ fontWeight: "bold" }}>
                  <h1>CHƯA CÓ SẢN PHẨM NÀO</h1>
                </div>
              )}
            </>
          )}
        </Space>
        <Row style={{ display: "flex", justifyContent: "flex-end" }}>
          <Pagination
            showSizeChanger={false}
            current={currentPage}
            pageSize={6}
            total={total}
            onChange={handlePageChange}
          />
        </Row>
      </Content>
    </>
  );
};

export default Products;
