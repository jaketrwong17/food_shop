package com.example.shop.controller.admin;

import com.example.shop.domain.Promotion;
import com.example.shop.service.BrandService;
import com.example.shop.service.CategoryService;
import com.example.shop.service.ProductService;
import com.example.shop.service.PromotionService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin/promotion")
public class PromotionController {

    private final PromotionService promotionService;
    private final ProductService productService;
    private final CategoryService categoryService;
    private final BrandService brandService;

    public PromotionController(PromotionService promotionService, ProductService productService,
            CategoryService categoryService, BrandService brandService) {
        this.promotionService = promotionService;
        this.productService = productService;
        this.categoryService = categoryService;
        this.brandService = brandService;
    }

    @GetMapping
    public String getPromotionPage(Model model) {
        model.addAttribute("promotions", promotionService.getAllPromotions());
        return "admin/promotion/show";
    }

    @GetMapping("/create")
    public String getCreatePage(Model model) {
        model.addAttribute("newPromotion", new Promotion());
        model.addAttribute("products", productService.getAllProducts(null, null));
        model.addAttribute("categories", categoryService.getAllCategories(null));
        model.addAttribute("brands", brandService.getAllBrands());
        return "admin/promotion/create";
    }

    @PostMapping("/create")
    public String createPromotion(@ModelAttribute("newPromotion") Promotion promotion,
            @RequestParam(value = "selectedProducts", required = false) List<Long> selectedProducts,
            @RequestParam(value = "selectedBrands", required = false) List<Long> selectedBrands) {
        promotionService.savePromotion(promotion, selectedProducts, selectedBrands);
        return "redirect:/admin/promotion";
    }

    @GetMapping("/update/{id}")
    public String getUpdatePage(@PathVariable long id, Model model) {
        Promotion promotion = promotionService.getPromotionById(id);
        if (promotion == null)
            return "redirect:/admin/promotion";

        model.addAttribute("newPromotion", promotion);
        model.addAttribute("products", productService.getAllProducts(null, null));
        model.addAttribute("categories", categoryService.getAllCategories(null));
        model.addAttribute("brands", brandService.getAllBrands());

        return "admin/promotion/update";
    }

    @PostMapping("/update")
    public String updatePromotion(@ModelAttribute("newPromotion") Promotion promotion,
            @RequestParam(value = "selectedProducts", required = false) List<Long> selectedProducts,
            @RequestParam(value = "selectedBrands", required = false) List<Long> selectedBrands) {

        Promotion currentPromotion = promotionService.getPromotionById(promotion.getId());
        if (currentPromotion != null) {
            currentPromotion.setName(promotion.getName());
            currentPromotion.setDescription(promotion.getDescription());
            currentPromotion.setDiscountRate(promotion.getDiscountRate());
            currentPromotion.setStartDate(promotion.getStartDate());
            currentPromotion.setEndDate(promotion.getEndDate());
            currentPromotion.setActive(promotion.isActive());

            promotionService.savePromotion(currentPromotion, selectedProducts, selectedBrands);
        }
        return "redirect:/admin/promotion";
    }

    @GetMapping("/delete/{id}")
    public String deletePromotion(@PathVariable long id) {
        promotionService.deletePromotion(id);
        return "redirect:/admin/promotion";
    }

    // --- LOGIC MỚI: BẬT/TẮT NHANH ---
    @GetMapping("/toggle-status/{id}")
    public String toggleStatus(@PathVariable long id) {
        promotionService.toggleStatus(id);
        return "redirect:/admin/promotion";
    }
}