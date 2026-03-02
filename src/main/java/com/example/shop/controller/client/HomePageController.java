package com.example.shop.controller.client;

import com.example.shop.domain.Product;
import com.example.shop.domain.Voucher;
import com.example.shop.domain.dto.TopProductDTO;
import com.example.shop.service.BannerService; // IMPORT THÊM BANNER SERVICE
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

import java.util.List;

@Controller
public class HomePageController {

    private final ProductService productService;
    private final CategoryService categoryService;
    private final VoucherService voucherService;
    private final BrandService brandService;
    private final BannerService bannerService; // KHAI BÁO THÊM BIẾN

    // BỔ SUNG BANNER SERVICE VÀO CONSTRUCTOR
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

        model.addAttribute("bestSellingProducts", bestSellingProducts);
        model.addAttribute("products", products);
        model.addAttribute("categories", categoryService.getAllCategories(null));
        model.addAttribute("brands", brandService.getAllBrands());
        model.addAttribute("vouchers", vouchers);

        // DÒNG NÀY RẤT QUAN TRỌNG ĐỂ HIỂN THỊ BANNER RA NGOÀI TRANG CHỦ
        model.addAttribute("banners", bannerService.getActiveBanners());

        return "client/homepage/show";
    }
}