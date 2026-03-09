package com.example.shop.controller.client;

import com.example.shop.domain.Product;
import com.example.shop.domain.Voucher;
import com.example.shop.domain.dto.TopProductDTO;
import com.example.shop.service.BannerService;
import com.example.shop.service.BrandService;
import com.example.shop.service.CategoryService;
import com.example.shop.service.ProductService;
import com.example.shop.service.VoucherService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

@Controller
public class HomePageController {

    private final ProductService productService;
    private final CategoryService categoryService;
    private final VoucherService voucherService;
    private final BrandService brandService;
    private final BannerService bannerService;

    public HomePageController(ProductService productService,
            CategoryService categoryService,
            VoucherService voucherService,
            BrandService brandService,
            BannerService bannerService) {
        this.productService = productService;
        this.categoryService = categoryService;
        this.voucherService = voucherService;
        this.brandService = brandService;
        this.bannerService = bannerService;
    }

    @GetMapping("/")
    public String getHomePage(Model model,
            HttpServletRequest request,
            @RequestParam(required = false) String search,
            @RequestParam(required = false) Long categoryId,
            @RequestParam(required = false) Long brandId,
            @RequestParam(required = false) String origin,
            @RequestParam(required = false) String sort) {

        HttpSession session = request.getSession(true);
        if (session.getAttribute("sum") == null) {
            session.setAttribute("sum", 0);
        }

        List<Product> products;

        if (search != null || categoryId != null || brandId != null || origin != null || sort != null) {
            products = productService.getAllProducts(search, categoryId, brandId, origin, sort);
        } else {
            Pageable pageable = PageRequest.of(0, 100);
            Page<Product> pageProducts = productService.getAllProductsWithPaging(pageable, sort);
            products = pageProducts.getContent();
        }

        List<Voucher> vouchers = voucherService.getAllVouchers();
        List<TopProductDTO> bestSellingProducts = productService.getBestSellingProducts(10);

        // --- TẠO DANH SÁCH QUỐC GIA (XUẤT XỨ) ---
        List<String> origins = Arrays.asList(
                // Châu Á (Phổ biến)
                "Việt Nam", "Thái Lan", "Nhật Bản", "Hàn Quốc", "Đài Loan", "Trung Quốc", "Ấn Độ", "Indonesia",
                "Malaysia",
                // Châu Mỹ (Nông sản, thịt, trái cây)
                "Mỹ", "Canada", "Brazil", "Argentina", "Chile", "Colombia", "Peru",
                // Châu Âu (Sữa, bánh kẹo, rượu, đồ hộp)
                "Đức", "Pháp", "Ý", "Anh", "Hà Lan", "Tây Ban Nha", "Bỉ", "Thụy Sĩ", "Nga",
                // Châu Đại Dương (Thịt, sữa)
                "Úc", "New Zealand",
                // Châu Phi & Trung Phi (Cà phê, ca cao, hạt điều, chè...)
                "Nam Phi", "Ai Cập", "Kenya", "Cộng hòa Dân chủ Congo", "Cameroon", "Bờ Biển Ngà", "Ghana", "Ethiopia",
                "Nigeria", "Uganda");

        // Sắp xếp list theo thứ tự bảng chữ cái để user dễ tìm
        Collections.sort(origins);

        model.addAttribute("origins", origins); // Đẩy xuống JSP
        // ----------------------------------------

        model.addAttribute("bestSellingProducts", bestSellingProducts);
        model.addAttribute("products", products);
        model.addAttribute("categories", categoryService.getAllCategories(null));
        model.addAttribute("brands", brandService.getAllBrands());
        model.addAttribute("vouchers", vouchers);
        model.addAttribute("banners", bannerService.getActiveBanners());

        return "client/homepage/show";
    }
}