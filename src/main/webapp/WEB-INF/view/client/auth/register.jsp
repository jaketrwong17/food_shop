<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <title>Đăng Ký Tài Khoản</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
                <style>
                    body {
                        background-color: #e9eff5;
                        min-height: 100vh;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        margin: 0;
                        padding: 20px;
                    }

                    .register-card {
                        border-radius: 15px;
                        overflow: hidden;
                        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
                        max-width: 950px;
                        width: 100%;
                        border: none;
                        background: white;
                    }

                    .form-section {
                        padding: 40px;
                        display: flex;
                        flex-direction: column;
                        justify-content: center;
                    }

                    .image-section {
                        background-image: url('https://img.freepik.com/free-vector/sign-up-concept-illustration_114360-7965.jpg?w=740');
                        background-size: cover;
                        background-position: center;
                        min-height: 600px;
                        /* Tăng chiều cao lên chút vì form dài hơn */
                        position: relative;
                    }

                    .image-overlay {
                        position: absolute;
                        top: 0;
                        left: 0;
                        right: 0;
                        bottom: 0;
                        background: rgba(42, 131, 233, 0.05);
                    }

                    .btn-primary-custom {
                        background-color: #2A83E9;
                        border: none;
                        border-radius: 50px;
                        padding: 12px 20px;
                        font-weight: bold;
                        width: 100%;
                        transition: all 0.3s;
                        text-transform: uppercase;
                        letter-spacing: 1px;
                        margin-top: 10px;
                    }

                    .btn-primary-custom:hover {
                        background-color: #1c68c4;
                        transform: translateY(-2px);
                        box-shadow: 0 5px 15px rgba(42, 131, 233, 0.3);
                    }

                    .form-control {
                        border-radius: 50px;
                        padding: 12px 20px;
                        background-color: #f8f9fa;
                        border: 1px solid #eee;
                        margin-bottom: 15px;
                        /* Khoảng cách giữa các ô input */
                    }

                    .form-control:focus {
                        box-shadow: none;
                        border-color: #2A83E9;
                        background-color: white;
                    }

                    .social-btn {
                        width: 40px;
                        height: 40px;
                        border-radius: 50%;
                        display: inline-flex;
                        align-items: center;
                        justify-content: center;
                        border: 1px solid #eee;
                        color: #555;
                        margin: 0 5px;
                        text-decoration: none;
                        transition: 0.3s;
                    }

                    .social-btn:hover {
                        background-color: #2A83E9;
                        color: white;
                        border-color: #2A83E9;
                    }

                    .divider {
                        display: flex;
                        align-items: center;
                        text-align: center;
                        margin: 20px 0;
                        color: #aaa;
                        font-size: 13px;
                    }

                    .divider::before,
                    .divider::after {
                        content: '';
                        flex: 1;
                        border-bottom: 1px solid #eee;
                    }

                    .divider::before {
                        margin-right: .5em;
                    }

                    .divider::after {
                        margin-left: .5em;
                    }

                    .alert-custom {
                        border-radius: 20px;
                        font-size: 0.9rem;
                        padding: 8px 15px;
                    }
                </style>
            </head>

            <body>

                <div class="container d-flex justify-content-center">
                    <div class="card register-card">
                        <div class="row g-0">
                            <div class="col-md-6 d-none d-md-block image-section">
                                <div class="image-overlay"></div>
                            </div>

                            <div class="col-md-6 form-section">
                                <div class="text-center mb-4">
                                    <h3 class="fw-bold mb-1" style="color: #2A83E9;">ĐĂNG KÝ</h3>
                                    <p class="text-muted small">Tạo tài khoản mới hoàn toàn miễn phí</p>
                                </div>

                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger alert-custom text-center mb-3">
                                        <i class="fas fa-exclamation-triangle me-1"></i> ${error}
                                    </div>
                                </c:if>

                                <form:form action="/register" method="post" modelAttribute="registerUser">

                                    <form:input path="firstName" class="form-control" placeholder="Họ"
                                        required="true" />

                                    <form:input path="lastName" class="form-control" placeholder="Tên"
                                        required="true" />
                                    <form:input path="email" type="email" class="form-control"
                                        placeholder="Địa chỉ Email" required="true" />

                                    <form:input path="password" type="password" class="form-control"
                                        placeholder="Mật khẩu" required="true" />

                                    <form:input path="confirmPassword" type="password" class="form-control"
                                        placeholder="Xác nhận mật khẩu" required="true" />

                                    <button type="submit" class="btn btn-primary btn-primary-custom text-white">TẠO TÀI
                                        KHOẢN</button>
                                </form:form>

                                <div class="text-center mt-3">
                                    <p class="small text-muted mb-0">
                                        Đã có tài khoản?
                                        <a href="/login" class="fw-bold text-decoration-none"
                                            style="color: #2A83E9;">Đăng nhập ngay</a>
                                    </p>
                                </div>


                            </div>
                        </div>
                    </div>
                </div>

            </body>

            </html>