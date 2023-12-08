import React, { useEffect, useState } from "react";
import { Row, Col, Button, Pagination, Input, Modal } from "antd";
import Item from "./Item";
import { getAllProducts } from "../../../api/products";
import AddProduct from "./AddProduct";

const { Search } = Input;

const AdminProducts = () => {
  const [products, setProducts] = useState([]);
  const [totalProducts, setTotalProducts] = useState(0);
  const [currentPage, setCurrentPage] = useState(1);

  const handlePageChange = (page) => {
    setCurrentPage(page);
  };

  useEffect(() => {
    const fetchProducts = async () => {
      const response = await getAllProducts(currentPage - 1);
      const data = response;
      setProducts(data.content);
      setTotalProducts(data.totalElements);
    };
    fetchProducts();
  }, [currentPage]);

  const onSearch = (value, _e, info) => console.log(info?.source, value);

  const [isModalOpen, setIsModalOpen] = useState(false);
  const showModal = () => {
    setIsModalOpen(true);
  };
  const handleOk = () => {
    setIsModalOpen(false);
  };

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
        <Col span={6}>
          <Button
            type="primary"
            onClick={showModal}
            style={{ marginBottom: 16 }}
          >
            THÊM SẢN PHẨM MỚI
          </Button>
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
        <Col
          span={6}
          offset={12}
          style={{ display: "flex", justifyContent: "flex-end" }}
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
        {products.map((product) => (
          <Col
            span={8}
            key={product.id}
            style={{ display: "flex", justifyContent: "center", marginTop: 15 }}
          >
            <Item product={product} />
          </Col>
        ))}
      </Row>
      <Row
        style={{ marginTop: 20, display: "flex", justifyContent: "flex-end" }}
      >
        <Pagination
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
