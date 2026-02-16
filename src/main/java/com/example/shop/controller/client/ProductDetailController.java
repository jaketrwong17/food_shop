package com.example.shop.controller.client;

import com.example.shop.domain.Product;
import com.example.shop.domain.Review;
import com.example.shop.service.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@Controller
public class ProductDetailController {

    private final ProductService productService;
    private final CategoryService categoryService;
    private final OrderService orderService;
    private final ReviewService reviewService;

    public ProductDetailController(ProductService productService, CategoryService categoryService,
            OrderService orderService, ReviewService reviewService) {
        this.productService = productService;
        this.categoryService = categoryService;
        this.orderService = orderService;
        this.reviewService = reviewService;
    }

    @GetMapping("/product/{id}")
    public String getProductDetail(Model model, @PathVariable long id, HttpServletRequest request) {
        Product product = productService.fetchProductById(id).orElse(null);
        if (product == null)
            return "redirect:/";

        model.addAttribute("product", product);
        model.addAttribute("categories", categoryService.getAllCategories(null));

        List<Review> reviews = reviewService.getReviewsByProduct(product);
        model.addAttribute("reviews", reviews);

        boolean canReview = false;
        boolean hasReviewed = false;

        HttpSession session = request.getSession(false);
        if (session != null) {
            String email = (String) session.getAttribute("email");
            if (email != null) {
                boolean bought = orderService.hasUserBoughtProduct(email, id);
                hasReviewed = reviewService.hasUserReviewedProduct(email, id);
                if (bought && !hasReviewed) {
                    canReview = true;
                }
            }
        }
        model.addAttribute("canReview", canReview);
        model.addAttribute("hasReviewed", hasReviewed);

        return "client/product/detail";
    }
}