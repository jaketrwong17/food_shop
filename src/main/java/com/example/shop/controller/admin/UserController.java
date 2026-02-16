package com.example.shop.controller.admin;

import com.example.shop.domain.User;
import com.example.shop.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.example.shop.domain.Order;

import java.security.Principal;
import java.util.List;

@Controller
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/admin/user")
    public String getUserPage(Model model, @RequestParam(value = "keyword", required = false) String keyword) {
        List<User> users = userService.getAllUsers();
        model.addAttribute("users", users);
        model.addAttribute("keyword", keyword);
        return "admin/user/show";
    }

    @PostMapping("/admin/user/lock/{id}")
    public String lockUser(@PathVariable long id, Principal principal) {
        try {
            User currentUser = userService.getUserByEmail(principal.getName());
            long currentLoginId = currentUser.getId();

            userService.toggleLockUser(id, currentLoginId);

            // SỬA Ở ĐÂY: Dùng không dấu
            return "redirect:/admin/user?message=Cap nhat trang thai thanh cong";
        } catch (RuntimeException e) {
            if (e.getMessage().contains("chính mình")) {
                return "redirect:/admin/user?error=self_action";
            }
            if (e.getMessage().contains("đơn hàng")) {
                return "redirect:/admin/user?error=active_order";
            }
            return "redirect:/admin/user?error=unknown";
        }
    }

    @GetMapping("/admin/user/delete/{id}")
    public String deleteUser(@PathVariable long id, Principal principal) {
        User user = userService.getUserById(id);
        if (user != null) {
            List<Order> orders = user.getOrders();
            if (orders != null && !orders.isEmpty()) {
                return "redirect:/admin/user?error=cannot_delete_has_orders";
            }

            try {
                User currentUser = userService.getUserByEmail(principal.getName());
                long currentLoginId = currentUser.getId();

                userService.deleteUserById(id, currentLoginId);

            } catch (RuntimeException e) {
                if (e.getMessage().contains("chính mình")) {
                    return "redirect:/admin/user?error=self_action";
                }
            }
        }
        // SỬA Ở ĐÂY: Dùng không dấu
        return "redirect:/admin/user?message=Xoa thanh cong";
    }
}