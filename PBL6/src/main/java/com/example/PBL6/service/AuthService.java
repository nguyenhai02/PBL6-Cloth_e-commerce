package com.example.PBL6.service;

import com.example.PBL6.dto.AuthResponse;
import com.example.PBL6.dto.UserLoginDto;
import com.example.PBL6.dto.UserRegisterDto;

public interface AuthService {
    AuthResponse register(UserRegisterDto userRegisterDto);
    AuthResponse login(UserLoginDto userLoginDto);

}
