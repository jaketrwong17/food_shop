package com.example.shop.service;

import com.example.shop.domain.Brand;
import com.example.shop.repository.BrandRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BrandService {

    private final BrandRepository brandRepository;

    public BrandService(BrandRepository brandRepository) {
        this.brandRepository = brandRepository;
    }

    public List<Brand> getAllBrands() {
        return brandRepository.findAll();
    }

    public List<Brand> searchBrands(String keyword) {
        if (keyword != null && !keyword.trim().isEmpty()) {
            return brandRepository.findByNameContainingIgnoreCase(keyword.trim());
        }
        return brandRepository.findAll();
    }

    public Brand getBrandById(long id) {
        return brandRepository.findById(id).orElse(null);
    }

    public Brand saveBrand(Brand brand) {
        return brandRepository.save(brand);
    }

    public void deleteBrand(long id) {
        brandRepository.deleteById(id);
    }
}