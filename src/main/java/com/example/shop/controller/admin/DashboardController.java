package com.example.shop.controller.admin;

import com.example.shop.domain.dto.TopProductDTO;
import com.example.shop.service.OrderService;
import com.example.shop.service.ProductService;
import com.example.shop.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/admin/dashboard")
public class DashboardController {

    private final OrderService orderService;
    private final ProductService productService;
    private final UserService userService;

    // Khởi tạo DashboardController và inject các dịch vụ cần thiết
    public DashboardController(OrderService orderService,
            ProductService productService,
            UserService userService) {
        this.orderService = orderService;
        this.productService = productService;
        this.userService = userService;
    }

    // Lấy dữ liệu thống kê tổng quan và hiển thị trang Dashboard
    @GetMapping("")
    public String getDashboard(Model model) {
        long totalOrders = orderService.countAllOrders();
        long totalProducts = productService.countAllProducts();
        long totalUsers = userService.countAllUsers();

        Double revenue = orderService.calculateTotalRevenue();
        double totalRevenue = (revenue != null) ? revenue : 0.0;

        List<TopProductDTO> bestSellingProducts = productService.getBestSellingProducts(5);

        model.addAttribute("totalOrders", totalOrders);
        model.addAttribute("totalRevenue", totalRevenue);
        model.addAttribute("totalProducts", totalProducts);
        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("bestSellingProducts", bestSellingProducts);
        model.addAttribute("activePage", "dashboard");

        return "admin/dashboard/show";
    }
}