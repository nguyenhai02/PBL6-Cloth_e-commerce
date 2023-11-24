import { Col, Row } from "antd";
import React, { useEffect, useState } from "react";
import { useSelector, useDispatch } from "react-redux";
import { useNavigate } from "react-router-dom";
import "./OrderInformation.scss";
import OrderItem from "./OrderItem";
import { ArrowRightOutlined } from "@ant-design/icons";
import { getAllCartItems } from "../../api/carts";
import { userProfile, userEditProfile } from "../../stores/user/user-slice";

const OrderInformation = (props) => {
  const navigate = useNavigate();
  const dispatch = useDispatch();
  const { user } = useSelector((state) => state.user);
  const [cartItems, setCartItems] = useState([]);
  const [totalAmount, setTotalAmount] = useState(0);
  const userToken = localStorage.getItem("token");
  useEffect(() => {
    if (userToken) {
      dispatch(userProfile(userToken));
    }
  }, []);
  const [values, setValues] = useState({
    name: "",
    address: "",
    phone: "",
    gender: "",
    avatar: "",
    email: "",
  });
  useEffect(() => {
    setValues({
      name: user?.name || "",
      address: user?.address || "",
      phone: user?.phone || "",
      gender: user?.gender || "",
      avatar: user?.avatar || "",
      email: user?.email || "",
    });
  }, [user]);

  useEffect(() => {
    const fetchCartItems = async () => {
      try {
        const response = await getAllCartItems();
        setCartItems(response || []);
      } catch (error) {
        console.error("Error fetching cart items:", error);
      }
    };

    fetchCartItems();
  }, [getAllCartItems]);

  useEffect(() => {
    const calculateTotalAmount = () => {
      const total = cartItems.reduce((accumulator, currentItem) => {
        return accumulator + currentItem.price * currentItem.quantity;
      }, 0);
      setTotalAmount(total);
    };

    calculateTotalAmount();
  }, [cartItems]);

  const checkoutsHandler = () => {
    if (props.drawer) {
      props?.drawer(false);
    }
    navigate(`/checkouts`);
  };

  const renderCartItem = cartItems.map((item) => {
    return <OrderItem key={item.id} product={item} />;
  });

  return (
    <Row gutter={64} style={{ marginTop: 32 }}>
      <Col md={17}>
        <div className="item__title">THÔNG TIN ĐƠN HÀNG</div>
        <div className="item" direction={"vertical"} size={0}>
          <div className="item__count">
            Bạn có <span>{cartItems.length} sản phẩm</span> trong đơn hàng
          </div>
          <div>{renderCartItem}</div>
        </div>
        <div className="item__total border-bottom-solid">
          <span className="item__total_title"></span>
          <span className="item__total_number">
            TỔNG TIỀN: {totalAmount} VNĐ
          </span>
          {props.onTotalAmountChange && props.onTotalAmountChange(totalAmount)}
        </div>
      </Col>
      <Col md={7} style={{ position: "relative" }}>
        <div className="item__bill">
          <div className="item__bill_title border-bottom-solid">
            THÔNG TIN KHÁCH HÀNG
          </div>
          <Row style={{ padding: 10 }}>
            <Col span={18} push={6}>
              {user?.name}
            </Col>
            <Col span={6} pull={18} style={{ textAlign: "left" }}>
              <div>Tên:</div>
            </Col>
          </Row>
          {/* <Row style={{ padding: 10 }}>
            <Col span={18} push={6}>
              {values.address}
            </Col>
            <Col span={6} pull={18} style={{ textAlign: "left" }}>
              <div>Địa chỉ:</div>
            </Col>
          </Row> */}
          <Row style={{ padding: 10 }}>
            <Col span={18} push={6}>
              {values.email}
            </Col>
            <Col span={6} pull={18} style={{ textAlign: "left" }}>
              <div>Email:</div>
            </Col>
          </Row>
          <Row style={{ padding: 10 }}>
            <Col span={18} push={6}>
              {values.phone}
            </Col>
            <Col span={6} pull={18} style={{ textAlign: "left" }}>
              <div>Điện thoại:</div>
            </Col>
          </Row>
        </div>
      </Col>
    </Row>
  );
};

export default OrderInformation;
