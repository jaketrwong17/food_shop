<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <c:set var="act" value="${param.activePage}" />

        <div class="card border-0 shadow-sm rounded-3 overflow-hidden">
            <div class="card-header bg-white border-bottom p-4 text-center">
                <div class="d-inline-flex align-items-center justify-content-center rounded-circle bg-primary bg-opacity-10 text-primary mb-3"
                    style="width: 60px; height: 60px;">
                    <span class="fs-3 fw-bold">${sessionScope.email.substring(0,1).toUpperCase()}</span>
                </div>
                <h6 class="fw-bold mb-1 text-dark">
                    ${sessionScope.fullName != null ? sessionScope.fullName : 'Thành viên'}
                </h6>
                <small class="text-muted d-block text-truncate">${sessionScope.email}</small>
            </div>

            <div class="list-group list-group-flush py-2">
                <a href="/order-history"
                    class="list-group-item list-group-item-action border-0 py-3 px-4 d-flex align-items-center ${act == 'history' ? 'active-menu' : ''}">
                    <i class="fas fa-history me-3 ${act == 'history' ? 'text-primary' : 'text-secondary'}"
                        style="width: 20px;"></i>
                    <span class="${act == 'history' ? 'fw-bold text-primary' : 'text-dark'}">Lịch sử mua hàng</span>
                </a>

                <a href="/order-tracking"
                    class="list-group-item list-group-item-action border-0 py-3 px-4 d-flex align-items-center ${act == 'tracking' ? 'active-menu' : ''}">
                    <i class="fas fa-truck-fast me-3 ${act == 'tracking' ? 'text-primary' : 'text-secondary'}"
                        style="width: 20px;"></i>
                    <span class="${act == 'tracking' ? 'fw-bold text-primary' : 'text-dark'}">Theo dõi đơn hàng</span>
                </a>
            </div>
        </div>

        <style>
            .active-menu {
                background-color: #f0f8ff !important;
                border-left: 4px solid ##2A83E9 !important;
            }

            .list-group-item-action:hover {
                background-color: #f8f9fa;
            }
        </style>