package com.example.shop.service;

import com.example.shop.domain.Brand;
import com.example.shop.domain.Product;
import com.example.shop.domain.Promotion;
import com.example.shop.repository.BrandRepository;
import com.example.shop.repository.ProductRepository;
import com.example.shop.repository.PromotionRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PromotionService {
    private final PromotionRepository promotionRepository;
    private final ProductRepository productRepository;
    private final BrandRepository brandRepository;

    public PromotionService(PromotionRepository promotionRepository, ProductRepository productRepository,
            BrandRepository brandRepository) {
        this.promotionRepository = promotionRepository;
        this.productRepository = productRepository;
        this.brandRepository = brandRepository;
    }

    public List<Promotion> getAllPromotions() {
        return promotionRepository.findAll();
    }

    public Promotion getPromotionById(long id) {
        return promotionRepository.findById(id).orElse(null);
    }

    public void deletePromotion(long id) {
        promotionRepository.deleteById(id);
    }

    public void savePromotion(Promotion promotion, List<Long> productIds, List<Long> brandIds) {
        if (productIds != null) {
            List<Product> products = productRepository.findAllById(productIds);
            promotion.setProducts(products);
        } else {
            promotion.setProducts(null);
        }

        // --- PHẦN SỬA MỚI ---
        if (brandIds != null) {
            List<Brand> brands = brandRepository.findAllById(brandIds);
            promotion.setBrands(brands);
        } else {
            promotion.setBrands(null);
        }
        // --------------------

        promotionRepository.save(promotion);
    }

    // --- LOGIC MỚI: BẬT/TẮT NHANH ---
    public void toggleStatus(long id) {
        Optional<Promotion> promotionOptional = promotionRepository.findById(id);
        if (promotionOptional.isPresent()) {
            Promotion promotion = promotionOptional.get();
            promotion.setActive(!promotion.isActive()); // Đảo ngược trạng thái
            promotionRepository.save(promotion);
        }
    }
}