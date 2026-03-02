package com.example.shop.repository;

import com.example.shop.domain.Product;
import com.example.shop.domain.Review;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;
import com.example.shop.domain.User;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {

    List<Review> findByContentContainingOrUserFullNameContainingOrProductNameContaining(String content, String userName,
            String productName);

    List<Review> findByProduct(Product product);

    boolean existsByUserAndProduct(User user, Product product);

    @Query("SELECT r FROM Review r WHERE " +
            "(:rating IS NULL OR r.rating = :rating) AND " +
            "(:keyword IS NULL OR :keyword = '' OR r.product.name LIKE %:keyword% OR r.user.fullName LIKE %:keyword% OR r.user.email LIKE %:keyword%) "
            +
            "ORDER BY r.id DESC")
    List<Review> searchReviews(@Param("keyword") String keyword, @Param("rating") Integer rating);
}