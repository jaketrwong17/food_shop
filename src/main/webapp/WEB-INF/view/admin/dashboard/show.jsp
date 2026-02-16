<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Dashboard - Admin Pro</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

                <style>
                    /* CSS riêng cho Layout Admin (nếu chưa có file css riêng) */
                    .card-stats {
                        transition: none !important;
                        border: none;
                        border-radius: 10px;
                    }

                    .card-stats:hover {
                        transform: none !important;
                        box-shadow: 0 .5rem 1rem rgba(0, 0, 0, .15) !important;
                    }

                    .icon-shape {
                        width: 48px;
                        height: 48px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        border-radius: 50%;
                    }

                    * {
                        transition: none !important;
                        animation: none !important;
                    }
                </style>
            </head>

            <body>

                <div class="d-flex" id="wrapper">

                    <jsp:include page="../layout/sidebar.jsp">
                        <jsp:param name="active" value="dashboard" />
                    </jsp:include>

                    <div id="page-content-wrapper" class="w-100 bg-light">

                        <jsp:include page="../layout/header.jsp" />

                        <div class="container-fluid px-4 py-4">
                            <h3 class="fw-bold mb-4">Tổng quan thống kê</h3>

                            <div class="row g-4 mb-4">
                                <div class="col-md-3">
                                    <div class="card card-stats shadow-sm h-100">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div>
                                                    <p class="text-muted mb-1 small text-uppercase fw-bold">Doanh thu
                                                    </p>
                                                    <h4 class="fw-bold text-success mb-0">
                                                        <fmt:formatNumber value="${totalRevenue}" type="currency"
                                                            currencySymbol="đ" />
                                                    </h4>
                                                </div>
                                                <div class="icon-shape bg-success bg-opacity-10 text-success">
                                                    <i class="fas fa-wallet fa-lg"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="card card-stats shadow-sm h-100">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div>
                                                    <p class="text-muted mb-1 small text-uppercase fw-bold">Đơn hàng</p>
                                                    <h4 class="fw-bold text-primary mb-0">${totalOrders}</h4>
                                                </div>
                                                <div class="icon-shape bg-primary bg-opacity-10 text-primary">
                                                    <i class="fas fa-shopping-bag fa-lg"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="card card-stats shadow-sm h-100">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div>
                                                    <p class="text-muted mb-1 small text-uppercase fw-bold">Sản phẩm</p>
                                                    <h4 class="fw-bold text-warning mb-0">${totalProducts}</h4>
                                                </div>
                                                <div class="icon-shape bg-warning bg-opacity-10 text-warning">
                                                    <i class="fas fa-box-open fa-lg"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="card card-stats shadow-sm h-100">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div>
                                                    <p class="text-muted mb-1 small text-uppercase fw-bold">Khách hàng
                                                    </p>
                                                    <h4 class="fw-bold text-info mb-0">${totalUsers}</h4>
                                                </div>
                                                <div class="icon-shape bg-info bg-opacity-10 text-info">
                                                    <i class="fas fa-users fa-lg"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row g-4">
                                <div class="col-lg-7">
                                    <div class="card shadow-sm border-0 h-100">
                                        <div class="card-header bg-white border-0 py-3">
                                            <h5 class="mb-0 fw-bold"><i
                                                    class="fas fa-chart-line me-2 text-primary"></i>Biểu đồ doanh thu (7
                                                ngày qua)</h5>
                                        </div>
                                        <div class="card-body">
                                            <canvas id="revenueChart" style="height: 300px; width: 100%;"></canvas>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-5">
                                    <div class="card shadow-sm border-0 h-100">
                                        <div class="card-header bg-white border-0 py-3">
                                            <h5 class="mb-0 fw-bold"><i class="fas fa-crown me-2 text-warning"></i>Top
                                                sản phẩm bán chạy</h5>
                                        </div>
                                        <div class="card-body p-0">
                                            <div class="table-responsive">
                                                <table class="table table-hover align-middle mb-0">
                                                    <thead class="bg-light">
                                                        <tr>
                                                            <th class="ps-3">Sản phẩm</th>
                                                            <th class="text-center">Đã bán</th>
                                                            <th class="text-end pe-3">Doanh thu</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="item" items="${bestSellingProducts}">
                                                            <tr>
                                                                <td class="ps-3">
                                                                    <div class="d-flex align-items-center">
                                                                        <div class="me-2"
                                                                            style="width: 40px; height: 40px;">
                                                                            <c:choose>
                                                                                <%-- Nếu có ảnh thì hiển thị --%>
                                                                                    <c:when
                                                                                        test="${not empty item.productImage}">
                                                                                        <img src="/images/${item.productImage}"
                                                                                            class="rounded border"
                                                                                            style="width: 100%; height: 100%; object-fit: cover;"
                                                                                            alt="Product Image">
                                                                                    </c:when>
                                                                                    <%-- Nếu không có ảnh thì hiện icon
                                                                                        mặc định --%>
                                                                                        <c:otherwise>
                                                                                            <div
                                                                                                class="bg-light rounded d-flex align-items-center justify-content-center h-100 border">
                                                                                                <i
                                                                                                    class="fas fa-image text-secondary"></i>
                                                                                            </div>
                                                                                        </c:otherwise>
                                                                            </c:choose>
                                                                        </div>

                                                                        <span class="fw-bold small text-truncate"
                                                                            style="max-width: 150px;"
                                                                            title="${item.productName}">
                                                                            ${item.productName}
                                                                        </span>
                                                                    </div>
                                                                </td>

                                                                <td class="text-center">
                                                                    <span
                                                                        class="badge bg-primary rounded-pill">${item.quantitySold}</span>
                                                                </td>

                                                                <td class="text-end pe-3 text-success fw-bold">
                                                                    <fmt:formatNumber value="${item.totalRevenue}"
                                                                        type="currency" currencySymbol="đ" />
                                                                </td>
                                                            </tr>
                                                        </c:forEach>

                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <div class="card-footer bg-white text-center border-0 py-3">
                                            <a href="/admin/product" class="text-decoration-none small fw-bold">Xem tất
                                                cả sản phẩm <i class="fas fa-arrow-right ms-1"></i></a>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <jsp:include page="../layout/footer.jsp" />
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

                <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

                <script>
                    // Cấu hình biểu đồ Doanh thu (Dữ liệu giả lập - Bạn cần thay bằng data thật từ Controller)
                    const ctx = document.getElementById('revenueChart');

                    new Chart(ctx, {
                        type: 'line',
                        data: {
                            // Labels: Lấy từ Controller (ví dụ: ngày 1, ngày 2...)
                            labels: ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'],
                            datasets: [{
                                label: 'Doanh thu (VNĐ)',
                                // Data: Lấy từ Controller
                                data: [1500000, 2300000, 1800000, 3200000, 2100000, 4500000, 3800000],
                                borderColor: '#198754', // Màu xanh success
                                backgroundColor: 'rgba(25, 135, 84, 0.1)',
                                tension: 0.3,
                                fill: true,
                                pointBackgroundColor: '#fff',
                                pointBorderColor: '#198754',
                                pointBorderWidth: 2
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: { display: false }
                            },
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    grid: { borderDash: [2, 4] }
                                },
                                x: {
                                    grid: { display: false }
                                }
                            }
                        }
                    });
                </script>
            </body>

            </html>