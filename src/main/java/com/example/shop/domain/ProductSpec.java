
package com.example.shop.domain;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "product_specs")
public class ProductSpec implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private String specName;
    private String specValue;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

    public ProductSpec() {
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getSpecName() {
        return specName;
    }

    public void setSpecName(String specName) {
        this.specName = specName;
    }

    public String getSpecValue() {
        return specValue;
    }

    public void setSpecValue(String specValue) {
        this.specValue = specValue;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}