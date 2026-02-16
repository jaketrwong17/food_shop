package com.example.shop.repository;

import com.example.shop.domain.Cart;
import com.example.shop.domain.CartItem;
import com.example.shop.domain.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CartItemRepository extends JpaRepository<CartItem, Long> {

    // Đã xóa tham số ProductColor, chỉ check theo Cart và Product
    CartItem findByCartAndProduct(Cart cart, Product product);
}