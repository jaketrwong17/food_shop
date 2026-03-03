<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <title>Quản lý Chính sách</title>
            <jsp:include page="../layout/header.jsp" />
        </head>

        <body class="bg-light">
            <div class="d-flex" id="wrapper">
                <jsp:include page="../layout/sidebar.jsp">
                    <jsp:param name="active" value="policy" />
                </jsp:include>

                <div id="page-content-wrapper">
                    <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom px-4 py-3">
                        <h4 class="mb-0 text-dark fw-bold">Quản lý Chính sách</h4>
                    </nav>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show m-3">
                            ${errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success alert-dismissible fade show m-3">
                            ${successMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <div class="container-fluid px-4 py-4">
                        <div class="card shadow-sm border-0 rounded-3">
                            <div
                                class="card-header bg-white py-3 d-flex justify-content-between align-items-center border-bottom">
                                <div class="d-flex gap-2">
                                </div>
                                <a href="/admin/policy/create" class="btn btn-success fw-bold text-nowrap">
                                    <i class="fas fa-plus me-1"></i> THÊM MỚI
                                </a>
                            </div>

                            <div class="card-body p-0">
                                <table class="table table-hover align-middle mb-0">
                                    <thead class="bg-light text-secondary">
                                        <tr>
                                            <th class="ps-4" width="10%">ID</th>
                                            <th width="45%">Tên chính sách</th>
                                            <th width="20%">Trạng thái</th>
                                            <th width="25%" class="text-center">Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="p" items="${policies}">
                                            <tr>
                                                <td class="ps-4 fw-bold">#${p.id}</td>
                                                <td class="fw-bold text-primary">${p.name}</td>

                                                <td>
                                                    <span class="badge ${p.active ? 'bg-success' : 'bg-secondary'}">
                                                        ${p.active ? 'Đang hiển thị' : 'Đang ẩn'}
                                                    </span>
                                                </td>

                                                <td class="text-center">
                                                    <div class="d-flex align-items-center justify-content-center gap-3">



                                                        <div class="form-check form-switch m-0"
                                                            style="padding-left: 2.5rem;"
                                                            title="${p.active ? 'Tắt hiển thị' : 'Bật hiển thị'}">
                                                            <input class="form-check-input m-0 shadow-none"
                                                                type="checkbox" role="switch"
                                                                style="cursor: pointer; width: 2.5em; height: 1.25em;"
                                                                id="switch_${p.id}" ${p.active ? 'checked' : '' }
                                                                onchange="window.location.href='/admin/policy/toggle-status/${p.id}'">
                                                        </div>
                                                        <a href="/admin/policy/update/${p.id}"
                                                            class="btn btn-sm btn-warning text-white" title="Sửa">
                                                            <i class="fas fa-edit"></i>
                                                        </a>
                                                        <a href="/admin/policy/delete/${p.id}"
                                                            class="btn btn-sm btn-outline-danger"
                                                            onclick="return confirm('Bạn có chắc chắn muốn XÓA chính sách này?');"
                                                            title="Xóa">
                                                            <i class="fas fa-trash"></i>
                                                        </a>

                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty policies}">
                                            <tr>
                                                <td colspan="4" class="text-center py-4 text-muted">Chưa có chính sách
                                                    nào.</td>
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