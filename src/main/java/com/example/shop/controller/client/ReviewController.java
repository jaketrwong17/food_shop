package com.example.shop.controller.client;

import com.example.shop.service.ReviewService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ReviewController {

    private final ReviewService reviewService;

    public ReviewController(ReviewService reviewService) {
        this.reviewService = reviewService;
    }

    @GetMapping("/review/product/{id}")
    public String getReviewPage(@PathVariable long id) {
        // Chuyển hướng về trang chi tiết và cuộn xuống div có id="review-section"
        return "redirect:/product/" + id + "#review-section";
    }

    @PostMapping("/product/add-review")
    public String addReview(@RequestParam("productId") long productId,
            @RequestParam("content") String content,
            @RequestParam("rating") int rating,
            HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            String email = (String) session.getAttribute("email");
            if (email != null) {
                boolean hasReviewed = reviewService.hasUserReviewedProduct(email, productId);
                if (!hasReviewed) {
                    reviewService.saveReview(email, productId, content, rating);
                }
            }
        }
        return "redirect:/product/" + productId + "#review-section";
    }
}