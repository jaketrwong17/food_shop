package com.example.shop.controller.client;

import com.example.shop.config.VnPayConfig;
import com.example.shop.domain.Cart;
import com.example.shop.domain.CartItem;
import com.example.shop.domain.Order;
import com.example.shop.domain.User;
import com.example.shop.domain.Voucher;
import com.example.shop.service.CategoryService;
import com.example.shop.service.OrderService;
import com.example.shop.service.ProductService;
import com.example.shop.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import java.text.SimpleDateFormat;
import java.util.*;

@Controller("clientOrderController")
public class OrderController {

    private final OrderService orderService;
    private final UserService userService;
    private final ProductService productService;
    private final CategoryService categoryService;

    public OrderController(OrderService orderService, UserService userService,
            ProductService productService, CategoryService categoryService) {
        this.orderService = orderService;
        this.userService = userService;
        this.productService = productService;
        this.categoryService = categoryService;
    }

    // Trang thanh toán (GIỮ NGUYÊN)
    @GetMapping("/checkout")
    public String getCheckoutPage(Model model, HttpServletRequest request,
            @RequestParam(required = false) List<Long> selectedIds,
            @RequestParam(required = false) String voucherCode) {

        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        if (email == null)
            return "redirect:/login";

        User user = this.userService.getUserByEmail(email);
        Cart cart = this.productService.fetchCartByUserEmail(email);

        if (cart == null || cart.getCartItems().isEmpty() || selectedIds == null || selectedIds.isEmpty()) {
            return "redirect:/cart";
        }

        List<CartItem> displayItems = new ArrayList<>();
        for (CartItem item : cart.getCartItems()) {
            if (selectedIds.contains(item.getId()))
                displayItems.add(item);
        }

        double originalPrice = 0;
        for (CartItem item : displayItems)
            originalPrice += item.getPrice() * item.getQuantity();

        double discountAmount = 0;
        Voucher voucher = null;
        Map<Long, Double> discountMap = new HashMap<>();

        if (voucherCode != null && !voucherCode.isEmpty()) {
            voucher = this.orderService.getVoucherByCode(voucherCode);
            if (voucher != null) {
                discountMap = this.orderService.calculateDiscountBreakdown(displayItems, voucher);
                for (Double val : discountMap.values())
                    discountAmount += val;
                model.addAttribute("voucher", voucher);
                model.addAttribute("successMessage", "Đã áp dụng mã: " + voucher.getCode());
            } else {
                model.addAttribute("errorMessage", "Mã giảm giá không hợp lệ!");
            }
        }

        double totalPrice = originalPrice - discountAmount;
        if (totalPrice < 0)
            totalPrice = 0;

        model.addAttribute("displayItems", displayItems);
        model.addAttribute("originalPrice", originalPrice);
        model.addAttribute("discountAmount", discountAmount);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("user", user);
        model.addAttribute("selectedIds", selectedIds);
        model.addAttribute("voucherCode", voucherCode);
        model.addAttribute("discountMap", discountMap);
        model.addAttribute("categories", categoryService.getAllCategories(null));

        return "client/cart/checkout";
    }

    // Xử lý đặt hàng (ĐÃ SỬA: THÊM LOGIC VNPAY)
    @PostMapping("/place-order")
    public String handlePlaceOrder(
            @RequestParam("receiverName") String receiverName,
            @RequestParam("receiverAddress") String receiverAddress,
            @RequestParam("receiverPhone") String receiverPhone,
            @RequestParam("paymentMethod") String paymentMethod,
            @RequestParam(value = "cartItemIds", required = false) List<Long> cartItemIds,
            @RequestParam(value = "voucherCode", required = false) String voucherCode,
            HttpServletRequest request) {

        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        if (email == null)
            return "redirect:/login";

        if (cartItemIds == null || cartItemIds.isEmpty()) {
            return "redirect:/cart?error=Vui lòng chọn sản phẩm";
        }

        User user = this.userService.getUserByEmail(email);

        // --- 1. XỬ LÝ THANH TOÁN VNPAY ---
        if ("VNPAY".equals(paymentMethod)) {
            try {
                // Tính tổng tiền
                Cart cart = this.productService.fetchCartByUserEmail(email);
                double totalPrice = 0;
                List<CartItem> itemsToPay = new ArrayList<>();
                if (cart != null) {
                    for (CartItem item : cart.getCartItems()) {
                        if (cartItemIds.contains(item.getId())) {
                            itemsToPay.add(item);
                            totalPrice += item.getPrice() * item.getQuantity();
                        }
                    }
                }
                // Trừ khuyến mãi
                if (voucherCode != null && !voucherCode.isEmpty()) {
                    Voucher voucher = this.orderService.getVoucherByCode(voucherCode);
                    if (voucher != null) {
                        Map<Long, Double> discountMap = this.orderService.calculateDiscountBreakdown(itemsToPay,
                                voucher);
                        for (Double val : discountMap.values())
                            totalPrice -= val;
                    }
                }
                long vnp_Amount = (long) (totalPrice * 100);

                // === QUAN TRỌNG: LƯU SESSION VỚI TÊN CHUẨN "order_..." ===
                session.setAttribute("order_receiverName", receiverName);
                session.setAttribute("order_receiverAddress", receiverAddress);
                session.setAttribute("order_receiverPhone", receiverPhone);
                session.setAttribute("order_cartItemIds", cartItemIds);
                session.setAttribute("order_voucherCode", voucherCode);

                // Tạo URL VNPAY
                String vnp_TxnRef = VnPayConfig.getRandomNumber(8);
                String vnp_IpAddr = VnPayConfig.getIpAddress(request);
                Map<String, String> vnp_Params = new HashMap<>();
                vnp_Params.put("vnp_Version", VnPayConfig.vnp_Version);
                vnp_Params.put("vnp_Command", VnPayConfig.vnp_Command);
                vnp_Params.put("vnp_TmnCode", VnPayConfig.vnp_TmnCode);
                vnp_Params.put("vnp_Amount", String.valueOf(vnp_Amount));
                vnp_Params.put("vnp_CurrCode", "VND");
                vnp_Params.put("vnp_BankCode", "NCB");
                vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
                vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang:" + vnp_TxnRef);
                vnp_Params.put("vnp_OrderType", "other");
                vnp_Params.put("vnp_Locale", "vn");
                vnp_Params.put("vnp_ReturnUrl", VnPayConfig.vnp_ReturnUrl);
                vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

                // Tạo ngày tháng
                Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
                SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
                vnp_Params.put("vnp_CreateDate", formatter.format(cld.getTime()));
                cld.add(Calendar.MINUTE, 15);
                vnp_Params.put("vnp_ExpireDate", formatter.format(cld.getTime()));

                // Build URL
                List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
                Collections.sort(fieldNames);
                StringBuilder hashData = new StringBuilder();
                StringBuilder query = new StringBuilder();
                Iterator<String> itr = fieldNames.iterator();
                while (itr.hasNext()) {
                    String fieldName = itr.next();
                    String fieldValue = vnp_Params.get(fieldName);
                    if ((fieldValue != null) && (fieldValue.length() > 0)) {
                        hashData.append(fieldName).append('=')
                                .append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                        query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString())).append('=')
                                .append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                        if (itr.hasNext()) {
                            query.append('&');
                            hashData.append('&');
                        }
                    }
                }
                String queryUrl = query.toString();
                String vnp_SecureHash = VnPayConfig.hmacSHA512(VnPayConfig.vnp_HashSecret, hashData.toString());
                queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;

                return "redirect:" + VnPayConfig.vnp_PayUrl + "?" + queryUrl;

            } catch (Exception e) {
                e.printStackTrace();
                return "redirect:/checkout?error=Lỗi thanh toán VNPAY";
            }
        }

        // --- 2. XỬ LÝ COD (GIỮ NGUYÊN) ---
        try {
            this.orderService.handlePlaceOrder(user, session, receiverName, receiverAddress,
                    receiverPhone, paymentMethod, cartItemIds, voucherCode);
            return "redirect:/thanks";
        } catch (Exception e) {
            // ... xử lý lỗi
            return "redirect:/checkout?error=" + e.getMessage();
        }
    }

    // Xử lý Callback từ VNPAY (MỚI THÊM VÀO)
    // Sửa lại hàm này trong OrderController.java
    @GetMapping("/vnpay-return")
    public String handleVnPayReturn(HttpServletRequest request, Model model) {
        try {
            // Lấy params
            Map<String, String> fields = new HashMap<>();
            for (Enumeration<String> params = request.getParameterNames(); params.hasMoreElements();) {
                String fieldName = params.nextElement();
                String fieldValue = request.getParameter(fieldName);
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    fields.put(fieldName, fieldValue);
                }
            }

            String vnp_SecureHash = request.getParameter("vnp_SecureHash");
            if (fields.containsKey("vnp_SecureHashType"))
                fields.remove("vnp_SecureHashType");
            if (fields.containsKey("vnp_SecureHash"))
                fields.remove("vnp_SecureHash");

            // Checksum
            String signValue = VnPayConfig.hashAllFields(fields);

            if (signValue.equals(vnp_SecureHash)) {
                if ("00".equals(request.getParameter("vnp_ResponseCode"))) {

                    HttpSession session = request.getSession(false);
                    if (session == null)
                        return "redirect:/login";

                    // === LẤY ĐÚNG TÊN BIẾN ĐÃ LƯU Ở TRÊN ===
                    String receiverName = (String) session.getAttribute("order_receiverName");
                    String receiverAddress = (String) session.getAttribute("order_receiverAddress");
                    String receiverPhone = (String) session.getAttribute("order_receiverPhone");
                    List<Long> cartItemIds = (List<Long>) session.getAttribute("order_cartItemIds");
                    String voucherCode = (String) session.getAttribute("order_voucherCode");
                    String email = (String) session.getAttribute("email");

                    // Kiểm tra dữ liệu Session có tồn tại không
                    if (cartItemIds == null || cartItemIds.isEmpty()) {
                        return "redirect:/checkout?error=" + URLEncoder
                                .encode("Lỗi: Mất thông tin giỏ hàng. Vui lòng thử lại.", StandardCharsets.UTF_8);
                    }

                    User user = this.userService.getUserByEmail(email);

                    // Lưu đơn hàng thật
                    this.orderService.handlePlaceOrder(user, session, receiverName, receiverAddress,
                            receiverPhone, "VNPAY", cartItemIds, voucherCode);

                    // Dọn dẹp session
                    session.removeAttribute("order_cartItemIds");
                    session.removeAttribute("order_receiverName");
                    session.removeAttribute("order_receiverAddress");
                    session.removeAttribute("order_receiverPhone");
                    session.removeAttribute("order_voucherCode");

                    return "redirect:/thanks";
                } else {
                    return "redirect:/checkout?error="
                            + URLEncoder.encode("Giao dịch bị hủy hoặc thất bại", StandardCharsets.UTF_8);
                }
            } else {
                return "redirect:/checkout?error=" + URLEncoder.encode("Sai chữ ký bảo mật", StandardCharsets.UTF_8);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/checkout?error=" + URLEncoder.encode("Lỗi xử lý hóa đơn", StandardCharsets.UTF_8);
        }
    }

    // Trang cảm ơn (GIỮ NGUYÊN)
    @GetMapping("/thanks")
    public String getThankYouPage(Model model) {
        model.addAttribute("categories", categoryService.getAllCategories(null));
        return "client/cart/thanks";
    }

    // Trang lịch sử đơn hàng (GIỮ NGUYÊN)
    @GetMapping("/order-history")
    public String getHistoryPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        if (email == null)
            return "redirect:/login";

        model.addAttribute("categories", categoryService.getAllCategories(null));
        model.addAttribute("historyOrders", orderService.getCompletedOrders(email));

        return "client/order/history";
    }

    // Trang theo dõi đơn hàng (GIỮ NGUYÊN)
    @GetMapping("/order-tracking")
    public String getTrackingPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        if (email == null)
            return "redirect:/login";

        model.addAttribute("categories", categoryService.getAllCategories(null));
        model.addAttribute("activeOrders", orderService.getActiveOrders(email));

        return "client/order/tracking";
    }

    // Xử lý hủy đơn hàng (GIỮ NGUYÊN)
    @GetMapping("/order/cancel/{id}")
    public String handleCancelOrder(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        if (email == null)
            return "redirect:/login";

        Optional<Order> orderOptional = orderService.getOrderById(id);
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            if (order.getStatus().equals("PENDING")) {
                order.setStatus("CANCELLED");
                orderService.handleSaveOrder(order);
            }
        }
        return "redirect:/order-tracking";
    }

    // Xem chi tiết đơn hàng (GIỮ NGUYÊN)
    @GetMapping("/order-detail/{id}")
    public String getOrderDetailPage(Model model, @PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        if (email == null)
            return "redirect:/login";

        User user = userService.getUserByEmail(email);
        Optional<Order> orderOptional = orderService.getOrderById(id);

        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            if (order.getUser().getId() != user.getId()) {
                return "redirect:/order-history";
            }
            model.addAttribute("order", order);
            model.addAttribute("orderDetails", orderService.getOrderDetailsByOrderId(id));
        } else {
            return "redirect:/order-history";
        }

        model.addAttribute("categories", categoryService.getAllCategories(null));
        return "client/order/detail";
    }
}