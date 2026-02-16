package com.example.shop.repository;

import com.example.shop.domain.User;
import com.example.shop.domain.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    List<User> findByRole(Role role);

    List<User> findByFullNameContainingIgnoreCaseOrEmailContainingIgnoreCase(String name, String email);

    User findByEmail(String email);

    User findByVerificationCode(String code);

    User findByResetPasswordToken(String token); // Dùng cho Quên mật khẩu
    // Dùng cho Xác thực Email
    // -----------------------

    boolean existsByEmail(String email);

}