<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="vi">
        <jsp:include page="../layout/header.jsp" />

        <body>
            <div class="d-flex" id="wrapper">
                <jsp:include page="../layout/sidebar.jsp">
                    <jsp:param name="active" value="category" />
                </jsp:include>

                <div id="page-content-wrapper">
                    <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom px-4 py-3">
                        <div class="d-flex justify-content-between align-items-center w-100 flex-wrap gap-3">

                            <h4 class="mb-0 text-dark fw-bold">Quản lý Danh mục</h4>


                        </div>
                    </nav>


                    <div class="container-fluid px-4 py-4">
                        <div class="card shadow-sm border-0 rounded-3">
                            <div class="card-header bg-white py-3">
                                <div class="row align-items-center">
                                    <div class="col-md-9">
                                        <form action="/admin/category" method="GET"
                                            class="d-flex gap-2 align-items-center">
                                            <input type="text" name="keyword" class="form-control" placeholder=""
                                                value="${keyword}" style="max-width: 400px;">
                                            <button class="btn btn-outline-primary ms-2"><i class="fas fa-search"></i>
                                            </button>
                                        </form>
                                    </div>
                                    <div class="col-md-3 text-end">
                                        <a href="/admin/category/create" class="btn btn-success fw-bold">
                                            <i class="fas fa-plus me-1"></i> THÊM DANH MỤC
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                <c:if test="${empty categories}">
                                    <div class="alert alert-warning text-center">
                                        Không tìm thấy danh mục nào phù hợp với từ khóa "<strong>${keyword}</strong>".
                                        <a href="/admin/category" class="alert-link">Xóa bộ lọc</a>
                                    </div>
                                </c:if>
                                <c:if test="${not empty categories}">
                                    <div class="table-responsive">
                                        <table class="table table-hover align-middle">
                                            <thead class="table-light">
                                                <tr>
                                                    <th style="width: 80px;">ID</th>
                                                    <th style="width: 120px;">Biểu tượng</th>
                                                    <th>Tên danh mục</th>
                                                    <th>Mô tả</th>
                                                    <th style="width: 180px;">Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="cat" items="${categories}">
                                                    <tr>
                                                        <td class="fw-bold">#${cat.id}</td>
                                                        <td>
                                                            <c:if test="${not empty cat.image}">
                                                                <div style="width: 60px; height: 60px; cursor: pointer;"
                                                                    onclick="viewImage('/images/${cat.image}')">
                                                                    <img src="/images/${cat.image}"
                                                                        class="img-thumbnail w-100 h-100 object-fit-cover">
                                                                </div>
                                                            </c:if>
                                                            <c:if test="${empty cat.image}">
                                                                <span class="badge bg-light text-secondary border">Không
                                                                    có ảnh</span>
                                                            </c:if>
                                                        </td>
                                                        <td class="fw-bold text-primary">${cat.name}</td>
                                                        <td class="text-muted">${cat.description}</td>
                                                        <td>
                                                            <a href="/admin/category/update/${cat.id}"
                                                                class="btn btn-sm btn-warning text-white me-2">
                                                                <i class="fas fa-edit"></i>
                                                            </a>
                                                            <a href="/admin/category/delete/${cat.id}"
                                                                class="btn btn-sm btn-danger"
                                                                onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục [${cat.name}]?')">
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

            <div class="modal fade" id="previewModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content bg-transparent border-0 text-center">
                        <div class="modal-body p-0 position-relative">
                            <button type="button" class="btn-close btn-close-white position-absolute top-0 end-0 m-2"
                                data-bs-dismiss="modal" aria-label="Close"></button>
                            <img id="modalImg" src="" class="img-fluid rounded shadow-lg bg-white"
                                style="max-height: 80vh; max-width: 100%;">
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                function viewImage(src) {
                    document.getElementById('modalImg').src = src;
                    new bootstrap.Modal(document.getElementById('previewModal')).show();
                }
            </script>
        </body>

        </html>