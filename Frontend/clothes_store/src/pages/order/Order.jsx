import { Button, Modal, Table } from "antd";
import { useState, useEffect } from "react";
import { getToken } from "../../api/users";
import { useNavigate } from "react-router-dom";
import { getAllOrders } from "../../api/orders";
import moment from "moment";
import "./Order.scss";

const Order = () => {
  const [orders, setOrders] = useState([]);
  const navigate = useNavigate();

  const [open, setOpen] = useState(false);
  const [confirmLoading, setConfirmLoading] = useState(false);
  const [modalText, setModalText] = useState(
    "Chuyển hướng đến trang đăng nhập"
  );
  const showModal = () => {
    setOpen(true);
  };
  const handleOk = () => {
    setModalText("Chuyển hướng đến trang đăng nhập");
    setConfirmLoading(true);
    setTimeout(() => {
      setOpen(false);
      setConfirmLoading(false);
      navigate("/account/login");
    }, 1500);
  };
  const handleCancel = () => {
    console.log("Clicked cancel button");
    setOpen(false);
  };

  const columns = [
    {
      title: "Số thứ tự",
      dataIndex: "index",
    },
    {
      title: "Mã đơn hàng",
      dataIndex: "id",
    },
    {
      title: "Ngày đặt hàng",
      dataIndex: "date",
      defaultSortOrder: "descend",
      sorter: (a, b) =>
        moment(a.date, "HH:mm:ss DD/MM/YYYY") -
        moment(b.date, "HH:mm:ss DD/MM/YYYY"),
    },
    {
      title: "Số tiền",
      dataIndex: "money",
    },
    {
      title: "Phương thức thanh toán",
      dataIndex: "paymentMethod",
    },
    {
      title: "Địa chỉ giao hàng",
      dataIndex: "address",
    },
    {
      title: "Trạng thái",
      dataIndex: "status",
    },
  ];
  useEffect(() => {
    const fetchOrders = async () => {
      try {
        const response = await getAllOrders();
        setOrders(response);
      } catch (error) {
        console.error("Error fetching orders:", error);
      }
    };
    fetchOrders();
  }, []);

  const getStatus = (status) => {
    if (status === "COMPLETE") {
      return <span style={{ color: "green" }}>Hoàn thành</span>;
    } else if (status === "UN-COMPLETE") {
      return <span style={{ color: "red" }}>Chưa hoàn thành</span>;
    } else {
      return status;
    }
  };

  const data = [];
  if (orders) {
    for (let i = 1; i < orders.length + 1; i++) {
      const order = orders[i - 1].order;
      if (order) {
        data.push({
          index: i,
          id: `DH${order.id}`,
          date: moment(order.orderDate).format("HH:mm:ss DD/MM/YYYY"),
          money: order.totalPrice.toLocaleString("vi-VN"),
          paymentMethod: order.paymentMethod,
          address: order.addressDelivery,
          status: getStatus(order.status),
        });
      }
    }
  }

  return getToken() === null ? (
    <>
      <Button
        type="primary"
        onClick={showModal}
        style={{ width: 200, height: 50, marginTop: 50, marginLeft: 555 }}
      >
        LOGIN TO CONTINUE
      </Button>
      <Modal
        title="Thông báo"
        open={open}
        onOk={handleOk}
        confirmLoading={confirmLoading}
        onCancel={handleCancel}
      >
        <p>{modalText}</p>
      </Modal>
    </>
  ) : (
    <>
      {Array.isArray(orders) && orders.length > 0 ? (
        <div>
          <div className="item__title" style={{ marginTop: 40 }}>
            DANH SÁCH ĐƠN HÀNG
          </div>
          <div
            style={{
              marginBottom: 16,
            }}
          ></div>
          <Table columns={columns} dataSource={data} />
        </div>
      ) : (
        <div className="item__title" style={{ marginTop: 40 }}>
          BẠN CHƯA CÓ ĐƠN HÀNG NÀO
        </div>
      )}
    </>
  );
};
export default Order;
