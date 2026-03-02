package com.example.shop.repository;

import com.example.shop.domain.User;
import com.example.shop.domain.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;
import org.springframework.data.repository.query.Param;

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

    @Query("SELECT u FROM User u WHERE " +
            "(:status IS NULL OR u.isLocked = :status) AND " +
            "(:roleName IS NULL OR :roleName = '' OR u.role.name = :roleName) AND " +
            "(:keyword IS NULL OR :keyword = '' OR u.fullName LIKE %:keyword% OR u.email LIKE %:keyword%) " +
            "ORDER BY u.id DESC")
    List<User> searchUsers(@Param("keyword") String keyword,
            @Param("roleName") String roleName,
            @Param("status") Boolean status);

}