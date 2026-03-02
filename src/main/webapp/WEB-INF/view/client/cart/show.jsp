<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <title>Giỏ hàng - GreenFood</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
                <style>
                    /* MÀU CHỦ ĐẠO */
                    .text-theme {
                        color: #3c8a2e !important;
                    }

                    .bg-theme {
                        background-color: #3c8a2e !important;
                        color: #fff !important;
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

                    .border-theme {
                        border-color: #3c8a2e !important;
                    }

                    /* Fix focus ô checkbox */
                    .form-check-input:checked {
                        background-color: #3c8a2e;
                        border-color: #3c8a2e;
                    }

                    .form-check-input:focus {
                        box-shadow: 0 0 0 0.25rem rgba(60, 138, 46, 0.25);
                        border-color: #3c8a2e;
                    }

                    .cart-item {
                        border-radius: 12px;
                        background: #fff;
                        margin-bottom: 15px;
                        padding: 20px;
                        border: none;
                    }

                    .product-img {
                        width: 100px;
                        height: 100px;
                        object-fit: contain;
                    }

                    .summary-box {
                        border-radius: 12px;
                        background: #fafafa;
                        padding: 30px;
                        position: sticky;
                        top: 20px;
                    }

                    .btn-checkout {
                        background-color: #3c8a2e;
                        /* Đã đổi màu */
                        color: white;
                        border-radius: 50px;
                        font-weight: 600;
                        width: 100%;
                        border: none;
                        padding: 12px;
                        transition: all 0.3s;
                    }

                    .btn-checkout:hover:not(:disabled) {
                        background-color: #2d6a22;
                        /* Hiệu ứng hover cho nút checkout */
                    }

                    .btn-checkout:disabled {
                        background-color: #ccc;
                    }

                    .item-checkbox {
                        width: 1.2em;
                        height: 1.2em;
                        cursor: pointer;
                    }

                    /* Fix màu các nút cộng trừ số lượng (Chỉ khoanh vùng trong giỏ hàng) */
                    .input-group .btn-link:focus,
                    .input-group .btn-link:active {
                        color: #3c8a2e !important;
                        box-shadow: none !important;
                    }

                    .input-group .btn-link:hover {
                        color: #3c8a2e !important;
                    }
                </style>
            </head>

            <body class="bg-light">
                <jsp:include page="../layout/header.jsp" />

                <div class="container mt-5 pb-5">
                    <nav aria-label="breadcrumb" class="mb-4">
                        <ol class="breadcrumb mb-0">
                            <li class="breadcrumb-item"><a href="/" class="text-decoration-none text-muted">Trang
                                    chủ</a></li>
                            <li class="breadcrumb-item active text-theme" aria-current="page">Giỏ hàng</li>
                        </ol>
                    </nav>
                    <h3 class="fw-bold mb-5 border-start border-theme border-4 ps-3">GIỎ HÀNG CỦA BẠN</h3>

                    <div class="row g-4">
                        <div class="col-lg-8">
                            <c:if test="${empty cartItems}">
                                <div class="text-center bg-white p-5 rounded shadow-sm border">
                                    <i class="fas fa-shopping-basket fa-4x text-light mb-4"></i>
                                    <p class="fs-5 text-muted">Giỏ hàng của bạn đang trống.</p>
                                    <a href="/" class="btn btn-theme rounded-pill px-5 mt-3 text-decoration-none">Tiếp
                                        tục mua sắm</a>
                                </div>
                            </c:if>

                            <c:if test="${not empty cartItems}">
                                <div
                                    class="d-flex justify-content-between align-items-center mb-3 bg-white p-3 rounded shadow-sm">
                                    <div class="form-check d-flex align-items-center">
                                        <input class="form-check-input item-checkbox me-2" type="checkbox"
                                            id="selectAll" onclick="toggleSelectAll(this)">
                                        <label class="form-check-label fw-bold" for="selectAll">Chọn tất cả
                                            (${cartItems.size()})</label>
                                    </div>
                                    <button class="btn btn-outline-danger btn-sm border-0" onclick="deleteSelected()">
                                        <i class="far fa-trash-alt me-1"></i> Xóa mục đã chọn
                                    </button>
                                </div>

                                <c:forEach var="item" items="${cartItems}">
                                    <div class="cart-item shadow-sm">
                                        <div class="row align-items-center">
                                            <div class="col-md-1 text-center">
                                                <input class="form-check-input item-checkbox" type="checkbox"
                                                    name="selectedItems" value="${item.id}"
                                                    data-price="${item.product.discountedPrice * item.quantity}"
                                                    onclick="updateTotalSummary()">
                                            </div>

                                            <div class="col-md-2 text-center">
                                                <c:if test="${not empty item.product.images}">
                                                    <img src="/images/${item.product.images[0].imageUrl}"
                                                        class="product-img">
                                                </c:if>
                                            </div>

                                            <div class="col-md-4">
                                                <h6 class="fw-bold mb-1">${item.product.name}</h6>

                                                <div class="mt-2">
                                                    <c:choose>
                                                        <c:when test="${item.product.onSale}">
                                                            <span class="text-danger fw-bold">
                                                                <%-- SỬA: maxFractionDigits="2" để giữ số lẻ --%>
                                                                    <fmt:formatNumber
                                                                        value="${item.product.discountedPrice}"
                                                                        type="currency" currencySymbol="đ"
                                                                        maxFractionDigits="2" />
                                                            </span>
                                                            <span
                                                                class="text-muted text-decoration-line-through small ms-2">
                                                                <fmt:formatNumber value="${item.product.price}"
                                                                    type="currency" currencySymbol="đ"
                                                                    maxFractionDigits="2" />
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-danger fw-bold">
                                                                <fmt:formatNumber value="${item.product.price}"
                                                                    type="currency" currencySymbol="đ"
                                                                    maxFractionDigits="2" />
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="small text-muted mt-1">Kho: <span
                                                        class="fw-bold">${item.product.quantity}</span></div>
                                            </div>

                                            <div class="col-md-4">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <form action="/update-cart-quantity" method="POST"
                                                        class="d-flex mb-0">
                                                        <input type="hidden" name="${_csrf.parameterName}"
                                                            value="${_csrf.token}" />
                                                        <input type="hidden" name="cartItemId" value="${item.id}">

                                                        <div class="input-group border rounded-pill overflow-hidden bg-white"
                                                            style="width: 110px;">
                                                            <button
                                                                class="btn btn-link text-dark text-decoration-none fw-bold"
                                                                type="submit" name="action" value="minus">-</button>
                                                            <input type="text" name="quantity"
                                                                class="form-control border-0 text-center fw-bold bg-transparent"
                                                                value="${item.quantity}" readonly>
                                                            <button
                                                                class="btn btn-link text-dark text-decoration-none fw-bold"
                                                                type="submit" name="action" value="plus">+</button>
                                                        </div>
                                                    </form>

                                                    <span class="text-danger fw-bold fs-5">
                                                        <%-- SỬA: maxFractionDigits="2" --%>
                                                            <fmt:formatNumber
                                                                value="${item.product.discountedPrice * item.quantity}"
                                                                type="currency" currencySymbol="đ"
                                                                maxFractionDigits="2" />
                                                    </span>
                                                </div>
                                            </div>

                                            <div class="col-md-1 text-end">
                                                <a href="/delete-cart-item/${item.id}"
                                                    class="text-muted text-decoration-none">
                                                    <i class="far fa-trash-alt fs-5"></i>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:if>
                        </div>

                        <div class="col-lg-4">
                            <div class="summary-box shadow-sm">
                                <h5 class="fw-bold mb-4">Tóm tắt đơn hàng</h5>
                                <div class="d-flex justify-content-between mb-3">
                                    <span class="text-muted">Tổng tiền hàng:</span>
                                    <span class="fw-bold" id="totalDisplay">0 đ</span>
                                </div>
                                <div class="border-top pt-3 mb-4">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="fw-bold fs-5">Tổng thanh toán:</span>
                                        <span class="text-danger fw-bold fs-4" id="totalFinal">0 đ</span>
                                    </div>
                                    <small class="text-muted d-block text-end mt-1">(Đã bao gồm VAT)</small>
                                </div>
                                <button id="btnCheckout" class="btn btn-checkout shadow-sm" disabled
                                    onclick="handleCheckout()">
                                    Tiến hành thanh toán
                                </button>
                                <a href="/" class="btn btn-link w-100 text-decoration-none text-muted small mt-2"
                                    onmouseover="this.style.color='#3c8a2e'" onmouseout="this.style.color='#6c757d'">
                                    <i class="fas fa-arrow-left me-1"></i> Tiếp tục mua sắm
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <jsp:include page="../layout/footer.jsp" />

                <script>
                    // SỬA: Cấu hình formatter để KHÔNG LÀM TRÒN và hiển thị tối đa 2 số thập phân
                    const formatCurrency = (amount) => {
                        return new Intl.NumberFormat('vi-VN', {
                            style: 'currency',
                            currency: 'VND',
                            minimumFractionDigits: 0, // Nếu là số chẵn thì không hiện .00
                            maximumFractionDigits: 2  // Tối đa 2 số lẻ
                        }).format(amount);
                    };

                    function updateTotalSummary() {
                        let total = 0;
                        const selectedCheckboxes = document.querySelectorAll('input[name="selectedItems"]:checked');
                        const btnCheckout = document.getElementById('btnCheckout');

                        selectedCheckboxes.forEach(cb => {
                            total += parseFloat(cb.getAttribute('data-price'));
                        });

                        // Hiển thị giá không làm tròn
                        document.getElementById('totalDisplay').innerText = formatCurrency(total);
                        document.getElementById('totalFinal').innerText = formatCurrency(total);
                        btnCheckout.disabled = selectedCheckboxes.length === 0;
                    }

                    function toggleSelectAll(source) {
                        const checkboxes = document.querySelectorAll('input[name="selectedItems"]');
                        checkboxes.forEach(cb => cb.checked = source.checked);
                        updateTotalSummary();
                    }

                    function deleteSelected() {
                        const selectedIds = Array.from(document.querySelectorAll('input[name="selectedItems"]:checked')).map(cb => cb.value);
                        if (selectedIds.length === 0) {
                            alert("Vui lòng chọn ít nhất một sản phẩm để xóa!");
                            return;
                        }
                        window.location.href = '/delete-multiple-cart-items?ids=' + selectedIds.join(',');
                    }

                    function handleCheckout() {
                        const selectedIds = Array.from(document.querySelectorAll('input[name="selectedItems"]:checked')).map(cb => cb.value);
                        if (selectedIds.length > 0) {
                            window.location.href = '/checkout?selectedIds=' + selectedIds.join(',');
                        }
                    }
                </script>
            </body>

            </html>