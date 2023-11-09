package com.example.PBL6.controller;

import com.example.PBL6.dto.cart.CartResponseDto;
import com.example.PBL6.dto.product.FaProductRespDto;
import com.example.PBL6.persistance.product.Product;
import com.example.PBL6.persistance.user.User;
import com.example.PBL6.service.ProductService;
import com.example.PBL6.util.AuthenticationUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/favouriteProduct")
public class FaProductController {
    @Autowired
    private ProductService productService;

    @GetMapping("")
    public ResponseEntity<Object> getAllFavouriteProducts() {
        User user = AuthenticationUtils.getUserFromSecurityContext();
        if(user != null) {
            List<Product> products = productService.getFavouriteProducts(user);
            if(products == null) {
                return ResponseEntity.ok("Không có sản phẩm yêu thích nào");
            } else {
                return ResponseEntity.ok(products);
            }
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
    }

    @PostMapping("/add/{id}")
    public ResponseEntity<Object> addFavouriteProduct(@PathVariable("id") Integer id) {
        User user = AuthenticationUtils.getUserFromSecurityContext();
        if(user != null) {
            FaProductRespDto faProductRespDto = productService.addFavouriteProduct(user, id);
            return ResponseEntity.ok(faProductRespDto);
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<Object> deleteFavouriteProduct(@PathVariable("id") Integer id) {
        User user = AuthenticationUtils.getUserFromSecurityContext();
        if(user != null) {
            FaProductRespDto faProductRespDto = productService.deleteFavouriteProduct(user, id);
            return ResponseEntity.ok(faProductRespDto);
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
    }

    @DeleteMapping("/deleteAll")
    public ResponseEntity<Object> deleteFavouriteProduct() {
        User user = AuthenticationUtils.getUserFromSecurityContext();
        if(user != null) {
            FaProductRespDto faProductRespDto = productService.deleteAllFavouriteProducts(user);
            return ResponseEntity.ok(faProductRespDto);
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
    }
}
