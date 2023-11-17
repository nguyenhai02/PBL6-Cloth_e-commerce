package com.example.PBL6.service;

import com.example.PBL6.dto.order.OrderDto;
import com.example.PBL6.persistance.order.Order;
import com.example.PBL6.persistance.user.User;

import java.util.List;

public interface OrderService {
    OrderDto saveOrder(User user, String paymentMethod, double totalPrice, String status);
    List<Order> getAllOrders(User user);
}
