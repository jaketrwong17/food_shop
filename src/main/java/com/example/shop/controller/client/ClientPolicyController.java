package com.example.shop.controller.client;

import com.example.shop.domain.Policy;
import com.example.shop.service.PolicyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class ClientPolicyController {

    @Autowired
    private PolicyService policyService;

    // Mapping URL mà người dùng click từ footer: /policy/{id}
    @GetMapping("/policy/{id}")
    public String showPolicyDetail(@PathVariable("id") Long id, Model model) {
        Policy policy = policyService.getPolicyById(id);

        // Nếu id không tồn tại hoặc chính sách đang bị admin tắt (ẩn)
        if (policy == null || !policy.isActive()) {
            return "redirect:/"; // Đẩy về trang chủ hoặc trang báo lỗi 404 tuỳ bạn
        }

        model.addAttribute("policy", policy);

        // Trả về file jsp hiển thị giao diện
        return "client/policy/detail";
    }
}