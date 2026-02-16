<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <style>
            .insta-box {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 30px;

                height: 30px;
                border-radius: 10px;

                color: white;

                font-size: 22px;



                background: linear-gradient(45deg,
                        #f09433 0%,
                        #e6683c 25%,
                        #dc2743 50%,
                        #cc2366 75%,
                        #bc1888 100%);


                box-shadow: 0 4px 10px rgba(220, 39, 67, 0.3);
                transition: transform 0.3s ease;
            }

            .insta-box:hover {
                transform: translateY(-3px);

            }

            .fb_tk-box:hover {
                transform: translateY(-3px);

            }


            .payment-badge {
                background: white;
                border: 1px solid #e0e0e0;
                border-radius: 6px;
                padding: 5px 12px;
                font-weight: 800;

                font-size: 14px;
                display: inline-flex;
                align-items: center;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            }


            .vnpay-blue {
                color: #005baa;
            }


            .vnpay-red {
                color: #ed1c24;
            }

            .momo-color {
                color: #a50064;
            }

            .cod-color {
                color: #212529;
            }
        </style>

        <footer class="bg-dark text-white pt-5 pb-3 mt-5">
            <div class="container">
                <div class="row gy-4">
                    <div class="col-lg-3">
                        <h6 class="fw-bold mb-3">Tổng đài hỗ trợ miễn phí</h6>
                        <p class="mb-1 text-secondary">Tư vấn mua hàng: <strong class="text-white">0968 733 752</strong>
                        </p>
                        <p class="mb-1 text-secondary">Góp ý, khiếu nại: <strong class="text-white">0968 733
                                752</strong></p>
                    </div>

                    <div class="col-lg-3">
                        <h6 class="fw-bold mb-3">Thông tin và chính sách</h6>
                        <ul class="list-unstyled text-secondary fs-sm">
                            <li><a href="#" class="text-reset text-decoration-none">Giới thiệu 16Home</a></li>
                            <li><a href="#" class="text-reset text-decoration-none">Chính sách bảo hành</a></li>
                            <li><a href="#" class="text-reset text-decoration-none">Hình thức thanh toán</a></li>
                        </ul>
                    </div>

                    <div class="col-lg-3 text-center text-lg-start">
                        <h6 class="fw-bold mb-3">Kết nối với chúng tôi</h6>
                        <div class="d-flex gap-3 justify-content-center justify-content-lg-start align-items-center">

                            <a href="https://www.facebook.com/duong.anh.752713" class="text-decoration-none">
                                <div class="fb_tk-box">
                                    <i class="fab fa-facebook fs-3 text-primary"></i>
                                </div>
                            </a>

                            <a href="https://www.tiktok.com/@duonganh162005" class="text-decoration-none">
                                <div class="fb_tk-box">
                                    <i class="fab fa-tiktok fs-3 text-white"></i>
                                </div>
                            </a>

                            <a href="https://www.instagram.com/mitiudayroi_16" class="text-decoration-none">
                                <div class="insta-box">
                                    <i class="fab fa-instagram"></i>
                                </div>
                            </a>
                        </div>

                        <div class="footer-information d-flex flex-column mt-4">

                            <div class="d-flex gap-2 align-items-center mb-2">
                                <i class="fas fa-envelope text-white fs-5"></i>
                                <p class="reason mb-0 text-white">support@16home.vn</p>
                            </div>

                            <div class="d-flex gap-2 justify-content-start align-items-center mb-2">
                                <i class="fas fa-map-marker-alt text-white fs-5"></i>
                                <p class="reason mb-0 text-white">
                                    P.Nguyễn Trắc, Yên Nghĩa, Hà Đông, Hà Nội
                                </p>
                            </div>

                            <div class="d-flex gap-2 justify-content-start align-items-center mb-2">
                                <i class="fas fa-phone text-white fs-5"></i>
                                <p class="reason mb-0 text-white">
                                    0968 733 752
                                </p>
                            </div>

                        </div>
                    </div>

                    <div class="col-lg-3">
                        <h6 class="fw-bold mb-3">Phương thức thanh toán</h6>
                        <div class="d-flex flex-wrap gap-2">

                            <span class="payment-badge">
                                <span class="vnpay-blue">VN</span><span class="vnpay-red">PAY</span>
                            </span>
                            <span class="payment-badge cod-color">
                                <i class="fas fa-truck me-1"></i> COD
                            </span>
                        </div>
                    </div>
                    <hr class="my-4 border-secondary">

                    <div class="d-flex justify-content-between flex-wrap align-items-center">
                        <p class="text-secondary small mb-0">© 2024 Bản quyền thuộc về 16Home.</p>
                    </div>
                </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

        <script>

            setTimeout(function () {
                let alerts = document.querySelectorAll('.alert');
                alerts.forEach(function (alert) {
                    let bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                });
            }, 5000);
        </script>