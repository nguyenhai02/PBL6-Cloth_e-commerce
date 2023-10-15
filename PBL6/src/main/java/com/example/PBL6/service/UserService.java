package com.example.PBL6.service;

import com.example.PBL6.persistance.User;

import java.util.List;
import java.util.Optional;

public interface UserService {
    List<User> findAll();

    Optional<User> getUserProfile(String email);
}
