package com.example.PBL6.controller;

import com.example.PBL6.dto.user.AuthResponse;
import com.example.PBL6.dto.user.UserLoginDto;
import com.example.PBL6.dto.user.UserRegisterDto;
import com.example.PBL6.persistance.user.User;
import com.example.PBL6.service.AuthService;
import com.example.PBL6.service.UserService;
import com.example.PBL6.util.JwtUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
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
            return ResponseEntity.status(HttpStatus.CONFLICT).body("Gmail is ready exist");
        } else {
            return ResponseEntity.ok(authResponse);
        }
    }

    @PostMapping("/login")
    public ResponseEntity<Object> authenticate(@RequestBody UserLoginDto userLoginDto) {
        return ResponseEntity.ok(authService.login(userLoginDto));
    }

    @GetMapping("/profile")
    public ResponseEntity<User> getUserProfile(@RequestHeader(HttpHeaders.AUTHORIZATION) String token){
        String email = JwtUtils.getUserEmailFromJwt(token);
        User user =  userService.getUserProfile(email).orElse(null);
        if(user != null) {
            return ResponseEntity.ok(user);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }
}
