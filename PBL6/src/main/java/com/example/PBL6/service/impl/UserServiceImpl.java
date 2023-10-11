package com.example.PBL6.service.impl;

import com.example.PBL6.persistance.User;
import com.example.PBL6.repository.UserRepository;
import com.example.PBL6.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public List<User> findAll() {
        return userRepository.findAll();
    }
}
