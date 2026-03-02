package com.example.shop.repository;

import com.example.shop.domain.Banner;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BannerRepository extends JpaRepository<Banner, Long> {

    // Hàm này giúp chỉ lấy những Banner đang được Admin bật (active = true)
    List<Banner> findByActiveTrue();
}