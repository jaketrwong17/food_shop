package com.example.shop.repository;

import com.example.shop.domain.Order;
import com.example.shop.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
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

    // Lấy doanh thu 7 ngày gần nhất (Chỉ tính đơn đã Hoàn thành)
    @Query(value = "SELECT DATE(created_at) as date, SUM(total_price) as sum " +
            "FROM orders " +
            "WHERE status = 'COMPLETED' AND created_at >= DATE(NOW()) - INTERVAL 7 DAY " +
            "GROUP BY DATE(created_at) " +
            "ORDER BY DATE(created_at) ASC", nativeQuery = true)
    List<Object[]> getRevenueLast7Days();

    // Doanh thu theo từng ngày trong THÁNG HIỆN TẠI
    @Query(value = "SELECT DATE(created_at) as date, SUM(total_price) as sum " +
            "FROM orders " +
            "WHERE status = 'COMPLETED' AND MONTH(created_at) = MONTH(NOW()) AND YEAR(created_at) = YEAR(NOW()) " +
            "GROUP BY DATE(created_at) " +
            "ORDER BY DATE(created_at) ASC", nativeQuery = true)
    List<Object[]> getRevenueThisMonth();

    // Doanh thu theo từng tháng trong NĂM HIỆN TẠI
    @Query(value = "SELECT MONTH(created_at) as month, SUM(total_price) as sum " +
            "FROM orders " +
            "WHERE status = 'COMPLETED' AND YEAR(created_at) = YEAR(NOW()) " +
            "GROUP BY MONTH(created_at) " +
            "ORDER BY MONTH(created_at) ASC", nativeQuery = true)
    List<Object[]> getRevenueThisYear();

    // 1. Tính tổng doanh thu theo khoảng thời gian
    @Query("SELECT SUM(o.totalPrice) FROM Order o WHERE o.status = 'COMPLETED' AND o.createdAt BETWEEN :startDate AND :endDate")
    Double calculateTotalRevenueByDateRange(@Param("startDate") java.time.LocalDateTime startDate,
            @Param("endDate") java.time.LocalDateTime endDate);

    // 2. Đếm tổng số đơn hàng theo khoảng thời gian
    @Query("SELECT COUNT(o) FROM Order o WHERE o.createdAt BETWEEN :startDate AND :endDate")
    long countOrdersByDateRange(@Param("startDate") java.time.LocalDateTime startDate,
            @Param("endDate") java.time.LocalDateTime endDate);

    // 3. Đếm số đơn hàng theo trạng thái VÀ khoảng thời gian
    @Query("SELECT COUNT(o) FROM Order o WHERE o.status = :status AND o.createdAt BETWEEN :startDate AND :endDate")
    long countOrdersByStatusAndDateRange(@Param("status") String status,
            @Param("startDate") java.time.LocalDateTime startDate, @Param("endDate") java.time.LocalDateTime endDate);

    // 4. Lấy dữ liệu vẽ biểu đồ theo khoảng thời gian
    @Query(value = "SELECT DATE(created_at) as date, SUM(total_price) as sum " +
            "FROM orders " +
            "WHERE status = 'COMPLETED' AND created_at BETWEEN :startDate AND :endDate " +
            "GROUP BY DATE(created_at) " +
            "ORDER BY DATE(created_at) ASC", nativeQuery = true)
    List<Object[]> getRevenueChartByDateRange(@Param("startDate") java.time.LocalDateTime startDate,
            @Param("endDate") java.time.LocalDateTime endDate);

    // Lọc theo cả từ khóa (tên, sđt) và trạng thái
    @Query("SELECT o FROM Order o WHERE " +
            "(:status IS NULL OR :status = '' OR o.status = :status) AND " +
            "(:keyword IS NULL OR :keyword = '' OR o.receiverName LIKE %:keyword% OR o.receiverPhone LIKE %:keyword%) "
            +
            "ORDER BY o.id DESC")
    List<Order> searchOrders(@Param("keyword") String keyword, @Param("status") String status);

}