package com.example.shop.domain;

import jakarta.persistence.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "promotions")
public class Promotion implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private String name;
    private String description;

    private double discountRate;

    // SỬA: Định dạng 'yyyy-MM-ddTHH:mm' để nhận được cả giờ phút từ form
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private Date startDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private Date endDate;

    private boolean active = true;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "product_promotion", joinColumns = @JoinColumn(name = "promotion_id"), inverseJoinColumns = @JoinColumn(name = "product_id"))
    private List<Product> products;

    public Promotion() {
    }

    // --- LOGIC TRẠNG THÁI (Tính theo Giờ & Phút) ---
    public boolean isExpired() {
        return this.endDate != null && new Date().after(this.endDate);
    }

    public boolean isUpcoming() {
        return this.startDate != null && new Date().before(this.startDate);
    }

    // --- Getter & Setter ---
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getDiscountRate() {
        return discountRate;
    }

    public void setDiscountRate(double discountRate) {
        this.discountRate = discountRate;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }
}