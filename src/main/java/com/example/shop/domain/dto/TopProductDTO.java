package com.example.shop.domain.dto;

public class TopProductDTO {
    private Long productId;
    private String productName;
    private String productImage;
    private Long quantitySold;
    private Double totalRevenue;
    private boolean active; // === 1. THÊM TRƯỜNG NÀY ===

    // === 2. SỬA LẠI CONSTRUCTOR (Thêm tham số boolean active vào cuối) ===
    public TopProductDTO(Long productId, String productName, String productImage, Long quantitySold,
            Double totalRevenue, boolean active) {
        this.productId = productId;
        this.productName = productName;
        this.productImage = productImage;
        this.quantitySold = quantitySold;
        this.totalRevenue = totalRevenue;
        this.active = active;
    }

    // === 3. THÊM GETTER/SETTER CHO ACTIVE ===
    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    // --- CÁC GETTER/SETTER CŨ GIỮ NGUYÊN ---
    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public String getProductImage() {
        return productImage;
    }

    public Long getQuantitySold() {
        return quantitySold;
    }

    public Double getTotalRevenue() {
        return totalRevenue;
    }
}