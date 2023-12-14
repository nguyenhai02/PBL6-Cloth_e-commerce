package com.example.PBL6.dto.user;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BestCustomerDto {
    private Integer id;
    private String name;
    private Double totalMoney;
}
