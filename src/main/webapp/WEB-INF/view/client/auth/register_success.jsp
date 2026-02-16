<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
        <title>Đăng ký thành công</title>
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
                padding: 50px;
                text-align: center;
                border: none;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                max-width: 500px;
                width: 100%;
            }

            .icon-box {
                color: #2A83E9;
                font-size: 5rem;
                margin-bottom: 20px;
            }

            .btn-custom {
                background-color: #2A83E9;
                color: white;
                border-radius: 50px;
                padding: 10px 30px;
                font-weight: bold;
                text-decoration: none;
                display: inline-block;
                margin-top: 20px;
            }

            .btn-custom:hover {
                background-color: #1c68c4;
                color: white;
            }
        </style>
    </head>

    <body>
        <div class="card card-custom bg-white">
            <div class="icon-box"><i class="fas fa-check-circle"></i></div>
            <h2 class="fw-bold mb-3" style="color: #333;">Đăng Ký Thành Công!</h2>
            <p class="text-muted">Cảm ơn bạn đã đăng ký. Một email xác thực đã được gửi đến hòm thư của bạn.</p>
            <p class="text-muted small">Vui lòng kiểm tra và kích hoạt tài khoản.</p>
            <a href="/login" class="btn-custom">Quay lại Đăng nhập</a>
        </div>
    </body>

    </html>