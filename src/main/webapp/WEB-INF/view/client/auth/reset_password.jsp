<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <title>Đặt lại mật khẩu</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
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
                    margin-bottom: 15px;
                }
            </style>
        </head>

        <body>
            <div class="card card-custom bg-white">
                <h3 class="text-center mb-4 fw-bold" style="color: #2A83E9;">Đặt lại mật khẩu</h3>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger text-center small rounded-pill">${error}</div>
                </c:if>

                <form action="/reset-password" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                    <input type="hidden" name="token" value="${token}" />

                    <div class="mb-3">
                        <input type="password" name="password" class="form-control" placeholder="Mật khẩu mới" required>
                    </div>
                    <div class="mb-4">
                        <input type="password" name="confirmPassword" class="form-control"
                            placeholder="Xác nhận mật khẩu" required>
                    </div>

                    <button type="submit" class="btn btn-primary btn-primary-custom text-white">LƯU MẬT KHẨU</button>
                </form>
            </div>
        </body>

        </html>