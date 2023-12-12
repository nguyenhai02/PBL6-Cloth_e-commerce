import React from "react";
import CountUp from "react-countup";
import { Col, Row, Statistic } from "antd";

const formatter = (value) => <CountUp end={value} separator="," />;

const AdminPage = () => {
  return (
    <Row gutter={16} style={{ marginTop: 50 }}>
      <Col span={12}>
        <Statistic title="Số thành viên" value={54} formatter={formatter} />
      </Col>
      <Col span={12}>
        <Statistic
          title="Doanh số bán được"
          value={112893000}
          precision={2}
          formatter={formatter}
        />
      </Col>
    </Row>
  );
};

export default AdminPage;
