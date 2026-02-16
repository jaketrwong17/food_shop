<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <title>Quên mật khẩu</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
            <style>
                body {
                    background-color: #f0f2f5;
                    height: 100vh;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }

                .card-custom {
                    border-radius: 20px;
                    border: none;
                    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                    width: 450px;
                    padding: 40px;
                }

                .btn-primary-custom {
                    background-color: #2A83E9;
                    border: none;
                    border-radius: 50px;
                    padding: 12px;
                    font-weight: bold;
                    width: 100%;
                }

                .btn-primary-custom:hover {
                    background-color: #1c68c4;
                }

                .form-control {
                    border-radius: 50px;
                    padding: 12px 20px;
                    background-color: #f8f9fa;
                    border: 1px solid #eee;
                }
            </style>
        </head>

        <body>
            <div class="card card-custom bg-white">
                <div class="text-center mb-4">
                    <div class="bg-light rounded-circle d-inline-flex align-items-center justify-content-center"
                        style="width: 80px; height: 80px;">
                        <i class="fas fa-lock fa-2x" style="color: #2A83E9;"></i>
                    </div>
                </div>
                <h3 class="text-center mb-2 fw-bold" style="color: #333;">Quên mật khẩu?</h3>
                <p class="text-center text-muted small mb-4">Nhập email của bạn, chúng tôi sẽ gửi liên kết đặt lại mật
                    khẩu.</p>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger text-center small rounded-pill">${error}</div>
                </c:if>
                <c:if test="${not empty message}">
                    <div class="alert alert-success text-center small rounded-pill">${message}</div>
                </c:if>

                <form action="/forgot-password" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <div class="mb-3">
                        <input type="email" name="email" class="form-control" required placeholder="Nhập email của bạn">
                    </div>
                    <button type="submit" class="btn btn-primary btn-primary-custom text-white">GỬI YÊU CẦU</button>
                </form>

                <div class="text-center mt-4">
                    <a href="/login" class="text-decoration-none small" style="color: #555;">
                        <i class="fas fa-arrow-left me-1"></i> Quay lại đăng nhập
                    </a>
                </div>
            </div>
        </body>

        </html>