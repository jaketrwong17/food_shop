package com.example.shop.service;

import com.example.shop.domain.Banner;
import com.example.shop.repository.BannerRepository;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class BannerService {
    private final BannerRepository bannerRepository;

    public BannerService(BannerRepository bannerRepository) {
        this.bannerRepository = bannerRepository;
    }

    public List<Banner> getAllBanners() {
        return bannerRepository.findAll();
    }

    public List<Banner> getActiveBanners() {
        return bannerRepository.findByActiveTrue();
    }

    public Banner getBannerById(long id) {
        return bannerRepository.findById(id).orElse(null);
    }

    public Banner saveBanner(Banner banner) {
        return bannerRepository.save(banner);
    }

    public void deleteBanner(long id) {
        bannerRepository.deleteById(id);
    }
}