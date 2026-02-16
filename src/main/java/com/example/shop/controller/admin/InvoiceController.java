package com.example.shop.controller.admin;

import com.example.shop.domain.Order;
import com.example.shop.service.InvoiceService;
import com.example.shop.service.OrderService;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.io.IOException;
import java.util.Optional;

@Controller
public class InvoiceController {

    private final InvoiceService invoiceService;
    private final OrderService orderService;

    public InvoiceController(InvoiceService invoiceService, OrderService orderService) {
        this.invoiceService = invoiceService;
        this.orderService = orderService;
    }

    // Đổi đường dẫn thành /admin/invoice/... cho đúng ý nghĩa
    @GetMapping("/admin/invoice/export/{orderId}")
    public void exportInvoice(@PathVariable("orderId") long orderId, HttpServletResponse response) throws IOException {
        Optional<Order> orderOptional = orderService.getOrderById(orderId);

        if (orderOptional.isPresent()) {
            invoiceService.exportInvoice(response, orderOptional.get());
        } else {
            // Nếu không tìm thấy đơn, chuyển hướng về trang danh sách đơn hàng
            response.sendRedirect("/admin/order?error=not_found");
        }
    }
}