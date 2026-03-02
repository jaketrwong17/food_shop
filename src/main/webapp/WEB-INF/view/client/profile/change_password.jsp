<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <title>Đổi mật khẩu | GreenFood</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
            <style>
                /* THÊM CLASS MÀU THEME */
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

                body {
                    background-color: #f5f5fa;
                    min-height: 100vh;
                    display: flex;
                    flex-direction: column;
                }

                .main-wrapper {
                    flex: 1;
                }

                .content-box {
                    background: #fff;
                    border-radius: 8px;
                    box-shadow: 0 .125rem .25rem rgba(0, 0, 0, .075);
                    padding: 1.5rem;
                    min-height: 100%;
                }

                /* Class cho label giống hệt trang Profile */
                .form-label-custom {
                    color: #6c757d;
                    font-weight: 500;
                }

                .form-control:focus {
                    box-shadow: 0 0 0 0.25rem rgba(60, 138, 46, 0.25);
                    border-color: #3c8a2e;
                }
            </style>
        </head>

        <body class="bg-light">

            <jsp:include page="../layout/header.jsp" />

            <div class="main-wrapper">
                <div class="container mt-4 mb-5">
                    <nav aria-label="breadcrumb" class="mb-4">
                        <ol class="breadcrumb mb-0">
                            <li class="breadcrumb-item"><a href="/" class="text-decoration-none text-muted">Trang
                                    chủ</a></li>
                            <li class="breadcrumb-item active text-theme">Đổi mật khẩu</li>
                        </ol>
                    </nav>

                    <div class="row g-4">
                        <div class="col-lg-3">
                            <jsp:include page="sidebar.jsp">
                                <jsp:param name="activePage" value="password" />
                            </jsp:include>
                        </div>

                        <div class="col-lg-9">
                            <div class="content-box">
                                <h5 class="fw-bold text-uppercase mb-4 pb-3 border-bottom text-theme">
                                    <i class="fas fa-lock me-2"></i>Đổi mật khẩu
                                </h5>

                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
                                        <i class="fas fa-exclamation-circle me-2"></i> ${error}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"
                                            aria-label="Close"></button>
                                    </div>
                                </c:if>
                                <c:if test="${not empty message}">
                                    <div class="alert alert-success alert-dismissible fade show mb-4" role="alert">
                                        <i class="fas fa-check-circle me-2"></i> ${message}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"
                                            aria-label="Close"></button>
                                    </div>
                                </c:if>

                                <form action="/change-password" method="post">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                    <div class="row mb-4 align-items-center">
                                        <label class="col-md-3 text-md-end form-label-custom">Mật khẩu hiện tại</label>
                                        <div class="col-md-8">
                                            <input type="password" name="currentPassword" class="form-control" required
                                                placeholder="Nhập mật khẩu đang sử dụng">
                                        </div>
                                    </div>

                                    <div class="row mb-4 align-items-center">
                                        <label class="col-md-3 text-md-end form-label-custom">Mật khẩu mới</label>
                                        <div class="col-md-8">
                                            <input type="password" name="newPassword" class="form-control" required
                                                placeholder="Nhập mật khẩu mới">
                                        </div>
                                    </div>

                                    <div class="row mb-4 align-items-center">
                                        <label class="col-md-3 text-md-end form-label-custom">Xác nhận mật khẩu</label>
                                        <div class="col-md-8">
                                            <input type="password" name="confirmPassword" class="form-control" required
                                                placeholder="Nhập lại mật khẩu mới">
                                        </div>
                                    </div>

                                    <div class="row mt-5">
                                        <div class="col-md-8 offset-md-3">
                                            <button type="submit" class="btn btn-theme px-5 rounded-pill fw-bold">
                                                Lưu thay đổi
                                            </button>
                                        </div>
                                    </div>

                                </form>

                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <jsp:include page="../layout/footer.jsp" />

        </body>

        </html>