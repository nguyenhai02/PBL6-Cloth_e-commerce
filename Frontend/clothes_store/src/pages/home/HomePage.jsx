import { Layout, Row, theme, Card, Col } from "antd";
import { Content, Footer } from "antd/es/layout/layout";
import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router";
import Banner from "../../components/banner/Banner";
import CardItem from "../../components/card/CardItem";
import HeaderPage from "../../components/header/HeaderPage";
import Introductions from "../../components/introductions/Introductions";
import "./HomePage.scss";
import botImg from "../../assets/images/bot-img.jpg";
import topImg from "../../assets/images/top-img.jpg";
import pkImg from "../../assets/images/pk-img.jpg";
import { getProductBestSeller } from "../../api/products";
const { Meta } = Card;

const HomePage = () => {
  const navigate = useNavigate();
  const [bestSellers, setBestSellers] = useState([]);

  useEffect(() => {
    const fetchBestSellers = async () => {
      try {
        const response = await getProductBestSeller();
        setBestSellers(response || []);
      } catch (error) {
        console.error("Error fetching best sellers:", error);
      }
    };
    fetchBestSellers();
  }, []);

  console.log(bestSellers);

  const renderBestSellers = bestSellers.slice(0, 5).map((product) => (
    <Col key={product.id} span={5.8}>
      <Card
        hoverable
        style={{ width: 240 }}
        cover={<img alt={product.name} src={product.image} />}
        onClick={() => navigate(`/products/${product.id}`)}
      >
        <Meta
          title={product.name}
          description={`Sold: ${product.sellQuantity}`}
        />
      </Card>
    </Col>
  ));

  useEffect(() => {
    document.title = "Clothes Store";
  }, []);

  const {
    token: { colorBgContainer },
  } = theme.useToken();
  const imageCard = {
    SHIRT: topImg,
    PANTS: pkImg,
    ACCESSORIES: botImg,
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
          <div className="products" style={{ marginTop: 20 }}>
            <span
              onClick={() => navigate("/collections/all")}
              style={{ cursor: "pointer" }}
            >
              PRODUCTS
            </span>
          </div>
        </div>
        <div style={{ margin: "24px 24px", position: "relative" }}>
          <Row gutter={18}>{renderCart}</Row>
        </div>
        <div className="products">
          <div className="products">TRENDING</div>
        </div>

        <Row
          gutter={36}
          justify="center"
          style={{ paddingTop: 24, paddingBottom: 24 }}
        >
          {renderBestSellers}
        </Row>
        <Introductions />
        <iframe
          src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3837.459888523149!2d108.3468685011478!3d15.884959884768097!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31420dc5c25a734d%3A0x6c1dc07344a7d03d!2zMjQ5IEPhu61hIMSQ4bqhaSwgQ-G6qW0gQ2jDonUsIEjhu5lpIEFuLCBRdeG6o25nIE5hbSwgVmnhu4d0IE5hbQ!5e0!3m2!1svi!2s!4v1699358307162!5m2!1svi!2s"
          width="100%"
          height="450"
          style={{ border: 0 }}
          allowfullscreen=""
          loading="lazy"
          referrerpolicy="no-referrer-when-downgrade"
        ></iframe>
      </Content>
      <Footer
        style={{
          textAlign: "center",
        }}
      >
        Hair 2023
      </Footer>
    </Layout>
  );
};

export default HomePage;
