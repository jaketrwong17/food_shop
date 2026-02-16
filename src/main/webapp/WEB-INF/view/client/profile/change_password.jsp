<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <title>Đổi mật khẩu | 16Home</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        </head>

        <body class="bg-light">

            <jsp:include page="../layout/header.jsp" />

            <div class="container py-5">
                <div class="row">
                    <div class="col-md-3 mb-4">
                        <div class="card border-0 shadow-sm">
                            <div class="card-body text-center pt-4 pb-3">
                                <div class="avatar-placeholder bg-primary text-white rounded-circle d-inline-flex align-items-center justify-content-center mb-3"
                                    style="width: 64px; height: 64px; font-size: 24px;">
                                    <i class="fas fa-user"></i>
                                </div>
                                <h6 class="fw-bold mb-0 text-truncate">${pageContext.request.userPrincipal.name}</h6>
                            </div>
                            <div class="list-group list-group-flush small">
                                <a href="/profile" class="list-group-item list-group-item-action py-3 border-0">
                                    <i class="fas fa-user-circle me-2 text-muted"></i> Thông tin tài khoản
                                </a>
                                <a href="/change-password"
                                    class="list-group-item list-group-item-action py-3 border-0 active fw-bold">
                                    <i class="fas fa-key me-2"></i> Đổi mật khẩu
                                </a>

                                <form id="logoutFormSide" method="POST" action="/logout" style="display:none;">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                </form>

                                <a href="#" onclick="document.getElementById('logoutFormSide').submit(); return false;"
                                    class="list-group-item list-group-item-action py-3 border-0 text-danger">
                                    <i class="fas fa-sign-out-alt me-2"></i> Đăng xuất
                                </a>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-9">
                        <div class="card border-0 shadow-sm">
                            <div class="card-header bg-white py-3 border-bottom-0">
                                <h5 class="mb-0 fw-bold text-primary"><i class="fas fa-lock me-2"></i> Đổi mật khẩu</h5>
                            </div>
                            <div class="card-body p-4">

                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger rounded-pill px-4 small">
                                        <i class="fas fa-exclamation-circle me-2"></i> ${error}
                                    </div>
                                </c:if>
                                <c:if test="${not empty message}">
                                    <div class="alert alert-success rounded-pill px-4 small">
                                        <i class="fas fa-check-circle me-2"></i> ${message}
                                    </div>
                                </c:if>

                                <form action="/change-password" method="post">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                    <div class="mb-3">
                                        <label class="form-label small text-muted fw-bold">Mật khẩu hiện tại</label>
                                        <input type="password" name="currentPassword" class="form-control" required
                                            placeholder="Nhập mật khẩu đang sử dụng">
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label small text-muted fw-bold">Mật khẩu mới</label>
                                        <input type="password" name="newPassword" class="form-control" required
                                            placeholder="Nhập mật khẩu mới">
                                    </div>

                                    <div class="mb-4">
                                        <label class="form-label small text-muted fw-bold">Xác nhận mật khẩu mới</label>
                                        <input type="password" name="confirmPassword" class="form-control" required
                                            placeholder="Nhập lại mật khẩu mới">
                                    </div>

                                    <div class="d-flex justify-content-end">
                                        <button type="submit" class="btn btn-primary px-4 fw-bold">
                                            <i class="fas fa-save me-2"></i> Lưu thay đổi
                                        </button>
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