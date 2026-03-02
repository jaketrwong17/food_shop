package com.example.shop.service;

import com.example.shop.domain.Cart;
import com.example.shop.domain.CartItem;
import com.example.shop.domain.Product;
import com.example.shop.domain.User;
import com.example.shop.domain.dto.TopProductDTO;
import com.example.shop.repository.CartItemRepository;
import com.example.shop.repository.CartRepository;
import com.example.shop.repository.ProductRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class ProductService {

    private final CartRepository cartRepository;
    private final CartItemRepository cartItemRepository;
    private final ProductRepository productRepository;
    // ĐÃ XÓA: private final ProductColorRepository productColorRepository;
    private final UserService userService;

    public ProductService(CartRepository cartRepository,
            CartItemRepository cartItemRepository,
            ProductRepository productRepository,
            // ĐÃ XÓA tham số ProductColorRepository
            UserService userService) {
        this.cartRepository = cartRepository;
        this.cartItemRepository = cartItemRepository;
        this.productRepository = productRepository;
        // ĐÃ XÓA gán this.productColorRepository
        this.userService = userService;
    }

    // ĐÃ XÓA: private void enrichProductQuantity(Product product)

    public List<Product> getAllProducts(String keyword, Long categoryId) {
        List<Product> products;

        if (keyword != null && !keyword.isEmpty() && categoryId != null) {
            products = productRepository.findByNameContainingIgnoreCaseAndCategoryId(keyword, categoryId);
        } else if (keyword != null && !keyword.isEmpty()) {
            products = productRepository.findByNameContainingIgnoreCase(keyword);
        } else if (categoryId != null) {
            products = productRepository.findByCategoryId(categoryId);
        } else {
            products = productRepository.findAll();
        }

        // ĐÃ XÓA vòng lặp enrichProductQuantity

        return products;
    }

    // Đã thay thế hàm cũ bằng hàm mới có nhận thêm tham số brandId
    public List<Product> getAllProducts(String keyword, Long categoryId, Long brandId, String status) {
        List<Product> products;

        if (keyword != null && !keyword.isEmpty() && categoryId != null) {
            products = productRepository.findByNameContainingIgnoreCaseAndCategoryId(keyword, categoryId);
        } else if (keyword != null && !keyword.isEmpty()) {
            products = productRepository.findByNameContainingIgnoreCase(keyword);
        } else if (categoryId != null) {
            products = productRepository.findByCategoryId(categoryId);
        } else {
            products = productRepository.findAll();
        }

        // Lọc bằng Stream kết hợp Trạng thái và Thương hiệu
        return products.stream()
                .filter(p -> "all".equals(status) ||
                        ("active".equals(status) && p.isActive()) ||
                        ("inactive".equals(status) && !p.isActive()))
                .filter(p -> brandId == null || (p.getBrand() != null && p.getBrand().getId() == brandId))
                .toList();
    }

    // === HÀM MỚI THÊM: PHỤC VỤ TÍNH NĂNG LỌC NGOÀI TRANG CHỦ ===
    public List<Product> getAllProducts(String keyword, Long categoryId, Long brandId, String origin, String sort) {
        List<Product> products;

        if (keyword != null && !keyword.isEmpty() && categoryId != null) {
            products = productRepository.findByNameContainingIgnoreCaseAndCategoryId(keyword, categoryId);
        } else if (keyword != null && !keyword.isEmpty()) {
            products = productRepository.findByNameContainingIgnoreCase(keyword);
        } else if (categoryId != null) {
            products = productRepository.findByCategoryId(categoryId);
        } else {
            products = productRepository.findAll();
        }

        return products.stream()
                // Lọc theo Brand (Nếu có chọn)
                .filter(p -> brandId == null || (p.getBrand() != null && p.getBrand().getId() == brandId))
                // Lọc theo Origin (Nếu có chọn)
                .filter(p -> origin == null || origin.isEmpty()
                        || (p.getOrigin() != null && p.getOrigin().equalsIgnoreCase(origin)))
                // Xử lý sắp xếp (Sort)
                .sorted((p1, p2) -> {
                    if ("price-asc".equals(sort)) {
                        return Double.compare(p1.getPrice(), p2.getPrice());
                    } else if ("price-desc".equals(sort)) {
                        return Double.compare(p2.getPrice(), p1.getPrice());
                    }
                    // Mặc định hiển thị sản phẩm mới nhất lên đầu
                    return Long.compare(p2.getId(), p1.getId());
                })
                .toList();
    }
    // ==========================================================

    public Product handleSaveProduct(Product product) {
        return productRepository.save(product);
    }

    public Optional<Product> fetchProductById(long id) {
        Optional<Product> productOptional = productRepository.findById(id);
        // ĐÃ XÓA: if (productOptional.isPresent()) { this.enrichProductQuantity(...) }
        return productOptional;
    }

    public void deleteProduct(long id) {
        productRepository.deleteById(id);
    }

    public List<Product> fetchProductsByName(String name) {
        List<Product> products = productRepository.findByNameContainingIgnoreCase(name);
        // ĐÃ XÓA: products.forEach(this::enrichProductQuantity);
        return products;
    }

    public List<Product> fetchProductsByCategory(Long categoryId) {
        List<Product> products = productRepository.findByCategoryId(categoryId);
        // ĐÃ XÓA: products.forEach(this::enrichProductQuantity);
        return products;
    }

    public Cart fetchCartByUserEmail(String email) {
        User user = this.userService.getUserByEmail(email);
        if (user != null) {
            return this.cartRepository.findByUser(user);
        }
        return null;
    }

    // ĐÃ SỬA: Bỏ tham số colorId
    public void handleAddProductToCart(String email, long productId, HttpSession session, long quantity) {
        if (email == null) {
            // --- XỬ LÝ CHO GUEST (SESSION) ---
            List<CartItem> guestCart = (List<CartItem>) session.getAttribute("guestCart");
            if (guestCart == null) {
                guestCart = new ArrayList<>();
            }
            Optional<Product> pOptional = this.productRepository.findById(productId);

            if (pOptional.isPresent()) {
                Product p = pOptional.get();
                boolean isExist = false;
                for (CartItem item : guestCart) {
                    // Chỉ so sánh productId, bỏ so sánh Color
                    if (item.getProduct().getId() == productId) {
                        item.setQuantity(item.getQuantity() + quantity);
                        isExist = true;
                        break;
                    }
                }
                if (!isExist) {
                    CartItem newItem = new CartItem();
                    newItem.setId(System.currentTimeMillis());
                    newItem.setProduct(p);
                    // Bỏ setProductColor
                    newItem.setQuantity(quantity);
                    newItem.setPrice(p.getPrice());
                    guestCart.add(newItem);
                }
                session.setAttribute("guestCart", guestCart);
                session.setAttribute("sum", guestCart.size());
            }
        } else {
            // --- XỬ LÝ CHO USER ĐĂNG NHẬP (DB) ---
            User user = this.userService.getUserByEmail(email);
            if (user != null) {
                Cart cart = this.cartRepository.findByUser(user);
                if (cart == null) {
                    cart = new Cart();
                    cart.setUser(user);
                    cart.setSum(0);
                    cart = this.cartRepository.save(cart);
                }

                Optional<Product> pOptional = this.productRepository.findById(productId);

                if (pOptional.isPresent()) {
                    Product p = pOptional.get();

                    // Tìm item chỉ dựa trên Cart và Product (Repository đã sửa ở bước trước)
                    CartItem oldDetail = this.cartItemRepository.findByCartAndProduct(cart, p);

                    if (oldDetail == null) {
                        CartItem newItem = new CartItem();
                        newItem.setCart(cart);
                        newItem.setProduct(p);
                        // Bỏ setProductColor
                        newItem.setPrice(p.getPrice());
                        newItem.setQuantity(quantity);

                        this.cartItemRepository.save(newItem);

                        int newSum = cart.getSum() + 1;
                        cart.setSum(newSum);
                        this.cartRepository.save(cart);
                        session.setAttribute("sum", newSum);
                    } else {
                        oldDetail.setQuantity(oldDetail.getQuantity() + quantity);
                        this.cartItemRepository.save(oldDetail);
                    }
                }
            }
        }
    }

    public void handleUpdateCartQuantity(long cartItemId, String action, HttpSession session) {
        String email = (String) session.getAttribute("email");
        if (email == null) {
            List<CartItem> guestCart = (List<CartItem>) session.getAttribute("guestCart");
            if (guestCart != null) {
                for (CartItem item : guestCart) {
                    if (item.getId() == cartItemId) {
                        if (action.equals("plus"))
                            item.setQuantity(item.getQuantity() + 1);
                        else if (action.equals("minus") && item.getQuantity() > 1)
                            item.setQuantity(item.getQuantity() - 1);
                        break;
                    }
                }
                session.setAttribute("guestCart", guestCart);
            }
        } else {
            Optional<CartItem> cartItemOptional = this.cartItemRepository.findById(cartItemId);
            if (cartItemOptional.isPresent()) {
                CartItem cartItem = cartItemOptional.get();
                if (action.equals("plus"))
                    cartItem.setQuantity(cartItem.getQuantity() + 1);
                else if (action.equals("minus") && cartItem.getQuantity() > 1)
                    cartItem.setQuantity(cartItem.getQuantity() - 1);
                this.cartItemRepository.save(cartItem);
            }
        }
    }

    public void handleDeleteCartItem(long id, HttpSession session) {
        String email = (String) session.getAttribute("email");
        if (email == null) {
            List<CartItem> guestCart = (List<CartItem>) session.getAttribute("guestCart");
            if (guestCart != null) {
                guestCart.removeIf(item -> item.getId() == id);
                session.setAttribute("guestCart", guestCart);
                session.setAttribute("sum", guestCart.size());
            }
        } else {
            Optional<CartItem> cartItemOptional = this.cartItemRepository.findById(id);
            if (cartItemOptional.isPresent()) {
                CartItem cartItem = cartItemOptional.get();
                Cart cart = cartItem.getCart();
                this.cartItemRepository.deleteById(id);
                if (cart.getSum() > 0) {
                    int newSum = cart.getSum() - 1;
                    cart.setSum(newSum);
                    this.cartRepository.save(cart);
                    session.setAttribute("sum", newSum);
                }
            }
        }
    }

    public Page<Product> getAllProductsWithPaging(Pageable pageable, String sort) {
        if (sort != null && !sort.equals("default")) {
            Sort s = Sort.by("id").descending();
            if ("price-asc".equals(sort))
                s = Sort.by("price").ascending();
            else if ("price-desc".equals(sort))
                s = Sort.by("price").descending();

            pageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), s);
        }
        return productRepository.findAll(pageable);
    }

    public List<TopProductDTO> getBestSellingProducts(int limit) {
        Pageable pageable = PageRequest.of(0, limit);
        return productRepository.findBestSellingProducts(pageable);
    }

    public long countAllProducts() {
        return productRepository.count();
    }

    public void toggleProductStatus(long id) {
        Optional<Product> productOptional = productRepository.findById(id);
        if (productOptional.isPresent()) {
            Product product = productOptional.get();
            product.setActive(!product.isActive());
            productRepository.save(product);
        }
    }

    public long countLowStockProducts(long threshold) {
        return productRepository.countByQuantityLessThanEqual(threshold);
    }
}