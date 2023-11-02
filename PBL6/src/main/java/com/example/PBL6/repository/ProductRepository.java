package com.example.PBL6.repository;

import com.example.PBL6.persistance.product.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;


@Repository
public interface ProductRepository extends JpaRepository<Product, Integer>  {
    @Query
    Optional<Product> findProductByName(String name);

    @Query
    Product getById(Integer id);
}
