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
                                        <div class="card-body p-0">
                                            <table class="table table-hover align-middle mb-0">
                                                <thead class="bg-light">
                                                    <tr>
                                                        <th class="ps-4">Sản phẩm</th>
                                                        <th class="text-center">Số lượng</th>
                                                        <th class="text-end pe-4">Thành tiền</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="detail" items="${orderDetails}">
                                                        <tr>
                                                            <td class="ps-4">
                                                                <div class="d-flex align-items-center">
                                                                    <img src="/images/${detail.product.images[0].imageUrl}"
                                                                        class="rounded border" width="50" height="50"
                                                                        style="object-fit: cover;">
                                                                    <div class="ms-3">
                                                                        <h6 class="mb-0 text-primary">
                                                                            ${detail.product.name}</h6>
                                                                        <small class="text-muted">Đơn giá:
                                                                            <fmt:formatNumber value="${detail.price}"
                                                                                type="currency" currencySymbol="đ" />
                                                                        </small>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td class="text-center fw-bold">x${detail.quantity}</td>
                                                            <td class="text-end pe-4 fw-bold text-danger">
                                                                <fmt:formatNumber
                                                                    value="${detail.price * detail.quantity}"
                                                                    type="currency" currencySymbol="đ" />
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                                <tfoot class="bg-light">
                                                    <tr>
                                                        <td colspan="2" class="text-end fw-bold pt-3">TỔNG CỘNG:</td>
                                                        <td class="text-end pe-4 fw-bold text-danger fs-5 pt-3">
                                                            <fmt:formatNumber value="${order.totalPrice}"
                                                                type="currency" currencySymbol="đ" />
                                                        </td>
                                                    </tr>
                                                </tfoot>
                                            </table>
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
            </body>

            </html>