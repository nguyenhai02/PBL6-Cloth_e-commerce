import { Form, Space } from "antd";
import Search from "antd/es/input/Search";
import React, { useEffect, useState } from "react";
import "./SearchForm.scss";
import { searchProduct } from "../../api/products";
import SearchItem from "./SearchItem";
const SearchForm = () => {
  const [form] = Form.useForm();
  const [searchTerm, setSearchTerm] = useState("");
  const [products, setProducts] = useState([]);

  const onSearch = (value) => {
    setSearchTerm(value);
  };

  useEffect(() => {
    const getSearchProduct = async () => {
      try {
        const response = await searchProduct(searchTerm);
        setProducts(response);
      } catch (error) {
        console.error(error);
      }
    };
    if (searchTerm) {
      getSearchProduct();
    } else {
      setProducts([]);
    }
  }, [searchTerm]);

  useEffect(() => {
    console.log("product >>", products);
  }, [products]);

  return (
    <div className="search__wrapper">
      <p className="search__title">Search</p>
      <Form form={form}>
        <Form.Item name="Search">
          <Search
            className="search__input"
            placeholder="Search..."
            onSearch={onSearch}
            allowClear
          />
        </Form.Item>
      </Form>
      <Space
        className="search__item search__item--scrollable"
        direction="vertical"
      >
        {products.map((product, index) => (
          <SearchItem key={index} product={product} />
        ))}
      </Space>
    </div>
  );
};

export default SearchForm;
