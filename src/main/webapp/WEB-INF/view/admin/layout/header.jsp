<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <title>Admin Dashboard</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>

        <style>
            body {
                overflow-x: hidden;
                background-color: #f5f7fa;
                /* Màu nền xám nhạt dịu mắt */
            }

            #wrapper {
                display: flex;
                width: 100%;
                height: 100vh;
                /* Full chiều cao màn hình */
            }

            /* Sidebar màu đen bên trái */
            #sidebar-wrapper {
                width: 260px;
                background-color: #212529;
                /* Màu đen Bootstrap dark */
                flex-shrink: 0;
                transition: all 0.3s ease;
            }

            .sidebar-heading {
                padding: 1.5rem;
                font-size: 1.5rem;
                font-weight: bold;
                color: #fff;
                text-align: center;
                border-bottom: 1px solid #343a40;
            }

            /* Style cho từng mục menu */
            .list-group-item {
                background-color: #212529;
                /* Màu nền đen trùng sidebar */
                color: #adb5bd;
                /* Màu chữ xám */
                border: none;
                padding: 15px 25px;
            }

            .list-group-item:hover {
                background-color: #343a40;
                /* Hover sáng hơn tí */
                color: #fff;
            }

            /* Mục đang chọn (Active) */
            .list-group-item.active {
                background-color: #0d6efd;
                /* Màu xanh nổi bật */
                color: #fff;
                font-weight: 600;
                border-left: 4px solid #fff;
                /* Viền trắng bên trái */
            }

            /* Nội dung chính bên phải */
            #page-content-wrapper {
                flex-grow: 1;
                overflow-y: auto;
                /* Cho phép cuộn dọc nếu nội dung dài */
                width: 100%;
            }

            /* Style cho các Card thống kê */
            .card-stat {
                border: none;
                border-radius: 10px;
                box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
                transition: transform 0.2s;
            }

            .card-stat:hover {
                transform: translateY(-5px);
                /* Hiệu ứng bay lên khi di chuột */
            }
        </style>
    </head>