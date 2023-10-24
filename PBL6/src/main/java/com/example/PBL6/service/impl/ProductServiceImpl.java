package com.example.PBL6.service.impl;

import com.example.PBL6.dto.product.ProductRequestDto;
import com.example.PBL6.dto.product.ProductResponseDto;
import com.example.PBL6.persistance.product.Product;
import com.example.PBL6.persistance.product.ProductVariant;
import com.example.PBL6.repository.CategoryRepository;
import com.example.PBL6.repository.ProductRepository;
import com.example.PBL6.repository.ProductVariantRepository;
import com.example.PBL6.service.ProductService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private CategoryRepository categoryRepository;
    @Autowired
    private ProductVariantRepository productVariantRepository;


    @Override
    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    @Override
    public Page<Product> getAllProducts(@PageableDefault(size = 4) Pageable pageable) {
        return productRepository.findAll(pageable);
    }

    @Transactional
    @Override
    public ProductResponseDto addProduct(ProductRequestDto productRequestDto) {
        Optional<Product> productCheck = productRepository.findProductByName(productRequestDto.getName());
        Product product;
        Product productResponse;
        ProductResponseDto productResponseDto;
        if (!productCheck.isPresent()) {
            product = Product.builder()
                    .name(productRequestDto.getName())
                    .description(productRequestDto.getDescription())
                    .price(productRequestDto.getPrice())
                    .discount(productRequestDto.getDiscount())
                    .category(categoryRepository.getById(productRequestDto.getCategoryId()))
                    .createDate(LocalDateTime.now())
                    .updateDate(LocalDateTime.now())
                    .build();
            productResponse = productRepository.save(product);
            ProductVariant productVariant = new ProductVariant().builder()
                    .quantity(productRequestDto.getQuantity())
                    .color(productRequestDto.getColor())
                    .size(productRequestDto.getSize())
                    .product(productResponse)
                    .build();
            productVariantRepository.save(productVariant);
            productResponseDto = new ProductResponseDto().builder()
                    .product(productResponse)
                    .build();
        } else {
            productResponse = productCheck.get();
            Integer productId = productCheck.get().getId();
            String color = productRequestDto.getColor();
            String size = productRequestDto.getSize();
            Integer quantity = productRequestDto.getQuantity();
            if(productVariantRepository.countByProductIdAndColorAndSize(productId, color, size) == 0) {
                productVariantRepository.addProductVariantIfExistProduct(productId, color, size, quantity);
            } else {
                productVariantRepository.addQuantity(productId, quantity);
            }
            productResponseDto = new ProductResponseDto().builder()
                    .product(productResponse)
                    .build();
        }
        List<ProductVariant> productVariants = productVariantRepository.getAllByProduct(productResponseDto.getProduct());
        productResponseDto.setProductVariants(productVariants);

        return productResponseDto;
    }
}
