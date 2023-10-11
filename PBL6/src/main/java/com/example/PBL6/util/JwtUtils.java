package com.example.PBL6.util;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;

public class JwtUtils {
    private static final String SECRET_KEY = "475949fea142d344c1ee5bdd91cdff56234f8e2c1daea78e53f52cb70f9c7f7d";

    public static String getUserGmailFromJwt(String jwt) {
        try {
            Claims claims = Jwts.parser().setSigningKey(SECRET_KEY).parseClaimsJws(jwt).getBody();
            String gmail = claims.get("sub", String.class);
            return gmail;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}
