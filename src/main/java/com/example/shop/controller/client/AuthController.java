package com.example.shop.controller.client;

import com.example.shop.domain.User;
import com.example.shop.domain.dto.RegisterDTO;
import com.example.shop.service.UserService;
import jakarta.servlet.http.HttpServletRequest; // Import mới
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam; // Import mới

import java.util.UUID;

@Controller
public class AuthController {

    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    public AuthController(UserService userService, PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }

    // Lấy giao diện trang đăng nhập
    @GetMapping("/login")
    public String getLoginPage() {
        return "client/auth/login";
    }

    // Lấy giao diện trang đăng ký tài khoản
    @GetMapping("/register")
    public String getRegisterPage(Model model) {
        model.addAttribute("registerUser", new RegisterDTO());
        return "client/auth/register";
    }

    // Xử lý logic đăng ký tài khoản (Đã sửa để thêm xác thực Email)
    @PostMapping("/register")
    public String handleRegister(@ModelAttribute("registerUser") RegisterDTO registerDTO,
            Model model,
            HttpServletRequest request) { // Thêm HttpServletRequest để lấy URL web

        if (userService.checkEmailExists(registerDTO.getEmail())) {
            model.addAttribute("error", "Email này đã được sử dụng, vui lòng chọn email khác!");
            model.addAttribute("registerUser", registerDTO);
            return "client/auth/register";
        }

        if (!registerDTO.getPassword().equals(registerDTO.getConfirmPassword())) {
            model.addAttribute("error", "Mật khẩu xác nhận không khớp!");
            model.addAttribute("registerUser", registerDTO);
            return "client/auth/register";
        }

        User user = userService.registerDTOtoUser(registerDTO);

        // Gọi registerUser của Service (Hàm này đã lo việc Mã hóa pass + Tạo token
        // verification)
        userService.registerUser(user);

        try {
            // Lấy đường dẫn trang web (ví dụ: http://localhost:8080)
            String siteURL = request.getRequestURL().toString().replace(request.getServletPath(), "");
            // Gửi mail xác thực
            userService.sendVerificationEmail(user, siteURL);
        } catch (Exception e) {
            model.addAttribute("error", "Lỗi gửi email xác thực: " + e.getMessage());
            return "client/auth/register";
        }

        // Chuyển hướng đến trang thông báo thành công (Bạn cần tạo file
        // register_success.jsp)
        return "client/auth/register_success";
    }

    // --- (MỚI) Xử lý link xác thực email ---
    @GetMapping("/verify")
    public String verifyUser(@RequestParam("code") String code, Model model) {
        if (userService.verify(code)) {
            return "client/auth/verify_success"; // Tạo file jsp thông báo thành công
        } else {
            return "client/auth/verify_fail"; // Tạo file jsp thông báo thất bại
        }
    }

    // --- (MỚI) Các hàm xử lý Quên mật khẩu ---

    @GetMapping("/forgot-password")
    public String showForgotPasswordForm() {
        return "client/auth/forgot_password"; // Trỏ đến file jsp quên mật khẩu
    }

    @PostMapping("/forgot-password")
    public String processForgotPassword(HttpServletRequest request, Model model) {
        String email = request.getParameter("email");
        String token = UUID.randomUUID().toString(); // Tạo token ngẫu nhiên

        try {
            userService.updateResetPasswordToken(token, email);

            // Tạo link reset password
            String siteURL = request.getRequestURL().toString().replace(request.getServletPath(), "");
            String resetPasswordLink = siteURL + "/reset-password?token=" + token;

            userService.sendEmail(email, resetPasswordLink);
            model.addAttribute("message", "Link đặt lại mật khẩu đã được gửi vào email của bạn.");
        } catch (Exception ex) {
            model.addAttribute("error", "Lỗi: " + ex.getMessage());
        }

        return "client/auth/forgot_password";
    }

    @GetMapping("/reset-password")
    public String showResetPasswordForm(@RequestParam(value = "token") String token, Model model) {
        User user = userService.getByResetPasswordToken(token);
        if (user == null) {
            model.addAttribute("error", "Token không hợp lệ hoặc đã hết hạn.");
            return "client/auth/forgot_password";
        }
        model.addAttribute("token", token);
        return "client/auth/reset_password"; // Trỏ đến file jsp đặt lại mật khẩu
    }

    // Trong file AuthController.java

    // Trong file AuthController.java

    @PostMapping("/reset-password")
    public String processResetPassword(HttpServletRequest request, Model model) {
        String token = request.getParameter("token");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!password.equals(confirmPassword)) {
            model.addAttribute("error", "Mật khẩu xác nhận không khớp.");
            model.addAttribute("token", token);
            return "client/auth/reset_password";
        }

        User user = userService.getByResetPasswordToken(token);
        if (user == null) {
            model.addAttribute("error", "Token không hợp lệ.");
            return "client/auth/reset_password";
        } else {
            // === SỬA ĐOẠN NÀY ===
            // 1. Mã hóa mật khẩu trước (Vì Service giờ chỉ lưu thôi, không mã hóa nữa)
            String encodedPassword = passwordEncoder.encode(password);

            // 2. Gọi hàm updatePassword với mật khẩu đã mã hóa
            userService.updatePassword(user, encodedPassword);

            model.addAttribute("message", "Đổi mật khẩu thành công. Vui lòng đăng nhập.");
        }

        return "client/auth/login";
    }
}