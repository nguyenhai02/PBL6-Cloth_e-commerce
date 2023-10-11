package com.example.PBL6.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserRegisterDto {
    private String name;
    private String email;
    private String password;
    private String address;
    private String phone;
    private String role;
}
