package com.example.shop.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "brands")
public class Brand implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    // Tên hãng không được null và nên là duy nhất
    @Column(nullable = false, unique = true)
    private String name;

    // Tuỳ chọn: Dùng để hiển thị logo của hãng trên giao diện (VD: logo Apple,
    // Samsung...)
    private String logoUrl;

    @Column(columnDefinition = "TEXT")
    private String description;

    // Mối quan hệ 1-N: Một hãng có thể có nhiều sản phẩm
    // mappedBy = "brand" trỏ tới tên biến 'brand' trong class Product
    @OneToMany(mappedBy = "brand", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Product> products = new ArrayList<>();

    public Brand() {
    }

    // --- GETTER & SETTER ---

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

    public String getLogoUrl() {
        return logoUrl;
    }

    public void setLogoUrl(String logoUrl) {
        this.logoUrl = logoUrl;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }
}