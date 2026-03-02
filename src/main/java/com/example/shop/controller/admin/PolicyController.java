package com.example.shop.controller.admin;

import com.example.shop.domain.Policy;
import com.example.shop.service.PolicyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin/policy")
public class PolicyController {

    @Autowired
    private PolicyService policyService;

    // 1. Hiển thị trang danh sách (show.jsp)
    @GetMapping
    public String showPolicyPage(Model model) {
        List<Policy> policies = policyService.getAllPolicies();
        model.addAttribute("policies", policies);
        return "admin/policy/show";
    }

    // 2. Hiển thị form Thêm mới (create.jsp)
    @GetMapping("/create")
    public String showCreateForm(Model model) {
        model.addAttribute("newPolicy", new Policy());
        return "admin/policy/create";
    }

    // 3. Xử lý lưu Thêm mới
    @PostMapping("/create")
    public String createPolicy(@ModelAttribute("newPolicy") Policy policy, RedirectAttributes redirectAttributes) {
        try {
            policyService.savePolicy(policy);
            redirectAttributes.addFlashAttribute("successMessage", "Thêm mới chính sách thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra khi thêm mới!");
        }
        return "redirect:/admin/policy";
    }

    // 4. Hiển thị form Cập nhật (update.jsp)
    @GetMapping("/update/{id}")
    public String showUpdateForm(@PathVariable("id") Long id, Model model, RedirectAttributes redirectAttributes) {
        Policy policy = policyService.getPolicyById(id);
        if (policy == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy chính sách!");
            return "redirect:/admin/policy";
        }
        model.addAttribute("policy", policy);
        return "admin/policy/update";
    }

    // 5. Xử lý lưu Cập nhật
    @PostMapping("/update")
    public String updatePolicy(@ModelAttribute("policy") Policy policy, RedirectAttributes redirectAttributes) {
        try {
            policyService.savePolicy(policy);
            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật chính sách thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật!");
        }
        return "redirect:/admin/policy";
    }

    // 6. Xử lý thay đổi trạng thái (Bật/Tắt)
    @GetMapping("/toggle-status/{id}")
    public String toggleStatus(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        try {
            policyService.toggleStatus(id);
            redirectAttributes.addFlashAttribute("successMessage", "Đã thay đổi trạng thái hiển thị!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi: Không thể đổi trạng thái!");
        }
        return "redirect:/admin/policy";
    }

    // 7. Xử lý Xóa chính sách
    @GetMapping("/delete/{id}")
    public String deletePolicy(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        try {
            policyService.deletePolicy(id);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa chính sách thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi: Không thể xóa chính sách này!");
        }
        return "redirect:/admin/policy";
    }

    @GetMapping("/policy/{id}")
    public String showPolicyDetail(@PathVariable("id") Long id, Model model) {
        Policy policy = policyService.getPolicyById(id);

        // Nếu không tìm thấy hoặc đang bị Ẩn thì đẩy về trang chủ
        if (policy == null || !policy.isActive()) {
            return "redirect:/";
        }

        model.addAttribute("policy", policy);
        return "client/policy/detail";
    }
}