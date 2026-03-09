package com.example.shop.repository;

import com.example.shop.domain.Product;
import com.example.shop.domain.dto.TopProductDTO;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {

    List<Product> findByNameContainingIgnoreCaseAndCategoryId(String name, Long categoryId);

    List<Product> findByNameContainingIgnoreCase(String name);

    List<Product> findByCategoryId(Long categoryId);

    // Các hàm phục vụ sắp xếp (Sort)
    List<Product> findByNameContainingIgnoreCaseAndCategoryId(String name, Long categoryId, Sort sort);

    List<Product> findByNameContainingIgnoreCase(String name, Sort sort);

    List<Product> findByCategoryId(Long categoryId, Sort sort);

    @Query("SELECT p FROM Product p ORDER BY CASE WHEN p.quantity > 0 THEN 0 ELSE 1 END ASC, p.id DESC")
    Page<Product> findAllSortedByStock(Pageable pageable);

    long count();

    // === ĐÃ FIX LỖI NHÂN BẢN DỮ LIỆU (CARTESIAN PRODUCT) ===
    // Dùng Subquery để lấy ảnh thay vì LEFT JOIN để tránh quantity bị nhân lên theo
    // số lượng ảnh
    @Query("SELECT new com.example.shop.domain.dto.TopProductDTO(" +
            "p.id, " +
            "p.name, " +
            "(SELECT MIN(img.imageUrl) FROM ProductImage img WHERE img.product.id = p.id), " +
            "SUM(od.quantity), " +
            "SUM(od.price * od.quantity), " +
            "p.active) " +
            "FROM OrderDetail od " +
            "JOIN od.product p " +
            "JOIN od.order o " +
            "WHERE o.status <> 'CANCELLED' " + // Loại bỏ các đơn hàng đã bị Hủy
            "GROUP BY p.id, p.name, p.active " +
            "ORDER BY SUM(od.quantity) DESC")
    List<TopProductDTO> findBestSellingProducts(Pageable pageable);

    // Thêm hàm đếm sản phẩm có số lượng nhỏ hơn hoặc bằng một mức nào đó
    long countByQuantityLessThanEqual(long quantity);
}