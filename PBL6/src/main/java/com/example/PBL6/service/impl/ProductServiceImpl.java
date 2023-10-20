package com.example.PBL6.service.impl;

import com.example.PBL6.dto.product.ProductDto;
import com.example.PBL6.dto.product.ProductResponseDto;
import com.example.PBL6.persistance.Product;
import com.example.PBL6.persistance.ProductImage;
import com.example.PBL6.repository.CategoryRepository;
import com.example.PBL6.repository.ProductImageRepository;
import com.example.PBL6.repository.ProductRepository;
import com.example.PBL6.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
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
    public ProductResponseDto addProduct(ProductDto productDto) {
        Product product = new Product().builder()
                .name(productDto.getName())
                .description(productDto.getDescription())
                .quantity(productDto.getQuantity())
                .price(productDto.getPrice())
                .discount(productDto.getDiscount())
                .category(categoryRepository.getById(productDto.getCategoryId()))
                .createDate(LocalDateTime.now())
                .updateDate(LocalDateTime.now())
                .build();
        Product productResponse = productRepository.save(product);
        ProductResponseDto productResponseDto =  new ProductResponseDto().builder()
                .product(productResponse)
                .build();
        if(productDto.getImageUrl().size() != 0) {
            for(String image : productDto.getImageUrl()) {
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
