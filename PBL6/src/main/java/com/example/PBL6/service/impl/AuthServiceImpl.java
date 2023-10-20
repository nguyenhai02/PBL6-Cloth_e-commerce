package com.example.PBL6.service.impl;


import com.example.PBL6.configuration.JwtService;
import com.example.PBL6.dto.user.AuthResponse;
import com.example.PBL6.dto.user.UserLoginDto;
import com.example.PBL6.dto.user.UserRegisterDto;
import com.example.PBL6.persistance.User;
import com.example.PBL6.persistance.UserRole;
import com.example.PBL6.repository.UserRepository;
import com.example.PBL6.service.AuthService;
import com.example.PBL6.util.PasswordUtils;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Service;
import java.util.Optional;

@Service
@NoArgsConstructor
public class AuthServiceImpl implements AuthService {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private JwtService jwtService;
    @Autowired
    private AuthenticationManager authenticationManager;

    @Override
    public AuthResponse register(UserRegisterDto userRegisterDto) {
        Optional<User> customerCheck = userRepository.findUserByEmail(userRegisterDto.getEmail());
        if (customerCheck.isEmpty()) {
            User user = User.builder()
                    .name(userRegisterDto.getName())
                    .email(userRegisterDto.getEmail())
                    .password(PasswordUtils.encodePassword(userRegisterDto.getPassword()))
                    .address(userRegisterDto.getAddress())
                    .phone(userRegisterDto.getPhone())
                    .role(UserRole.ADMIN)
                    .build();
            userRepository.save(user);
            var jwtToken = jwtService.generateToken(user);
            return AuthResponse.builder()
                    .token(jwtToken)
                    .build();
        } else {
            return AuthResponse.builder().build();
        }
    }

    @Override
    public AuthResponse login(UserLoginDto userLoginDto) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        userLoginDto.getEmail(),
                        userLoginDto.getPassword()
                )
        );
        var customer = userRepository.findUserByEmail(userLoginDto.getEmail())
                .orElseThrow();
        var jwtToken = jwtService.generateToken(customer);
        return AuthResponse.builder()
                .token(jwtToken)
                .build();
    }
}
