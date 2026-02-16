<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Đặt hàng thành công - 16Home</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
            <style>
                body {
                    background-color: #f8f9fa;
                }

                .thank-you-card {
                    max-width: 600px;
                    border-radius: 20px;
                    border: none;
                    transition: transform 0.3s ease;
                }

                .thank-you-card:hover {
                    transform: translateY(-5px);
                }

                .btn-home {
                    background-color: ##2A83E9;

                    border: none;
                }

                .btn-home:hover {
                    background-color: #cdcecf;
                }
            </style>
        </head>

        <body>

            <jsp:include page="../layout/header.jsp" />

            <div class="container text-center py-5">
                <div class="card shadow-lg p-5 mx-auto thank-you-card">
                    <div class="text-success mb-4">
                        <i class="fas fa-check-circle fa-5x"></i>
                    </div>

                    <h2 class="fw-bold mb-3 text-uppercase">Đặt hàng thành công!</h2>
                    <p class="text-muted mb-4">
                        Cảm ơn bạn đã tin tưởng và mua sắm tại <strong>WolfHome</strong>. <br>
                        Đơn hàng của bạn đã được tiếp nhận và đang trong quá trình chuẩn bị để giao đến bạn sớm nhất.
                    </p>

                    <!-- <div class="d-grid gap-2 d-md-block">
                        <a href="/"
                            class="btn btn-primary btn-home rounded-pill px-5 py-2 fw-bold text-uppercase shadow-sm text-white">
                            <i class="fas fa-shopping-bag me-2"></i>Tiếp tục mua sắm
                        </a>
                    </div> -->
                    <div class="d-grid gap-2 d-md-block">
                        <a href="/" class="btn btn-outline-primary w-100 rounded-pill fw-bold">
                            <i class="fas fa-shopping-bag me-2"></i>Tiếp tục mua sắm
                        </a>
                    </div>

                    <div class="mt-4">
                        <small class="text-muted">Bạn có thắc mắc? Liên hệ chúng tôi qua Hotline: 1900 xxxx</small>
                    </div>
                </div>
            </div>


            <jsp:include page="../layout/footer.jsp" />


        </body>

        </html>