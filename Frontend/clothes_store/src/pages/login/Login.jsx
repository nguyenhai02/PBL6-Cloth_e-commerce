import { LockOutlined, UserOutlined } from "@ant-design/icons";
import { Button, Checkbox, Col, Form, Input, Row, Space } from "antd";
import React from "react";
import { Link } from "react-router-dom";
import "./Login.scss";
const Login = () => {
  const onFinish = (values) => {
    console.log("Received values of form: ", values);
  };
  return (
    <Row justify={"center"} className="loginPage__row">
      <Col
        md={12}
        style={{
          display: "flex",
          justifyContent: "center",
          alignItems: "center",
          borderRight: "1px solid #ccc",
        }}
        className="loginPage__col"
      >
        <Space
          direction="vertical"
          justify="center"
          align="center"
          className="mainForm"
        >
          <Form
            name="normal_login"
            className="login__form"
            initialValues={{
              remember: true,
            }}
            onFinish={onFinish}
          >
            <Form.Item
              name="username"
              rules={[
                {
                  required: true,
                  message: "Please input your Username!",
                },
              ]}
              className="form__username input-value"
            >
              <Input
                prefix={<UserOutlined className="site-form-item-icon" />}
                placeholder="Username"
                className="login__input"
              />
            </Form.Item>
            <Form.Item
              name="password"
              rules={[
                {
                  required: true,
                  message: "Please input your Password!",
                },
              ]}
              className="form__password input-value"
            >
              <Input
                prefix={<LockOutlined className="site-form-item-icon" />}
                type="password"
                placeholder="Password"
                className="login__input"
              />
            </Form.Item>
            <Form.Item>
              <Form.Item name="remember" valuePropName="" noStyle>
                <Checkbox>Remember me</Checkbox>
              </Form.Item>
            </Form.Item>

            <Form.Item>
              <Space>
                <Button
                  type="primary"
                  htmlType="submit"
                  className="login-form-button"
                >
                  Log in
                </Button>
                <span>
                  Or{" "}
                  <Link
                    to="/account/register"
                    color="#000"
                    style={{ textDecoration: "underline", color: "#000" }}
                    title="Register"
                  >
                    register now!
                  </Link>
                </span>
              </Space>
            </Form.Item>
          </Form>
        </Space>
      </Col>
      <Col md={12} className="login__col">
        <Space className="wrapper login__container">
          <span className="login__title">LOGIN NOW</span>
          <span className="login__sub">Login for better experience!</span>
        </Space>
      </Col>
    </Row>
  );
};

export default Login;
