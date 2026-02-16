<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
        <title>Xác thực thất bại</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>

    <body class="bg-light">
        <div class="container d-flex justify-content-center align-items-center vh-100">
            <div class="card shadow p-5 text-center" style="max-width: 500px; border-radius: 15px;">
                <div class="mb-4">
                    <i class="fas fa-times-circle text-danger" style="font-size: 4rem;"></i>
                </div>
                <h3 class="fw-bold text-danger">Kích hoạt thất bại!</h3>
                <p class="text-muted mt-3">Liên kết xác thực không hợp lệ hoặc tài khoản đã được kích hoạt trước đó.</p>
                <a href="/register" class="btn btn-warning mt-3 rounded-pill px-4 text-white">Đăng ký lại</a>
            </div>
        </div>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    </body>

    </html>