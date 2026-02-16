package com.example.shop.controller.client;

import com.example.shop.domain.Product;
import com.example.shop.domain.Voucher;
import com.example.shop.domain.dto.TopProductDTO;
import com.example.shop.service.CategoryService;
import com.example.shop.service.ProductService;
import com.example.shop.service.VoucherService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class HomePageController {

    private final ProductService productService;
    private final CategoryService categoryService;
    private final VoucherService voucherService;

    public HomePageController(ProductService productService,
            CategoryService categoryService,
            VoucherService voucherService) {
        this.productService = productService;
        this.categoryService = categoryService;
        this.voucherService = voucherService;
    }

    @GetMapping("/")
    public String getHomePage(Model model,
            HttpServletRequest request,
            @RequestParam(required = false) String search,
            @RequestParam(required = false) Long categoryId,
            @RequestParam(required = false) String sort) {

        HttpSession session = request.getSession(true);
        if (session.getAttribute("sum") == null) {
            session.setAttribute("sum", 0);
        }

        List<Product> products;

        if (search != null || categoryId != null) {
            products = productService.getAllProducts(search, categoryId, sort);
        } else {
            Pageable pageable = PageRequest.of(0, 100);
            Page<Product> pageProducts = productService.getAllProductsWithPaging(pageable, sort);
            products = pageProducts.getContent();
        }

        List<Voucher> vouchers = voucherService.getAllVouchers();
        List<TopProductDTO> bestSellingProducts = productService.getBestSellingProducts(10);

        model.addAttribute("bestSellingProducts", bestSellingProducts);
        model.addAttribute("products", products);
        model.addAttribute("categories", categoryService.getAllCategories(null));
        model.addAttribute("vouchers", vouchers);

        return "client/homepage/show";
    }
}