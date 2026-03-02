package com.example.shop.domain;

import jakarta.persistence.*;

@Entity
@Table(name = "banners")
public class Banner {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private String name; // Tên gợi nhớ (VD: Banner sale Tết)

    private String imageUrl; // Tên file ảnh

    private String link; // Đường dẫn khi khách click vào banner (Tuỳ chọn)

    @Column(columnDefinition = "boolean default true")
    private boolean active = true; // Trạng thái hiển thị (Bật/Tắt)

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

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }
}