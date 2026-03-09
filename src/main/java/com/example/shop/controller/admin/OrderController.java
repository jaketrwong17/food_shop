package com.example.shop.controller.admin;

import com.example.shop.domain.Order;
import com.example.shop.domain.OrderDetail; // MỚI THÊM
import com.example.shop.domain.Product; // MỚI THÊM
import com.example.shop.service.OrderService;
import com.example.shop.service.ProductService; // MỚI THÊM

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
public class OrderController {

    private final OrderService orderService;
    private final ProductService productService; // MỚI THÊM

    // SỬA: Thêm ProductService vào Constructor
    public OrderController(OrderService orderService, ProductService productService) {
        this.orderService = orderService;
        this.productService = productService;
    }

    // Xử lý cập nhật trạng thái đơn hàng bằng Ajax
    @PostMapping("/admin/order/update-status-ajax")
    @ResponseBody
    public ResponseEntity<String> updateOrderStatusAjax(@RequestParam("id") long id,
            @RequestParam("status") String status) {
        Optional<Order> orderOptional = orderService.getOrderById(id);
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            String oldStatus = order.getStatus(); // Lấy trạng thái cũ trước khi cập nhật

            order.setStatus(status);

            if ("COMPLETED".equals(status)) {
                order.setCompletedAt(new java.util.Date());
            } else {
                order.setCompletedAt(null);
            }

            // === BẮT ĐẦU SỬA: HOÀN KHO KHI ADMIN HỦY ĐƠN ===
            if ("CANCELLED".equals(status) && !"CANCELLED".equals(oldStatus)) {
                if (order.getOrderDetails() != null) {
                    for (OrderDetail detail : order.getOrderDetails()) {
                        Product p = detail.getProduct();
                        // 1. Cộng lại số lượng vào kho
                        p.setQuantity(p.getQuantity() + detail.getQuantity());
                        // 2. Trừ đi lượt đã bán (không để âm)
                        long newSold = p.getSold() - detail.getQuantity();
                        p.setSold(newSold < 0 ? 0 : newSold);

                        productService.handleSaveProduct(p); // Lưu lại thông tin sản phẩm
                    }
                }
            }

            // === BẮT ĐẦU SỬA: TRỪ LẠI KHO NẾU ADMIN KHÔI PHỤC ĐƠN TỪ TRẠNG THÁI HỦY ===
            if (!"CANCELLED".equals(status) && "CANCELLED".equals(oldStatus)) {
                if (order.getOrderDetails() != null) {
                    for (OrderDetail detail : order.getOrderDetails()) {
                        Product p = detail.getProduct();
                        p.setQuantity(p.getQuantity() - detail.getQuantity());
                        p.setSold(p.getSold() + detail.getQuantity());

                        productService.handleSaveProduct(p);
                    }
                }
            }
            // === KẾT THÚC SỬA ===

            orderService.handleSaveOrder(order);
            return ResponseEntity.ok("success");
        }
        return ResponseEntity.badRequest().body("failed");
    }

    // Hiển thị trang chi tiết đơn hàng cho Admin
    @GetMapping("/admin/order/view/{id}")
    public String getOrderDetailPage(Model model, @PathVariable long id) {
        Optional<Order> orderOptional = orderService.getOrderById(id);
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            model.addAttribute("order", order);
            model.addAttribute("orderDetails", order.getOrderDetails());
            return "admin/order/detail";
        } else {
            return "redirect:/admin/order";
        }
    }

    // Xử lý xóa đơn hàng theo ID
    @GetMapping("/admin/order/delete/{id}")
    public String deleteOrder(@PathVariable long id) {
        orderService.deleteOrderById(id);
        return "redirect:/admin/order";
    }

    // =======================================================================
    // ĐÃ SỬA CHỖ NÀY: Xóa 2 hàm bị xung đột và gộp thành 1 hàm chuẩn xác
    // =======================================================================
    @GetMapping("/admin/order")
    public String getOrderPage(Model model,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) String status) {

        // Gọi hàm từ Service truyền cả keyword và status vào để lọc
        List<Order> orders = orderService.getAllOrders(keyword, status);

        model.addAttribute("orders", orders);
        model.addAttribute("keyword", keyword);
        model.addAttribute("status", status); // Đẩy lại status xuống view để giữ nguyên Dropdown

        return "admin/order/show";
    }

}