package com.example.shop.controller.admin;

import com.example.shop.domain.Brand;
import com.example.shop.service.BrandService;
import com.example.shop.service.UploadService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Controller
@RequestMapping("/admin/brand")
public class AdminBrandController {

    private final BrandService brandService;
    private final UploadService uploadService;

    public AdminBrandController(BrandService brandService, UploadService uploadService) {
        this.brandService = brandService;
        this.uploadService = uploadService;
    }

    // Hiển thị danh sách và tìm kiếm thương hiệu
    @GetMapping
    public String getBrandPage(Model model,
            @RequestParam(value = "keyword", required = false) String keyword) {
        List<Brand> list = brandService.searchBrands(keyword);

        model.addAttribute("brands", list);
        model.addAttribute("keyword", keyword);
        return "admin/brand/show";
    }

    // Hiển thị trang tạo mới thương hiệu
    @GetMapping("/create")
    public String getCreatePage(Model model) {
        model.addAttribute("newBrand", new Brand());
        return "admin/brand/create";
    }

    // Xử lý tạo mới thương hiệu và upload ảnh
    @PostMapping("/create")
    public String createBrand(@ModelAttribute("newBrand") Brand brand,
            @RequestParam("imgFile") MultipartFile file) {
        if (!file.isEmpty()) {
            // Sửa lại lưu vào folder "images" giống Category
            String fileName = uploadService.handleSaveUploadFile(file, "images");
            brand.setLogoUrl(fileName);
        }
        brandService.saveBrand(brand);
        return "redirect:/admin/brand";
    }

    // Hiển thị trang cập nhật thương hiệu
    @GetMapping("/update/{id}")
    public String getUpdatePage(Model model, @PathVariable long id) {
        Brand brand = brandService.getBrandById(id);
        model.addAttribute("newBrand", brand);
        return "admin/brand/update";
    }

    // Xử lý cập nhật thông tin thương hiệu và thay đổi ảnh
    @PostMapping("/update")
    public String updateBrand(@ModelAttribute("newBrand") Brand brand,
            @RequestParam("imgFile") MultipartFile file,
            @RequestParam(value = "isDeleteImage", required = false) Boolean isDeleteImage) {

        Brand currentBrand = brandService.getBrandById(brand.getId());

        if (currentBrand != null) {
            // Gán lại thủ công giống hệt cách bạn làm ở Category
            currentBrand.setName(brand.getName());
            currentBrand.setDescription(brand.getDescription());

            if (Boolean.TRUE.equals(isDeleteImage)) {
                currentBrand.setLogoUrl(null);
            }

            if (!file.isEmpty()) {
                // Sửa lại lưu vào folder "images"
                String fileName = uploadService.handleSaveUploadFile(file, "images");
                currentBrand.setLogoUrl(fileName);
            }

            brandService.saveBrand(currentBrand);
        }
        return "redirect:/admin/brand";
    }

    // Xử lý xóa thương hiệu
    @GetMapping("/delete/{id}")
    public String deleteBrand(@PathVariable long id) {
        brandService.deleteBrand(id);
        return "redirect:/admin/brand";
    }
}