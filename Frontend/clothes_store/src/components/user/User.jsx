import { Avatar, Col, Form, Image, Input, Row, Select, Space } from "antd";
import { Option } from "antd/es/mentions";
import React, { useEffect, useState } from "react";
import "./User.scss";
import { useNavigate } from "react-router-dom";
const url =
  "https://gw.alipayobjects.com/zos/rmsportal/KDpgvguMpGfqaHPjicRK.svg";
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
        src={<Image src={url} alt="Avatar"></Image>}
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
// //{
//   "id": 15,
//   "username": "kminchelle",
//   "email": "kminchelle@qq.com",
//   "firstName": "Jeanne",
//   "lastName": "Halvorson",
//   "gender": "female",
//   "image": "https://robohash.org/autquiaut.png?size=50x50&set=set1",
//   "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoia21pbmNoZWxsZSIsImVtYWlsIjoia21pbmNoZWxsZUBxcS5jb20iLCJmaXJzdE5hbWUiOiJKZWFubmUiLCJsYXN0TmFtZSI6IkhhbHZvcnNvbiIsImdlbmRlciI6ImZlbWFsZSIsImltYWdlIjoiaHR0cHM6Ly9yb2JvaGFzaC5vcmcvYXV0cXVpYXV0LnBuZz9zaXplPTUweDUwJnNldD1zZXQxIiwiaWF0IjoxNjM1NzczOTYyLCJleHAiOjE2MzU3Nzc1NjJ9.n9PQX8w8ocKo0dMCw3g8bKhjB8Wo7f7IONFBDqfxKhs"
// }
