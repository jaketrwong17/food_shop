package com.example.shop.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date; // Cần thêm import này để so sánh ngày tháng
import java.util.List;
import java.util.ArrayList;
import org.hibernate.annotations.Formula;

@Entity
@Table(name = "products")
public class Product implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(nullable = false)
    private String name;

    private double price;

    // Thêm trường active cho Soft Delete (Mặc định là true - Đang kinh doanh)
    @Column(columnDefinition = "boolean default true")
    private boolean active = true;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER)
    private List<ProductImage> images = new ArrayList<>();

    @Column(columnDefinition = "TEXT")
    private String detailDesc;

    @Column(columnDefinition = "TEXT")
    private String shortDesc;

    private long quantity;
    private long sold;
    private String factory;
    private String target;

    @ManyToOne
    @JoinColumn(name = "category_id")
    private Category category;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER)
    private List<ProductSpec> specs = new ArrayList<>();

    // --- PHẦN MỚI THÊM: LIÊN KẾT VỚI PROMOTION (KHUYẾN MÃI) ---
    @ManyToMany(mappedBy = "products", fetch = FetchType.LAZY)
    private List<Promotion> promotions = new ArrayList<>();

    // Các trường tính toán (Formula)
    @Formula("(SELECT COALESCE(AVG(r.rating), 0) FROM reviews r WHERE r.product_id = id)")
    private double averageRating;

    @Formula("(SELECT COUNT(r.id) FROM reviews r WHERE r.product_id = id)")
    private int reviewCount;

    public Product() {
    }

    // --- LOGIC TÍNH GIÁ KHUYẾN MÃI (Transient: Không lưu vào DB) ---

    // Tính giá thực tế sau khi giảm (Dùng để bán và hiển thị)
    @Transient
    public double getDiscountedPrice() {
        double currentPrice = this.price;
        // Nếu không có khuyến mãi nào thì trả về giá gốc
        if (this.promotions == null || this.promotions.isEmpty()) {
            return currentPrice;
        }

        Date now = new Date();
        double maxDiscount = 0;

        // Duyệt qua các khuyến mãi, tìm cái nào đang hoạt động và có mức giảm cao nhất
        for (Promotion p : this.promotions) {
            if (p.isActive() && p.getStartDate().before(now) && p.getEndDate().after(now)) {
                if (p.getDiscountRate() > maxDiscount) {
                    maxDiscount = p.getDiscountRate();
                }
            }
        }

        if (maxDiscount > 0) {
            // Giá sau giảm = Giá gốc - (Giá gốc * %giảm / 100)
            return currentPrice - (currentPrice * maxDiscount / 100.0);
        }

        return currentPrice;
    }

    // Kiểm tra xem sản phẩm có đang được giảm giá không (để hiện nhãn SALE)
    @Transient
    public boolean isOnSale() {
        return this.getDiscountedPrice() < this.price;
    }

    // Lấy phần trăm giảm giá để hiển thị (Ví dụ: -20%)
    @Transient
    public int getDiscountPercentage() {
        if (!isOnSale())
            return 0;
        return (int) Math.round(((this.price - getDiscountedPrice()) / this.price) * 100);
    }

    // --- GETTER & SETTER ---

    public List<Promotion> getPromotions() {
        return promotions;
    }

    public void setPromotions(List<Promotion> promotions) {
        this.promotions = promotions;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

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

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public List<ProductImage> getImages() {
        return images;
    }

    public void setImages(List<ProductImage> images) {
        this.images = images;
    }

    public String getDetailDesc() {
        return detailDesc;
    }

    public void setDetailDesc(String detailDesc) {
        this.detailDesc = detailDesc;
    }

    public String getShortDesc() {
        return shortDesc;
    }

    public void setShortDesc(String shortDesc) {
        this.shortDesc = shortDesc;
    }

    public long getQuantity() {
        return quantity;
    }

    public void setQuantity(long quantity) {
        this.quantity = quantity;
    }

    public long getSold() {
        return sold;
    }

    public void setSold(long sold) {
        this.sold = sold;
    }

    public String getFactory() {
        return factory;
    }

    public void setFactory(String factory) {
        this.factory = factory;
    }

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public List<ProductSpec> getSpecs() {
        return specs;
    }

    public void setSpecs(List<ProductSpec> specs) {
        this.specs = specs;
    }

    public double getAverageRating() {
        return averageRating;
    }

    public int getReviewCount() {
        return reviewCount;
    }

    @Override
    public String toString() {
        return "Product [id=" + id + ", name=" + name + ", price=" + price + "]";
    }

    public String getImage() {
        if (this.images != null && !this.images.isEmpty()) {
            return this.images.get(0).getImageUrl();
        }
        return "";
    }
}