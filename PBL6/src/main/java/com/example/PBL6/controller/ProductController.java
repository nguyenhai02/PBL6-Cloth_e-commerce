package com.example.PBL6.controller;

import com.example.PBL6.dto.product.ProductRequestDto;
import com.example.PBL6.dto.product.ProductResponseDto;
import com.example.PBL6.persistance.product.Product;
import com.example.PBL6.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@RequestMapping("/product")
public class ProductController {
    @Autowired
    private ProductService productService;

    @GetMapping
    public List<Product> getAllProducts() {
        return productService.getAllProducts();
    }

    @GetMapping("/all")
    public Page<ProductResponseDto> getAllProducts(Pageable pageable) {
        return productService.getAllProducts(pageable);
    }

    @PostMapping("/add")
    public ProductResponseDto addProduct(@RequestBody ProductRequestDto productRequestDto) {
        return productService.addProduct(productRequestDto);
    }
}
