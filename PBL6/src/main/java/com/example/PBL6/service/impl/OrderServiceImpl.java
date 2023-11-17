package com.example.PBL6.service.impl;

import com.example.PBL6.dto.cart.CartItemDetail;
import com.example.PBL6.dto.order.OrderDto;
import com.example.PBL6.persistance.order.Order;
import com.example.PBL6.persistance.order.OrderItem;
import com.example.PBL6.persistance.product.ProductVariant;
import com.example.PBL6.persistance.user.User;
import com.example.PBL6.repository.OrderItemRepository;
import com.example.PBL6.repository.OrderRepository;
import com.example.PBL6.repository.ProductVariantRepository;
import com.example.PBL6.service.CartService;
import com.example.PBL6.service.OrderService;
import com.example.PBL6.util.AuthenticationUtils;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    private CartService cartService;
    @Autowired
    private OrderRepository orderRepository;
    @Autowired
    private ProductVariantRepository productVariantRepository;
    @Autowired
    private OrderItemRepository orderItemRepository;

    @Override
    @Transactional
    public OrderDto saveOrder(User user, String paymentMethod, double totalPrice, String status) {
//        User user = AuthenticationUtils.getUserFromSecurityContext();
        System.out.println(user);
        List<CartItemDetail> cartItemDetails = cartService.getAllCartItems(user);
        if(cartItemDetails.isEmpty()) {
            return null;
        }
        List<OrderItem> orderItems = new ArrayList<>();
        OrderDto orderDto;
        System.out.println(totalPrice);
        Order order = Order.builder()
                .orderDate(LocalDateTime.now())
                .totalPrice(totalPrice)
                .paymentMethod(paymentMethod)
                .user(user)
                .status(status)
                .build();
        orderRepository.save(order);

        for(CartItemDetail cartItemDetail : cartItemDetails) {
            Optional<ProductVariant> productVariant = productVariantRepository.findById(cartItemDetail.getProductVariantId());
            if(productVariant.isPresent()) {
                OrderItem orderItem = OrderItem.builder()
                        .productVariant(productVariant.get())
                        .order(order)
                        .quantity(cartItemDetail.getQuantity())
                        .build();
                orderItems.add(orderItem);
                if(status.equals("COMPLETE")) {
                    productVariantRepository.subtractQuantity(cartItemDetail.getProductId(), orderItem.getQuantity());

                }
                orderItemRepository.save(orderItem);
            }
        }
        orderDto = new OrderDto().builder()
                .orderId(order.getId())
                .address(user.getAddress())
                .orderDate(order.getOrderDate())
                .totalPrice(order.getTotalPrice())
                .paymentMethod(order.getPaymentMethod())
                .status(order.getStatus())
                .orderItems(orderItems)
                .build();
        if (status.equals("COMPLETE")) {
            cartService.deleteAllCartItems(user);
        }
        return orderDto;
    }

    @Override
    public List<Order> getAllOrders(User user) {
        List<Order> orders = orderRepository.getOrdersByUser(user);
        return orders;
    }
}
