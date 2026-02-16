package com.example.shop.repository;

import com.example.shop.domain.OrderDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {

    boolean existsByOrderUserEmailAndProductIdAndOrderStatus(String email, long productId, String status);
}