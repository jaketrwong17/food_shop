<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">
            <jsp:include page="../layout/header.jsp" />

            <head>
                <meta charset="UTF-8">
                <title>Quản lý Đơn hàng - Admin</title>
                <meta name="_csrf" content="${_csrf.token}" />
                <meta name="_csrf_header" content="${_csrf.headerName}" />

                <style>
                    .btn.disabled,
                    .btn:disabled {
                        opacity: 0.3 !important;
                        cursor: not-allowed;
                        pointer-events: none;
                        filter: grayscale(100%);
                    }

                    .action-group {
                        display: flex;
                        align-items: center;
                        justify-content: flex-end;
                        gap: 8px;
                    }

                    .table {
                        font-size: 0.95rem;
                    }

                    .text-nowrap {
                        white-space: nowrap;
                    }
                </style>
            </head>

            <body>
                <div class="d-flex" id="wrapper">
                    <jsp:include page="../layout/sidebar.jsp">
                        <jsp:param name="active" value="order" />
                    </jsp:include>

                    <div id="page-content-wrapper">
                        <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom px-4 py-3">
                            <h4 class="mb-0 text-dark fw-bold">Quản lý Đơn hàng</h4>
                        </nav>

                        <div class="container-fluid px-4 py-4">
                            <div class="card shadow-sm border-0 rounded-3">
                                <div class="card-header bg-white py-3">
                                    <div class="row">
                                        <div class="col-md-9">
                                            <form action="/admin/order" method="GET"
                                                class="d-flex gap-2 align-items-center">
                                                <input type="text" name="keyword" class="form-control" placeholder=""
                                                    value="${keyword}" style="max-width: 400px;">
                                                <button class="btn btn-outline-primary ms-2"><i
                                                        class="fas fa-search"></i></button>
                                            </form>
                                        </div>
                                    </div>
                                </div>

                                <div class="card-body p-0">
                                    <c:if test="${empty orders}">
                                        <div class="text-center py-5">
                                            <i class="fas fa-box-open fa-3x text-muted mb-3"></i>
                                            <p class="text-muted">Không tìm thấy đơn hàng nào phù hợp!</p>
                                        </div>
                                    </c:if>

                                    <c:if test="${not empty orders}">
                                        <div class="table-responsive">
                                            <table class="table table-hover align-middle mb-0">
                                                <thead class="bg-light text-secondary">
                                                    <tr>
                                                        <th class="ps-4">ID</th>
                                                        <th>Khách hàng</th>
                                                        <th>Ngày đặt</th>
                                                        <th>Hoàn thành</th>
                                                        <th>Tổng tiền</th>
                                                        <th>Trạng thái</th>
                                                        <th style="min-width: 350px;" class="text-end pe-4">Thao tác
                                                            nhanh</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="order" items="${orders}">
                                                        <tr>
                                                            <td class="ps-4 fw-bold">#${order.id}</td>
                                                            <td>
                                                                <div class="fw-bold">${order.receiverName}</div>
                                                                <small class="text-muted">${order.receiverPhone}</small>
                                                            </td>

                                                            <td class="text-nowrap">
                                                                <fmt:formatDate value="${order.createdAt}"
                                                                    pattern="dd/MM/yyyy HH:mm" />
                                                            </td>

                                                            <td class="text-nowrap text-success fw-bold">
                                                                <c:if test="${not empty order.completedAt}">
                                                                    <fmt:formatDate value="${order.completedAt}"
                                                                        pattern="dd/MM/yyyy HH:mm" />
                                                                </c:if>
                                                                <c:if test="${empty order.completedAt}">
                                                                    <span class="text-muted fw-normal">-</span>
                                                                </c:if>
                                                            </td>

                                                            <td class="text-danger fw-bold text-nowrap">
                                                                <fmt:formatNumber value="${order.totalPrice}"
                                                                    type="currency" currencySymbol="đ" />
                                                            </td>

                                                            <td id="status-badge-${order.id}">
                                                                <c:choose>
                                                                    <c:when test="${order.status == 'PENDING'}">
                                                                        <span class="badge bg-warning text-dark">Chờ xử
                                                                            lý</span>
                                                                    </c:when>
                                                                    <c:when test="${order.status == 'CONFIRMED'}">
                                                                        <span class="badge bg-primary">Đã xác
                                                                            nhận</span>
                                                                    </c:when>
                                                                    <c:when test="${order.status == 'SHIPPING'}">
                                                                        <span class="badge bg-info text-dark">Đang
                                                                            giao</span>
                                                                    </c:when>
                                                                    <c:when test="${order.status == 'COMPLETED'}">
                                                                        <span class="badge bg-success">Hoàn thành</span>
                                                                    </c:when>
                                                                    <c:when test="${order.status == 'CANCELLED'}">
                                                                        <span class="badge bg-danger">Đã hủy</span>
                                                                    </c:when>
                                                                </c:choose>
                                                            </td>

                                                            <td id="action-cell-${order.id}" class="pe-4">
                                                                <div class="action-group">
                                                                    <select class="form-select form-select-sm"
                                                                        onchange="updateStatus(${order.id}, this.value)"
                                                                        style="width: 140px; font-weight: 500;"
                                                                        ${order.status=='CANCELLED' ? 'disabled' : '' }>
                                                                        <option value="PENDING"
                                                                            ${order.status=='PENDING' ? 'selected' : ''
                                                                            }>Chờ xử lý</option>
                                                                        <option value="CONFIRMED"
                                                                            ${order.status=='CONFIRMED' ? 'selected'
                                                                            : '' }>Đã xác nhận</option>
                                                                        <option value="SHIPPING"
                                                                            ${order.status=='SHIPPING' ? 'selected' : ''
                                                                            }>Đang giao</option>
                                                                        <option value="COMPLETED"
                                                                            ${order.status=='COMPLETED' ? 'selected'
                                                                            : '' }>Hoàn thành</option>
                                                                    </select>

                                                                    <c:choose>
                                                                        <c:when test="${order.status == 'PENDING'}">
                                                                            <button
                                                                                onclick="updateStatus(${order.id}, 'CONFIRMED')"
                                                                                class="btn btn-sm btn-primary text-white"
                                                                                title="Xác nhận đơn">
                                                                                <i class="fas fa-check"></i>
                                                                            </button>
                                                                        </c:when>
                                                                        <c:when test="${order.status == 'CONFIRMED'}">
                                                                            <button
                                                                                onclick="updateStatus(${order.id}, 'SHIPPING')"
                                                                                class="btn btn-sm btn-info text-dark"
                                                                                title="Giao hàng">
                                                                                <i class="fas fa-truck"></i>
                                                                            </button>
                                                                        </c:when>
                                                                        <c:when test="${order.status == 'SHIPPING'}">
                                                                            <button
                                                                                onclick="updateStatus(${order.id}, 'COMPLETED')"
                                                                                class="btn btn-sm btn-success text-white"
                                                                                title="Hoàn thành">
                                                                                <i class="fas fa-check-double"></i>
                                                                            </button>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <button
                                                                                class="btn btn-sm btn-secondary disabled"><i
                                                                                    class="fas fa-check"></i></button>
                                                                        </c:otherwise>
                                                                    </c:choose>

                                                                    <button
                                                                        onclick="updateStatus(${order.id}, 'CANCELLED')"
                                                                        class="btn btn-sm btn-danger ${order.status == 'COMPLETED' || order.status == 'CANCELLED' || order.status == 'SHIPPING' ? 'disabled' : ''}">
                                                                        <i class="fas fa-times"></i>
                                                                    </button>

                                                                    <a href="/admin/invoice/export/${order.id}"
                                                                        class="btn btn-sm btn-warning text-dark border"
                                                                        title="Xuất hóa đơn PDF">
                                                                        <i class="fas fa-file-invoice"></i>
                                                                    </a>
                                                                    <a href="/admin/order/view/${order.id}"
                                                                        class="btn btn-sm btn-light border text-primary"
                                                                        title="Xem chi tiết">
                                                                        <i class="fas fa-eye"></i>
                                                                    </a>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

                <script>
                    function updateStatus(orderId, newStatus) {
                        const csrfMeta = document.querySelector('meta[name="_csrf"]');
                        var csrfToken = csrfMeta ? csrfMeta.getAttribute('content') : '';
                        const csrfHeader = 'X-CSRF-TOKEN';

                        if (!csrfToken) {
                            alert("Lỗi bảo mật: Không tìm thấy CSRF Token. Hãy thử F5 lại trang.");
                            return;
                        }

                        const params = new URLSearchParams();
                        params.append('id', orderId);
                        params.append('status', newStatus);

                        fetch('<c:url value="/admin/order/update-status-ajax" />', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded',
                                [csrfHeader]: csrfToken
                            },
                            body: params
                        })
                            .then(response => {
                                if (response.ok) {
                                    window.location.reload();
                                } else {
                                    alert("Lỗi từ Server: " + response.status);
                                }
                            })
                            .catch(error => {
                                console.error("Lỗi chi tiết:", error);
                                alert("Lỗi thao tác: " + error.message);
                            });
                    }
                </script>
            </body>

            </html>