package com.example.PBL6.service;

import com.example.PBL6.dto.product.ProductRequestDto;
import com.example.PBL6.dto.product.ProductResponseDto;
import com.example.PBL6.persistance.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;


public interface ProductService {

    List<Product> getAllProducts();

    ProductResponseDto addProduct(ProductRequestDto productRequestDto);

    Page<Product> getAllProducts(Pageable pageable);
}
