package com.example.PBL6.service.impl;

import com.example.PBL6.dto.product.ProductRequestDto;
import com.example.PBL6.dto.product.ProductResponseDto;
import com.example.PBL6.persistance.Product;
import com.example.PBL6.persistance.ProductImage;
import com.example.PBL6.repository.CategoryRepository;
import com.example.PBL6.repository.ProductImageRepository;
import com.example.PBL6.repository.ProductRepository;
import com.example.PBL6.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private CategoryRepository categoryRepository;
    @Autowired
    private ProductImageRepository productImageRepository;


    @Override
    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    @Override
    public Page<Product> getAllProducts(@PageableDefault(size = 4) Pageable pageable) {
        return productRepository.findAll(pageable);
    }

    @Override
    public ProductResponseDto addProduct(ProductRequestDto productRequestDto) {
        Product product = new Product().builder()
                .name(productRequestDto.getName())
                .description(productRequestDto.getDescription())
                .quantity(productRequestDto.getQuantity())
                .price(productRequestDto.getPrice())
                .discount(productRequestDto.getDiscount())
                .color(productRequestDto.getColor())
                .size(productRequestDto.getSize())
                .category(categoryRepository.getById(productRequestDto.getCategoryId()))
                .createDate(LocalDateTime.now())
                .updateDate(LocalDateTime.now())
                .build();
        Product productResponse = productRepository.save(product);
        ProductResponseDto productResponseDto =  new ProductResponseDto().builder()
                .product(productResponse)
                .build();
        if(productRequestDto.getImageUrl().size() != 0) {
            for(String image : productRequestDto.getImageUrl()) {
                ProductImage productImage = new ProductImage().builder()
                        .imageUrl(image)
                        .product(productResponse)
                        .build();
                productImageRepository.save(productImage);
            }
            productResponseDto.setProductImageUrl(productImageRepository.findUrlByProductId(productResponse.getId()));
        }
        return productResponseDto;
    }
}
