<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <style>
                .coupon-ticker-wrap {
                    background-color: #237fe7;


                    width: 100%;
                    position: relative;
                    z-index: 1;

                }


                .ticker-viewport {
                    overflow: hidden;
                    white-space: nowrap;
                    height: 35px;
                    display: flex;
                    align-items: center;
                    position: relative;

                    -webkit-mask-image: linear-gradient(to right, transparent, black 20px, black 95%, transparent);
                    mask-image: linear-gradient(to right, transparent, black 20px, black 95%, transparent);
                }


                .coupon-ticker-content {
                    display: inline-block;
                    padding-left: 100%;
                    animation: ticker-scroll 120s linear infinite;
                }


                .coupon-ticker-content:hover {
                    animation-play-state: paused;
                    cursor: default;
                }

                @keyframes ticker-scroll {
                    0% {
                        transform: translate3d(0, 0, 0);
                    }

                    100% {
                        transform: translate3d(-100%, 0, 0);
                    }
                }

                .coupon-item {
                    margin-right: 50px;
                    font-weight: 500;
                    color: #fff;
                    font-size: 0.9rem;
                    display: inline-flex;
                    align-items: center;
                    gap: 8px;
                }

                .coupon-item i {
                    font-size: 0.85rem;
                    opacity: 0.9;
                }


                header.sticky-top {
                    z-index: 1020 !important;

                    position: sticky;
                    top: 0;
                }


                .dropdown-menu {
                    z-index: 1030 !important;

                }


                .btn-register-custom {
                    color: #0d6efd !important;

                    background-color: #fff;
                    transition: all 0.3s ease;
                }


                .btn-login-hover:hover {
                    color: #2A83E9 !important;

                    background-color: #fff !important;

                    border-color: #fff !important;

                }

                .btn-auth {
                    min-width: 120px;

                    display: inline-flex;

                    justify-content: center;
                    align-items: center;
                }

                .custom-logo {
                    display: inline-block;
                    border-bottom: 3px solid #ffc107;

                    line-height: 1.2;

                    padding-bottom: 2px;
                }

                .custom-logo:hover {
                    color: inherit;

                    opacity: 0.8;
                }
            </style>

            <header class="navbar navbar-expand-lg navbar-dark py-3 sticky-top" style="background-color: #2A83E9;">
                <div class="container">
                    <a class="navbar-brand fw-bold fs-2 custom-logo" href="/">
                        16Home<span class="text-warning">.</span>
                    </a>

                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarContent">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="collapse navbar-collapse" id="navbarContent">
                        <div class="d-flex flex-grow-1 mx-lg-4 my-2 my-lg-0">

                            <div class="dropdown me-2">
                                <button class="btn btn-primary border-white dropdown-toggle rounded-pill w-100"
                                    type="button" id="dropdownMenuCategory" data-bs-toggle="dropdown"
                                    aria-expanded="false">
                                    <i class="fas fa-bars me-2"></i>Danh mục
                                </button>
                                <ul class="dropdown-menu shadow border-0" aria-labelledby="dropdownMenuCategory"
                                    style="min-width: 250px; padding: 0.5rem 0;">
                                    <c:choose>
                                        <c:when test="${not empty categories}">
                                            <c:forEach var="cat" items="${categories}">
                                                <li>
                                                    <a class="dropdown-item py-2 d-flex align-items-center"
                                                        href="/?categoryId=${cat.id}#danh-sach-san-pham">
                                                        <div class="me-3 d-flex align-items-center justify-content-center"
                                                            style="width: 30px; height: 30px;">
                                                            <c:choose>
                                                                <c:when test="${not empty cat.image}">
                                                                    <img src="/images/${cat.image}" alt="${cat.name}"
                                                                        style="width: 100%; height: 100%; object-fit: contain;"
                                                                        onerror="this.style.display='none'; this.nextElementSibling.style.display='inline-block';">
                                                                    <i class="fas fa-mobile-alt text-muted"
                                                                        style="display: none;"></i>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <i class="fas fa-tag text-secondary opacity-50"></i>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        <span class="fw-normal"
                                                            style="font-size: 0.95rem;">${cat.name}</span>
                                                    </a>
                                                </li>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <li><a class="dropdown-item disabled text-muted" href="#">Chưa có danh
                                                    mục</a></li>
                                        </c:otherwise>
                                    </c:choose>
                                </ul>
                            </div>

                            <form class="flex-grow-1 d-flex position-relative" action="/" method="GET">
                                <input class="form-control rounded-pill pe-5" type="search" name="search" placeholder=""
                                    value="${param.keyword}">
                                <button
                                    class="btn btn-link position-absolute end-0 top-50 translate-middle-y me-2 text-primary"
                                    type="submit">
                                    <i class="fas fa-search"></i>
                                </button>
                            </form>
                        </div>

                        <div class="d-flex align-items-center gap-3 justify-content-end">
                            <a href="/cart" class="text-white text-decoration-none position-relative me-2">
                                <i class="fas fa-shopping-cart fs-4"></i>
                                <span
                                    class="badge bg-warning text-dark rounded-pill position-absolute top-0 start-100 translate-middle">
                                    ${sessionScope.sum != null ? sessionScope.sum : 0}
                                </span>
                            </a>

                            <c:choose>
                                <c:when test="${empty sessionScope.email}">
                                    <a href="/login"
                                        class="btn btn-outline-light rounded-pill fw-bold btn-sm btn-auth btn-login-hover">
                                        Đăng nhập
                                    </a>

                                    <a href="/register"
                                        class="btn btn-light text-primary rounded-pill fw-bold btn-sm btn-auth">
                                        Đăng ký
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <div class="dropdown">
                                        <button
                                            class="btn btn-link text-white text-decoration-none dropdown-toggle d-flex align-items-center"
                                            type="button" id="userDropdown" data-bs-toggle="dropdown"
                                            aria-expanded="false">
                                            <div class="bg-warning rounded-circle d-flex justify-content-center align-items-center text-dark fw-bold me-2"
                                                style="width: 35px; height: 35px;">
                                                <i class="fas fa-user"></i>
                                            </div>
                                            <span class="d-none d-md-inline-block fw-bold small text-truncate"
                                                style="max-width: 150px;">
                                                ${sessionScope.email}
                                            </span>
                                        </button>
                                        <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2"
                                            aria-labelledby="userDropdown">
                                            <c:if test="${sessionScope.role == 'ADMIN'}">
                                                <li>
                                                    <a class="dropdown-item py-2" href="/admin/dashboard">
                                                        <i class="fas fa-user-shield me-2 text-danger"></i> Trang quản
                                                        trị
                                                    </a>
                                                </li>
                                                <li>
                                                    <hr class="dropdown-divider">
                                                </li>
                                            </c:if>
                                            <li><a class="dropdown-item py-2" href="/profile"><i
                                                        class="fas fa-id-card me-2 text-primary"></i> Thông tin tài
                                                    khoản</a></li>
                                            <li><a class="dropdown-item py-2" href="/order-history"><i
                                                        class="fas fa-box-open me-2 text-success"></i> Quản lý đơn
                                                    hàng</a></li>
                                            <li>
                                                <hr class="dropdown-divider">
                                            </li>
                                            <li>
                                                <form action="/logout" method="post" class="m-0">
                                                    <c:if test="${not empty _csrf}">
                                                        <input type="hidden" name="${_csrf.parameterName}"
                                                            value="${_csrf.token}" />
                                                    </c:if>
                                                    <button type="submit"
                                                        class="dropdown-item py-2 text-danger fw-bold">
                                                        <i class="fas fa-sign-out-alt me-2"></i> Đăng xuất
                                                    </button>
                                                </form>
                                            </li>
                                        </ul>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </header>

            <div class="coupon-ticker-wrap">
                <div class="container">
                    <div class="ticker-viewport">
                        <div class="coupon-ticker-content">
                            <c:forEach begin="1" end="10">
                                <span class="coupon-item">
                                    <i class="fas fa-check-circle"></i> Sản phẩm chính hãng
                                </span>
                                <span class="coupon-item">
                                    <i class="fas fa-phone-alt"></i> Tổng đài: 0968 733 752
                                </span>
                                <span class="coupon-item">
                                    <i class="fas fa-shipping-fast"></i> Giao hàng tận nơi
                                </span>
                                <span class="coupon-item">
                                    <i class="fas fa-sync-alt"></i> Đổi trả 7 ngày
                                </span>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>