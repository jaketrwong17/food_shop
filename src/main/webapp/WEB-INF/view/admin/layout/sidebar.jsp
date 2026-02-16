<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <div id="sidebar-wrapper">
        <div class="sidebar-heading">
            <i class="fas fa-rocket me-2"></i> Admin Pro
        </div>

        <div class="list-group list-group-flush mt-3">
            <a href="/" class="list-group-item list-group-item-action text-primary fw-bold">
                <i class="fas fa-external-link-alt me-2"></i> Xem Website
            </a>

            <hr class="mx-3 my-2 text-muted">

            <a href="/admin/dashboard"
                class="list-group-item list-group-item-action ${param.active == 'dashboard' ? 'active' : ''}">
                <i class="fas fa-tachometer-alt me-2"></i> Thống kê
            </a>
            <a href="/admin/product"
                class="list-group-item list-group-item-action ${param.active == 'product' ? 'active' : ''}">
                <i class="fas fa-box me-2"></i> Sản phẩm
            </a>

            <a href="/admin/category"
                class="list-group-item list-group-item-action ${param.active == 'category' ? 'active' : ''}">
                <i class="fas fa-tags me-2"></i> Danh mục
            </a>

            <a href="/admin/order"
                class="list-group-item list-group-item-action ${param.active == 'order' ? 'active' : ''}">
                <i class="fas fa-shopping-cart me-2"></i> Đơn hàng
            </a>

            <a href="/admin/user"
                class="list-group-item list-group-item-action ${param.active == 'user' ? 'active' : ''}">
                <i class="fas fa-users me-2"></i> Người dùng
            </a>

            <a href="/admin/review"
                class="list-group-item list-group-item-action ${param.active == 'review' ? 'active' : ''}">
                <i class="fas fa-star me-2"></i> Đánh giá
            </a>

            <a href="/admin/voucher"
                class="list-group-item list-group-item-action ${param.active == 'voucher' ? 'active' : ''}">
                <i class="fas fa-ticket-alt me-2"></i> Mã giảm giá
            </a>

            <a href="/admin/promotion"
                class="list-group-item list-group-item-action ${param.active == 'promotion' ? 'active' : ''}">
                <i class="fas fa-bullhorn me-2"></i> Khuyến mãi
            </a>

            <div class="mt-auto p-4">
                <form id="logoutForm" method="POST" action="/logout" style="display:none;">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                </form>

                <a href="#" onclick="document.getElementById('logoutForm').submit(); return false;"
                    class="btn btn-outline-danger w-100">
                    <i class="fas fa-sign-out-alt me-2"></i> Đăng xuất
                </a>
            </div>
        </div>
    </div>