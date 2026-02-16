<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <title>Chi tiết đơn hàng #${order.id} - 16Home</title>
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

                    .content-box {
                        background: #fff;
                        border-radius: 8px;
                        box-shadow: 0 .125rem .25rem rgba(0, 0, 0, .075);
                        padding: 1.5rem;
                        min-height: 100%;
                    }

                    .table-custom thead th {
                        background-color: #f8f9fa;
                        border-bottom: 2px solid #dee2e6;
                        color: #495057;
                        font-weight: 600;
                    }

                    .review-link:hover {
                        text-decoration: underline !important;
                        color: #ffc107 !important;
                        cursor: pointer;
                    }
                </style>
            </head>

            <body>
                <jsp:include page="../layout/header.jsp" />

                <div class="main-wrapper">
                    <div class="container mt-4 mb-5">

                        <nav aria-label="breadcrumb" class="mb-4">
                            <ol class="breadcrumb mb-0">
                                <li class="breadcrumb-item"><a href="/" class="text-decoration-none text-muted">Trang
                                        chủ</a></li>
                                <li class="breadcrumb-item"><a href="/order-history"
                                        class="text-decoration-none text-muted">Lịch sử đơn hàng</a></li>
                                <li class="breadcrumb-item active text-primary" aria-current="page">Chi tiết
                                    #${order.id}</li>
                            </ol>
                        </nav>

                        <div class="row g-4">
                            <div class="col-lg-3">
                                <jsp:include page="sidebar.jsp">
                                    <jsp:param name="activePage" value="history" />
                                </jsp:include>
                            </div>

                            <div class="col-lg-9">
                                <div class="content-box">
                                    <div
                                        class="d-flex justify-content-between align-items-center border-bottom pb-3 mb-4">
                                        <h5 class="fw-bold text-uppercase text-primary m-0">
                                            <i class="fas fa-file-invoice me-2"></i>Chi tiết đơn hàng
                                        </h5>
                                        <a href="/order-history" class="btn btn-sm btn-light border">
                                            <i class="fas fa-arrow-left me-1"></i>Quay lại
                                        </a>
                                    </div>

                                    <div class="row mb-4">
                                        <div class="col-md-6">
                                            <div class="p-3 bg-light rounded h-100">
                                                <h6 class="fw-bold text-dark"><i
                                                        class="fas fa-map-marker-alt me-2 text-danger"></i>Địa chỉ nhận
                                                    hàng</h6>
                                                <hr class="my-2">
                                                <p class="mb-1 fw-bold">${order.receiverName}</p>
                                                <p class="mb-1 text-muted small"><i
                                                        class="fas fa-phone me-1"></i>${order.receiverPhone}</p>
                                                <p class="mb-0 text-muted small">${order.receiverAddress}</p>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div
                                                class="p-3 bg-light rounded h-100 d-flex flex-column justify-content-center align-items-end">
                                                <span class="text-muted mb-2">Trạng thái đơn hàng</span>
                                                <c:choose>
                                                    <c:when test="${order.status == 'PENDING'}">
                                                        <span class="badge bg-warning text-dark fs-6 px-3 py-2">Chờ xử
                                                            lý</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'CONFIRMED'}">
                                                        <span class="badge bg-primary fs-6 px-3 py-2">Đã xác nhận</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'SHIPPING'}">
                                                        <span class="badge bg-info text-dark fs-6 px-3 py-2">Đang giao
                                                            hàng</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'COMPLETED'}">
                                                        <span class="badge bg-success fs-6 px-3 py-2">Giao hàng thành
                                                            công</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'CANCELLED'}">
                                                        <span class="badge bg-secondary fs-6 px-3 py-2">Đã hủy</span>
                                                    </c:when>
                                                </c:choose>

                                                <small class="text-muted mt-2">
                                                    Ngày đặt:
                                                    <fmt:formatDate value="${order.createdAt}"
                                                        pattern="dd/MM/yyyy HH:mm" />
                                                </small>

                                                <c:if test="${not empty order.completedAt}">
                                                    <small class="text-success fw-bold mt-1">
                                                        Hoàn thành:
                                                        <fmt:formatDate value="${order.completedAt}"
                                                            pattern="dd/MM/yyyy HH:mm" />
                                                    </small>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="table-responsive">
                                        <table class="table table-custom align-middle mb-0">
                                            <thead>
                                                <tr>
                                                    <th style="width: 50%">Sản phẩm</th>
                                                    <th class="text-center">Đơn giá</th>
                                                    <th class="text-center">Số lượng</th>
                                                    <th class="text-end">Thành tiền</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="detail" items="${orderDetails}">
                                                    <tr>
                                                        <td>
                                                            <div class="d-flex align-items-center">
                                                                <c:choose>
                                                                    <c:when
                                                                        test="${not empty detail.product.images and not empty detail.product.images[0].imageUrl}">
                                                                        <img src="/images/${detail.product.images[0].imageUrl}"
                                                                            alt="${detail.product.name}"
                                                                            style="width: 70px; height: 70px; object-fit: cover;"
                                                                            class="me-3 border rounded shadow-sm">
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <div style="width: 70px; height: 70px;"
                                                                            class="me-3 border rounded bg-light d-flex align-items-center justify-content-center text-muted small">
                                                                            No Img</div>
                                                                    </c:otherwise>
                                                                </c:choose>

                                                                <div>
                                                                    <p class="mb-1 fw-bold text-dark">
                                                                        ${detail.product.name}</p>

                                                                    <c:if test="${not empty detail.selectedColor}">
                                                                        <div class="mb-1">
                                                                            <small class="text-muted">Phân loại: <strong
                                                                                    class="text-dark">${detail.selectedColor}</strong></small>
                                                                        </div>
                                                                    </c:if>

                                                                    <c:if test="${order.status == 'COMPLETED'}">
                                                                        <a href="/product/${detail.product.id}#review-section"
                                                                            class="text-warning text-decoration-none small review-link">
                                                                            <i class="fas fa-star me-1"></i> Đánh giá
                                                                            sản phẩm
                                                                        </a>
                                                                    </c:if>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td class="text-center text-muted">
                                                            <fmt:formatNumber value="${detail.price}" type="currency"
                                                                currencySymbol="đ" />
                                                        </td>
                                                        <td class="text-center fw-bold">x${detail.quantity}</td>
                                                        <td class="text-end fw-bold text-primary">
                                                            <fmt:formatNumber value="${detail.price * detail.quantity}"
                                                                type="currency" currencySymbol="đ" />
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>

                                    <div class="row mt-4 pt-3 border-top">
                                        <div class="col-md-6 offset-md-6">
                                            <div class="d-flex justify-content-between align-items-center mb-2">
                                                <span class="text-muted">Tổng tiền hàng:</span>
                                                <span class="fw-bold">
                                                    <fmt:formatNumber value="${order.totalPrice}" type="currency"
                                                        currencySymbol="đ" />
                                                </span>
                                            </div>
                                            <div class="d-flex justify-content-between align-items-center">
                                                <span class="h5 fw-bold text-dark">Thành tiền:</span>
                                                <span class="h4 fw-bold text-danger">
                                                    <fmt:formatNumber value="${order.totalPrice}" type="currency"
                                                        currencySymbol="đ" />
                                                </span>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <jsp:include page="../layout/footer.jsp" />
            </body>

            </html>