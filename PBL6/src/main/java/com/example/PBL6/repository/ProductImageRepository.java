package com.example.PBL6.repository;

import com.example.PBL6.persistance.Product;
import com.example.PBL6.persistance.ProductImage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductImageRepository extends JpaRepository<ProductImage, Integer> {
    @Query(value =  "SELECT url " +
                    "  FROM product_images" +
                    " WHERE products_id = :productId", nativeQuery = true)
    List<String> findUrlByProductId(@Param("productId") Integer productId);

}
