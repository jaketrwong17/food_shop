package com.example.shop.service;

import com.example.shop.domain.*;
import com.example.shop.repository.*;
import jakarta.servlet.http.HttpSession;

import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class OrderService {

    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final CartRepository cartRepository;
    private final ProductRepository productRepository;
    private final CartItemRepository cartItemRepository;
    private final VoucherRepository voucherRepository;
    private final UserRepository userRepository;

    public OrderService(OrderRepository orderRepository,
            OrderDetailRepository orderDetailRepository,
            CartRepository cartRepository,
            ProductRepository productRepository,
            CartItemRepository cartItemRepository,
            VoucherRepository voucherRepository,
            UserRepository userRepository) {
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
        this.cartRepository = cartRepository;
        this.productRepository = productRepository;
        this.cartItemRepository = cartItemRepository;
        this.voucherRepository = voucherRepository;
        this.userRepository = userRepository;
    }

    public List<Order> getAllOrders() {
        return this.orderRepository.findAll();
    }

    public Optional<Order> getOrderById(long id) {
        return this.orderRepository.findById(id);
    }

    public void handleSaveOrder(Order order) {
        this.orderRepository.save(order);
    }

    public void deleteOrderById(long id) {
        this.orderRepository.deleteById(id);
    }

    public Voucher getVoucherByCode(String code) {
        return this.voucherRepository.findByCode(code);
    }

    public Map<Long, Double> calculateDiscountBreakdown(List<CartItem> items, Voucher voucher) {
        Map<Long, Double> breakdown = new HashMap<>();
        if (voucher == null)
            return breakdown;

        if (voucher.isAll()) {
            for (CartItem item : items) {
                double itemTotal = item.getPrice() * item.getQuantity();
                double discount = itemTotal * (voucher.getDiscount() / 100.0);
                breakdown.put(item.getId(), discount);
            }
        } else {
            List<Category> allowedCategories = voucher.getCategories();
            for (CartItem item : items) {
                long productCategoryId = item.getProduct().getCategory().getId();
                boolean isMatch = allowedCategories.stream()
                        .anyMatch(cat -> cat.getId() == productCategoryId);
                if (isMatch) {
                    double itemTotal = item.getPrice() * item.getQuantity();
                    double discount = itemTotal * (voucher.getDiscount() / 100.0);
                    breakdown.put(item.getId(), discount);
                } else {
                    breakdown.put(item.getId(), 0.0);
                }
            }
        }
        return breakdown;
    }

    @Transactional(rollbackFor = Exception.class)
    public Order handlePlaceOrder(
            User user, HttpSession session,
            String receiverName, String receiverAddress, String receiverPhone, String paymentMethod,
            List<Long> cartItemIds, String voucherCode) throws Exception {

        Cart cart = this.cartRepository.findByUser(user);
        if (cart == null || cart.getCartItems().isEmpty())
            throw new Exception("Giỏ hàng trống!");

        List<CartItem> cartItems = cart.getCartItems();
        List<CartItem> itemsToOrder = new ArrayList<>();

        for (CartItem item : cartItems) {
            if (cartItemIds.contains(item.getId())) {
                Product product = item.getProduct();
                if (product.getQuantity() < item.getQuantity()) {
                    throw new Exception("Sản phẩm " + product.getName()
                            + " không đủ số lượng (Chỉ còn " + product.getQuantity() + ").");
                }
                itemsToOrder.add(item);
            }
        }

        if (itemsToOrder.isEmpty())
            throw new Exception("Chưa chọn sản phẩm nào để thanh toán.");

        double originalTotal = 0;
        double totalDiscount = 0;

        for (CartItem item : itemsToOrder) {
            // Lấy giá trị khuyến mại thực tế của sản phẩm
            double actualPrice = item.getPrice();
            if (item.getProduct().getDiscountedPrice() > 0) {
                actualPrice = item.getProduct().getDiscountedPrice();
            }
            originalTotal += actualPrice * item.getQuantity();
        }

        if (voucherCode != null && !voucherCode.isEmpty()) {
            Voucher voucher = this.voucherRepository.findByCode(voucherCode);
            if (voucher != null) {
                Map<Long, Double> breakdown = calculateDiscountBreakdown(itemsToOrder, voucher);
                for (Double d : breakdown.values()) {
                    totalDiscount += d;
                }
            }
        }

        double finalTotalPrice = originalTotal - totalDiscount;
        if (finalTotalPrice < 0)
            finalTotalPrice = 0;

        Order order = new Order();
        order.setUser(user);
        order.setReceiverName(receiverName);
        order.setReceiverAddress(receiverAddress);
        order.setReceiverPhone(receiverPhone);
        order.setPaymentMethod(paymentMethod);
        order.setStatus("PENDING");
        order.setTotalPrice(finalTotalPrice);
        order.setPaymentStatus(paymentMethod.equals("COD") ? "UNPAID" : "PENDING");
        order.setCreatedAt(new Date());

        order = this.orderRepository.save(order);

        // 2. Tạo OrderDetail và Trừ tồn kho Product
        for (CartItem item : itemsToOrder) {
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setOrder(order);
            orderDetail.setProduct(item.getProduct());

            // Lưu đơn giá đúng vào DB
            double actualPrice = item.getPrice();
            if (item.getProduct().getDiscountedPrice() > 0) {
                actualPrice = item.getProduct().getDiscountedPrice();
            }
            orderDetail.setPrice(actualPrice);

            orderDetail.setQuantity(item.getQuantity());

            Product product = item.getProduct();
            product.setQuantity(product.getQuantity() - item.getQuantity());
            this.productRepository.save(product);

            this.orderDetailRepository.save(orderDetail);
            this.cartItemRepository.deleteById(item.getId());
        }

        cart.getCartItems().removeIf(item -> cartItemIds.contains(item.getId()));
        int newSum = cart.getCartItems().size();
        cart.setSum(newSum);
        this.cartRepository.save(cart);
        session.setAttribute("sum", newSum);

        return order;
    }

    public List<Order> getAllOrders(String keyword) {
        if (keyword != null && !keyword.trim().isEmpty()) {
            return orderRepository.searchOrders(keyword);
        }
        return orderRepository.findAll(Sort.by(Sort.Direction.DESC, "id"));
    }

    public List<Order> getCompletedOrders(String email) {
        User user = userRepository.findByEmail(email);
        List<String> statuses = List.of("COMPLETED", "CANCELLED");
        return orderRepository.findByUserAndStatusInOrderByIdDesc(user, statuses);
    }

    public List<Order> getActiveOrders(String email) {
        User user = userRepository.findByEmail(email);
        List<String> statuses = List.of("PENDING", "CONFIRMED", "SHIPPING");
        return orderRepository.findByUserAndStatusInOrderByIdDesc(user, statuses);
    }

    @Transactional
    public List<OrderDetail> getOrderDetailsByOrderId(long id) {
        Optional<Order> orderOptional = this.orderRepository.findById(id);
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            order.getOrderDetails().size();
            return order.getOrderDetails();
        }
        return new ArrayList<>();
    }

    public boolean hasUserBoughtProduct(String email, long productId) {
        return orderDetailRepository.existsByOrderUserEmailAndProductIdAndOrderStatus(email, productId, "COMPLETED");
    }

    public Double calculateTotalRevenue() {
        return orderRepository.calculateTotalRevenue();
    }

    public long countAllOrders() {
        return orderRepository.countByStatus("COMPLETED");
    }

    public long countOrdersByStatus(String status) {
        return orderRepository.countByStatus(status);
    }

    public List<Object[]> getRevenueLast7Days() {
        return orderRepository.getRevenueLast7Days();
    }

    public List<Object[]> getRevenueThisMonth() {
        return orderRepository.getRevenueThisMonth();
    }

    public List<Object[]> getRevenueThisYear() {
        return orderRepository.getRevenueThisYear();
    }

    public Double calculateTotalRevenue(java.time.LocalDateTime start, java.time.LocalDateTime end) {
        return orderRepository.calculateTotalRevenueByDateRange(start, end);
    }

    public long countOrders(java.time.LocalDateTime start, java.time.LocalDateTime end) {
        return orderRepository.countOrdersByDateRange(start, end);
    }

    public long countOrdersByStatus(String status, java.time.LocalDateTime start, java.time.LocalDateTime end) {
        return orderRepository.countOrdersByStatusAndDateRange(status, start, end);
    }

    public List<Object[]> getRevenueChart(java.time.LocalDateTime start, java.time.LocalDateTime end) {
        return orderRepository.getRevenueChartByDateRange(start, end);
    }

    public List<Order> getAllOrders(String keyword, String status) {
        return orderRepository.searchOrders(keyword, status);
    }
}