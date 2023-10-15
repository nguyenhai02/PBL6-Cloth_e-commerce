import { MobileOutlined, SkinOutlined } from "@ant-design/icons";
import { Menu } from "antd";
import React, { useEffect, useState } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import "./SideMenu.scss";
function getItem(label, key, icon, children, type) {
  return {
    key,
    icon,
    children,
    label,
    type,
  };
}
const items = [
  getItem("CLOTHES", "collections", <SkinOutlined />, [
    getItem("TOPS", "TOPS"),
    getItem("BOTTOMS", "BOTTOMS"),
    getItem("ACCESSORIES", "Accessories"),
  ]),
  getItem("SMART DEVICE", "smart-devices", <MobileOutlined />, [
    getItem("PHONES", "PHONES"),
    getItem("LAPTOPS", "LAPTOPS"),
    getItem("Submenu", "sub3", null, [
      getItem("Option 7", "7"),
      getItem("Option 8", "8"),
    ]),
  ]),
  {
    type: "divider",
  },
];
const SideBar = () => {
  const { pathname } = useLocation();
  const [, setMainPath] = useState("");
  const navigate = useNavigate();
  const pathArr = pathname.split("/").filter((item) => item);

  useEffect(() => {
    setMainPath(pathArr[0]);
  }, [pathArr]);

  const onClick = (e) => {
    const childPath = e.key;
    const parentPath = e.keyPath[1];
    const path = "/" + parentPath + "/" + childPath;
    navigate(path);
  };

  return (
    <Menu
      onClick={onClick}
      className="menubox"
      defaultSelectedKeys={[`${pathArr[1]}`]}
      defaultOpenKeys={["sub1"]}
      mode="inline"
      items={items}
    />
  );
};

export default SideBar;
