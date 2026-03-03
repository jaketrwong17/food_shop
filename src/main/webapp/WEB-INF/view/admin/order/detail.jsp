<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">
            <jsp:include page="../layout/header.jsp" />

            <body>
                <div class="d-flex" id="wrapper">
                    <jsp:include page="../layout/sidebar.jsp">
                        <jsp:param name="active" value="order" />
                    </jsp:include>

                    <div id="page-content-wrapper">
                        <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom px-4 py-3">
                            <h4 class="mb-0 text-dark fw-bold">Chi tiết Đơn hàng #${order.id}</h4>
                        </nav>

                        <div class="container-fluid px-4 py-4">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="card shadow-sm border-0 rounded-3 mb-4">
                                        <div class="card-header bg-white fw-bold">Thông tin người nhận</div>
                                        <div class="card-body">
                                            <p class="mb-1"><strong>Họ tên:</strong> ${order.receiverName}</p>
                                            <p class="mb-1"><strong>SĐT:</strong> ${order.receiverPhone}</p>
                                            <p class="mb-1"><strong>Địa chỉ:</strong> ${order.receiverAddress}</p>
                                            <hr>
                                            <form action="/admin/order/update/${order.id}" method="POST">
                                                <label class="form-label fw-bold">Cập nhật trạng thái:</label>
                                                <select name="status" class="form-select mb-3">
                                                    <option value="PENDING" ${order.status=='PENDING' ? 'selected' : ''
                                                        }>Chờ xác nhận</option>
                                                    <option value="SHIPPING" ${order.status=='SHIPPING' ? 'selected'
                                                        : '' }>Đang giao hàng</option>
                                                    <option value="COMPLETED" ${order.status=='COMPLETED' ? 'selected'
                                                        : '' }>Hoàn thành</option>
                                                    <option value="CANCELLED" ${order.status=='CANCELLED' ? 'selected'
                                                        : '' }>Đã hủy</option>
                                                </select>
                                                <button type="submit" class="btn btn-primary w-100">Cập nhật</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-8">
                                    <div class="card shadow-sm border-0 rounded-3">
                                        <div class="card-header bg-white fw-bold">Danh sách sản phẩm</div>

                                        <c:set var="rawSubtotal" value="0" />
                                        <c:forEach var="item" items="${orderDetails}">
                                            <c:set var="rawSubtotal"
                                                value="${rawSubtotal + (item.price * item.quantity)}" />
                                        </c:forEach>
                                        <c:set var="totalVoucherDiscount" value="${rawSubtotal - order.totalPrice}" />
                                        <c:if test="${totalVoucherDiscount < 1}">
                                            <c:set var="totalVoucherDiscount" value="0" />
                                        </c:if>

                                        <div class="card-body p-0">
                                            <div class="table-responsive">
                                                <table class="table table-hover align-middle mb-0">
                                                    <thead class="bg-light">
                                                        <tr>
                                                            <th class="ps-4" style="width: 45%;">Sản phẩm</th>
                                                            <th class="text-center">Đơn giá</th>
                                                            <th class="text-center">Số lượng</th>
                                                            <th class="text-end pe-4">Thành tiền</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="detail" items="${orderDetails}">

                                                            <c:set var="itemLineTotal"
                                                                value="${detail.price * detail.quantity}" />
                                                            <c:set var="itemVoucherDiscount" value="0" />
                                                            <c:if
                                                                test="${totalVoucherDiscount > 0 and rawSubtotal > 0}">
                                                                <c:set var="itemVoucherDiscount"
                                                                    value="${(itemLineTotal / rawSubtotal) * totalVoucherDiscount}" />
                                                            </c:if>
                                                            <c:set var="finalItemTotal"
                                                                value="${itemLineTotal - itemVoucherDiscount}" />

                                                            <tr>
                                                                <td class="ps-4 py-3">
                                                                    <div class="d-flex align-items-center">
                                                                        <c:choose>
                                                                            <c:when
                                                                                test="${not empty detail.product.images and not empty detail.product.images[0].imageUrl}">
                                                                                <img src="/images/${detail.product.images[0].imageUrl}"
                                                                                    class="rounded border shadow-sm"
                                                                                    width="50" height="50"
                                                                                    style="object-fit: cover;">
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <div style="width: 50px; height: 50px;"
                                                                                    class="rounded border bg-light d-flex justify-content-center align-items-center small text-muted">
                                                                                    No Img</div>
                                                                            </c:otherwise>
                                                                        </c:choose>

                                                                        <div class="ms-3">
                                                                            <h6 class="mb-0 text-primary">
                                                                                ${detail.product.name}</h6>

                                                                            <c:if test="${itemVoucherDiscount > 0}">
                                                                                <small
                                                                                    class="text-success fst-italic mt-1 d-block">
                                                                                    <i class="fas fa-tag"></i> Giảm
                                                                                    thêm:
                                                                                    <fmt:formatNumber
                                                                                        value="${itemVoucherDiscount}"
                                                                                        type="currency"
                                                                                        currencySymbol="đ"
                                                                                        maxFractionDigits="2" />
                                                                                </small>
                                                                            </c:if>
                                                                        </div>
                                                                    </div>
                                                                </td>

                                                                <td class="text-center">
                                                                    <c:choose>
                                                                        <c:when
                                                                            test="${detail.product.price > detail.price}">
                                                                            <span
                                                                                class="text-muted text-decoration-line-through small d-block">
                                                                                <fmt:formatNumber
                                                                                    value="${detail.product.price}"
                                                                                    type="currency"
                                                                                    currencySymbol="đ" />
                                                                            </span>
                                                                        </c:when>
                                                                    </c:choose>
                                                                    <span class="fw-bold text-dark">
                                                                        <fmt:formatNumber value="${detail.price}"
                                                                            type="currency" currencySymbol="đ" />
                                                                    </span>
                                                                </td>

                                                                <td class="text-center fw-bold">x${detail.quantity}</td>

                                                                <td class="text-end pe-4">
                                                                    <c:choose>
                                                                        <c:when test="${itemVoucherDiscount > 0}">
                                                                            <span
                                                                                class="text-muted text-decoration-line-through small d-block">
                                                                                <fmt:formatNumber
                                                                                    value="${itemLineTotal}"
                                                                                    type="currency"
                                                                                    currencySymbol="đ" />
                                                                            </span>
                                                                            <span class="fw-bold text-danger">
                                                                                <fmt:formatNumber
                                                                                    value="${finalItemTotal}"
                                                                                    type="currency"
                                                                                    currencySymbol="đ" />
                                                                            </span>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <span class="fw-bold text-danger">
                                                                                <fmt:formatNumber
                                                                                    value="${itemLineTotal}"
                                                                                    type="currency"
                                                                                    currencySymbol="đ" />
                                                                            </span>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>

                                                    <tfoot class="bg-light border-top">

                                                        <tr>
                                                            <td colspan="3" class="text-end fw-bold pt-2 border-top">
                                                                TỔNG CỘNG:</td>
                                                            <td
                                                                class="text-end pe-4 fw-bold text-danger fs-5 pt-2 border-top">
                                                                <fmt:formatNumber value="${order.totalPrice}"
                                                                    type="currency" currencySymbol="đ"
                                                                    maxFractionDigits="2" />
                                                            </td>
                                                        </tr>
                                                    </tfoot>
                                                </table>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="mt-3">
                                        <a href="/admin/order" class="btn btn-secondary">Quay lại danh sách</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
            </body>

            </html>