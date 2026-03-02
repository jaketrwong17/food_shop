package com.example.shop.controller.admin;

import com.example.shop.domain.dto.TopProductDTO;
import com.example.shop.service.OrderService;
import com.example.shop.service.ProductService;
import com.example.shop.service.UserService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

@Controller
@RequestMapping("/admin/dashboard")
public class DashboardController {

    private final OrderService orderService;
    private final ProductService productService;
    private final UserService userService;

    public DashboardController(OrderService orderService, ProductService productService, UserService userService) {
        this.orderService = orderService;
        this.productService = productService;
        this.userService = userService;
    }

    @GetMapping("")
    public String getDashboard(Model model,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate startDate,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate endDate) {

        // 1. XỬ LÝ NGÀY THÁNG (Mặc định là xem 30 ngày gần nhất nếu không chọn)
        if (endDate == null) {
            endDate = LocalDate.now(); // Hôm nay
        }
        if (startDate == null) {
            startDate = endDate.minusDays(29); // Cách đây 30 ngày
        }

        // Chuyển LocalDate sang LocalDateTime để truy vấn chính xác đến từng giây
        LocalDateTime startDateTime = startDate.atStartOfDay(); // 00:00:00
        LocalDateTime endDateTime = endDate.atTime(LocalTime.MAX); // 23:59:59

        // 2. THỐNG KÊ TỔNG QUAN THEO THỜI GIAN
        long totalOrders = orderService.countOrders(startDateTime, endDateTime);
        Double revenue = orderService.calculateTotalRevenue(startDateTime, endDateTime);
        double totalRevenue = (revenue != null) ? revenue : 0.0;

        // Sản phẩm và User tổng thì thường để All time (hoặc bạn có thể viết hàm đếm
        // theo ngày tương tự Order)
        long totalProducts = productService.countAllProducts();
        long totalUsers = userService.countAllUsers();

        // 3. THỐNG KÊ TRẠNG THÁI THEO THỜI GIAN
        long pendingOrdersCount = orderService.countOrdersByStatus("PENDING", startDateTime, endDateTime);
        long completedOrdersCount = orderService.countOrdersByStatus("COMPLETED", startDateTime, endDateTime);
        long shippingOrdersCount = orderService.countOrdersByStatus("SHIPPING", startDateTime, endDateTime);
        long cancelledOrdersCount = orderService.countOrdersByStatus("CANCELLED", startDateTime, endDateTime);

        long lowStockProductsCount = productService.countLowStockProducts(5);
        List<TopProductDTO> bestSellingProducts = productService.getBestSellingProducts(5);

        // 4. XỬ LÝ BIỂU ĐỒ ĐƯỜNG THEO THỜI GIAN
        List<Object[]> revenueRaw = orderService.getRevenueChart(startDateTime, endDateTime);
        StringBuilder chartLabels = new StringBuilder();
        StringBuilder chartData = new StringBuilder();

        for (int i = 0; i < revenueRaw.size(); i++) {
            Object[] row = revenueRaw.get(i);
            chartLabels.append("'").append(row[0].toString()).append("'");
            chartData.append(row[1].toString());
            if (i < revenueRaw.size() - 1) {
                chartLabels.append(", ");
                chartData.append(", ");
            }
        }

        // 5. ĐẨY DỮ LIỆU XUỐNG VIEW
        model.addAttribute("startDate", startDate); // Trả lại ngày để hiển thị trên input
        model.addAttribute("endDate", endDate);

        model.addAttribute("totalOrders", totalOrders);
        model.addAttribute("totalRevenue", totalRevenue);
        model.addAttribute("totalProducts", totalProducts);
        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("bestSellingProducts", bestSellingProducts);

        model.addAttribute("pendingOrdersCount", pendingOrdersCount);
        model.addAttribute("lowStockProductsCount", lowStockProductsCount);
        model.addAttribute("completedOrdersCount", completedOrdersCount);
        model.addAttribute("shippingOrdersCount", shippingOrdersCount);
        model.addAttribute("cancelledOrdersCount", cancelledOrdersCount);

        model.addAttribute("chartLabels", chartLabels.toString());
        model.addAttribute("chartData", chartData.toString());
        model.addAttribute("activePage", "dashboard");

        return "admin/dashboard/show";
    }
}