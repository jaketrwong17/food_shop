package com.example.shop.config;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
            AuthenticationException exception) throws IOException, ServletException {

        // Mặc định: Lỗi sai mật khẩu hoặc user không tồn tại
        String errorMessage = "error";

        // 1. Kiểm tra nếu là lỗi BỊ KHÓA (Do CustomUserDetailsService ném ra)
        if (exception instanceof LockedException) {
            errorMessage = "locked";
        }
        // 2. Kiểm tra nếu là lỗi CHƯA KÍCH HOẠT (Nếu có dùng chức năng này)
        else if (exception instanceof DisabledException) {
            errorMessage = "disabled";
        }

        // Chuyển hướng về trang login kèm lý do cụ thể
        response.sendRedirect("/login?error=" + errorMessage);
    }
}