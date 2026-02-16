package com.example.shop.repository;

import com.example.shop.domain.Product;
import com.example.shop.domain.Review;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import com.example.shop.domain.User;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {

    List<Review> findByContentContainingOrUserFullNameContainingOrProductNameContaining(String content, String userName,
            String productName);

    List<Review> findByProduct(Product product);

    boolean existsByUserAndProduct(User user, Product product);
}