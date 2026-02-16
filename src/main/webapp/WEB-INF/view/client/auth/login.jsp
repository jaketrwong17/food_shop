<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <title>Đăng nhập</title>
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

                .login-card {
                    border-radius: 15px;
                    overflow: hidden;
                    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
                    max-width: 900px;
                    width: 100%;
                    border: none;
                    background: white;
                }

                .form-section {
                    padding: 50px 40px;
                    display: flex;
                    flex-direction: column;
                    justify-content: center;
                }

                .image-section {
                    background-image: url('https://img.freepik.com/free-vector/mobile-login-concept-illustration_114360-83.jpg?w=740');

                    background-size: cover;
                    background-position: center;
                    min-height: 500px;
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
                <div class="card login-card">
                    <div class="row g-0">
                        <div class="col-md-6 d-none d-md-block image-section">
                            <div class="image-overlay"></div>
                        </div>

                        <div class="col-md-6 form-section">
                            <div class="text-center mb-4">
                                <h3 class="fw-bold mb-1" style="color: #2A83E9;">ĐĂNG NHẬP</h3>
                                <p class="text-muted small">Chào mừng bạn quay trở lại!</p>
                            </div>

                            <c:if test="${not empty param.error}">
                                <div class="alert alert-danger alert-custom text-center mb-3">
                                    <i class="fas fa-exclamation-triangle me-1"></i>

                                    <c:choose>
                                        <%-- Trường hợp 1: Tài khoản bị khóa (Admin bấm khóa) --%>
                                            <c:when test="${param.error == 'locked'}">
                                                <strong>Tài khoản đã bị khóa!</strong><br>
                                                Vui lòng liên hệ Admin để mở khóa.
                                            </c:when>

                                            <%-- Trường hợp 2: Tài khoản chưa kích hoạt email (nếu có dùng) --%>
                                                <c:when test="${param.error == 'disabled'}">
                                                    Tài khoản chưa được kích hoạt.<br>
                                                    Vui lòng kiểm tra email để xác thực.
                                                </c:when>

                                                <%-- Trường hợp 3: Sai mật khẩu hoặc User không tồn tại --%>
                                                    <c:otherwise>
                                                        Sai email hoặc mật khẩu!
                                                    </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:if>
                            <c:if test="${not empty param.logout}">
                                <div class="alert alert-success alert-custom text-center mb-3">
                                    <i class="fas fa-check-circle me-1"></i> Đã đăng xuất thành công.
                                </div>
                            </c:if>

                            <form action="/login" method="post">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                <div class="mb-3">
                                    <input type="text" name="username" class="form-control" placeholder="Email của bạn"
                                        required>
                                </div>
                                <div class="mb-2">
                                    <input type="password" name="password" class="form-control" placeholder="Mật khẩu"
                                        required>
                                </div>

                                <div class="d-flex justify-content-between align-items-center mb-4 px-2">
                                    <div class="form-check">

                                    </div>
                                    <a href="/forgot-password" class="small text-decoration-none fw-bold"
                                        style="color: #2A83E9;">Quên mật khẩu?</a>
                                </div>

                                <button type="submit" class="btn btn-primary btn-primary-custom text-white">ĐĂNG
                                    NHẬP</button>

                                <div class="text-center mt-3">
                                    <p class="small text-muted mb-0">
                                        Chưa có tài khoản?
                                        <a href="/register" class="fw-bold text-decoration-none"
                                            style="color: #2A83E9;">Đăng ký ngay</a>
                                    </p>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>
            </div>

        </body>

        </html>