package com.example.shop.repository;

import com.example.shop.domain.Brand;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BrandRepository extends JpaRepository<Brand, Long> {

    // Tìm kiếm thương hiệu theo tên (Bỏ qua viết hoa/viết thường)
    List<Brand> findByNameContainingIgnoreCase(String keyword);
}