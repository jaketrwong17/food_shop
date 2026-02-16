package com.example.shop.controller.admin;

import com.example.shop.domain.Category;
import com.example.shop.service.CategoryService;
import com.example.shop.service.UploadService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Controller
@RequestMapping("/admin/category")
public class CategoryController {

    private final CategoryService categoryService;
    private final UploadService uploadService;

    public CategoryController(CategoryService categoryService, UploadService uploadService) {
        this.categoryService = categoryService;
        this.uploadService = uploadService;
    }

    // Hiển thị danh sách và tìm kiếm danh mục
    @GetMapping
    public String getCategoryPage(Model model,
            @RequestParam(value = "keyword", required = false) String keyword) {
        List<Category> list = categoryService.getAllCategories(keyword);

        model.addAttribute("categories", list);
        model.addAttribute("keyword", keyword);
        return "admin/category/show";
    }

    // Hiển thị trang tạo mới danh mục
    @GetMapping("/create")
    public String getCreatePage(Model model) {
        model.addAttribute("newCategory", new Category());
        return "admin/category/create";
    }

    // Xử lý tạo mới danh mục và upload ảnh
    @PostMapping("/create")
    public String createCategory(@ModelAttribute("newCategory") Category category,
            @RequestParam("imgFile") MultipartFile file) {
        if (!file.isEmpty()) {
            String fileName = uploadService.handleSaveUploadFile(file, "images");
            category.setImage(fileName);
        }
        categoryService.saveCategory(category);
        return "redirect:/admin/category";
    }

    // Hiển thị trang cập nhật danh mục
    @GetMapping("/update/{id}")
    public String getUpdatePage(Model model, @PathVariable long id) {
        Category category = categoryService.getCategoryById(id);
        model.addAttribute("newCategory", category);
        return "admin/category/update";
    }

    // Xử lý cập nhật thông tin danh mục và thay đổi ảnh
    @PostMapping("/update")
    public String updateCategory(@ModelAttribute("newCategory") Category category,
            @RequestParam("imgFile") MultipartFile file,
            @RequestParam(value = "isDeleteImage", required = false) Boolean isDeleteImage) {

        Category currentCategory = categoryService.getCategoryById(category.getId());

        if (currentCategory != null) {
            currentCategory.setName(category.getName());
            currentCategory.setDescription(category.getDescription());

            if (Boolean.TRUE.equals(isDeleteImage)) {
                currentCategory.setImage(null);
            }

            if (!file.isEmpty()) {
                String fileName = uploadService.handleSaveUploadFile(file, "images");
                currentCategory.setImage(fileName);
            }

            categoryService.saveCategory(currentCategory);
        }
        return "redirect:/admin/category";
    }

    // Xử lý xóa danh mục
    @GetMapping("/delete/{id}")
    public String deleteCategory(@PathVariable long id) {
        categoryService.deleteCategory(id);
        return "redirect:/admin/category";
    }
}