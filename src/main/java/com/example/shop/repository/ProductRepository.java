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

    // === SỬA QUERY DƯỚI ĐÂY (Thêm p.active vào SELECT và GROUP BY) ===
    @Query("SELECT new com.example.shop.domain.dto.TopProductDTO(" +
            "p.id, " +
            "p.name, " +
            "MIN(i.imageUrl), " +
            "SUM(od.quantity), " +
            "SUM(od.price * od.quantity), " +
            "p.active) " + // Thêm tham số active vào constructor
            "FROM OrderDetail od " +
            "JOIN od.product p " +
            "LEFT JOIN p.images i " +
            "JOIN od.order o " +
            "WHERE o.status = 'COMPLETED' " +
            "GROUP BY p.id, p.name, p.active " + // Thêm p.active vào Group By
            "ORDER BY SUM(od.quantity) DESC")
    List<TopProductDTO> findBestSellingProducts(Pageable pageable);
}