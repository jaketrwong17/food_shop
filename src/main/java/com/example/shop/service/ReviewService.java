package com.example.shop.service;

import com.example.shop.domain.Product;
import com.example.shop.domain.Review;
import com.example.shop.domain.User;
import com.example.shop.repository.ProductRepository;
import com.example.shop.repository.ReviewRepository;
import com.example.shop.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReviewService {
    private final ReviewRepository reviewRepository;
    private final ProductRepository productRepository;
    private final UserRepository userRepository;

    public ReviewService(ReviewRepository reviewRepository, ProductRepository productRepository,
            UserRepository userRepository) {
        this.reviewRepository = reviewRepository;
        this.productRepository = productRepository;
        this.userRepository = userRepository;
    }

    public List<Review> getReviewsByProduct(Product product) {
        return reviewRepository.findByProduct(product);
    }

    public void saveReview(String email, long productId, String content, int rating) {
        User user = userRepository.findByEmail(email);
        Product product = productRepository.findById(productId).orElse(null);

        if (user != null && product != null) {
            Review review = new Review();
            review.setUser(user);
            review.setProduct(product);
            review.setContent(content);
            review.setRating(rating);
            reviewRepository.save(review);
        }
    }

    public List<Review> getAllReviews() {
        return this.reviewRepository.findAll();
    }

    public List<Review> searchReviews(String keyword) {
        return this.reviewRepository.findByContentContainingOrUserFullNameContainingOrProductNameContaining(keyword,
                keyword, keyword);
    }

    public void deleteReview(long id) {
        this.reviewRepository.deleteById(id);
    }

    public boolean hasUserReviewedProduct(String email, long productId) {
        User user = userRepository.findByEmail(email);
        Product product = productRepository.findById(productId).orElse(null);
        if (user != null && product != null) {
            return reviewRepository.existsByUserAndProduct(user, product);
        }
        return false;
    }
}