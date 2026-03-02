package com.example.shop.repository;

import com.example.shop.domain.Policy;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface PolicyRepository extends JpaRepository<Policy, Long> {
    // Lấy các chính sách đang hiển thị
    List<Policy> findByActiveTrue();
}