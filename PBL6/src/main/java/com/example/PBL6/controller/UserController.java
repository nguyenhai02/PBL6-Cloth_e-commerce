package com.example.PBL6.controller;

import com.example.PBL6.dto.AuthResponse;
import com.example.PBL6.dto.UserLoginDto;
import com.example.PBL6.dto.UserRegisterDto;
import com.example.PBL6.persistance.User;
import com.example.PBL6.service.AuthService;
import com.example.PBL6.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private AuthService authService;

    @GetMapping("/all")
    public List<User> findAll() {
        List<User> rs = userService.findAll();
        return rs;
    }

    @PostMapping("/register")
    public ResponseEntity<Object> register(@RequestBody UserRegisterDto userRegisterDto) {
        AuthResponse authResponse = authService.register(userRegisterDto);
        if (authResponse.getToken() == null) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body("Gmail đã tồn tại");
        } else {
            return ResponseEntity.ok(authResponse);
        }
    }

    @GetMapping("login")
    public ResponseEntity<Object> authenticate(@RequestBody UserLoginDto userLoginDto) {
        return ResponseEntity.ok(authService.login(userLoginDto));
    }
}
