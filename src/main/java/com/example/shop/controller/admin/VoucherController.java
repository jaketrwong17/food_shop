package com.example.shop.controller.admin;

import com.example.shop.domain.Voucher;
import com.example.shop.service.CategoryService;
import com.example.shop.service.VoucherService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin/voucher")
public class VoucherController {

    private final VoucherService voucherService;
    private final CategoryService categoryService;

    public VoucherController(VoucherService voucherService, CategoryService categoryService) {
        this.voucherService = voucherService;
        this.categoryService = categoryService;
    }

    // Phương thức hiển thị danh sách VÀ tìm kiếm (Gộp làm 1)
    @GetMapping("")
    public String getVoucherPage(
            Model model,
            @RequestParam(value = "categoryId", required = false) Long categoryId,
            @RequestParam(value = "keyword", required = false) String keyword) {

        // Gọi Service xử lý lọc. Bạn cần cập nhật hàm này trong VoucherService
        List<Voucher> vouchers = this.voucherService.getVouchersWithFilters(categoryId, keyword);

        model.addAttribute("vouchers", vouchers);
        model.addAttribute("categories", this.categoryService.getAllCategories(null));
        model.addAttribute("categoryId", categoryId);
        model.addAttribute("keyword", keyword);

        return "admin/voucher/show";
    }

    @GetMapping("/create")
    public String getCreateVoucherPage(Model model) {
        model.addAttribute("newVoucher", new Voucher());
        model.addAttribute("categories", this.categoryService.getAllCategories(null));
        return "admin/voucher/create";
    }

    @PostMapping("/create")
    public String handleCreateVoucher(@ModelAttribute("newVoucher") Voucher voucher,
            @RequestParam(value = "appliedCategories", required = false) List<Long> categoryIds) {
        this.voucherService.handleSaveVoucher(voucher, categoryIds);
        return "redirect:/admin/voucher";
    }

    @GetMapping("/delete/{id}")
    public String deleteVoucher(@PathVariable long id) {
        this.voucherService.deleteVoucher(id);
        return "redirect:/admin/voucher";
    }

    @GetMapping("/update/{id}")
    public String getUpdateVoucherPage(Model model, @PathVariable long id) {
        Voucher currentVoucher = this.voucherService.getVoucherById(id);
        model.addAttribute("newVoucher", currentVoucher);
        model.addAttribute("categories", this.categoryService.getAllCategories(null));
        return "admin/voucher/update";
    }

    @PostMapping("/update")
    public String handleUpdateVoucher(@ModelAttribute("newVoucher") Voucher voucher,
            @RequestParam(value = "appliedCategories", required = false) List<Long> categoryIds) {
        this.voucherService.handleSaveVoucher(voucher, categoryIds);
        return "redirect:/admin/voucher";
    }
}