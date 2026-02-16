package com.example.shop.repository;

import com.example.shop.domain.Voucher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface VoucherRepository extends JpaRepository<Voucher, Long> {
    Voucher findByCode(String code);
}