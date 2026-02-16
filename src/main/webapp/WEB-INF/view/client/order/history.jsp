<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <title>Lịch sử mua hàng - 16Home</title>
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
                        border-top: none;
                        border-bottom: 2px solid #f1f1f1;
                        color: #6c757d;
                        font-weight: 600;
                        text-transform: uppercase;
                        font-size: 0.85rem;
                        white-space: nowrap;
                    }

                    .table-custom tbody td {
                        vertical-align: middle;
                        padding: 1rem 0.75rem;
                        border-bottom: 1px solid #f8f9fa;
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
                                    Lịch sử mua hàng
                                </li>
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
                                    <h5 class="fw-bold text-uppercase mb-4 pb-3 border-bottom text-primary">
                                        <i class="fas fa-clipboard-list me-2"></i>Lịch sử mua hàng
                                    </h5>

                                    <c:choose>
                                        <%-- TRƯỜNG HỢP KHÔNG CÓ ĐƠN HÀNG --%>
                                            <c:when test="${empty historyOrders}">
                                                <div class="text-center py-5">
                                                    <i
                                                        class="fas fa-shopping-basket fa-4x text-muted opacity-25 mb-3"></i>
                                                    <p class="text-muted">Bạn chưa mua đơn hàng nào.</p>
                                                    <a href="/" class="btn btn-primary rounded-pill px-4">Mua sắm
                                                        ngay</a>
                                                </div>
                                            </c:when>

                                            <%-- TRƯỜNG HỢP CÓ ĐƠN HÀNG --%>
                                                <c:otherwise>
                                                    <div class="table-responsive">
                                                        <table class="table table-hover table-custom mb-0">
                                                            <thead>
                                                                <tr>
                                                                    <th class="text-center">Mã ĐH</th>
                                                                    <th>Ngày đặt</th>
                                                                    <th>Hoàn thành</th>
                                                                    <th>Tổng tiền</th>
                                                                    <th class="text-center">Trạng thái</th>
                                                                    <th class="text-center">Thao tác</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <c:forEach var="order" items="${historyOrders}">
                                                                    <tr>
                                                                        <td class="text-center fw-bold text-primary">
                                                                            #${order.id}
                                                                        </td>

                                                                        <td>
                                                                            <fmt:formatDate value="${order.createdAt}"
                                                                                pattern="dd/MM/yyyy HH:mm" />
                                                                        </td>

                                                                        <td class="small fw-bold text-success">
                                                                            <c:if test="${not empty order.completedAt}">
                                                                                <fmt:formatDate
                                                                                    value="${order.completedAt}"
                                                                                    pattern="dd/MM/yyyy HH:mm" />
                                                                            </c:if>
                                                                            <c:if test="${empty order.completedAt}">
                                                                                <span
                                                                                    class="text-muted fw-normal">-</span>
                                                                            </c:if>
                                                                        </td>

                                                                        <td class="fw-bold text-danger">
                                                                            <fmt:formatNumber
                                                                                value="${order.totalPrice}"
                                                                                type="currency" currencySymbol="đ" />
                                                                        </td>

                                                                        <td class="text-center">
                                                                            <c:choose>
                                                                                <c:when
                                                                                    test="${order.status == 'COMPLETED'}">
                                                                                    <span
                                                                                        class="badge rounded-pill bg-success bg-opacity-10 text-success px-3 py-2">
                                                                                        Thành công
                                                                                    </span>
                                                                                </c:when>
                                                                                <c:when
                                                                                    test="${order.status == 'CANCELLED'}">
                                                                                    <span
                                                                                        class="badge rounded-pill bg-secondary bg-opacity-10 text-secondary px-3 py-2">
                                                                                        Đã hủy
                                                                                    </span>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <span
                                                                                        class="badge rounded-pill bg-warning bg-opacity-10 text-dark px-3 py-2">
                                                                                        ${order.status}
                                                                                    </span>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </td>

                                                                        <td class="text-center">
                                                                            <a href="/order-detail/${order.id}"
                                                                                class="btn btn-sm btn-light border"
                                                                                title="Xem chi tiết">
                                                                                <i class="fas fa-eye text-primary"></i>
                                                                            </a>
                                                                        </td>
                                                                    </tr>
                                                                </c:forEach>
                                                            </tbody>
                                                        </table>
                                                    </div>
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