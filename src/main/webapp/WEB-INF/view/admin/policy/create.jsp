<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <title>Thêm mới Chính sách</title>
                <jsp:include page="../layout/header.jsp" />
                <style>
                    .cke_notification_warning {
                        display: none !important;
                    }
                </style>
            </head>

            <body class="bg-light">
                <div class="d-flex" id="wrapper">
                    <jsp:include page="../layout/sidebar.jsp">
                        <jsp:param name="active" value="policy" />
                    </jsp:include>

                    <div id="page-content-wrapper">
                        <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom px-4 py-3">
                            <h4 class="mb-0 text-dark fw-bold text-uppercase">Thêm Mới Chính Sách</h4>
                        </nav>

                        <div class="container-fluid px-4 py-4">
                            <form:form action="/admin/policy/create" method="POST" modelAttribute="newPolicy">
                                <div class="row justify-content-center">
                                    <div class="col-lg-10">
                                        <div class="card shadow-sm border-0 rounded-3 mb-4">
                                            <div class="card-body p-4">
                                                <h6 class="fw-bold mb-4 text-primary text-uppercase small">Nội dung
                                                    chính sách</h6>

                                                <div class="mb-3">
                                                    <label class="form-label fw-bold small">Tên Chính Sách *</label>
                                                    <form:input path="name" class="form-control"
                                                        placeholder="VD: Chính sách đổi trả, Bảo mật..."
                                                        required="true" />
                                                </div>

                                                <div class="mb-4">
                                                    <label class="form-label fw-bold small">Chi tiết nội dung *</label>
                                                    <form:textarea path="content" id="policyContent"
                                                        class="form-control" rows="15" required="true" />
                                                </div>

                                                <div class="mb-4 form-check form-switch">
                                                    <form:checkbox path="active" class="form-check-input"
                                                        id="activeStatus" checked="checked" />
                                                    <label class="form-check-label fw-bold small"
                                                        for="activeStatus">Kích hoạt (Hiển thị ngay)</label>
                                                </div>

                                                <div class="d-flex justify-content-end gap-2 mt-4 border-top pt-3">
                                                    <a href="/admin/policy" class="btn btn-outline-secondary px-4">
                                                        <i class="fas fa-times me-2"></i>Hủy
                                                    </a>
                                                    <button type="submit" class="btn btn-primary px-5 fw-bold">
                                                        <i class="fas fa-save me-2"></i>Lưu Chính Sách
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                <script src="https://cdn.ckeditor.com/4.22.1/full/ckeditor.js"></script>
                <script>
                    CKEDITOR.replace('policyContent', { height: 400 });
                </script>
            </body>

            </html>