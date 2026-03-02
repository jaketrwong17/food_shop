package com.example.shop.controller.admin;

import com.example.shop.domain.Banner;
import com.example.shop.service.BannerService;
import com.example.shop.service.UploadService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/admin/banner")
public class AdminBannerController {

    private final BannerService bannerService;
    private final UploadService uploadService;

    public AdminBannerController(BannerService bannerService, UploadService uploadService) {
        this.bannerService = bannerService;
        this.uploadService = uploadService;
    }

    @GetMapping
    public String index(Model model) {
        model.addAttribute("banners", bannerService.getAllBanners());
        return "admin/banner/show";
    }

    @GetMapping("/create")
    public String createPage(Model model) {
        model.addAttribute("newBanner", new Banner());
        return "admin/banner/create";
    }

    @PostMapping("/create")
    public String createBanner(@ModelAttribute("newBanner") Banner banner,
            @RequestParam("imgFile") MultipartFile file) {
        if (!file.isEmpty()) {
            String fileName = uploadService.handleSaveUploadFile(file, "images");
            banner.setImageUrl(fileName);
        }
        bannerService.saveBanner(banner);
        return "redirect:/admin/banner";
    }

    @GetMapping("/update/{id}")
    public String updatePage(Model model, @PathVariable long id) {
        model.addAttribute("newBanner", bannerService.getBannerById(id));
        return "admin/banner/update";
    }

    @PostMapping("/update")
    public String updateBanner(@ModelAttribute("newBanner") Banner banner,
            @RequestParam("imgFile") MultipartFile file) {
        Banner currentBanner = bannerService.getBannerById(banner.getId());
        if (currentBanner != null) {
            currentBanner.setName(banner.getName());
            currentBanner.setLink(banner.getLink());
            currentBanner.setActive(banner.isActive()); // Cập nhật trạng thái Bật/Tắt

            if (!file.isEmpty()) {
                String fileName = uploadService.handleSaveUploadFile(file, "images");
                currentBanner.setImageUrl(fileName);
            }
            bannerService.saveBanner(currentBanner);
        }
        return "redirect:/admin/banner";
    }

    @GetMapping("/delete/{id}")
    public String deleteBanner(@PathVariable long id) {
        bannerService.deleteBanner(id);
        return "redirect:/admin/banner";
    }
}