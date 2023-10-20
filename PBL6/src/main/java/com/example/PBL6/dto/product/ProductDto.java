package com.example.PBL6.dto.product;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProductDto {
    public String name;
    public String description;
    public Double price;
    public Integer discount;
    public Integer quantity;
    public Integer categoryId;
    public List<String> imageUrl;
}
