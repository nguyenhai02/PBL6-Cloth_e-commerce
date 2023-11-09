package com.example.PBL6.service;

import com.example.PBL6.dto.product.FaProductRespDto;
import com.example.PBL6.dto.product.ProductRequestDto;
import com.example.PBL6.dto.product.ProductResponseDto;
import com.example.PBL6.persistance.product.Product;
import com.example.PBL6.persistance.user.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;


public interface ProductService {

    List<Product> getAllProducts();

    ProductResponseDto addProduct(ProductRequestDto productRequestDto);

    Page<ProductResponseDto> getAllProducts(Pageable pageable);

    ProductResponseDto getDetailProduct(Integer id);

    FaProductRespDto addFavouriteProduct(User user, Integer id);

    List<Product> getFavouriteProducts(User user);

    FaProductRespDto deleteFavouriteProduct(User user, Integer id);

    FaProductRespDto deleteAllFavouriteProducts(User user);

}
