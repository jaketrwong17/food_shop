<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <c:set var="act" value="${param.activePage}" />

        <%-- LOGIC THÔNG MINH: Ưu tiên lấy tên từ biến user -> session -> mặc định là Admin 1 để không bị lỗi ở trang
            đổi mật khẩu --%>
            <c:set var="displayName"
                value="${not empty user.fullName ? user.fullName : (not empty sessionScope.fullName ? sessionScope.fullName : 'Admin 1')}" />
            <c:set var="displayEmail"
                value="${not empty user.email ? user.email : (not empty sessionScope.email ? sessionScope.email : pageContext.request.userPrincipal.name)}" />

            <div class="card border-0 shadow-sm rounded-3 overflow-hidden">
                <div class="card-header bg-white border-bottom p-4 text-center">
                    <div class="d-inline-flex align-items-center justify-content-center rounded-circle mb-3"
                        style="width: 60px; height: 60px; background-color: #eef5eb; color: #3c8a2e;">
                        <span class="fs-3 fw-bold">${displayName.substring(0,1).toUpperCase()}</span>
                    </div>
                    <h6 class="fw-bold mb-1 text-dark">${displayName}</h6>
                    <small class="text-muted d-block text-truncate">${displayEmail}</small>
                </div>

                <div class="list-group list-group-flush py-2">
                    <a href="/profile"
                        class="list-group-item list-group-item-action border-0 py-3 px-4 d-flex align-items-center ${act == 'profile' ? 'active-menu' : ''}">
                        <i class="fas fa-user-circle me-3 ${act == 'profile' ? 'text-theme' : 'text-secondary'}"
                            style="width: 20px;"></i>
                        <span class="${act == 'profile' ? 'fw-bold text-theme' : 'text-dark'}">Thông tin tài
                            khoản</span>
                    </a>

                    <a href="/change-password"
                        class="list-group-item list-group-item-action border-0 py-3 px-4 d-flex align-items-center ${act == 'password' ? 'active-menu' : ''}">
                        <i class="fas fa-key me-3 ${act == 'password' ? 'text-theme' : 'text-secondary'}"
                            style="width: 20px;"></i>
                        <span class="${act == 'password' ? 'fw-bold text-theme' : 'text-dark'}">Đổi mật khẩu</span>
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
                .text-theme {
                    color: #3c8a2e !important;
                }

                .active-menu {
                    background-color: #eef5eb !important;
                    border-left: 4px solid #3c8a2e !important;
                }

                .list-group-item-action:hover {
                    background-color: #f8f9fa;
                }
            </style>