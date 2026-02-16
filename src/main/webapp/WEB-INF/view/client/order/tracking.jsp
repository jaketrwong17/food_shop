<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <title>Theo dõi đơn hàng - 16Home</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
                <style>
                    body {
                        background-color: #f5f5fa;
                        min-height: 100vh;
                        display: flex;
                        flex-direction: column;
                    }

                    .main-wrapper {
                        flex: 1;
                    }

                    .page-header-box {
                        background: #fff;
                        padding: 1rem;
                        border-radius: 8px;
                        box-shadow: 0 .125rem .25rem rgba(0, 0, 0, .075);
                        margin-bottom: 1.5rem;
                    }

                    .content-box {
                        background: #fff;
                        border-radius: 8px;
                        box-shadow: 0 .125rem .25rem rgba(0, 0, 0, .075);
                        padding: 1.5rem;
                        min-height: 100%;
                    }

                    .order-card-item {
                        border: 1px solid #eee;
                        border-radius: 8px;
                        padding: 15px;
                        margin-bottom: 15px;
                        transition: all 0.3s;
                        background: #fff;
                    }

                    .order-card-item:hover {
                        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
                        border-color: ##2A83E9;
                        transform: translateY(-2px);
                    }
                </style>
            </head>

            <body>
                <jsp:include page="../layout/header.jsp" />

                <div class="main-wrapper">
                    <div class="container mt-4 mb-5">
                        <nav aria-label="breadcrumb" class="mb-4">
                            <ol class="breadcrumb mb-0">
                                <li class="breadcrumb-item">
                                    <a href="/" class="text-decoration-none text-muted">Trang chủ</a>
                                </li>
                                <li class="breadcrumb-item active text-primary" aria-current="page">
                                    Theo dõi đơn hàng
                                </li>
                            </ol>
                        </nav>

                        <div class="row g-4">
                            <div class="col-lg-3">
                                <jsp:include page="sidebar.jsp">
                                    <jsp:param name="activePage" value="tracking" />
                                </jsp:include>
                            </div>

                            <div class="col-lg-9">
                                <div class="content-box">
                                    <h5 class="fw-bold text-uppercase mb-4 pb-3 border-bottom text-primary">
                                        <i class="fas fa-truck-fast me-2"></i>Đơn hàng đang xử lý
                                    </h5>

                                    <c:choose>
                                        <c:when test="${empty activeOrders}">
                                            <div class="text-center py-5">
                                                <i class="fas fa-box-open fa-4x text-muted opacity-25 mb-3"></i>
                                                <p class="text-muted">Không có đơn hàng nào đang xử lý.</p>
                                                <a href="/" class="btn btn-primary rounded-pill px-4">Tiếp tục mua
                                                    sắm</a>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="order" items="${activeOrders}">
                                                <div class="order-card-item">
                                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                                        <div>
                                                            <span class="fw-bold text-primary me-2">Đơn hàng
                                                                #${order.id}</span>
                                                            <small class="text-muted"><i class="far fa-clock me-1"></i>
                                                                <%-- SỬA: Đổi orderDate thành createdAt --%>
                                                                    <fmt:formatDate value="${order.createdAt}"
                                                                        pattern="dd/MM/yyyy HH:mm" />
                                                            </small>
                                                        </div>
                                                        <div>
                                                            <c:if test="${order.status == 'PENDING'}">
                                                                <span
                                                                    class="badge bg-warning text-dark rounded-pill px-3 py-2"><i
                                                                        class="fas fa-spinner fa-spin me-1"></i>Chờ xác
                                                                    nhận</span>
                                                            </c:if>
                                                            <c:if test="${order.status == 'CONFIRMED'}">
                                                                <span class="badge bg-primary rounded-pill px-3 py-2"><i
                                                                        class="fas fa-check me-1"></i>Đã xác nhận</span>
                                                            </c:if>
                                                            <c:if test="${order.status == 'SHIPPING'}">
                                                                <span
                                                                    class="badge bg-info text-dark rounded-pill px-3 py-2"><i
                                                                        class="fas fa-shipping-fast me-1"></i>Đang giao
                                                                    hàng</span>
                                                            </c:if>
                                                        </div>
                                                    </div>

                                                    <div class="d-flex justify-content-between align-items-end">
                                                        <div>
                                                            <p class="mb-1 text-muted small">Tổng thanh toán:</p>
                                                            <h5 class="fw-bold text-danger m-0">
                                                                <fmt:formatNumber value="${order.totalPrice}"
                                                                    type="currency" currencySymbol="đ" />
                                                            </h5>
                                                        </div>
                                                        <div class="d-flex gap-2">
                                                            <a href="/order-detail/${order.id}"
                                                                class="btn btn-outline-primary btn-sm rounded-pill px-3">
                                                                Xem chi tiết
                                                            </a>
                                                            <c:if test="${order.status == 'PENDING'}">
                                                                <a href="/order/cancel/${order.id}"
                                                                    onclick="return confirm('Bạn chắc chắn muốn hủy đơn hàng này?')"
                                                                    class="btn btn-outline-danger btn-sm rounded-pill px-3">Hủy
                                                                    đơn</a>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <jsp:include page="../layout/footer.jsp" />
            </body>

            </html>