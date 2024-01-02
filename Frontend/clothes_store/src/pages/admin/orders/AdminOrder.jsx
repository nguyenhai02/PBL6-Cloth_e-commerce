import React from "react";
import { useState, useEffect } from "react";
import { Space, DatePicker, Button, Table, Select, Image } from "antd";
import { getAllOrdersAdmin } from "../../../api/managements";
import { updateStatusOrder } from "../../../api/orders";
import "./AdminOrder.scss";
const { RangePicker } = DatePicker;
const { Option } = Select;

const AdminOrder = () => {
  const [orders, setOrders] = useState([]);
  const [fullOrders, setFullOrders] = useState([]);
  const [dateRange, setDateRange] = useState([]);
  const [startDate, setStartDate] = useState("");
  const [endDate, setEndDate] = useState("");

  const convertStatus = (status) => {
    switch (status) {
      case "COMPLETE":
        return "Đã thanh toán";
      case "UN-COMPLETE":
        return "Chưa thanh toán";
      case "CANCELLED":
        return "Đã hủy";
      default:
        return status;
    }
  };

  const handleStatusChange = async (orderId, newStatus) => {
    let id = orderId.slice(2);
    let status = "";
    if (newStatus === "Đã thanh toán") {
      status = "COMPLETE";
    } else if (newStatus === "Chưa thanh toán") {
      status = "UN-COMPLETE";
    } else {
      status = "CANCELLED";
    }
    try {
      const response = await updateStatusOrder(id, status);
      window.location.reload();
    } catch (error) {
      console.error("Error updating order status:", error);
    }

    const updatedOrders = orders.map((order) => {
      if (order.id === orderId) {
        return { ...order, status: newStatus };
      }
      return order;
    });
    setOrders(updatedOrders);
  };

  useEffect(() => {
    const fetchOrders = async () => {
      try {
        const response = await getAllOrdersAdmin();
        setOrders(response);
        setFullOrders(response);
      } catch (error) {
        console.error("Error fetching orders:", error);
      }
    };
    fetchOrders();
  }, []);

  const columns = [
    {
      title: "Số thứ tự",
      dataIndex: "index",
      sorter: (a, b) => a.index - b.index,
    },
    {
      title: "ID",
      dataIndex: "id",
    },
    {
      title: "Ngày đặt hàng",
      dataIndex: "orderDate",
      render: (orderDate) => new Date(orderDate).toLocaleDateString("vi-VN"),
    },
    {
      title: "Tên",
      dataIndex: "name",
    },
    {
      title: "Email",
      dataIndex: "email",
    },
    {
      title: "Địa chỉ giao hàng",
      dataIndex: "address",
    },
    {
      title: "Số điện thoại",
      dataIndex: "phone",
    },
    {
      title: "Số tiền (VNĐ)",
      dataIndex: "amountPayed",
      render: (amountPayed) => amountPayed.toLocaleString("vi-VN"),
    },
    {
      title: "Phương thức thanh toán",
      dataIndex: "paymentMethod",
      render: (paymentMethod) => {
        if (paymentMethod === "COD") {
          return "Thanh toán khi nhận hàng";
        }
        return "Thanh toán online";
      },
    },
    {
      title: "Trạng thái",
      dataIndex: "status",
      width: 180,
      render: (status, record) => {
        if (status === "COMPLETE") {
          return <span style={{ color: "green" }}>Đã thanh toán</span>;
        }
        if (status === "CANCELLED") {
          return <span style={{ color: "red" }}>Đã hủy</span>;
        }
        return (
          <Select
            defaultValue={convertStatus(status)}
            style={{ width: 150 }}
            onChange={(newStatus) => handleStatusChange(record.id, newStatus)}
          >
            <Option value="Đã thanh toán">
              <span style={{ color: "green" }}>Đã thanh toán</span>
            </Option>
            <Option value="Chưa thanh toán">
              <span style={{ color: "orange" }}>Chưa thanh toán</span>
            </Option>
            <Option value="Đã hủy">
              <span style={{ color: "red" }}>Đã hủy</span>
            </Option>
          </Select>
        );
      },
    },
  ];

  const data = [];
  for (let i = 1; i < orders.length + 1; i++) {
    data.push({
      key: orders[i - 1].order.id,
      index: i,
      id: `DH${orders[i - 1].order.id}`,
      name: orders[i - 1].order.user.name,
      email: orders[i - 1].order.user.email,
      address: orders[i - 1].order.addressDelivery,
      phone: orders[i - 1].order.user.phone,
      amountPayed: orders[i - 1].order.totalPrice,
      orderDate: orders[i - 1].order.orderDate,
      status: orders[i - 1].order.status,
      orderItems: orders[i - 1].orderItems,
      paymentMethod: orders[i - 1].order.paymentMethod,
    });
  }

  const expandedRowRender = (record) => {
    const columns = [
      {
        title: "Hình ảnh",
        dataIndex: "image",
        key: "image",
        render: (image) => <Image src={image} width={40} height={40} />,
      },
      {
        title: "Tên sản phẩm",
        dataIndex: "name",
        key: "name",
      },
      {
        title: "Kích cỡ",
        dataIndex: "size",
        key: "size",
      },
      {
        title: "Màu sắc",
        dataIndex: "color",
        key: "color",
      },
      {
        title: "Số lượng",
        dataIndex: "quantity",
        key: "quantity",
      },
      {
        title: "Đơn giá",
        dataIndex: "price",
        key: "price",
      },
    ];
    const data =
      record.orderItems?.map((item, index) => ({
        key: index,
        image: item.product.image,
        name: item.product.name,
        size: item.productVariant.size,
        color: item.productVariant.color,
        quantity: item.quantity,
        price: item.product.price,
      })) || [];

    return (
      <Table
        className="sub-table"
        columns={columns}
        dataSource={data}
        pagination={false}
      />
    );
  };

  useEffect(() => {
    if (dateRange.length === 2) {
      setStartDate(dateRange[0].format("DD/MM/YYYY"));
      setEndDate(dateRange[1].format("DD/MM/YYYY"));
    }
  }, [dateRange]);

  const handleDateChange = (dates) => {
    setDateRange(dates || []);
    if (!dates || dates.length !== 2) {
      setStartDate("");
      setEndDate("");
      return;
    }
  };

  const handleSearchButtonClick = () => {
    if (startDate === "" || endDate === "") {
      setOrders(fullOrders);
      return;
    }
    const start = dateRange[0];
    const end = dateRange[1];

    const filteredOrders = fullOrders.filter((order) => {
      const orderDate = new Date(order.order.orderDate).toLocaleDateString(
        "vi-VN"
      );
      return orderDate >= startDate && orderDate <= endDate;
    });
    setOrders(filteredOrders);
  };

  return (
    <>
      <div
        style={{
          marginTop: 25,
          display: "flex",
          justifyContent: "center",
          fontWeight: 700,
          fontSize: 30,
        }}
      >
        DANH SÁCH ĐƠN HÀNG
      </div>
      <Space style={{ marginTop: 10, marginLeft: 5 }}>
        <RangePicker format="DD/MM/YYYY" onChange={handleDateChange} />
        <Button
          type="primary"
          style={{ backgroundColor: "blue" }}
          onClick={handleSearchButtonClick}
        >
          Tìm kiếm
        </Button>
      </Space>
      <Table
        className="table"
        expandable={{
          expandedRowRender,
        }}
        columns={columns}
        dataSource={data}
        pagination={{ pageSize: 3 }}
        style={{ marginTop: 10 }}
      />
    </>
  );
};

export default AdminOrder;
