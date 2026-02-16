package com.example.shop.repository;

import com.example.shop.domain.Order;
import com.example.shop.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {

    // 1. Lấy danh sách đơn hàng của User (giữ nguyên)
    List<Order> findByUserOrderByIdDesc(User user);

    @Query("SELECT o FROM Order o WHERE " +
            "o.receiverName LIKE %?1% OR " +
            "o.receiverPhone LIKE %?1% OR " +
            "CAST(o.id as string) LIKE %?1%")
    List<Order> searchOrders(String keyword);

    // 2. Lấy lịch sử đơn hàng theo trạng thái (giữ nguyên)
    List<Order> findByUserAndStatusInOrderByIdDesc(User user, List<String> status);

    // === THÊM DÒNG NÀY (Hỗ trợ logic chặn khóa tài khoản) ===
    // Tìm các đơn hàng của User mà trạng thái KHÔNG nằm trong danh sách (Ví dụ:
    // Không phải COMPLETE hay CANCEL)
    List<Order> findByUserAndStatusNotIn(User user, List<String> status);
    // ========================================================

    @Query("SELECT SUM(o.totalPrice) FROM Order o WHERE o.status = 'COMPLETED'")
    Double calculateTotalRevenue();

    long countByStatus(String status);

    long count();
}