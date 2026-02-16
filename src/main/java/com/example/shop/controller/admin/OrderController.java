package com.example.shop.controller.admin;

import com.example.shop.domain.Order;
import com.example.shop.service.OrderService;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
public class OrderController {

    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    // Xử lý cập nhật trạng thái đơn hàng bằng Ajax
    @PostMapping("/admin/order/update-status-ajax")
    @ResponseBody
    public ResponseEntity<String> updateOrderStatusAjax(@RequestParam("id") long id,
            @RequestParam("status") String status) {
        Optional<Order> orderOptional = orderService.getOrderById(id);
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            order.setStatus(status);

            if ("COMPLETED".equals(status)) {
                order.setCompletedAt(new java.util.Date());
            } else {
                order.setCompletedAt(null);
            }

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

    // Hiển thị danh sách đơn hàng và tìm kiếm theo từ khóa
    @GetMapping("/admin/order")
    public String getOrderPage(Model model,
            @RequestParam(value = "keyword", required = false) String keyword) {
        List<Order> orders = orderService.getAllOrders(keyword);

        model.addAttribute("orders", orders);
        model.addAttribute("keyword", keyword);
        return "admin/order/show";
    }

}