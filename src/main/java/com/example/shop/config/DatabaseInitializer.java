package com.example.shop.config;

import com.example.shop.domain.Role;
import com.example.shop.repository.RoleRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DatabaseInitializer {

    // CommandLineRunner sẽ chạy ngay sau khi Spring Boot khởi động xong
    @Bean
    CommandLineRunner initDatabase(RoleRepository roleRepository) {
        return args -> {

            // 1. Kiểm tra Role USER
            if (roleRepository.findByName("USER") == null) {
                Role userRole = new Role();
                userRole.setName("USER");
                userRole.setDescription("user");
                roleRepository.save(userRole);
                System.out.println(">>> Đã tự động tạo Role: USER");
            }

            // 2. Kiểm tra Role ADMIN
            if (roleRepository.findByName("ADMIN") == null) {
                Role adminRole = new Role();
                adminRole.setName("ADMIN");
                adminRole.setDescription("admin");
                roleRepository.save(adminRole);
                System.out.println(">>> Đã tự động tạo Role: ADMIN");
            }
        };
    }
}