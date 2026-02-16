package com.example.shop.service;

import java.util.Collections;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final UserService userService;

    public CustomUserDetailsService(UserService userService) {
        this.userService = userService;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        System.out.println("--- ĐANG THỬ ĐĂNG NHẬP VỚI EMAIL: " + username + " ---");

        com.example.shop.domain.User user = userService.getUserByEmail(username);

        if (user == null) {
            System.out.println(">>> KẾT QUẢ: Không tìm thấy User trong Database!");
            throw new UsernameNotFoundException("User not found");
        }

        System.out.println(">>> TÌM THẤY USER! Mật khẩu trong DB: " + user.getPassword());
        System.out.println(">>> TRẠNG THÁI KÍCH HOẠT (Enabled): " + user.isEnabled());
        System.out.println(">>> TRẠNG THÁI KHÓA (IsLocked): " + user.getIsLocked());

        return new org.springframework.security.core.userdetails.User(
                user.getEmail(),
                user.getPassword(),
                user.isEnabled(),
                true, // accountNonExpired
                true, // credentialsNonExpired
                !user.getIsLocked(), // <--- ĐÃ SỬA: Chặn đăng nhập nếu isLocked = true
                Collections.singletonList(new SimpleGrantedAuthority("ROLE_" + user.getRole().getName())));
    }
}