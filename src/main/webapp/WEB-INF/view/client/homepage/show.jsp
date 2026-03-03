<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <title>GreenFood - Cửa hàng trực tuyến</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

                <style>
                    /* === 0. MÀU CHỦ ĐẠO THEME === */
                    .bg-theme {
                        background-color: #3c8a2e !important;
                        color: #fff !important;
                    }

                    .text-theme {
                        color: #3c8a2e !important;
                    }

                    .btn-theme {
                        background-color: #3c8a2e !important;
                        color: #fff !important;
                        border-color: #3c8a2e !important;
                    }

                    .btn-theme:hover {
                        background-color: #2d6a22 !important;
                        color: #fff !important;
                    }

                    .btn-outline-theme {
                        color: #3c8a2e !important;
                        border-color: #3c8a2e !important;
                        background-color: transparent;
                    }

                    .btn-outline-theme:hover {
                        background-color: #3c8a2e !important;
                        color: #fff !important;
                    }

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

                    /* ==================== SORT & FILTER OPTIONS ==================== */
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
                        color: #3c8a2e;
                    }

                    .btn-sort.active {
                        border-color: #3c8a2e;
                        background: #eef5eb;
                        color: #3c8a2e;
                        font-weight: 500;
                    }

                    /* CSS BỘ LỌC TAGS */
                    .filter-tag {
                        display: inline-flex;
                        align-items: center;
                        background-color: #fff;
                        border: 1px solid #d1d5db;
                        color: #333;
                        font-size: 0.85rem;
                        padding: 4px 12px;
                        border-radius: 50px;
                        text-decoration: none;
                        transition: 0.2s;
                    }

                    .filter-tag:hover {
                        background-color: #f8f9fa;
                        border-color: #adb5bd;
                        color: #000;
                    }

                    .filter-tag i {
                        font-size: 0.75rem;
                        color: #6c757d;
                        margin-left: 6px;
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

                <%-- Gọi File Header ở đây --%>
                    <jsp:include page="../layout/header.jsp" />

                    <div class="container mt-4 mb-4">
                        <div id="homeBannerCarousel" class="carousel slide shadow-sm" data-bs-ride="carousel"
                            style="border-radius: 12px; overflow: hidden;">

                            <div class="carousel-indicators">
                                <c:choose>
                                    <c:when test="${not empty banners}">
                                        <c:forEach var="banner" items="${banners}" varStatus="status">
                                            <button type="button" data-bs-target="#homeBannerCarousel"
                                                data-bs-slide-to="${status.index}"
                                                class="${status.first ? 'active' : ''}"></button>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <button type="button" data-bs-target="#homeBannerCarousel" data-bs-slide-to="0"
                                            class="active"></button>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="carousel-inner">
                                <c:choose>
                                    <c:when test="${not empty banners}">
                                        <c:forEach var="banner" items="${banners}" varStatus="status">
                                            <div class="carousel-item ${status.first ? 'active' : ''}"
                                                data-bs-interval="4000">
                                                <c:choose>
                                                    <c:when test="${not empty banner.link}">
                                                        <a href="${banner.link}">
                                                            <img src="/images/${banner.imageUrl}" class="d-block w-100"
                                                                style="height: 400px; object-fit: cover;">
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="/images/${banner.imageUrl}" class="d-block w-100"
                                                            style="height: 400px; object-fit: cover;">
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="carousel-item active" data-bs-interval="4000">
                                            <img src="" class="d-block w-100" style="height: 400px; object-fit: cover;">
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <button class="carousel-control-prev" type="button" data-bs-target="#homeBannerCarousel"
                                data-bs-slide="prev">
                                <span class="carousel-control-prev-icon bg-dark rounded-circle bg-opacity-50"
                                    aria-hidden="true" style="width: 2.5rem; height: 2.5rem; padding: 1.2rem;"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#homeBannerCarousel"
                                data-bs-slide="next">
                                <span class="carousel-control-next-icon bg-dark rounded-circle bg-opacity-50"
                                    aria-hidden="true" style="width: 2.5rem; height: 2.5rem; padding: 1.2rem;"></span>
                                <span class="visually-hidden">Next</span>
                            </button>

                        </div>
                    </div>

                    <div class="container mb-4">
                        <div class="bg-white p-3 rounded-4 shadow-sm border">
                            <div class="d-flex gap-4 overflow-auto category-scroll-container position-relative">
                                <c:forEach var="b" items="${brands}">
                                    <a href="?brandId=${b.id}#danh-sach-san-pham"
                                        class="text-center text-decoration-none text-dark d-flex flex-column align-items-center"
                                        style="min-width: 80px; transition: 0.2s;">

                                        <div class="bg-white rounded-circle mb-2 border hover-shadow"
                                            style="width: 60px; height: 60px; overflow: hidden; transition: border-color 0.2s;">
                                            <img src="/images/${not empty b.logoUrl ? b.logoUrl : 'default-brand.png'}"
                                                style="width: 100%; height: 100%; object-fit: cover; display: block;">
                                        </div>
                                        <span class="small fw-bold">${b.name}</span>
                                    </a>
                                </c:forEach>
                            </div>
                        </div>
                    </div>

                    <section class="container py-4">
                        <div class="bg-white p-4 rounded-4 shadow-sm position-relative">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <div>
                                    <h4 class="fw-bold mb-0 text-dark">
                                        <i class="fas fa-crown text-warning me-2"></i>SẢN PHẨM NỔI BẬT
                                    </h4>
                                    <div class="bg-theme"
                                        style="height: 3px; width: 45px; border-radius: 2px; margin-top: 5px;"></div>
                                </div>

                            </div>

                            <div class="category-slider-wrapper position-relative">
                                <button class="btn scroll-btn start-0" id="slideLeft"><i
                                        class="fas fa-chevron-left"></i></button>
                                <div class="d-flex gap-4 overflow-auto category-scroll-container" id="categoryList">
                                    <c:forEach var="item" items="${bestSellingProducts}" varStatus="status">
                                        <c:if test="${item.active}">
                                            <a href="/product/${item.productId}" class="text-decoration-none text-dark">
                                                <%-- KHÓA CỨNG CHIỀU RỘNG Ở ĐÂY --%>
                                                    <div class="card best-seller-card p-2"
                                                        style="min-width: 220px; width: 220px; max-width: 220px; flex-shrink: 0;">
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
                                                                <small class="text-muted">Đã bán:
                                                                    ${item.quantitySold}</small>
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

                        <h4 class="fw-bold mb-3" id="product-section-title">DANH SÁCH SẢN PHẨM</h4>

                        <div class="d-flex flex-wrap align-items-center gap-2 mb-3">
                            <span class="btn btn-outline-primary rounded-pill btn-sm fw-bold" style="cursor: default;">
                                <i class="fas fa-filter" style="color: white; -webkit-text-stroke: 1.5px #0d6efd;"></i>
                                Lọc
                            </span>

                            <c:if test="${not empty param.brandId}">
                                <c:forEach var="b" items="${brands}">
                                    <c:if test="${b.id == param.brandId}">
                                        <a href="?sort=${param.sort}&origin=${param.origin}&categoryId=${param.categoryId}#danh-sach-san-pham"
                                            class="filter-tag">
                                            Hãng: ${b.name} <i class="fas fa-times"></i>
                                        </a>
                                    </c:if>
                                </c:forEach>
                            </c:if>

                            <c:if test="${not empty param.origin}">
                                <a href="?sort=${param.sort}&brandId=${param.brandId}&categoryId=${param.categoryId}#danh-sach-san-pham"
                                    class="filter-tag">
                                    Xuất xứ: ${param.origin} <i class="fas fa-times"></i>
                                </a>
                            </c:if>

                            <c:if test="${not empty param.brandId or not empty param.origin}">
                                <a href="?sort=${param.sort}&categoryId=${param.categoryId}#danh-sach-san-pham"
                                    class="text-primary small text-decoration-none ms-2 fw-bold">Xóa tất cả</a>
                            </c:if>
                        </div>

                        <div
                            class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-3 border-bottom pb-3">

                            <div class="d-flex gap-2">
                                <div class="dropdown">
                                    <button class="btn btn-outline-secondary rounded-pill btn-sm dropdown-toggle px-3"
                                        type="button" data-bs-toggle="dropdown">
                                        Thương hiệu
                                    </button>
                                    <ul class="dropdown-menu shadow-sm border-0">
                                        <c:forEach var="b" items="${brands}">
                                            <li><a class="dropdown-item ${param.brandId == b.id ? 'active' : ''}"
                                                    href="?brandId=${b.id}&origin=${param.origin}&sort=${param.sort}&categoryId=${param.categoryId}#danh-sach-san-pham">${b.name}</a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>

                                <div class="dropdown">
                                    <button class="btn btn-outline-secondary rounded-pill btn-sm dropdown-toggle px-3"
                                        type="button" data-bs-toggle="dropdown">
                                        Xuất xứ
                                    </button>
                                    <ul class="dropdown-menu shadow-sm border-0">
                                        <li><a class="dropdown-item ${param.origin == 'Việt Nam' ? 'active' : ''}"
                                                href="?origin=Việt Nam&brandId=${param.brandId}&sort=${param.sort}&categoryId=${param.categoryId}#danh-sach-san-pham">Việt
                                                Nam</a></li>
                                        <li><a class="dropdown-item ${param.origin == 'Mỹ' ? 'active' : ''}"
                                                href="?origin=Mỹ&brandId=${param.brandId}&sort=${param.sort}&categoryId=${param.categoryId}#danh-sach-san-pham">Mỹ</a>
                                        </li>
                                        <li><a class="dropdown-item ${param.origin == 'Đức' ? 'active' : ''}"
                                                href="?origin=Đức&brandId=${param.brandId}&sort=${param.sort}&categoryId=${param.categoryId}#danh-sach-san-pham">Đức</a>
                                        </li>
                                        <li><a class="dropdown-item ${param.origin == 'Hàn Quốc' ? 'active' : ''}"
                                                href="?origin=Hàn Quốc&brandId=${param.brandId}&sort=${param.sort}&categoryId=${param.categoryId}#danh-sach-san-pham">Hàn
                                                Quốc</a></li>
                                        <li><a class="dropdown-item ${param.origin == 'Nhật Bản' ? 'active' : ''}"
                                                href="?origin=Nhật Bản&brandId=${param.brandId}&sort=${param.sort}&categoryId=${param.categoryId}#danh-sach-san-pham">Nhật
                                                Bản</a></li>
                                    </ul>
                                </div>
                            </div>

                            <div class="sort-options">
                                <c:set var="currentCatId" value="${param.categoryId}" />
                                <c:if test="${empty currentCatId}">
                                    <c:set var="currentCatId" value="${categoryId}" />
                                </c:if>

                                <c:set var="extraParams" value="" />
                                <c:if test="${not empty currentCatId}">
                                    <c:set var="extraParams" value="${extraParams}&categoryId=${currentCatId}" />
                                </c:if>
                                <c:if test="${not empty param.search}">
                                    <c:set var="extraParams" value="${extraParams}&search=${param.search}" />
                                </c:if>
                                <c:if test="${not empty param.brandId}">
                                    <c:set var="extraParams" value="${extraParams}&brandId=${param.brandId}" />
                                </c:if>
                                <c:if test="${not empty param.origin}">
                                    <c:set var="extraParams" value="${extraParams}&origin=${param.origin}" />
                                </c:if>

                                <a href="?sort=price-asc${extraParams}#danh-sach-san-pham"
                                    class="btn-sort ${param.sort == 'price-asc' ? 'active' : ''}">
                                    <i class="fas fa-sort-amount-down-alt"></i> Giá Thấp - Cao
                                </a>
                                <a href="?sort=price-desc${extraParams}#danh-sach-san-pham"
                                    class="btn-sort ${param.sort == 'price-desc' ? 'active' : ''}">
                                    <i class="fas fa-sort-amount-down"></i> Giá Cao - Thấp
                                </a>
                            </div>
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
                                                <p class="text-secondary small mb-4">Rất tiếc, chúng tôi không tìm thấy
                                                    sản phẩm phù hợp.</p>
                                                <a href="/#danh-sach-san-pham"
                                                    class="btn btn-theme rounded-pill px-4 fw-bold">
                                                    <i class="fas fa-arrow-left me-2"></i>Xem tất cả sản phẩm
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </c:when>

                                <%-- TRƯỜNG HỢP 2: CÓ SẢN PHẨM --%>
                                    <c:otherwise>
                                        <div id="product-list" class="row row-cols-1 row-cols-md-3 row-cols-lg-5 g-4">

                                            <%-- PHẦN 1: LOOP CÁC SẢN PHẨM CÒN HÀNG --%>
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
                                                                                <c:otherwise><span
                                                                                        class="text-muted">Chưa có đánh
                                                                                        giá</span></c:otherwise>
                                                                            </c:choose>
                                                                        </div>

                                                                        <%--===KHU VỰC HIỂN THỊ GIÁ===--%>
                                                                            <div class="mt-auto">
                                                                                <c:choose>
                                                                                    <c:when test="${p.onSale}">
                                                                                        <p
                                                                                            class="product-price mb-0 fw-bold text-danger">
                                                                                            <fmt:formatNumber
                                                                                                value="${p.discountedPrice}"
                                                                                                type="currency"
                                                                                                currencySymbol="đ" />
                                                                                        </p>
                                                                                        <div class="d-flex align-items-center justify-content-center gap-2"
                                                                                            style="font-size: 0.85rem;">
                                                                                            <span
                                                                                                class="text-muted text-decoration-line-through">
                                                                                                <fmt:formatNumber
                                                                                                    value="${p.price}"
                                                                                                    type="currency"
                                                                                                    currencySymbol="đ" />
                                                                                            </span>
                                                                                            <span
                                                                                                class="badge bg-danger">-${p.discountPercentage}%</span>
                                                                                        </div>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <p class="product-price mb-0">
                                                                                            <fmt:formatNumber
                                                                                                value="${p.price}"
                                                                                                type="currency"
                                                                                                currencySymbol="đ" />
                                                                                        </p>
                                                                                        <div
                                                                                            style="font-size: 0.85rem; visibility: hidden;">
                                                                                            <span>Placeholder</span>
                                                                                        </div>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </div>
                                                                    </div>
                                                                </a>
                                                                <div
                                                                    class="card-footer bg-white border-0 pb-3 text-center">
                                                                    <a href="/product/${p.id}"
                                                                        class="btn btn-outline-theme w-100 rounded-pill btn-sm fw-bold">Xem
                                                                        ngay</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                </c:forEach>

                                                <%-- PHẦN 2: LOOP CÁC SẢN PHẨM HẾT HÀNG --%>
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
                                                                                style="min-height: 2.5em;">${p.name}
                                                                            </h6>
                                                                            <div class="mb-2 small">
                                                                                <c:choose>
                                                                                    <c:when test="${p.reviewCount > 0}">
                                                                                        <span class="text-warning">
                                                                                            <c:forEach begin="1"
                                                                                                end="${p.averageRating.intValue()}">
                                                                                                <i
                                                                                                    class="fas fa-star"></i>
                                                                                            </c:forEach>
                                                                                            <span
                                                                                                class="text-muted">(${p.reviewCount})</span>
                                                                                        </span>
                                                                                    </c:when>
                                                                                    <c:otherwise><span
                                                                                            class="text-muted">Chưa có
                                                                                            đánh giá</span>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </div>

                                                                            <div class="mt-auto">
                                                                                <c:choose>
                                                                                    <c:when test="${p.onSale}">
                                                                                        <p
                                                                                            class="product-price mb-0 fw-bold text-danger">
                                                                                            <fmt:formatNumber
                                                                                                value="${p.discountedPrice}"
                                                                                                type="currency"
                                                                                                currencySymbol="đ" />
                                                                                        </p>
                                                                                        <div class="d-flex align-items-center justify-content-center gap-2"
                                                                                            style="font-size: 0.85rem;">
                                                                                            <span
                                                                                                class="text-muted text-decoration-line-through">
                                                                                                <fmt:formatNumber
                                                                                                    value="${p.price}"
                                                                                                    type="currency"
                                                                                                    currencySymbol="đ" />
                                                                                            </span>
                                                                                            <span
                                                                                                class="badge bg-danger">-${p.discountPercentage}%</span>
                                                                                        </div>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <p class="product-price mb-0">
                                                                                            <fmt:formatNumber
                                                                                                value="${p.price}"
                                                                                                type="currency"
                                                                                                currencySymbol="đ" />
                                                                                        </p>
                                                                                        <div
                                                                                            style="font-size: 0.85rem; visibility: hidden;">
                                                                                            <span>Placeholder</span>
                                                                                        </div>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </div>
                                                                        </div>
                                                                    </a>
                                                                    <div
                                                                        class="card-footer bg-white border-0 pb-3 text-center">
                                                                        <a href="/product/${p.id}"
                                                                            class="btn btn-outline-theme w-100 rounded-pill btn-sm fw-bold">Xem
                                                                            ngay</a>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </c:if>
                                                    </c:forEach>

                                        </div>

                                        <div class="text-center mt-5 mb-4 d-flex gap-2 justify-content-center">
                                            <button id="loadMoreBtn" class="btn px-5 py-2 rounded-pill fw-bold"
                                                style="display:none; background:#eef5eb; color:#3c8a2e; border:none;">
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
                            // --- CẤU HÌNH SỐ LƯỢNG SẢN PHẨM HIỂN THỊ MẶC ĐỊNH LÀ 15 ---
                            const ITEMS_PER_PAGE = 15;

                            // Slider Best Seller & Brand Strip
                            const container = document.getElementById('categoryList');
                            if (container) {
                                document.getElementById('slideLeft').onclick = () => container.scrollBy({ left: -400, behavior: 'smooth' });
                                document.getElementById('slideRight').onclick = () => container.scrollBy({ left: 400, behavior: 'smooth' });
                            }

                            // Logic Xem Thêm / Thu Gọn
                            const productItems = document.querySelectorAll('.product-item');
                            const loadMoreBtn = document.getElementById('loadMoreBtn');
                            const collapseBtn = document.getElementById('collapseBtn');

                            if (loadMoreBtn && productItems.length > ITEMS_PER_PAGE) {
                                loadMoreBtn.style.display = 'inline-block';

                                for (let i = ITEMS_PER_PAGE; i < productItems.length; i++) {
                                    productItems[i].classList.add('d-none-custom');
                                }

                                loadMoreBtn.onclick = function () {
                                    productItems.forEach(item => item.classList.remove('d-none-custom'));
                                    this.style.display = 'none';
                                    collapseBtn.style.display = 'inline-block';
                                };

                                collapseBtn.onclick = function () {
                                    for (let i = ITEMS_PER_PAGE; i < productItems.length; i++) {
                                        productItems[i].classList.add('d-none-custom');
                                    }
                                    this.style.display = 'none';
                                    loadMoreBtn.style.display = 'inline-block';
                                    const title = document.getElementById('product-section-title');
                                    if (title) title.scrollIntoView({ behavior: 'smooth' });
                                };
                            }
                        });
                    </script>
            </body>

            </html>