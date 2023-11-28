import {
  // AutoComplete,
  Button,
  // Cascader,
  // Checkbox,
  // Col,
  // Form,
  // Input,
  // InputNumber,
  // Row
  // Select,
  Modal,
  // message,
  Steps,
  theme,
} from "antd";
import { useState, useEffect } from "react";
// import { Link } from "react-router-dom";
import { getToken } from "../../api/users";
import { useNavigate } from "react-router-dom";
// import CartItem from "../cart/CartItem";
// import CartDetail from "../cart/CartDetail";
import OrderInformation from "../order/OrderInformation";
// import { getAllCartItems } from "../../api/carts";
import AddressDelivery from "../order/AddressDelivery";
import PaymentMethod from "../order/PaymentMethod";
import "./CheckOut.scss";

// const formItemLayout = {
//   labelCol: {
//     xs: {
//       span: 24,
//     },
//     sm: {
//       span: 8,
//     },
//   },
//   wrapperCol: {
//     xs: {
//       span: 24,
//     },
//     sm: {
//       span: 16,
//     },
//   },
// };
// const tailFormItemLayout = {
//   wrapperCol: {
//     xs: {
//       span: 24,
//       offset: 0,
//     },
//     sm: {
//       span: 16,
//       offset: 8,
//     },
//   },
// };
const CheckOut = () => {
  const [deliveryAddress, setDeliveryAddress] = useState("");
  const [amount, setAmount] = useState(0);
  const [orderInfo, setOrderInfo] = useState({
    amount: 0,
    addressDelivery: "",
    productId: 0,
    color: "",
    size: "",
    quantity: 1,
  });
  // const [cartItems, setCartItems] = useState([]);

  // useEffect(() => {
  //   if (localStorage.getItem("token") === null) {
  //     navigate("/account/login");
  //   }
  //   if (localStorage.getItem("item") !== "") {
  //     const fetchCartItems = async () => {
  //       try {
  //         const response = await getAllCartItems();
  //         setCartItems(response || []);
  //       } catch (error) {
  //         console.error("Error fetching cart items:", error);
  //       }
  //     };
  //     fetchCartItems();
  //   }
  // }, [getAllCartItems]);

  const updateDeliveryAddress = (address) => {
    setDeliveryAddress(address);
  };

  // console.log("Địa chỉ nhận hàng:", deliveryAddress);

  // Hàm callback để nhận giá trị totalAmount từ OrderInformation component
  const handleTotalAmountChange = (amount) => {
    setAmount(amount);
  };
  // console.log("Tổng tiền: ", amount);

  useEffect(() => {
    const item = JSON.parse(localStorage.getItem("item"));
    setOrderInfo({
      amount: item ? item.product.product.price : amount,
      addressDelivery: deliveryAddress,
      productId: item?.productId,
      color: item?.color,
      size: item?.size,
      quantity: item?.quantity,
    });
  }, [amount, deliveryAddress]);

  // console.log(orderInfo);

  const steps = [
    {
      title: "Thông tin đơn hàng",
      content: (
        <OrderInformation
          onTotalAmountChange={handleTotalAmountChange}
        ></OrderInformation>
      ),
    },
    {
      title: "Địa chỉ giao hàng",
      content: (
        <AddressDelivery
          onUpdateAddress={updateDeliveryAddress}
        ></AddressDelivery>
      ),
    },
    {
      title: "Phương thức thanh toán",
      content: <PaymentMethod orderInfo={orderInfo}></PaymentMethod>,
    },
  ];

  // const [form] = Form.useForm();
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

  const { token } = theme.useToken();
  const [current, setCurrent] = useState(0);
  const next = () => {
    setCurrent(current + 1);
  };
  const prev = () => {
    setCurrent(current - 1);
  };
  const items = steps.map((item) => ({
    key: item.title,
    title: item.title,
  }));
  const contentStyle = {
    lineHeight: 1,
    textAlign: "center",
    borderRadius: token.borderRadiusLG,
    border: `1px dashed ${token.colorBorder}`,
    marginTop: 16,
  };

  // const { Option } = Select;

  // const onFinish = (values) => {
  //   console.log("Received values of form: ", values);
  // };
  // const [autoCompleteResult, setAutoCompleteResult] = useState([]);
  // const onWebsiteChange = (value) => {
  //   if (!value) {
  //     setAutoCompleteResult([]);
  //   } else {
  //     setAutoCompleteResult(
  //       [".com", ".org", ".net"].map((domain) => `${value}${domain}`)
  //     );
  //   }
  // };
  // const websiteOptions = autoCompleteResult.map((website) => ({
  //   label: website,
  //   value: website,
  // }));

  const cancelPayment = () => {
    localStorage.removeItem("item");
    navigate("/cart");
    // Redirect user or show a message
  };

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
      <div className="item__title" style={{ marginTop: 40 }}>
        THANH TOÁN
      </div>
      <Steps current={current} items={items} style={{ marginTop: 40 }} />
      <div style={contentStyle}>{steps[current].content}</div>
      <div
        style={{
          marginTop: 24,
        }}
      >
        {current < steps.length - 1 && (
          <Button type="primary" onClick={() => next()}>
            Next
          </Button>
        )}
        {/* {current === steps.length - 1 && (
          <Button
            type="primary"
            onClick={() => message.success("Processing complete!")}
          >
            Done
          </Button>
        )} */}
        {current > 0 && (
          <Button
            style={{
              margin: "0 8px",
            }}
            onClick={() => prev()}
          >
            Previous
          </Button>
        )}
      </div>
      <Button
        type="danger"
        onClick={cancelPayment}
        // style={{
        //   borderColor: "red",
        //   borderWidth: "2px",
        //   transition: "opacity 0.5s ease-in-out",
        //   ":hover": { opacity: 0.7 },
        //   width: "150px", // Adjust as needed
        //   height: "40px", // Adjust as needed
        //   margin: "0 auto", // Center the button
        // }}
        className="myButton"
      >
        Hủy đơn hàng
      </Button>
    </>
  );
};
export default CheckOut;
