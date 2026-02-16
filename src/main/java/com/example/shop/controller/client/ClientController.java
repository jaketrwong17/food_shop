package com.example.shop.controller.client;

import com.example.shop.domain.User;
import com.example.shop.service.CategoryService;
import com.example.shop.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller

public class ClientController {

    private final UserService userService;
    private final CategoryService categoryService;
    private final PasswordEncoder passwordEncoder;

    public ClientController(UserService userService, CategoryService categoryService, PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.categoryService = categoryService;
        this.passwordEncoder = passwordEncoder;
    }

    // 1. Hiển thị trang thông tin cá nhân
    @GetMapping("/profile")
    public String getProfilePage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email"); // Lấy email từ session

        User currentUser = this.userService.getUserByEmail(email);
        model.addAttribute("user", currentUser);
        model.addAttribute("categories", categoryService.getAllCategories(null));
        return "client/profile/show";
    }

    // 2. Xử lý cập nhật thông tin
    // Import thêm RedirectAttributes

    @PostMapping("/profile")
    public String updateProfile(@ModelAttribute("user") User user,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) { // Thêm tham số này
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        User currentUser = this.userService.getUserByEmail(email);

        // Kiểm tra định dạng SĐT trước khi lưu
        if (user.getPhone() != null && user.getPhone().matches("^0[0-9]{9}$")) {
            this.userService.updateUserProfile(currentUser.getId(), user);
            session.setAttribute("fullName", user.getFullName());

            // Gửi thông báo thành công
            redirectAttributes.addFlashAttribute("successMsg", "Cập nhật thông tin thành công!");
        } else {
            redirectAttributes.addFlashAttribute("errorMsg", "Số điện thoại không đúng định dạng!");
        }

        return "redirect:/profile";
    }
    // ==============================================================
    // PHẦN THÊM MỚI: CHỨC NĂNG ĐỔI MẬT KHẨU
    // ==============================================================

    @GetMapping("/change-password")
    public String getChangePasswordPage(Model model) {
        // Truyền categories để header hiển thị đẹp, không bị lỗi
        model.addAttribute("categories", categoryService.getAllCategories(null));
        return "client/profile/change_password";
    }

    @PostMapping("/change-password")
    public String handleChangePassword(
            @RequestParam("currentPassword") String currentPassword,
            @RequestParam("newPassword") String newPassword,
            @RequestParam("confirmPassword") String confirmPassword,
            HttpServletRequest request,
            Model model) {

        // 1. Lấy user hiện tại từ Session
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        User currentUser = this.userService.getUserByEmail(email);

        // 2. Kiểm tra mật khẩu cũ (Dùng passwordEncoder để so sánh)
        if (!passwordEncoder.matches(currentPassword, currentUser.getPassword())) {
            model.addAttribute("error", "Mật khẩu hiện tại không chính xác.");
            model.addAttribute("categories", categoryService.getAllCategories(null));
            return "client/profile/change_password";
        }

        // 3. Kiểm tra xác nhận mật khẩu mới
        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "Mật khẩu xác nhận không khớp.");
            model.addAttribute("categories", categoryService.getAllCategories(null));
            return "client/profile/change_password";
        }

        // 4. MÃ HÓA mật khẩu mới trước khi gửi xuống Service
        // (Làm tại đây để tránh lỗi vòng lặp Circular Dependency)
        String encodedPassword = passwordEncoder.encode(newPassword);

        // Gọi Service để lưu (Service chỉ việc lưu, không cần mã hóa nữa)
        this.userService.updatePassword(currentUser, encodedPassword);

        model.addAttribute("message", "Đổi mật khẩu thành công!");
        model.addAttribute("categories", categoryService.getAllCategories(null));

        return "client/profile/change_password";
    }
}