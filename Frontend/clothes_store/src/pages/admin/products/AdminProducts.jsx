import React, { useEffect, useState } from "react";
import { Row, Col, Button, Pagination, Input, Modal, Select } from "antd";
import Item from "./Item";
import {
  getAllProducts,
  getProductByCategory,
  getProductByName,
} from "../../../api/products";
import AddProduct from "./AddProduct";
import { set } from "lodash";

const { Search } = Input;

const AdminProducts = () => {
  const [products, setProducts] = useState([]);
  const [totalProducts, setTotalProducts] = useState(0);
  const [currentPage, setCurrentPage] = useState(1);
  const [searchTerm, setSearchTerm] = useState("");
  const [selectedType, setSelectedType] = useState("all"); // New state for selected type

  const handlePageChange = (page) => {
    setCurrentPage(page);
  };

  useEffect(() => {
    const fetchProducts = async () => {
      try {
        if (searchTerm) {
          const response = await getProductByName(searchTerm, currentPage - 1);
          setProducts(response.content);
          setTotalProducts(response.totalElements);
        } else if (selectedType === "all") {
          const response = await getAllProducts(currentPage - 1);
          setProducts(response.content);
          setTotalProducts(response.totalElements);
        } else {
          const response = await getProductByCategory(
            selectedType,
            currentPage - 1,
            6,
            "name,asc"
          );
          setProducts(response.content);
          setTotalProducts(response.totalElements);
        }
      } catch (error) {
        console.error(error); // Log the error for debugging
      }
    };
    fetchProducts();
  }, [currentPage, selectedType, searchTerm]); // Add searchTerm to the dependency array

  const onSearch = (value, _e, info) => {
    setSearchTerm(value);
    setCurrentPage(1);
  };

  const handleChange = (value) => {
    setSelectedType(value);
    setCurrentPage(1); // Reset currentPage to 1 when selectedType changes
  };

  const [isModalOpen, setIsModalOpen] = useState(false);
  const showModal = () => {
    setIsModalOpen(true);
  };
  const handleOk = () => {
    setIsModalOpen(false);
  };

  const filteredProducts =
    products &&
    products.filter((product) =>
      product?.product.name.toLowerCase().includes(searchTerm.toLowerCase())
    );

  return (
    <div style={{ marginTop: 40, overflowX: "hidden" }}>
      <Col
        span={24}
        style={{
          marginTop: 25,
          display: "flex",
          justifyContent: "center",
          fontWeight: 700,
          fontSize: 30,
        }}
      >
        DANH SÁCH SẢN PHẨM
      </Col>

      <Row>
        <Col span={8}>
          <div>
            <Button
              type="primary"
              onClick={showModal}
              style={{ marginBottom: 16, marginTop: 16 }}
            >
              THÊM SẢN PHẨM MỚI
            </Button>
          </div>
          <Modal
            title="Thêm sản phẩm mới"
            open={isModalOpen}
            centered
            closable={false}
            footer={[
              <Button key="submit" type="ghost" onClick={handleOk}>
                Đóng
              </Button>,
            ]}
          >
            <AddProduct />
          </Modal>
        </Col>
        <Col span={8} style={{ display: "flex", justifyContent: "center" }}>
          <Select
            defaultValue="all"
            style={{
              width: 120,
              display: "flex",
              justifyContent: "center",
              flexDirection: "column",
            }}
            onChange={handleChange}
            options={[
              {
                value: "all",
                label: "Tất cả",
              },
              {
                value: "shirt",
                label: "Áo",
              },
              {
                value: "pants",
                label: "Quần",
              },
              {
                value: "accessories",
                label: "Phụ kiện",
              },
              {
                value: "other",
                label: "Khác",
              },
            ]}
          />
        </Col>
        <Col
          span={8}
          style={{
            display: "flex",
            justifyContent: "flex-end",
            marginTop: 16,
            marginBottom: 16,
          }}
        >
          <Search
            placeholder="Nhập tên sản phẩm"
            allowClear
            onSearch={onSearch}
            style={{
              width: 200,
            }}
          />
        </Col>
      </Row>

      <Row gutter={15}>
        {products &&
          filteredProducts.map((product) => (
            <Col
              span={8}
              key={product.id}
              style={{
                display: "flex",
                justifyContent: "center",
                marginTop: 15,
              }}
            >
              <Item product={product} />
            </Col>
          ))}
      </Row>

      <Row
        style={{ marginTop: 20, display: "flex", justifyContent: "flex-end" }}
      >
        <Pagination
          showSizeChanger={false}
          current={currentPage}
          pageSize={6}
          total={totalProducts}
          onChange={handlePageChange}
        />
      </Row>
      <div
        style={{
          marginTop: 20,
          padding: 20,
          backgroundColor: "#f0f0f0",
          textAlign: "center",
        }}
      >
        © 2023 by hair. Clothes store
      </div>
    </div>
  );
};
export default AdminProducts;
