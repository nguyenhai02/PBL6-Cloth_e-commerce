import React, { useState } from "react";
import {
  DesktopOutlined,
  FileOutlined,
  HomeOutlined,
  TeamOutlined,
  UserOutlined,
} from "@ant-design/icons";
import { Layout, Menu, theme } from "antd";
import Authenticate from "../../guards/Authenticate";
import AdminHeader from "../../components/header/AdminHeader";
import { Route, Routes, useNavigate } from "react-router-dom";
import AdminLayout from "./layout/AdminLayout";
const { Content, Sider } = Layout;
// function getItem(label, key, icon, children) {
//   return {
//     key,
//     icon,
//     children,
//     label,
//   };
// }
// const items = [
//   getItem("Home", "/admin", <HomeOutlined />),
//   getItem("Option 2", "/admin/option", <DesktopOutlined />),
//   getItem("User", "sub1", <UserOutlined />, [
//     getItem("Tom", "3"),
//     getItem("Bill", "4"),
//     getItem("Alex", "5"),
//   ]),
//   getItem("Team", "sub2", <TeamOutlined />, [
//     getItem("Team 1", "6"),
//     getItem("Team 2", "8"),
//   ]),
//   getItem("Files", "9", <FileOutlined />),
// ];
const AdminPage = () => {
  const navigate = useNavigate();
  const [collapsed, setCollapsed] = useState(false);
  const {
    token: { colorBgContainer },
  } = theme.useToken();
  return (
    <Authenticate>
      {/* <Layout
        style={{
          minHeight: "100vh",
        }}
      >
        <Sider
          collapsible
          collapsed={collapsed}
          onCollapse={(value) => setCollapsed(value)}
        >
          <div className="demo-logo-vertical" />
          <Menu
            theme="dark"
            defaultSelectedKeys={["/"]}
            mode="inline"
            items={items}
            style={{ marginTop: 59.6, paddingTop: 0 }}
            onClick={(item) => navigate(item.key)}
          />
        </Sider>
        <Layout>
          <Content
            style={{
              margin: "0 16px",
            }}
          >
            <div
              style={{
                padding: 0,
                minHeight: 360,
                background: colorBgContainer,
              }}
            >
              <Routes>
                <Route path="/admin" element={<div>Home</div>}>
                  <Route path="option" element={<div>Option 2</div>} />
             
                </Route>
              </Routes>
            </div>
          </Content>
        </Layout>
      </Layout> */}
      123
    </Authenticate>
  );
};

export default AdminPage;
