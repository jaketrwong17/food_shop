<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <title>16Home - Cửa hàng trực tuyến</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

                <style>
                    /* === 1. CẤU HÌNH CUỘN TRANG MƯỢT MÀ === */
                    html {
                        scroll-behavior: smooth;
                    }

                    /* === 2. CĂN CHỈNH VỊ TRÍ DỪNG KHI CUỘN === */
                    #danh-sach-san-pham {
                        scroll-margin-top: 110px;
                    }

                    /* ==================== STYLE CHUNG & PRODUCT CARD ==================== */
                    .product-card {
                        transition: 0.3s;
                        border-radius: 12px;
                        overflow: hidden;
                        border: none;
                        height: 100%;
                        display: flex;
                        flex-direction: column;
                        position: relative;
                    }

                    .product-card:hover {
                        transform: translateY(-5px);
                        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1) !important;
                    }

                    .img-container {
                        height: 200px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        padding: 15px;
                    }

                    .img-container img {
                        max-width: 100%;
                        max-height: 100%;
                        object-fit: contain;
                    }

                    .info-section {
                        background: #fafafa;
                        padding: 15px;
                        flex-grow: 1;
                        text-align: center;
                        display: flex;
                        flex-direction: column;
                    }

                    .product-price {
                        color: #ee4d2d;
                        font-weight: bold;
                        font-size: 1.1rem;
                        margin-top: auto;
                        padding-top: 10px;
                    }

                    .out-of-stock-label {
                        position: absolute;
                        top: 10px;
                        right: 10px;
                        background: #6c757d;
                        color: white;
                        padding: 2px 10px;
                        border-radius: 4px;
                        font-size: 0.7rem;
                        font-weight: bold;
                        z-index: 10;
                    }

                    /* ==================== BEST SELLER COLORS ==================== */
                    .best-seller-card {
                        border: 1px solid rgba(0, 0, 0, 0.08);
                        border-radius: 15px;
                        background: #fff;
                        transition: all 0.4s ease;
                        position: relative;
                        overflow: hidden;
                        height: 100%;
                        display: flex;
                        flex-direction: column;
                    }

                    .best-seller-card:hover {
                        transform: translateY(-8px);
                        box-shadow: 0 15px 30px rgba(0, 0, 0, 0.12) !important;
                    }

                    .best-seller-card .card-body {
                        display: flex;
                        flex-direction: column;
                        flex-grow: 1;
                    }

                    .best-seller-card .card-body .price-container {
                        margin-top: auto;
                    }

                    .ranking-badge {
                        position: absolute;
                        top: 0;
                        left: 0;
                        color: white;
                        padding: 4px 12px;
                        border-bottom-right-radius: 15px;
                        font-weight: bold;
                        font-size: 0.75rem;
                        z-index: 2;
                    }

                    .ranking-top-1 {
                        background: linear-gradient(45deg, #ff416c, #ff4b2b);
                    }

                    .ranking-top-2 {
                        background: linear-gradient(45deg, #f2994a, #f2c94c);
                    }

                    .ranking-top-3 {
                        background: linear-gradient(45deg, #11998e, #38ef7d);
                    }

                    .ranking-top-4 {
                        background: linear-gradient(45deg, #8e2de2, #4a00e0);
                    }

                    .ranking-top-others {
                        background: linear-gradient(45deg, #2d97f5, #035fb1);
                    }

                    /* ==================== HOT TREND BADGE ==================== */
                    .hot-trend-badge-new {
                        background: #fff;
                        border: 2px solid #ff4b2b;
                        color: #ff4b2b;
                        padding: 5px 15px;
                        border-radius: 50px;
                        font-weight: 800;
                        font-size: 0.8rem;
                        text-transform: uppercase;
                        display: inline-flex;
                        align-items: center;
                        box-shadow: 0 4px 12px rgba(255, 75, 43, 0.15);
                        animation: hot-pulse 2s infinite;
                    }

                    .hot-trend-badge-new i {
                        font-size: 1.1rem;
                        animation: flame-shake 0.5s infinite alternate;
                    }

                    @keyframes hot-pulse {
                        0% {
                            transform: scale(1);
                            box-shadow: 0 4px 12px rgba(255, 75, 43, 0.2);
                        }

                        50% {
                            transform: scale(1.05);
                            box-shadow: 0 4px 20px rgba(255, 75, 43, 0.4);
                        }

                        100% {
                            transform: scale(1);
                            box-shadow: 0 4px 12px rgba(255, 75, 43, 0.2);
                        }
                    }

                    @keyframes flame-shake {
                        from {
                            transform: rotate(-8deg);
                        }

                        to {
                            transform: rotate(12deg);
                        }
                    }

                    /* ==================== SORT OPTIONS & SLIDER ==================== */
                    .sort-options {
                        display: flex;
                        gap: 12px;
                        align-items: center;
                    }

                    .btn-sort {
                        display: inline-flex;
                        align-items: center;
                        gap: 8px;
                        padding: 8px 22px;
                        border-radius: 50px;
                        border: 1px solid #e0e0e0;
                        background: #fff;
                        color: #444;
                        font-size: 0.95rem;
                        text-decoration: none;
                        transition: 0.2s;
                    }

                    .btn-sort:hover {
                        background: #f8f9fa;
                        color: #2A83E9;
                    }

                    .btn-sort.active {
                        border-color: #2A83E9;
                        background: #f0f7ff;
                        color: #2A83E9;
                        font-weight: 500;
                    }

                    .category-scroll-container {
                        scroll-behavior: smooth;
                        scrollbar-width: none;
                        -ms-overflow-style: none;
                        padding: 15px 5px;
                    }

                    .category-scroll-container::-webkit-scrollbar {
                        display: none;
                    }

                    .scroll-btn {
                        position: absolute;
                        top: 50%;
                        transform: translateY(-50%);
                        z-index: 10;
                        width: 45px;
                        height: 45px;
                        background: white;
                        border: 1px solid #dee2e6;
                        border-radius: 50%;
                        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                    }

                    .carousel-indicators button {
                        width: 35px !important;
                        height: 4px !important;
                        border-radius: 2px;
                    }

                    .d-none-custom {
                        display: none !important;
                    }
                </style>
            </head>

            <body class="bg-light">

                <jsp:include page="../layout/header.jsp" />

                <div class="container-fluid p-0 mb-5">
                    <div id="homeBannerCarousel" class="carousel slide" data-bs-ride="carousel">
                        <div class="carousel-indicators">
                            <button type="button" data-bs-target="#homeBannerCarousel" data-bs-slide-to="0"
                                class="active"></button>
                            <button type="button" data-bs-target="#homeBannerCarousel" data-bs-slide-to="1"></button>
                        </div>
                        <div class="carousel-inner">
                            <div class="carousel-item active" data-bs-interval="5000">
                                <img src="https://theme.hstatic.net/200000946105/1001363519/14/collection_banner.jpg?v=1368"
                                    class="d-block w-100" style="height: 700px; object-fit: cover;">
                            </div>
                            <div class="carousel-item" data-bs-interval="5000">
                                <img src="https://duytan.com/Data/Sites/1/Banner/banner-spm-t12.jpg"
                                    class="d-block w-100" style="height: 700px; object-fit: cover;">
                            </div>
                        </div>
                    </div>
                </div>

                <section class="container py-4">
                    <div class="bg-white p-4 rounded-4 shadow-sm position-relative">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div>
                                <h4 class="fw-bold mb-0 text-dark">
                                    <i class="fas fa-crown text-warning me-2"></i>SẢN PHẨM BÁN CHẠY
                                </h4>
                                <div class="bg-primary"
                                    style="height: 3px; width: 45px; border-radius: 2px; margin-top: 5px;"></div>
                            </div>
                            <div class="hot-trend-badge-new">Hot Trend <i class="fas fa-fire ms-2"></i></div>
                        </div>

                        <div class="category-slider-wrapper position-relative">
                            <button class="btn scroll-btn start-0" id="slideLeft"><i
                                    class="fas fa-chevron-left"></i></button>
                            <div class="d-flex gap-4 overflow-auto category-scroll-container" id="categoryList">
                                <c:forEach var="item" items="${bestSellingProducts}" varStatus="status">
                                    <c:if test="${item.active}">
                                        <a href="/product/${item.productId}" class="text-decoration-none text-dark">
                                            <div class="card best-seller-card p-2" style="min-width: 220px;">
                                                <div class="ranking-badge 
                                    ${status.index == 0 ? 'ranking-top-1' : 
                                      (status.index == 1 ? 'ranking-top-2' : 
                                      (status.index == 2 ? 'ranking-top-3' : 
                                      (status.index == 3 ? 'ranking-top-4' : 'ranking-top-others')))}">
                                                    #${status.index + 1} Best Seller
                                                </div>
                                                <div class="bg-white rounded-3 mb-2 d-flex align-items-center justify-content-center"
                                                    style="height: 180px;">
                                                    <img src="/images/${not empty item.productImage ? item.productImage : 'default.png'}"
                                                        style="max-width: 90%; max-height: 90%; object-fit: contain;">
                                                </div>
                                                <div class="card-body p-1 text-center">
                                                    <h6 class="text-dark fw-bold mb-2"
                                                        style="font-size: 0.9rem; min-height: 2.6em;">
                                                        ${item.productName}
                                                    </h6>
                                                    <div class="price-container">
                                                        <div class="text-danger fw-bold">
                                                            <fmt:formatNumber
                                                                value="${item.totalRevenue / item.quantitySold}"
                                                                type="currency" currencySymbol="đ" />
                                                        </div>
                                                        <small class="text-muted">Đã bán: ${item.quantitySold}</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    </c:if>
                                </c:forEach>
                            </div>
                            <button class="btn scroll-btn end-0" id="slideRight"><i
                                    class="fas fa-chevron-right"></i></button>
                        </div>
                    </div>
                </section>

                <div class="container my-5" id="danh-sach-san-pham">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4 class="fw-bold mb-0" id="product-section-title">DANH SÁCH SẢN PHẨM</h4>

                        <%--=====SỬA LỖI NÚT LỌC TẠI ĐÂY=====--%>
                            <div class="sort-options">
                                <%-- Bước 1: Lấy categoryId từ URL hoặc Attribute --%>
                                    <c:set var="currentCatId" value="${param.categoryId}" />
                                    <c:if test="${empty currentCatId}">
                                        <c:set var="currentCatId" value="${categoryId}" />
                                    </c:if>

                                    <%-- Bước 2: Tạo chuỗi tham số phụ (giữ lại category và search) --%>
                                        <c:set var="extraParams" value="" />
                                        <c:if test="${not empty currentCatId}">
                                            <c:set var="extraParams"
                                                value="${extraParams}&categoryId=${currentCatId}" />
                                        </c:if>
                                        <c:if test="${not empty param.search}">
                                            <c:set var="extraParams" value="${extraParams}&search=${param.search}" />
                                        </c:if>

                                        <%-- Bước 3: Nút lọc dùng đường dẫn tương đối (?) --%>
                                            <a href="?sort=price-asc${extraParams}#danh-sach-san-pham"
                                                class="btn-sort ${param.sort == 'price-asc' ? 'active' : ''}">
                                                <i class="fas fa-sort-amount-down-alt"></i> Giá Thấp - Cao
                                            </a>
                                            <a href="?sort=price-desc${extraParams}#danh-sach-san-pham"
                                                class="btn-sort ${param.sort == 'price-desc' ? 'active' : ''}">
                                                <i class="fas fa-sort-amount-down"></i> Giá Cao - Thấp
                                            </a>
                            </div>
                            <%--=====KẾT THÚC SỬA LỖI=====--%>

                    </div>

                    <c:choose>
                        <%-- TRƯỜNG HỢP 1: KHÔNG CÓ SẢN PHẨM --%>
                            <c:when test="${empty products}">
                                <div class="row justify-content-center">
                                    <div class="col-12 col-md-8 col-lg-6">
                                        <div class="text-center py-5 bg-white rounded-4 shadow-sm border">
                                            <div class="mb-3">
                                                <i class="fas fa-box-open text-muted"
                                                    style="font-size: 5rem; opacity: 0.3;"></i>
                                            </div>
                                            <h5 class="text-muted fw-bold">Không tìm thấy sản phẩm nào!</h5>
                                            <p class="text-secondary small mb-4">Rất tiếc, chúng tôi không tìm thấy sản
                                                phẩm phù hợp.</p>
                                            <a href="/#danh-sach-san-pham"
                                                class="btn btn-primary rounded-pill px-4 fw-bold">
                                                <i class="fas fa-arrow-left me-2"></i>Xem tất cả sản phẩm
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:when>

                            <%-- TRƯỜNG HỢP 2: CÓ SẢN PHẨM --%>
                                <c:otherwise>
                                    <div id="product-list" class="row row-cols-1 row-cols-md-3 row-cols-lg-5 g-4">

                                        <%-- PHẦN 1: LOOP CÁC SẢN PHẨM CÒN HÀNG (quantity> 0) TRƯỚC --%>
                                            <c:forEach var="p" items="${products}">
                                                <c:if test="${p.active && p.quantity > 0}">
                                                    <div class="col product-item">
                                                        <div class="card product-card shadow-sm h-100">
                                                            <a href="/product/${p.id}"
                                                                class="text-decoration-none h-100 d-flex flex-column">
                                                                <div class="img-container">
                                                                    <img src="/images/${(not empty p.images and not empty p.images[0]) ? p.images[0].imageUrl : 'default.png'}"
                                                                        alt="${p.name}">
                                                                </div>
                                                                <div class="info-section">
                                                                    <h6 class="text-dark mb-2"
                                                                        style="min-height: 2.5em;">${p.name}</h6>
                                                                    <div class="mb-2 small">
                                                                        <c:choose>
                                                                            <c:when test="${p.reviewCount > 0}">
                                                                                <span class="text-warning">
                                                                                    <c:forEach begin="1"
                                                                                        end="${p.averageRating.intValue()}">
                                                                                        <i class="fas fa-star"></i>
                                                                                    </c:forEach>
                                                                                    <span
                                                                                        class="text-muted">(${p.reviewCount})</span>
                                                                                </span>
                                                                            </c:when>
                                                                            <c:otherwise><span class="text-muted">Chưa
                                                                                    có đánh giá</span></c:otherwise>
                                                                        </c:choose>
                                                                    </div>
                                                                    <p class="product-price mb-0">
                                                                        <fmt:formatNumber value="${p.price}"
                                                                            type="currency" currencySymbol="đ" />
                                                                    </p>
                                                                </div>
                                                            </a>
                                                            <div class="card-footer bg-white border-0 pb-3 text-center">
                                                                <a href="/product/${p.id}"
                                                                    class="btn btn-outline-primary w-100 rounded-pill btn-sm fw-bold">Xem
                                                                    ngay</a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:forEach>

                                            <%-- PHẦN 2: LOOP CÁC SẢN PHẨM HẾT HÀNG (quantity <=0) SAU --%>
                                                <c:forEach var="p" items="${products}">
                                                    <c:if test="${p.active && p.quantity <= 0}">
                                                        <div class="col product-item">
                                                            <div class="card product-card shadow-sm h-100">
                                                                <div class="out-of-stock-label">Hết hàng</div>
                                                                <a href="/product/${p.id}"
                                                                    class="text-decoration-none h-100 d-flex flex-column">
                                                                    <div class="img-container">
                                                                        <img src="/images/${(not empty p.images and not empty p.images[0]) ? p.images[0].imageUrl : 'default.png'}"
                                                                            alt="${p.name}">
                                                                    </div>
                                                                    <div class="info-section">
                                                                        <h6 class="text-dark mb-2"
                                                                            style="min-height: 2.5em;">${p.name}</h6>
                                                                        <div class="mb-2 small">
                                                                            <c:choose>
                                                                                <c:when test="${p.reviewCount > 0}">
                                                                                    <span class="text-warning">
                                                                                        <c:forEach begin="1"
                                                                                            end="${p.averageRating.intValue()}">
                                                                                            <i class="fas fa-star"></i>
                                                                                        </c:forEach>
                                                                                        <span
                                                                                            class="text-muted">(${p.reviewCount})</span>
                                                                                    </span>
                                                                                </c:when>
                                                                                <c:otherwise><span
                                                                                        class="text-muted">Chưa có đánh
                                                                                        giá</span></c:otherwise>
                                                                            </c:choose>
                                                                        </div>
                                                                        <p class="product-price mb-0">
                                                                            <fmt:formatNumber value="${p.price}"
                                                                                type="currency" currencySymbol="đ" />
                                                                        </p>
                                                                    </div>
                                                                </a>
                                                                <div
                                                                    class="card-footer bg-white border-0 pb-3 text-center">
                                                                    <a href="/product/${p.id}"
                                                                        class="btn btn-outline-primary w-100 rounded-pill btn-sm fw-bold">Xem
                                                                        ngay</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                </c:forEach>

                                    </div>

                                    <div class="text-center mt-5 mb-4 d-flex gap-2 justify-content-center">
                                        <button id="loadMoreBtn" class="btn btn-primary px-5 py-2 rounded-pill fw-bold"
                                            style="display:none; background:#e3f2fd; color:#2A83E9; border:none;">
                                            XEM THÊM <i class="fas fa-chevron-down ms-2"></i>
                                        </button>
                                        <button id="collapseBtn"
                                            class="btn btn-outline-secondary px-5 py-2 rounded-pill fw-bold"
                                            style="display:none;">
                                            THU GỌN <i class="fas fa-chevron-up ms-2"></i>
                                        </button>
                                    </div>
                                </c:otherwise>
                    </c:choose>
                </div>

                <jsp:include page="../layout/footer.jsp" />

                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        // --- 1. CẤU HÌNH SỐ LƯỢNG SẢN PHẨM HIỂN THỊ MẶC ĐỊNH LÀ 15 ---
                        const ITEMS_PER_PAGE = 15;

                        // Slider Best Seller (Giữ nguyên)
                        const container = document.getElementById('categoryList');
                        if (container) {
                            document.getElementById('slideLeft').onclick = () => container.scrollBy({ left: -400, behavior: 'smooth' });
                            document.getElementById('slideRight').onclick = () => container.scrollBy({ left: 400, behavior: 'smooth' });
                        }

                        // --- 2. Logic Xem Thêm / Thu Gọn ---
                        const productItems = document.querySelectorAll('.product-item');
                        const loadMoreBtn = document.getElementById('loadMoreBtn');
                        const collapseBtn = document.getElementById('collapseBtn');

                        // Log ra console để kiểm tra
                        console.log("Tổng số sản phẩm tìm thấy:", productItems.length);

                        // Chỉ hiện nút nếu số sản phẩm thực tế lớn hơn 15
                        if (loadMoreBtn && productItems.length > ITEMS_PER_PAGE) {

                            // 1. Hiện nút Xem thêm
                            loadMoreBtn.style.display = 'inline-block';

                            // 2. Ẩn các sản phẩm từ vị trí thứ 15 trở đi (index bắt đầu từ 0 nên là từ index 15)
                            for (let i = ITEMS_PER_PAGE; i < productItems.length; i++) {
                                productItems[i].classList.add('d-none-custom');
                            }

                            // 3. Sự kiện nút Xem Thêm
                            loadMoreBtn.onclick = function () {
                                productItems.forEach(item => item.classList.remove('d-none-custom')); // Hiện tất cả
                                this.style.display = 'none'; // Ẩn nút xem thêm
                                collapseBtn.style.display = 'inline-block'; // Hiện nút thu gọn
                            };

                            // 4. Sự kiện nút Thu Gọn
                            collapseBtn.onclick = function () {
                                // Ẩn lại các sản phẩm từ vị trí 15 trở đi
                                for (let i = ITEMS_PER_PAGE; i < productItems.length; i++) {
                                    productItems[i].classList.add('d-none-custom');
                                }
                                this.style.display = 'none'; // Ẩn nút thu gọn
                                loadMoreBtn.style.display = 'inline-block'; // Hiện nút xem thêm

                                // Cuộn trang lên lại tiêu đề
                                const title = document.getElementById('product-section-title');
                                if (title) title.scrollIntoView({ behavior: 'smooth' });
                            };
                        }
                    });
                </script>
            </body>

            </html>