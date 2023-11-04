package com.example.PBL6.service;

import com.example.PBL6.dto.product.ProductRequestDto;
import com.example.PBL6.dto.product.ProductResponseDto;
import com.example.PBL6.persistance.product.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;


public interface ProductService {

    List<Product> getAllProducts();

    ProductResponseDto addProduct(ProductRequestDto productRequestDto);

    Page<ProductResponseDto> getAllProducts(Pageable pageable);

    ProductResponseDto getDetailProduct(Integer id);
}
