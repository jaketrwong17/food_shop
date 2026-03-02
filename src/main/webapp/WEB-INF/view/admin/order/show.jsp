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

                    /* CSS CHO BẢNG THỐNG KÊ MỚI (STYLE DASHBOARD) */
                    .card-stats {
                        transition: transform 0.2s ease !important;
                        border: none;
                        border-radius: 10px;
                        background-color: #fff;
                    }

                    .card-stats:hover {
                        transform: translateY(-5px) !important;
                        box-shadow: 0 .5rem 1rem rgba(0, 0, 0, .15) !important;
                    }

                    .icon-shape {
                        width: 42px;
                        height: 42px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        border-radius: 50%;
                    }
                </style>
            </head>

            <body>
                <div class="d-flex" id="wrapper">
                    <jsp:include page="../layout/sidebar.jsp">
                        <jsp:param name="active" value="order" />
                    </jsp:include>

                    <div id="page-content-wrapper" class="bg-light">
                        <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom px-4 py-3 mb-4">
                            <h4 class="mb-0 text-dark fw-bold">Quản lý Đơn hàng</h4>
                        </nav>

                        <div class="container-fluid px-4">

                            <%-- THUẬT TOÁN ĐẾM SỐ LƯỢNG TRẠNG THÁI --%>
                                <c:set var="countTotal" value="0" />
                                <c:set var="countPending" value="0" />
                                <c:set var="countConfirmed" value="0" />
                                <c:set var="countShipping" value="0" />
                                <c:set var="countCompleted" value="0" />
                                <c:set var="countCancelled" value="0" />

                                <c:if test="${not empty orders}">
                                    <c:forEach var="o" items="${orders}">
                                        <c:set var="countTotal" value="${countTotal + 1}" />
                                        <c:choose>
                                            <c:when test="${o.status == 'PENDING'}">
                                                <c:set var="countPending" value="${countPending + 1}" />
                                            </c:when>
                                            <c:when test="${o.status == 'CONFIRMED'}">
                                                <c:set var="countConfirmed" value="${countConfirmed + 1}" />
                                            </c:when>
                                            <c:when test="${o.status == 'SHIPPING'}">
                                                <c:set var="countShipping" value="${countShipping + 1}" />
                                            </c:when>
                                            <c:when test="${o.status == 'COMPLETED'}">
                                                <c:set var="countCompleted" value="${countCompleted + 1}" />
                                            </c:when>
                                            <c:when test="${o.status == 'CANCELLED'}">
                                                <c:set var="countCancelled" value="${countCancelled + 1}" />
                                            </c:when>
                                        </c:choose>
                                    </c:forEach>
                                </c:if>

                                <%-- GIAO DIỆN BẢNG THỐNG KÊ (STYLE DASHBOARD) --%>
                                    <div class="row g-3 mb-4">
                                        <div class="col-xl-2 col-lg-4 col-md-4 col-6">
                                            <div
                                                class="card card-stats shadow-sm h-100 border-start border-secondary border-4">
                                                <div class="card-body p-3">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <div>
                                                            <p class="text-muted mb-1 small fw-bold">TỔNG SỐ ĐƠN</p>
                                                            <h4 class="fw-bold text-secondary mb-0">${countTotal}</h4>
                                                        </div>
                                                        <div
                                                            class="icon-shape bg-secondary bg-opacity-10 text-secondary">
                                                            <i class="fas fa-boxes fa-lg"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-2 col-lg-4 col-md-4 col-6">
                                            <div
                                                class="card card-stats shadow-sm h-100 border-start border-warning border-4">
                                                <div class="card-body p-3">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <div>
                                                            <p class="text-muted mb-1 small fw-bold">CHỜ XỬ LÝ</p>
                                                            <h4 class="fw-bold text-warning mb-0">${countPending}</h4>
                                                        </div>
                                                        <div class="icon-shape bg-warning bg-opacity-10 text-warning">
                                                            <i class="fas fa-clock fa-lg"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-2 col-lg-4 col-md-4 col-6">
                                            <div
                                                class="card card-stats shadow-sm h-100 border-start border-primary border-4">
                                                <div class="card-body p-3">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <div>
                                                            <p class="text-muted mb-1 small fw-bold">ĐÃ XÁC NHẬN</p>
                                                            <h4 class="fw-bold text-primary mb-0">${countConfirmed}</h4>
                                                        </div>
                                                        <div class="icon-shape bg-primary bg-opacity-10 text-primary">
                                                            <i class="fas fa-check-circle fa-lg"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-2 col-lg-4 col-md-4 col-6">
                                            <div
                                                class="card card-stats shadow-sm h-100 border-start border-info border-4">
                                                <div class="card-body p-3">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <div>
                                                            <p class="text-muted mb-1 small fw-bold">ĐANG GIAO</p>
                                                            <h4 class="fw-bold text-info mb-0">${countShipping}</h4>
                                                        </div>
                                                        <div class="icon-shape bg-info bg-opacity-10 text-info">
                                                            <i class="fas fa-truck fa-lg"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-2 col-lg-4 col-md-4 col-6">
                                            <div
                                                class="card card-stats shadow-sm h-100 border-start border-success border-4">
                                                <div class="card-body p-3">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <div>
                                                            <p class="text-muted mb-1 small fw-bold">HOÀN THÀNH</p>
                                                            <h4 class="fw-bold text-success mb-0">${countCompleted}</h4>
                                                        </div>
                                                        <div class="icon-shape bg-success bg-opacity-10 text-success">
                                                            <i class="fas fa-check-double fa-lg"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-2 col-lg-4 col-md-4 col-6">
                                            <div
                                                class="card card-stats shadow-sm h-100 border-start border-danger border-4">
                                                <div class="card-body p-3">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <div>
                                                            <p class="text-muted mb-1 small fw-bold">ĐÃ HỦY</p>
                                                            <h4 class="fw-bold text-danger mb-0">${countCancelled}</h4>
                                                        </div>
                                                        <div class="icon-shape bg-danger bg-opacity-10 text-danger">
                                                            <i class="fas fa-times-circle fa-lg"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <%-- KẾT THÚC BẢNG THỐNG KÊ --%>


                                        <div class="card shadow-sm border-0 rounded-3 mb-5">
                                            <div class="card-header bg-white py-3 border-bottom">
                                                <div class="row">
                                                    <div class="col-md-10">
                                                        <form action="/admin/order" method="GET"
                                                            class="d-flex gap-2 align-items-center flex-wrap">

                                                            <select name="status" class="form-select"
                                                                style="max-width: 200px;">
                                                                <option value="">-- Tất cả trạng thái --</option>
                                                                <option value="PENDING" ${status=='PENDING' ? 'selected'
                                                                    : '' }>Chờ xử lý</option>
                                                                <option value="CONFIRMED" ${status=='CONFIRMED'
                                                                    ? 'selected' : '' }>Đã xác nhận</option>
                                                                <option value="SHIPPING" ${status=='SHIPPING'
                                                                    ? 'selected' : '' }>Đang giao</option>
                                                                <option value="COMPLETED" ${status=='COMPLETED'
                                                                    ? 'selected' : '' }>Hoàn thành</option>
                                                                <option value="CANCELLED" ${status=='CANCELLED'
                                                                    ? 'selected' : '' }>Đã hủy</option>
                                                            </select>

                                                            <input type="text" name="keyword" class="form-control"
                                                                placeholder="Tên khách, SĐT..." value="${keyword}"
                                                                style="max-width: 300px;">

                                                            <button
                                                                class="btn btn-outline-primary d-flex align-items-center justify-content-center shadow-none"
                                                                type="submit"
                                                                style="width: 38px; height: 38px; border-radius: 6px;"
                                                                title="Tìm kiếm">
                                                                <i class="fas fa-search"></i>
                                                            </button>
                                                            <a href="/admin/order"
                                                                class="btn btn-outline-secondary d-flex align-items-center justify-content-center shadow-none"
                                                                style="width: 38px; height: 38px; border-radius: 6px;"
                                                                title="Làm mới">
                                                                <i class="fas fa-sync-alt"
                                                                    style="font-size: 0.8rem;"></i>
                                                            </a>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="card-body p-0">
                                                <c:if test="${empty orders}">
                                                    <div class="text-center py-5">
                                                        <i class="fas fa-search fa-3x text-muted mb-3 opacity-25"></i>
                                                        <p class="text-muted fw-bold">Không tìm thấy đơn hàng nào phù
                                                            hợp!</p>
                                                    </div>
                                                </c:if>

                                                <c:if test="${not empty orders}">
                                                    <div class="table-responsive">
                                                        <table class="table table-hover align-middle mb-0">
                                                            <thead class="bg-light text-secondary">
                                                                <tr>
                                                                    <th class="ps-4 py-3">ID</th>
                                                                    <th>Khách hàng</th>
                                                                    <th>Ngày đặt</th>
                                                                    <th>Hoàn thành</th>
                                                                    <th>Tổng tiền</th>
                                                                    <th>Trạng thái</th>
                                                                    <th style="min-width: 350px;" class="text-end pe-4">
                                                                        Thao tác nhanh</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <c:forEach var="order" items="${orders}">
                                                                    <tr>
                                                                        <td class="ps-4 fw-bold">#${order.id}</td>
                                                                        <td>
                                                                            <div class="fw-bold text-dark">
                                                                                ${order.receiverName}</div>
                                                                            <small class="text-muted"><i
                                                                                    class="fas fa-phone-alt me-1"
                                                                                    style="font-size: 10px;"></i>${order.receiverPhone}</small>
                                                                        </td>

                                                                        <td class="text-nowrap">
                                                                            <fmt:formatDate value="${order.createdAt}"
                                                                                pattern="dd/MM/yyyy HH:mm" />
                                                                        </td>

                                                                        <td class="text-nowrap text-success fw-bold">
                                                                            <c:if test="${not empty order.completedAt}">
                                                                                <fmt:formatDate
                                                                                    value="${order.completedAt}"
                                                                                    pattern="dd/MM/yyyy HH:mm" />
                                                                            </c:if>
                                                                            <c:if test="${empty order.completedAt}">
                                                                                <span
                                                                                    class="text-muted fw-normal opacity-50">-</span>
                                                                            </c:if>
                                                                        </td>

                                                                        <td class="text-danger fw-bold text-nowrap">
                                                                            <fmt:formatNumber
                                                                                value="${order.totalPrice}"
                                                                                type="currency" currencySymbol="đ" />
                                                                        </td>

                                                                        <td id="status-badge-${order.id}">
                                                                            <c:choose>
                                                                                <c:when
                                                                                    test="${order.status == 'PENDING'}">
                                                                                    <span
                                                                                        class="badge bg-warning text-dark">Chờ
                                                                                        xử lý</span>
                                                                                </c:when>
                                                                                <c:when
                                                                                    test="${order.status == 'CONFIRMED'}">
                                                                                    <span class="badge bg-primary">Đã
                                                                                        xác nhận</span>
                                                                                </c:when>
                                                                                <c:when
                                                                                    test="${order.status == 'SHIPPING'}">
                                                                                    <span
                                                                                        class="badge bg-info text-dark">Đang
                                                                                        giao</span>
                                                                                </c:when>
                                                                                <c:when
                                                                                    test="${order.status == 'COMPLETED'}">
                                                                                    <span class="badge bg-success">Hoàn
                                                                                        thành</span>
                                                                                </c:when>
                                                                                <c:when
                                                                                    test="${order.status == 'CANCELLED'}">
                                                                                    <span class="badge bg-danger">Đã
                                                                                        hủy</span>
                                                                                </c:when>
                                                                            </c:choose>
                                                                        </td>

                                                                        <td id="action-cell-${order.id}" class="pe-4">
                                                                            <div class="action-group">
                                                                                <select
                                                                                    class="form-select form-select-sm shadow-none"
                                                                                    onchange="updateStatus(${order.id}, this.value)"
                                                                                    style="width: 140px; font-weight: 500;"
                                                                                    ${order.status=='CANCELLED'
                                                                                    ? 'disabled' : '' }>
                                                                                    <option value="PENDING"
                                                                                        ${order.status=='PENDING'
                                                                                        ? 'selected' : '' }>Chờ xử lý
                                                                                    </option>
                                                                                    <option value="CONFIRMED"
                                                                                        ${order.status=='CONFIRMED'
                                                                                        ? 'selected' : '' }>Đã xác nhận
                                                                                    </option>
                                                                                    <option value="SHIPPING"
                                                                                        ${order.status=='SHIPPING'
                                                                                        ? 'selected' : '' }>Đang giao
                                                                                    </option>
                                                                                    <option value="COMPLETED"
                                                                                        ${order.status=='COMPLETED'
                                                                                        ? 'selected' : '' }>Hoàn thành
                                                                                    </option>
                                                                                </select>

                                                                                <c:choose>
                                                                                    <c:when
                                                                                        test="${order.status == 'PENDING'}">
                                                                                        <button
                                                                                            onclick="updateStatus(${order.id}, 'CONFIRMED')"
                                                                                            class="btn btn-sm btn-primary text-white"
                                                                                            title="Xác nhận đơn"><i
                                                                                                class="fas fa-check"></i></button>
                                                                                    </c:when>
                                                                                    <c:when
                                                                                        test="${order.status == 'CONFIRMED'}">
                                                                                        <button
                                                                                            onclick="updateStatus(${order.id}, 'SHIPPING')"
                                                                                            class="btn btn-sm btn-info text-dark"
                                                                                            title="Giao hàng"><i
                                                                                                class="fas fa-truck"></i></button>
                                                                                    </c:when>
                                                                                    <c:when
                                                                                        test="${order.status == 'SHIPPING'}">
                                                                                        <button
                                                                                            onclick="updateStatus(${order.id}, 'COMPLETED')"
                                                                                            class="btn btn-sm btn-success text-white"
                                                                                            title="Hoàn thành"><i
                                                                                                class="fas fa-check-double"></i></button>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <button
                                                                                            class="btn btn-sm btn-secondary disabled border-0"><i
                                                                                                class="fas fa-check"></i></button>
                                                                                    </c:otherwise>
                                                                                </c:choose>

                                                                                <button
                                                                                    onclick="updateStatus(${order.id}, 'CANCELLED')"
                                                                                    class="btn btn-sm btn-danger ${order.status == 'COMPLETED' || order.status == 'CANCELLED' || order.status == 'SHIPPING' ? 'disabled border-0' : ''}"
                                                                                    title="Hủy đơn">
                                                                                    <i class="fas fa-times"></i>
                                                                                </button>

                                                                                <a href="/admin/invoice/export/${order.id}"
                                                                                    class="btn btn-sm btn-warning text-dark"
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