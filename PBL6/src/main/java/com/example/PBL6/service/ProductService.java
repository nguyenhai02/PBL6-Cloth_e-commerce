package com.example.PBL6.service;

import com.example.PBL6.dto.product.ProductDto;
import com.example.PBL6.dto.product.ProductResponseDto;
import com.example.PBL6.persistance.Product;

import java.util.List;

public interface ProductService {
    ProductResponseDto addProduct(ProductDto productDto);

    List<Product> getAllProducts();
}
