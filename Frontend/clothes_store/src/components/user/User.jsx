import { Avatar, Col, Form, Image, Input, Row, Select, Space } from "antd";
import { Option } from "antd/es/mentions";
import React, { useEffect, useState } from "react";
import "./User.scss";
import { useNavigate } from "react-router-dom";
import login from "../../assets/images/login.jpg"
const User = (props) => {
  const [form] = Form.useForm();
  const [isLogin, setIsLogin] = useState(false);
  const navigate = useNavigate();
  useEffect(() => {
    const user = localStorage.getItem("token");
    if (user) {
      setIsLogin(true);
    }
  }, []);
  const onLoginHandler = () => {
    if (props.onLogin) {
      navigate("/account/login");
    } else {
      props?.drawer(false);
      navigate("/account/login");
    }
  };
  return (
    <Space className="infor">
      {isLogin ? (
        <p className="infor__title">User Information</p>
      ) : (
        <p className="infor__title">Login</p>
      )}

      <Avatar
        size={{
          xs: 24,
          sm: 32,
          md: 40,
          lg: 64,
          xl: 80,
          xxl: 100,
        }}
        src={<Image src={login} alt="Avatar" className="login-icon"></Image>}
        className="infor__avatar"
      />
      {isLogin ? (
        <Space className="infor__container">
          <Form form={form}>
            <Form.Item name="userName">
              <Input placeholder="UserName" />
            </Form.Item>
            <Row gutter={16}>
              <Col>
                <Form.Item name="fullName">
                  <Input placeholder="FullName" />
                </Form.Item>
              </Col>
              <Col>
                <Select name="gender" defaultValue={"male"}>
                  <Option key="male">Male</Option>
                </Select>
              </Col>
            </Row>
            <Form.Item name="email">
              <Input placeholder="email" />
            </Form.Item>
          </Form>
        </Space>
      ) : (
        <>
          <p>Please login to order and ...</p>
          <div
            className="cart__btn_w"
            style={{ margin: 0 }}
            onClick={onLoginHandler}
          >
            Login
          </div>
        </>
      )}
    </Space>
  );
};

export default User;
