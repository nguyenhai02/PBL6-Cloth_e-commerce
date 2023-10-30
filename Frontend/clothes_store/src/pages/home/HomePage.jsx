import { Layout, Row, theme } from "antd";
import { Content, Footer } from "antd/es/layout/layout";
import React, { useEffect } from "react";
import Banner from "../../components/banner/Banner";
import CardItem from "../../components/card/CardItem";
import HeaderPage from "../../components/header/HeaderPage";
import Introductions from "../../components/introductions/Introductions";
import "./HomePage.scss";
const HomePage = () => {
  useEffect(() => {
    document.title = "Clothes Store";
  }, []);

  const {
    token: { colorBgContainer },
  } = theme.useToken();
  const imageCard = {
    TOPS: "https://file.hstatic.net/200000018774/file/dsc01790_copy_0a70f83d4c5d4bcbbbe53c6f3bccc01e.jpg",
    BOTTOMS:
      "https://file.hstatic.net/200000018774/file/dsc01767_copy_7e45479323c5457289cf021508babd9c.jpg",
    ACCESSORIES:
      "https://file.hstatic.net/200000018774/file/dsc01736_copy_f57d47f60ff04864ae5f61ab9624e270.jpg",
  };

  const entries = Object.entries(imageCard);
  const renderCart = entries.map(([key, value], index) => {
    return <CardItem key={index} src={value} title={key} />;
  });

  return (
    <Layout className="layout" style={{ position: "relative" }}>
      <HeaderPage />
      <Content>
        <div
          className="site-layout-content"
          style={{
            background: colorBgContainer,
          }}
        >
          <Banner />
        </div>
        <div className="products">
          <p>PRODUCTS</p>
        </div>
        <div style={{ margin: "64px 24px", position: "relative" }}>
          <Row gutter={18}>{renderCart}</Row>
        </div>
        <Introductions />
      </Content>
      <Footer
        style={{
          textAlign: "center",
        }}
      >
        Copyright © 2023
      </Footer>
    </Layout>
  );
};

export default HomePage;
