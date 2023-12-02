// AdminLayout.jsx
import React from "react";
import { Layout, theme } from "antd";
import { Outlet } from "react-router-dom";
import AdminHeader from "../../components/header/AdminHeader";

const { Content } = Layout;

const AdminLayout = () => {
  const {
    token: { colorBgContainer },
  } = theme.useToken();

  return (
    <Layout>
      <AdminHeader />
      <Content style={{ margin: "0 16px" }}>
        <div
          style={{ padding: 0, minHeight: 360, background: colorBgContainer }}
        >
          <Outlet />
        </div>
      </Content>
    </Layout>
  );
};

export default AdminLayout;
