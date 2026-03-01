<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <title>Thanh toán - 16Home</title>
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

                    /* Bỏ hiệu ứng xanh dương mặc định của bootstrap form-check */
                    .form-check-input:checked {
                        background-color: #3c8a2e;
                        border-color: #3c8a2e;
                    }

                    .form-check-input:focus {
                        box-shadow: 0 0 0 0.25rem rgba(60, 138, 46, 0.25);
                        border-color: #3c8a2e;
                    }
                </style>
            </head>

            <body class="bg-light">
                <jsp:include page="../layout/header.jsp" />

                <div class="container my-5">
                    <nav aria-label="breadcrumb" class="mb-4">
                        <ol class="breadcrumb mb-0">
                            <li class="breadcrumb-item">
                                <a href="/" class="text-decoration-none text-muted">Trang chủ / Giỏ hàng</a>
                            </li>
                            <li class="breadcrumb-item active text-theme" aria-current="page">
                                Thanh toán
                            </li>
                        </ol>
                    </nav>
                    <c:if test="${not empty param.error}">
                        <div class="alert alert-danger shadow-sm border-start border-4 border-danger">
                            <i class="fas fa-exclamation-triangle me-2"></i> ${param.error}
                        </div>
                    </c:if>

                    <form action="/place-order" method="POST" id="formOrder">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                        <c:forEach var="id" items="${selectedIds}">
                            <input type="hidden" name="cartItemIds" value="${id}">
                        </c:forEach>

                        <input type="hidden" name="voucherCode" value="${voucherCode}">

                        <div class="row">
                            <div class="col-md-7">
                                <div class="card shadow-sm border-0 mb-4">
                                    <div class="card-header bg-white py-3">
                                        <h5 class="mb-0 fw-bold">
                                            <i class="fas fa-map-marker-alt text-danger me-2"></i>Thông tin nhận hàng
                                        </h5>
                                    </div>
                                    <div class="card-body p-4">
                                        <div class="mb-3">
                                            <label class="form-label text-muted small">Họ và tên người nhận</label>
                                            <input type="text" name="receiverName" class="form-control"
                                                value="${user.fullName}" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label text-muted small">Số điện thoại</label>
                                            <input type="tel" name="receiverPhone" class="form-control"
                                                value="${user.phone}" pattern="0[0-9]{9}"
                                                title="Số điện thoại phải bắt đầu bằng số 0 và đủ 10 chữ số" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label text-muted small">Địa chỉ giao hàng</label>
                                            <textarea name="receiverAddress" class="form-control" rows="3"
                                                required>${user.address}</textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-5">
                                <div class="card shadow-sm border-0">
                                    <div class="card-header bg-white py-3">
                                        <h5 class="mb-0 fw-bold">Đơn hàng của bạn</h5>
                                    </div>
                                    <div class="card-body p-0">
                                        <ul class="list-group list-group-flush">
                                            <c:forEach var="item" items="${displayItems}">
                                                <li
                                                    class="list-group-item d-flex justify-content-between align-items-center px-4 py-3">
                                                    <div class="d-flex align-items-center">
                                                        <span
                                                            class="badge bg-secondary rounded-pill me-3">${item.quantity}</span>
                                                        <div>
                                                            <h6 class="my-0 small fw-bold">${item.product.name}</h6>

                                                            <c:if
                                                                test="${not empty discountMap and discountMap[item.id] > 0}">
                                                                <small class="text-theme fst-italic">
                                                                    <i class="fas fa-tag"></i> Giảm thêm:
                                                                    <fmt:formatNumber value="${discountMap[item.id]}"
                                                                        type="currency" currencySymbol="đ"
                                                                        maxFractionDigits="2" />
                                                                </small>
                                                            </c:if>
                                                        </div>
                                                    </div>

                                                    <div class="text-end">
                                                        <c:set var="oldItemTotal"
                                                            value="${item.product.price * item.quantity}" />
                                                        <c:set var="newItemTotal"
                                                            value="${item.product.discountedPrice * item.quantity}" />

                                                        <c:choose>
                                                            <c:when test="${item.product.onSale}">
                                                                <div
                                                                    class="text-muted small text-decoration-line-through">
                                                                    <fmt:formatNumber value="${oldItemTotal}"
                                                                        type="currency" currencySymbol="đ"
                                                                        maxFractionDigits="2" />
                                                                </div>
                                                                <div class="fw-bold">
                                                                    <fmt:formatNumber value="${newItemTotal}"
                                                                        type="currency" currencySymbol="đ"
                                                                        maxFractionDigits="2" />
                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="fw-bold">
                                                                    <fmt:formatNumber value="${oldItemTotal}"
                                                                        type="currency" currencySymbol="đ"
                                                                        maxFractionDigits="2" />
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </div>

                                    <c:set var="realSubtotal" value="0" />
                                    <c:forEach var="item" items="${displayItems}">
                                        <c:set var="realSubtotal"
                                            value="${realSubtotal + (item.product.discountedPrice * item.quantity)}" />
                                    </c:forEach>

                                    <c:set var="realTotal"
                                        value="${realSubtotal - (not empty discountAmount ? discountAmount : 0)}" />
                                    <c:if test="${realTotal < 0}">
                                        <c:set var="realTotal" value="0" />
                                    </c:if>

                                    <div class="p-4 bg-light border-top">
                                        <div class="input-group mb-3">
                                            <input type="text" class="form-control" id="voucherInput"
                                                value="${voucherCode}" placeholder="Nhập mã giảm giá">
                                            <button class="btn btn-theme fw-bold" type="button"
                                                onclick="applyVoucher()">Áp dụng</button>
                                        </div>

                                        <div class="d-flex justify-content-between mb-2">
                                            <span class="text-muted">Tạm tính:</span>
                                            <span>
                                                <fmt:formatNumber value="${realSubtotal}" type="currency"
                                                    currencySymbol="đ" maxFractionDigits="2" />
                                            </span>
                                        </div>

                                        <c:if test="${discountAmount > 0}">
                                            <div class="d-flex justify-content-between mb-2 text-theme">
                                                <span>Giảm giá (Voucher):</span>
                                                <span>-
                                                    <fmt:formatNumber value="${discountAmount}" type="currency"
                                                        currencySymbol="đ" maxFractionDigits="2" />
                                                </span>
                                            </div>
                                        </c:if>

                                        <div class="d-flex justify-content-between fw-bold fs-5 border-top pt-2">
                                            <span>Tổng cộng:</span>
                                            <span class="text-danger">
                                                <fmt:formatNumber value="${realTotal}" type="currency"
                                                    currencySymbol="đ" maxFractionDigits="2" />
                                            </span>
                                        </div>
                                    </div>

                                    <div class="p-4 bg-white border-top">
                                        <h6 class="fw-bold mb-3">Phương thức thanh toán</h6>
                                        <div class="form-check mb-2">
                                            <input class="form-check-input" type="radio" name="paymentMethod" id="cod"
                                                value="COD" checked>
                                            <label class="form-check-label" for="cod">
                                                <i class="fas fa-money-bill-wave text-theme me-2"></i>Thanh toán khi
                                                nhận hàng (COD)
                                            </label>
                                        </div>
                                        <div class="form-check mb-4">
                                            <input class="form-check-input" type="radio" name="paymentMethod"
                                                id="online" value="VNPAY">
                                            <label class="form-check-label" for="online">
                                                <i class="fas fa-credit-card text-primary me-2"></i>Thanh toán Online
                                                qua VNPAY
                                            </label>
                                        </div>

                                        <button type="submit"
                                            class="btn btn-theme w-100 rounded-pill py-2 fw-bold text-uppercase shadow-sm">
                                            ĐẶT HÀNG NGAY
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>

                <jsp:include page="../layout/footer.jsp" />

                <script>
                    function applyVoucher() {
                        const code = document.getElementById("voucherInput").value;
                        const currentUrl = new URL(window.location.href);
                        if (code.trim() !== "") {
                            currentUrl.searchParams.set('voucherCode', code);
                        } else {
                            currentUrl.searchParams.delete('voucherCode');
                        }
                        window.location.href = currentUrl.toString();
                    }
                </script>
            </body>

            </html>