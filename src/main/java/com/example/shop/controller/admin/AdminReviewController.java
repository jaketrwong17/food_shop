package com.example.shop.controller.admin;

import com.example.shop.domain.Review;
import com.example.shop.service.ReviewService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class AdminReviewController {

    private final ReviewService reviewService;

    public AdminReviewController(ReviewService reviewService) {
        this.reviewService = reviewService;
    }

    @GetMapping("/admin/review")
    public String getReviewPage(Model model, @RequestParam(value = "keyword", required = false) String keyword) {
        List<Review> reviews;
        if (keyword != null && !keyword.isEmpty()) {
            reviews = reviewService.searchReviews(keyword);
        } else {
            reviews = reviewService.getAllReviews();
        }
        model.addAttribute("reviews", reviews);
        model.addAttribute("keyword", keyword);
        return "admin/review/show";
    }

    @PostMapping("/admin/review/delete/{id}")
    public String deleteReview(@PathVariable long id) {
        reviewService.deleteReview(id);
        return "redirect:/admin/review";
    }
}