<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="vi">
        <jsp:include page="../layout/header.jsp" />

        <body>
            <div class="d-flex" id="wrapper">
                <jsp:include page="../layout/sidebar.jsp">
                    <jsp:param name="active" value="banner" />
                </jsp:include>

                <div id="page-content-wrapper">
                    <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom px-4 py-3">
                        <div class="d-flex justify-content-between align-items-center w-100">
                            <h4 class="mb-0 text-dark fw-bold">Quản lý Banner</h4>
                        </div>
                    </nav>

                    <div class="container-fluid px-4 py-4">
                        <div class="card shadow-sm border-0 rounded-3">
                            <div class="card-header bg-white py-3 text-end">
                                <a href="/admin/banner/create" class="btn btn-success fw-bold">
                                    <i class="fas fa-plus me-1"></i> THÊM MỚI
                                </a>
                            </div>
                            <div class="card-body p-0">
                                <c:if test="${empty banners}">
                                    <div class="text-center py-5 text-muted">
                                        <i class="fas fa-image fa-3x mb-3 opacity-50"></i>
                                        <h5>Chưa có Banner nào!</h5>
                                        <p>Hãy thêm banner để hiển thị trên trang chủ nhé.</p>
                                    </div>
                                </c:if>
                                <c:if test="${not empty banners}">
                                    <div class="table-responsive">
                                        <table class="table table-hover align-middle mb-0">
                                            <thead class="table-light">
                                                <tr>
                                                    <th class="ps-4" style="width: 80px;">ID</th>
                                                    <th style="width: 250px;">Hình ảnh</th>
                                                    <th>Tên Banner</th>
                                                    <th>Đường dẫn (Link)</th>
                                                    <th>Trạng thái</th>
                                                    <th style="width: 150px;">Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="b" items="${banners}">
                                                    <tr>
                                                        <td class="ps-4 fw-bold">#${b.id}</td>
                                                        <td>
                                                            <div
                                                                style="width: 200px; height: 80px; overflow: hidden; border-radius: 6px; border: 1px solid #ddd;">
                                                                <img src="/images/${b.imageUrl}"
                                                                    style="width: 100%; height: 100%; object-fit: cover;">
                                                            </div>
                                                        </td>
                                                        <td class="fw-bold text-primary">${b.name}</td>
                                                        <td class="text-muted small">${not empty b.link ? b.link :
                                                            '<i>Không có link</i>'}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${b.active}">
                                                                    <span class="badge bg-success px-2 py-1">Đang hiển
                                                                        thị</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge bg-secondary px-2 py-1">Đang
                                                                        ẩn</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <a href="/admin/banner/update/${b.id}"
                                                                class="btn btn-sm btn-warning text-white me-1">
                                                                <i class="fas fa-edit"></i>
                                                            </a>
                                                            <a href="/admin/banner/delete/${b.id}"
                                                                class="btn btn-sm btn-danger"
                                                                onclick="return confirm('Bạn có chắc chắn muốn xóa Banner này?')">
                                                                <i class="fas fa-trash-alt"></i>
                                                            </a>
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
        </body>

        </html>