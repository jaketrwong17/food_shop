<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">
            <jsp:include page="../layout/header.jsp" />

            <body>
                <div class="d-flex" id="wrapper">
                    <jsp:include page="../layout/sidebar.jsp">
                        <jsp:param name="active" value="promotion" />
                    </jsp:include>

                    <div id="page-content-wrapper">
                        <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom px-4 py-3">
                            <h4 class="mb-0 text-dark fw-bold ">Quản lý khuyến mại</h4>
                        </nav>

                        <div class="container-fluid px-4 py-4">
                            <div class="card shadow-sm border-0 rounded-3">
                                <div
                                    class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                                    <h6 class="m-0 fw-bold text-primary">Tất cả chương trình</h6>
                                    <a href="/admin/promotion/create" class="btn btn-success fw-bold px-3">
                                        <i class="fas fa-plus me-1"></i> THÊM MỚI
                                    </a>
                                </div>

                                <div class="card-body p-0">
                                    <table class="table table-hover align-middle mb-0">
                                        <thead class="bg-light text-secondary">
                                            <tr>
                                                <th class="ps-4">ID</th>
                                                <th>Tên chương trình</th>
                                                <th>Mức giảm</th>
                                                <th>Thời gian áp dụng</th>
                                                <th>Sản phẩm</th>
                                                <th>Trạng thái</th>
                                                <th class="text-center">Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="p" items="${promotions}">
                                                <tr>
                                                    <td class="ps-4 fw-bold">#${p.id}</td>
                                                    <td class="fw-bold text-primary">${p.name}</td>
                                                    <td><span class="badge bg-danger">-${p.discountRate}%</span></td>
                                                    <td>
                                                        <small class="d-flex flex-column text-muted">
                                                            <span><i class="fas fa-play text-success me-1"></i>
                                                                <fmt:formatDate value="${p.startDate}"
                                                                    pattern="dd/MM/yyyy HH:mm" />
                                                            </span>
                                                            <span><i class="fas fa-stop text-danger me-1"></i>
                                                                <fmt:formatDate value="${p.endDate}"
                                                                    pattern="dd/MM/yyyy HH:mm" />
                                                            </span>
                                                        </small>
                                                    </td>
                                                    <td><span class="badge bg-info text-dark">${p.products.size()}
                                                            SP</span></td>

                                                    <td>
                                                        <c:choose>
                                                            <%-- 1. Nếu Active=false -> Tạm dừng (Ưu tiên cao nhất) --%>
                                                                <c:when test="${!p.active}">
                                                                    <span class="badge bg-secondary">Tạm dừng</span>
                                                                </c:when>

                                                                <%-- 2. Nếu đã qua ngày kết thúc -> Kết thúc --%>
                                                                    <c:when test="${p.expired}">
                                                                        <span class="badge bg-danger">Đã kết thúc</span>
                                                                    </c:when>

                                                                    <%-- 3. Nếu chưa tới ngày bắt đầu -> Sắp diễn ra
                                                                        --%>
                                                                        <c:when test="${p.upcoming}">
                                                                            <span class="badge bg-warning text-dark">Sắp
                                                                                diễn ra</span>
                                                                        </c:when>

                                                                        <%-- 4. Còn lại -> Đang chạy --%>
                                                                            <c:otherwise>
                                                                                <span class="badge bg-success">
                                                                                    <i
                                                                                        class="fas fa-spinner fa-spin me-1"></i>
                                                                                    Đang chạy
                                                                                </span>
                                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>

                                                    <td class="text-center">
                                                        <a href="/admin/promotion/toggle-status/${p.id}"
                                                            class="btn btn-sm ${p.active ? 'btn-outline-secondary' : 'btn-outline-success'} me-1"
                                                            title="${p.active ? 'Tạm dừng' : 'Kích hoạt lại'}">
                                                            <i class="fas ${p.active ? 'fa-pause' : 'fa-play'}"></i>
                                                        </a>

                                                        <a href="/admin/promotion/update/${p.id}"
                                                            class="btn btn-sm btn-warning text-white me-1">
                                                            <i class="fas fa-edit"></i>
                                                        </a>
                                                        <a href="/admin/promotion/delete/${p.id}"
                                                            class="btn btn-sm btn-outline-danger"
                                                            onclick="return confirm('Bạn có chắc muốn xóa chương trình này?')">
                                                            <i class="fas fa-trash"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty promotions}">
                                                <tr>
                                                    <td colspan="7" class="text-center py-4 text-muted">Chưa có chương
                                                        trình khuyến mại nào.</td>
                                                </tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>