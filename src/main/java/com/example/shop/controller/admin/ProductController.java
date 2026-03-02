package com.example.shop.controller.admin;

import com.example.shop.domain.Product;
import com.example.shop.domain.ProductImage;
import com.example.shop.domain.ProductSpec;
import com.example.shop.service.BrandService;
import com.example.shop.service.CategoryService;
import com.example.shop.service.ProductService;
import com.example.shop.service.UploadService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/admin/product")
public class ProductController {

    private final ProductService productService;
    private final CategoryService categoryService;
    private final UploadService uploadService;
    private final BrandService brandService;

    public ProductController(ProductService productService, CategoryService categoryService,
            UploadService uploadService, BrandService brandService) {
        this.productService = productService;
        this.categoryService = categoryService;
        this.uploadService = uploadService;
        this.brandService = brandService;
    }

    @GetMapping
    public String getProductPage(Model model,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) Long categoryId,
            @RequestParam(required = false) Long brandId, // MỚI THÊM LỌC THEO HÃNG
            @RequestParam(required = false, defaultValue = "all") String status) {

        // Cập nhật hàm getAllProducts truyền thêm brandId
        model.addAttribute("products", productService.getAllProducts(keyword, categoryId, brandId, status));
        model.addAttribute("categories", categoryService.getAllCategories(null));
        model.addAttribute("brands", brandService.getAllBrands()); // Gửi danh sách hãng xuống View

        model.addAttribute("keyword", keyword);
        model.addAttribute("categoryId", categoryId);
        model.addAttribute("brandId", brandId);
        model.addAttribute("status", status);

        return "admin/product/show";
    }

    @GetMapping("/create")
    public String getCreatePage(Model model) {
        model.addAttribute("newProduct", new Product());
        model.addAttribute("categories", categoryService.getAllCategories(null));
        model.addAttribute("brands", brandService.getAllBrands());
        return "admin/product/create";
    }

    @PostMapping("/create")
    public String createProduct(@ModelAttribute("newProduct") Product product,
            @RequestParam("imageFiles") MultipartFile[] files,
            @RequestParam(value = "specNames", required = false) String[] specNames,
            @RequestParam(value = "specValues", required = false) String[] specValues) {

        if (product.getBrand() != null && product.getBrand().getId() == 0) {
            product.setBrand(null);
        }

        saveImages(product, files);
        handleSpecs(product, specNames, specValues);

        productService.handleSaveProduct(product);
        return "redirect:/admin/product";
    }

    @GetMapping("/update/{id}")
    public String getUpdatePage(Model model, @PathVariable long id) {
        Product currentProduct = productService.fetchProductById(id).get();
        model.addAttribute("newProduct", currentProduct);
        model.addAttribute("categories", categoryService.getAllCategories(null));
        model.addAttribute("brands", brandService.getAllBrands());
        return "admin/product/update";
    }

    @PostMapping("/update")
    public String updateProduct(@ModelAttribute("newProduct") Product product,
            @RequestParam("imageFiles") MultipartFile[] files,
            @RequestParam(value = "specNames", required = false) String[] specNames,
            @RequestParam(value = "specValues", required = false) String[] specValues,
            @RequestParam(value = "deleteImageIds", required = false) List<Long> deleteImageIds) {

        Product currentProduct = productService.fetchProductById(product.getId()).get();

        if (deleteImageIds != null && !deleteImageIds.isEmpty()) {
            currentProduct.getImages().removeIf(img -> deleteImageIds.contains(img.getId()));
        }
        saveImages(currentProduct, files);

        currentProduct.setName(product.getName());
        currentProduct.setPrice(product.getPrice());
        currentProduct.setQuantity(product.getQuantity());
        currentProduct.setCategory(product.getCategory());

        if (product.getBrand() != null && product.getBrand().getId() == 0) {
            currentProduct.setBrand(null);
        } else {
            currentProduct.setBrand(product.getBrand());
        }

        currentProduct.setOrigin(product.getOrigin());
        currentProduct.setShortDesc(product.getShortDesc());
        currentProduct.setDetailDesc(product.getDetailDesc());

        currentProduct.getSpecs().clear();
        handleSpecs(currentProduct, specNames, specValues);

        productService.handleSaveProduct(currentProduct);
        return "redirect:/admin/product";
    }

    @GetMapping("/delete/{id}")
    public String deleteProduct(@PathVariable long id, RedirectAttributes redirectAttributes) {
        try {
            productService.deleteProduct(id);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa sản phẩm thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Sản phẩm đã có lịch sử đơn hàng, không thể xóa! Vui lòng chọn 'Ngừng kinh doanh'.");
        }
        return "redirect:/admin/product";
    }

    private void handleSpecs(Product product, String[] specNames, String[] specValues) {
        if (specNames != null && specValues != null) {
            for (int i = 0; i < specNames.length; i++) {
                if (specNames[i] != null && !specNames[i].trim().isEmpty()) {
                    ProductSpec spec = new ProductSpec();
                    spec.setSpecName(specNames[i]);
                    spec.setSpecValue(specValues[i]);
                    spec.setProduct(product);
                    product.getSpecs().add(spec);
                }
            }
        }
    }

    private void saveImages(Product product, MultipartFile[] files) {
        if (product.getImages() == null)
            product.setImages(new ArrayList<>());
        for (MultipartFile file : files) {
            String fileName = uploadService.handleSaveUploadFile(file, "images");
            if (fileName != null) {
                ProductImage img = new ProductImage();
                img.setImageUrl(fileName);
                img.setProduct(product);
                product.getImages().add(img);
            }
        }
    }

    @GetMapping("/toggle-status/{id}")
    public String toggleProductStatus(@PathVariable long id, RedirectAttributes redirectAttributes) {
        productService.toggleProductStatus(id);
        redirectAttributes.addFlashAttribute("successMessage", "Đã cập nhật trạng thái kinh doanh của sản phẩm!");
        return "redirect:/admin/product";
    }
}