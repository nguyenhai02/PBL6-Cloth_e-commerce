package com.example.PBL6.controller;

import com.example.PBL6.dto.product.ProductDto;
import com.example.PBL6.dto.product.ProductResponseDto;
import com.example.PBL6.persistance.Product;
import com.example.PBL6.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/product")
public class ProductController {
    @Autowired
    private ProductService productService;

    @GetMapping("/all")
    public List<Product> getAllProducts() {
        return productService.getAllProducts();
    }

    @PostMapping("/add")
    public ProductResponseDto addProduct(@RequestBody ProductDto productDto) {
        return productService.addProduct(productDto);
    }
}
