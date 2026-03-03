<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <jsp:include page="../layout/header.jsp" />

                <style>
                    .card-stats {
                        transition: transform 0.2s ease !important;
                        border: none;
                        border-radius: 10px;
                        background: #fff;
                    }

                    .card-stats:hover {
                        transform: translateY(-5px) !important;
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

                    .table-custom-row td {
                        padding-top: 1rem;
                        padding-bottom: 1rem;
                        vertical-align: middle;
                    }

                    /* Form lọc thời gian */
                    .filter-bar {
                        background: #fff;
                        border-radius: 10px;
                        padding: 15px;
                        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                        margin-bottom: 25px;
                    }

                    .btn-time-shortcut {
                        border-radius: 50px;
                        font-size: 0.85rem;
                        padding: 5px 15px;
                        border: 1px solid #dee2e6;
                        color: #495057;
                        background: #fff;
                        transition: 0.2s;
                    }

                    .btn-time-shortcut:hover,
                    .btn-time-shortcut.active {
                        background: #f8f9fa;
                        border-color: #0d6efd;
                        color: #0d6efd;
                        font-weight: bold;
                    }
                </style>
            </head>

            <body>
                <div class="d-flex" id="wrapper">

                    <jsp:include page="../layout/sidebar.jsp">
                        <jsp:param name="active" value="dashboard" />
                    </jsp:include>

                    <div id="page-content-wrapper" class="bg-light w-100">
                        <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom px-4 py-3">
                            <h4 class="mb-0 text-dark fw-bold">Tổng quan thống kê</h4>
                        </nav>

                        <div class="container-fluid px-4 py-4">

                            <div class="filter-bar d-flex flex-wrap justify-content-between align-items-center gap-3">
                                <div class="d-flex gap-2 align-items-center">
                                    <button type="button"
                                        class="btn-time-shortcut ${currentRange == 'today' ? 'active' : ''}"
                                        onclick="setFilterRange('today')">Hôm nay</button>
                                    <button type="button"
                                        class="btn-time-shortcut ${currentRange == 'this_week' ? 'active' : ''}"
                                        onclick="setFilterRange('this_week')">Tuần này</button>
                                    <button type="button"
                                        class="btn-time-shortcut ${currentRange == 'this_month' ? 'active' : ''}"
                                        onclick="setFilterRange('this_month')">Tháng này</button>
                                    <button type="button"
                                        class="btn-time-shortcut ${currentRange == 'this_year' ? 'active' : ''}"
                                        onclick="setFilterRange('this_year')">Năm nay</button>

                                    <div class="vr mx-1 text-muted" style="height: 25px;"></div>
                                    <button type="button" class="btn-time-shortcut text-primary border-primary"
                                        style="background-color: #f0f8ff;"
                                        onclick="window.location.href='/admin/dashboard'" title="Xem dữ liệu tổng quát">
                                        <i class="fas fa-sync-alt me-1"></i> Tổng quát
                                    </button>
                                </div>

                                <form action="/admin/dashboard" method="GET" class="d-flex align-items-center gap-2 m-0"
                                    id="filterForm">
                                    <input type="hidden" name="range" id="rangeInput"
                                        value="${currentRange != null ? currentRange : ''}">
                                    <div class="input-group input-group-sm" style="width: auto;">
                                        <span class="input-group-text bg-white"><i
                                                class="fas fa-calendar-alt text-muted"></i></span>
                                        <input type="date" id="startDate" name="startDate"
                                            class="form-control fw-bold text-secondary" value="${startDate}" required>
                                    </div>
                                    <span class="text-muted fw-bold">-</span>
                                    <div class="input-group input-group-sm" style="width: auto;">
                                        <input type="date" id="endDate" name="endDate"
                                            class="form-control fw-bold text-secondary" value="${endDate}" required>
                                    </div>
                                    <button type="submit" class="btn btn-primary btn-sm fw-bold px-3 shadow-sm"><i
                                            class="fas fa-filter me-1"></i> Lọc dữ liệu</button>
                                </form>
                            </div>

                            <div class="row g-4 mb-4">
                                <div class="col-md-6">
                                    <div
                                        class="alert alert-warning border-0 shadow-sm d-flex align-items-center mb-0 h-100 bg-white border-start border-warning border-4">
                                        <div class="bg-warning bg-opacity-25 p-3 rounded-circle me-3">
                                            <i class="fas fa-box-open text-warning fs-4"></i>
                                        </div>
                                        <div>
                                            <h6 class="fw-bold mb-1">Đơn hàng chờ xử lý</h6>
                                            <span class="small text-dark">Bạn đang có <b
                                                    class="text-danger fs-5 mx-1">${pendingOrdersCount}</b> đơn chờ xác
                                                nhận.
                                                <a href="/admin/order?status=PENDING"
                                                    class="alert-link ms-1 text-decoration-none">Xử lý ngay <i
                                                        class="fas fa-arrow-right"></i></a>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div
                                        class="alert alert-danger border-0 shadow-sm d-flex align-items-center mb-0 h-100 bg-white border-start border-danger border-4">
                                        <div class="bg-danger bg-opacity-25 p-3 rounded-circle me-3">
                                            <i class="fas fa-exclamation-triangle text-danger fs-4"></i>
                                        </div>
                                        <div>
                                            <h6 class="fw-bold mb-1">Cảnh báo kho hàng</h6>
                                            <span class="small text-dark">Có <b
                                                    class="text-danger fs-5 mx-1">${lowStockProductsCount}</b> sản phẩm
                                                sắp hết hàng (< 5 SP). <a href="/admin/product"
                                                    class="alert-link text-danger ms-1 text-decoration-none">Kiểm tra
                                                    kho <i class="fas fa-arrow-right"></i></a>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row g-4 mb-4">
                                <div class="col-md-3">
                                    <div class="card card-stats shadow-sm h-100 border-start border-success border-4">
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
                                                <div class="icon-shape bg-success bg-opacity-10 text-success"><i
                                                        class="fas fa-wallet fa-lg"></i></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="card card-stats shadow-sm h-100 border-start border-primary border-4">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div>
                                                    <p class="text-muted mb-1 small text-uppercase fw-bold">Đơn hàng</p>
                                                    <h4 class="fw-bold text-primary mb-0">${totalOrders}</h4>
                                                </div>
                                                <div class="icon-shape bg-primary bg-opacity-10 text-primary"><i
                                                        class="fas fa-shopping-bag fa-lg"></i></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="card card-stats shadow-sm h-100 border-start border-warning border-4">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div>
                                                    <p class="text-muted mb-1 small text-uppercase fw-bold">Tổng Sản
                                                        phẩm</p>
                                                    <h4 class="fw-bold text-warning mb-0">${totalProducts}</h4>
                                                </div>
                                                <div class="icon-shape bg-warning bg-opacity-10 text-warning"><i
                                                        class="fas fa-box-open fa-lg"></i></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="card card-stats shadow-sm h-100 border-start border-info border-4">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div>
                                                    <p class="text-muted mb-1 small text-uppercase fw-bold">Tổng Khách
                                                        hàng</p>
                                                    <h4 class="fw-bold text-info mb-0">${totalUsers}</h4>
                                                </div>
                                                <div class="icon-shape bg-info bg-opacity-10 text-info"><i
                                                        class="fas fa-users fa-lg"></i></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row g-4 mb-4">
                                <div class="col-lg-8">
                                    <div class="card shadow-sm border-0 h-100">
                                        <div class="card-header bg-white border-0 py-3">
                                            <h5 class="mb-0 fw-bold"><i
                                                    class="fas fa-chart-line me-2 text-primary"></i>Biểu đồ biến động
                                                doanh thu</h5>
                                        </div>
                                        <div class="card-body pb-4">
                                            <canvas id="revenueChart" style="height: 300px; width: 100%;"></canvas>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-4">
                                    <div class="card shadow-sm border-0 h-100">
                                        <div class="card-header bg-white border-0 py-3 text-center">
                                            <h5 class="mb-0 fw-bold"><i
                                                    class="fas fa-chart-pie me-2 text-info"></i>Trạng thái đơn hàng</h5>
                                        </div>
                                        <div class="card-body d-flex justify-content-center align-items-center pb-4">
                                            <c:choose>
                                                <c:when test="${totalOrders > 0}">
                                                    <canvas id="statusChart" style="max-height: 260px;"></canvas>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="text-center text-muted py-5">
                                                        <i class="fas fa-chart-pie fa-3x mb-3 opacity-25"></i>
                                                        <p class="mb-0 mt-3 fw-bold">Chưa có dữ liệu</p>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-12">
                                    <div class="card shadow-sm border-0 mb-4">
                                        <div
                                            class="card-header bg-white border-bottom py-3 d-flex justify-content-between align-items-center">
                                            <h5 class="mb-0 fw-bold"><i class="fas fa-fire text-danger me-2"></i>Top 5
                                                sản phẩm bán chạy</h5>
                                            <a href="/admin/product"
                                                class="btn btn-sm btn-outline-primary fw-bold px-3">Tất cả SP <i
                                                    class="fas fa-arrow-right ms-1"></i></a>
                                        </div>
                                        <div class="card-body p-0">
                                            <div class="table-responsive">
                                                <table class="table table-hover align-middle mb-0">
                                                    <thead class="bg-light">
                                                        <tr>
                                                            <th class="ps-4 py-3 text-secondary">Tên sản phẩm</th>
                                                            <th class="text-center text-secondary">Đã bán</th>
                                                            <th class="text-end pe-4 text-secondary">Mang lại doanh thu
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:if test="${empty bestSellingProducts}">
                                                            <tr>
                                                                <td colspan="3" class="text-center text-muted py-5">Chưa
                                                                    có sản phẩm nào bán được.</td>
                                                            </tr>
                                                        </c:if>

                                                        <c:forEach var="item" items="${bestSellingProducts}">
                                                            <tr class="table-custom-row">
                                                                <td class="ps-4">
                                                                    <div class="d-flex align-items-center">
                                                                        <div class="me-3 shadow-sm rounded overflow-hidden d-flex align-items-center justify-content-center bg-white"
                                                                            style="width: 50px; height: 50px; border: 1px solid #dee2e6;">
                                                                            <c:choose>
                                                                                <c:when
                                                                                    test="${not empty item.productImage}">
                                                                                    <img src="/images/${item.productImage}"
                                                                                        style="width: 100%; height: 100%; object-fit: contain;"
                                                                                        onerror="this.style.display='none'; this.nextElementSibling.style.display='block';">
                                                                                    <i class="fas fa-image text-secondary opacity-50"
                                                                                        style="display: none;"></i>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <i
                                                                                        class="fas fa-image text-secondary opacity-50"></i>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </div>
                                                                        <div>
                                                                            <span class="fw-bold text-dark d-block"
                                                                                style="max-width: 350px;">${item.productName}</span>
                                                                        </div>
                                                                    </div>
                                                                </td>
                                                                <td class="text-center"><span
                                                                        class="badge bg-primary rounded-pill px-3 py-2">${item.quantitySold}</span>
                                                                </td>
                                                                <td class="text-end pe-4 text-success fw-bold">
                                                                    <fmt:formatNumber value="${item.totalRevenue}"
                                                                        type="currency" currencySymbol="đ" />
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.0.0"></script>

                <script>
                    // HÀM LẤY ĐÚNG MÚI GIỜ VIỆT NAM (Trả về YYYY-MM-DD vì HTML input type="date" BẮT BUỘC nhận format này)
                    function formatDateLocal(date) {
                        const year = date.getFullYear();
                        const month = String(date.getMonth() + 1).padStart(2, '0');
                        const day = String(date.getDate()).padStart(2, '0');
                        return year + '-' + month + '-' + day;
                    }

                    // LỌC THỜI GIAN VÀ CHỐNG GIẬT SCROLL
                    function setFilterRange(type) {
                        sessionStorage.setItem('scrollPosition', window.scrollY);

                        const today = new Date();
                        let start = new Date();
                        let end = new Date();
                        document.getElementById('rangeInput').value = type;

                        if (type === 'today') {
                            // Giữ nguyên
                        } else if (type === 'this_week') {
                            const day = today.getDay();
                            const diff = today.getDate() - day + (day === 0 ? -6 : 1);
                            start = new Date(today.setDate(diff));
                        } else if (type === 'this_month') {
                            start = new Date(today.getFullYear(), today.getMonth(), 1);
                        } else if (type === 'this_year') {
                            start = new Date(today.getFullYear(), 0, 1);
                        }

                        document.getElementById('startDate').value = formatDateLocal(start);
                        document.getElementById('endDate').value = formatDateLocal(end);
                        document.getElementById('filterForm').submit();
                    }

                    window.addEventListener('load', function () {
                        let scrollPos = sessionStorage.getItem('scrollPosition');
                        if (scrollPos) {
                            window.scrollTo(0, parseInt(scrollPos));
                            sessionStorage.removeItem('scrollPosition');
                        }
                    });

                    // ==========================================
                    // XỬ LÝ DỮ LIỆU TỪ JAVA SANG JAVASCRIPT AN TOÀN
                    // ==========================================

                    // 1. Nhận chuỗi dạng "[Giá trị 1, Giá trị 2]" từ Backend và bỏ đi dấu ngoặc vuông []
                    let rawLabels = "${chartLabels}".replace(/^\[|\]$/g, '');
                    let rawData = "${chartData}".replace(/^\[|\]$/g, '');

                    let parsedLabels = [];
                    let parsedData = [];

                    if (rawLabels && rawLabels.trim() !== "") {
                        // Tách chuỗi thành mảng các nhãn
                        let parts = rawLabels.split(',');
                        parsedLabels = parts.map(p => {
                            let labelStr = p.trim();
                            // KIỂM TRA & FORMAT LẠI NGÀY SANG CHUẨN VIỆT NAM (Ngày/Tháng/Năm)
                            // Nếu chuỗi có dạng YYYY-MM-DD (Ví dụ: 2026-03-01)
                            if (labelStr.match(/^\d{4}-\d{2}-\d{2}$/)) {
                                let dateParts = labelStr.split('-');
                                return dateParts[2] + '/' + dateParts[1] + '/' + dateParts[0];
                            }
                            return labelStr;
                        });
                    } else {
                        parsedLabels = ['Chưa có dữ liệu'];
                    }

                    if (rawData && rawData.trim() !== "") {
                        parsedData = rawData.split(',').map(Number);
                    } else {
                        parsedData = [0];
                    }

                    // ĐÃ SỬA: BIỂU ĐỒ DOANH THU 
                    const ctxRevenue = document.getElementById('revenueChart');
                    if (ctxRevenue) {
                        new Chart(ctxRevenue, {
                            type: 'line',
                            data: {
                                labels: parsedLabels,
                                datasets: [{
                                    label: 'Doanh thu (VNĐ)',
                                    data: parsedData,
                                    borderColor: '#0d6efd',
                                    backgroundColor: 'rgba(13, 110, 253, 0.1)',
                                    tension: 0.4,
                                    fill: true,
                                    pointBackgroundColor: '#fff',
                                    pointBorderColor: '#0d6efd',
                                    pointBorderWidth: 2,
                                    pointRadius: 4
                                }]
                            },
                            options: {
                                responsive: true, maintainAspectRatio: false,
                                plugins: { legend: { display: false }, datalabels: { display: false } },
                                scales: { y: { beginAtZero: true } }
                            }
                        });
                    }

                    // ĐÃ SỬA: BIỂU ĐỒ TRẠNG THÁI (Đưa % xuống chú thích)
                    const ctxStatus = document.getElementById('statusChart');
                    if (ctxStatus) {
                        const statusData = [${ completedOrdersCount }, ${ shippingOrdersCount }, ${ pendingOrdersCount }, ${ cancelledOrdersCount }];
                        const totalOrders = statusData.reduce((a, b) => a + b, 0);

                        // Tính toán % và ghép vào mảng nhãn (labels) để hiển thị bên dưới
                        const originalLabels = ['Hoàn thành', 'Đang giao', 'Chờ xử lý', 'Đã hủy'];
                        const labelsWithPercent = originalLabels.map((label, index) => {
                            const percent = totalOrders > 0 ? (statusData[index] * 100 / totalOrders).toFixed(1) : 0;
                            return label + " : " + percent + "%";
                        });

                        if (typeof ChartDataLabels !== 'undefined') { Chart.register(ChartDataLabels); }

                        new Chart(ctxStatus, {
                            type: 'pie',
                            data: {
                                labels: labelsWithPercent,
                                datasets: [{
                                    data: statusData,
                                    backgroundColor: ['#198754', '#0dcaf0', '#ffc107', '#dc3545'],
                                    borderWidth: 2, borderColor: '#ffffff'
                                }]
                            },
                            options: {
                                responsive: true, maintainAspectRatio: false,
                                plugins: {
                                    legend: {
                                        position: 'bottom',
                                        labels: { padding: 20, usePointStyle: true, pointStyle: 'circle' }
                                    },
                                    datalabels: {
                                        display: false // Ẩn % bên trong hình tròn
                                    }
                                }
                            }
                        });
                    }
                </script>
            </body>

            </html>