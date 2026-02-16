<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <c:set var="act" value="${param.activePage}" />

        <div class="card border-0 shadow-sm rounded-3 overflow-hidden">
            <div class="card-header bg-white border-bottom p-4 text-center">
                <div class="d-inline-flex align-items-center justify-content-center rounded-circle bg-primary bg-opacity-10 text-primary mb-3"
                    style="width: 60px; height: 60px;">
                    <span class="fs-3 fw-bold">${user.fullName.substring(0,1).toUpperCase()}</span>
                </div>
                <h6 class="fw-bold mb-1 text-dark">${user.fullName}</h6>
                <small class="text-muted d-block text-truncate">${user.email}</small>
            </div>

            <div class="list-group list-group-flush py-2">
                <a href="/profile"
                    class="list-group-item list-group-item-action border-0 py-3 px-4 d-flex align-items-center ${act == 'profile' ? 'active-menu' : ''}">
                    <i class="fas fa-user-circle me-3 ${act == 'profile' ? 'text-primary' : 'text-secondary'}"
                        style="width: 20px;"></i>
                    <span class="${act == 'profile' ? 'fw-bold text-primary' : 'text-dark'}">Thông tin tài khoản</span>
                </a>

                <a href="/change-password"
                    class="list-group-item list-group-item-action border-0 py-3 px-4 d-flex align-items-center ${act == 'password' ? 'active-menu' : ''}">
                    <i class="fas fa-key me-3 ${act == 'password' ? 'text-primary' : 'text-secondary'}"
                        style="width: 20px;"></i>
                    <span class="${act == 'password' ? 'fw-bold text-primary' : 'text-dark'}">Đổi mật khẩu</span>
                </a>
                <form action="/logout" method="post" class="m-0">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <button type="submit"
                        class="list-group-item list-group-item-action border-0 py-3 px-4 d-flex align-items-center text-danger bg-transparent">
                        <i class="fas fa-sign-out-alt me-3" style="width: 20px;"></i>
                        <span>Đăng xuất</span>
                    </button>
                </form>
            </div>
        </div>

        <style>
            .active-menu {
                background-color: #f0f8ff !important;
                border-left: 4px solid #0d6efd !important;
            }

            .list-group-item-action:hover {
                background-color: #f8f9fa;
            }
        </style>