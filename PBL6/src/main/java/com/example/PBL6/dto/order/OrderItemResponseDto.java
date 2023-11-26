package com.example.PBL6.dto.order;

import com.example.PBL6.persistance.product.ProductVariant;
import lombok.*;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class OrderItemResponseDto {
    private ProductVariant productVariant;
    private Integer quantity;
}
