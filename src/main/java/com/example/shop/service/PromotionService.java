package com.example.shop.service;

import com.example.shop.domain.Product;
import com.example.shop.domain.Promotion;
import com.example.shop.repository.ProductRepository;
import com.example.shop.repository.PromotionRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class PromotionService {
    private final PromotionRepository promotionRepository;
    private final ProductRepository productRepository;

    public PromotionService(PromotionRepository promotionRepository, ProductRepository productRepository) {
        this.promotionRepository = promotionRepository;
        this.productRepository = productRepository;
    }

    public List<Promotion> getAllPromotions() {
        return promotionRepository.findAll();
    }

    public void savePromotion(Promotion promotion, List<Long> productIds) {
        if (productIds != null) {
            List<Product> products = productRepository.findAllById(productIds);
            promotion.setProducts(products);
        }
        promotionRepository.save(promotion);
    }

    public Promotion getPromotionById(long id) {
        return promotionRepository.findById(id).orElse(null);
    }

    public void deletePromotion(long id) {
        promotionRepository.deleteById(id);
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