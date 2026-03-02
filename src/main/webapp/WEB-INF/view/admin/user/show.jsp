<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">
            <jsp:include page="../layout/header.jsp" />

            <head>
                <style>
                    /* CSS ĐỒNG BỘ VỚI TRANG THỐNG KÊ */
                    .card-stats {
                        transition: transform 0.2s ease !important;
                        border: none;
                        border-radius: 10px;
                        background-color: #fff;
                    }

                    .card-stats:hover {
                        transform: translateY(-5px) !important;
                        box-shadow: 0 .5rem 1rem rgba(0, 0, 0, .15) !important;
                    }

                    .icon-shape {
                        width: 42px;
                        height: 42px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        border-radius: 50%;
                    }

                    .table-custom-row td {
                        padding-top: 1rem;
                        padding-bottom: 1rem;
                    }
                </style>
            </head>

            <body>
                <div class="d-flex" id="wrapper">
                    <jsp:include page="../layout/sidebar.jsp">
                        <jsp:param name="active" value="user" />
                    </jsp:include>

                    <div id="page-content-wrapper" class="bg-light w-100">
                        <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom px-4 py-3 mb-4">
                            <h4 class="mb-0 text-dark fw-bold">Quản lý Người dùng</h4>
                        </nav>

                        <div class="container-fluid px-4">

                            <%-- THÔNG BÁO LỖI/THÀNH CÔNG --%>
                                <c:if test="${not empty param.error}">
                                    <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
                                        <i class="fas fa-exclamation-triangle me-2"></i>
                                        <c:choose>
                                            <c:when test="${param.error == 'self_action'}">Bạn không thể tự tác động lên
                                                tài khoản của chính mình.</c:when>
                                            <c:otherwise>Lỗi xử lý: ${param.error}</c:otherwise>
                                        </c:choose>
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                </c:if>

                                <%--==================== THUẬT TOÁN ĐẾM & BẢNG THỐNG KÊ (STYLE
                                    DASHBOARD)====================--%>
                                    <c:set var="countTotal" value="0" />
                                    <c:set var="countAdmin" value="0" />
                                    <c:set var="countUser" value="0" />
                                    <c:set var="countActive" value="0" />
                                    <c:set var="countLocked" value="0" />

                                    <c:forEach var="u" items="${users}">
                                        <c:set var="countTotal" value="${countTotal + 1}" />
                                        <c:choose>
                                            <c:when test="${u.role.name == 'ADMIN'}">
                                                <c:set var="countAdmin" value="${countAdmin + 1}" />
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="countUser" value="${countUser + 1}" />
                                            </c:otherwise>
                                        </c:choose>
                                        <c:choose>
                                            <c:when test="${!u.isLocked}">
                                                <c:set var="countActive" value="${countActive + 1}" />
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="countLocked" value="${countLocked + 1}" />
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>

                                    <div class="row g-3 mb-4">
                                        <div class="col-xl-2 col-lg-4 col-md-4 col-6">
                                            <div
                                                class="card card-stats shadow-sm h-100 border-start border-secondary border-4">
                                                <div class="card-body p-3">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <div>
                                                            <p class="text-muted mb-1 small fw-bold text-uppercase">Tổng
                                                                User</p>
                                                            <h4 class="fw-bold text-secondary mb-0">${countTotal}</h4>
                                                        </div>
                                                        <div
                                                            class="icon-shape bg-secondary bg-opacity-10 text-secondary">
                                                            <i class="fas fa-users"></i></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-2 col-lg-4 col-md-4 col-6">
                                            <div
                                                class="card card-stats shadow-sm h-100 border-start border-primary border-4">
                                                <div class="card-body p-3">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <div>
                                                            <p class="text-muted mb-1 small fw-bold text-uppercase">
                                                                Admin</p>
                                                            <h4 class="fw-bold text-primary mb-0">${countAdmin}</h4>
                                                        </div>
                                                        <div class="icon-shape bg-primary bg-opacity-10 text-primary"><i
                                                                class="fas fa-user-shield"></i></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-2 col-lg-4 col-md-4 col-6">
                                            <div
                                                class="card card-stats shadow-sm h-100 border-start border-info border-4">
                                                <div class="card-body p-3">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <div>
                                                            <p class="text-muted mb-1 small fw-bold text-uppercase">
                                                                Khách hàng</p>
                                                            <h4 class="fw-bold text-info mb-0">${countUser}</h4>
                                                        </div>
                                                        <div class="icon-shape bg-info bg-opacity-10 text-info"><i
                                                                class="fas fa-user"></i></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-3 col-lg-6 col-md-6 col-6">
                                            <div
                                                class="card card-stats shadow-sm h-100 border-start border-success border-4">
                                                <div class="card-body p-3">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <div>
                                                            <p class="text-muted mb-1 small fw-bold text-uppercase">Hoạt
                                                                động</p>
                                                            <h4 class="fw-bold text-success mb-0">${countActive}</h4>
                                                        </div>
                                                        <div class="icon-shape bg-success bg-opacity-10 text-success"><i
                                                                class="fas fa-check-circle"></i></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-3 col-lg-6 col-md-6 col-6">
                                            <div
                                                class="card card-stats shadow-sm h-100 border-start border-danger border-4">
                                                <div class="card-body p-3">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <div>
                                                            <p class="text-muted mb-1 small fw-bold text-uppercase">Đã
                                                                khóa</p>
                                                            <h4 class="fw-bold text-danger mb-0">${countLocked}</h4>
                                                        </div>
                                                        <div class="icon-shape bg-danger bg-opacity-10 text-danger"><i
                                                                class="fas fa-user-lock"></i></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <%--==================== KẾT THÚC THỐNG KÊ====================--%>

                                        <div class="card shadow-sm border-0 rounded-3 mb-5">
                                            <div class="card-header bg-white py-3 border-bottom">
                                                <form action="/admin/user" method="GET"
                                                    class="d-flex gap-2 align-items-center flex-wrap">
                                                    <select name="role" class="form-select" style="max-width: 150px;">
                                                        <option value="">-- Vai trò --</option>
                                                        <c:forEach var="r" items="${roles}">
                                                            <option value="${r.name}" ${selectedRole==r.name
                                                                ? 'selected' : '' }>${r.name}</option>
                                                        </c:forEach>
                                                    </select>

                                                    <select name="locked" class="form-select" style="max-width: 150px;">
                                                        <option value="">-- Trạng thái --</option>
                                                        <option value="false" ${selectedLocked==false ? 'selected' : ''
                                                            }>Hoạt động</option>
                                                        <option value="true" ${selectedLocked==true ? 'selected' : '' }>
                                                            Đã khóa</option>
                                                    </select>

                                                    <input type="text" name="keyword" class="form-control"
                                                        placeholder="Tên hoặc email..." value="${keyword}"
                                                        style="max-width: 300px;">

                                                    <button
                                                        class="btn btn-outline-primary d-flex align-items-center justify-content-center shadow-none"
                                                        type="submit"
                                                        style="width: 38px; height: 38px; border-radius: 6px;">
                                                        <i class="fas fa-search"></i>
                                                    </button>

                                                    <a href="/admin/user"
                                                        class="btn btn-outline-secondary d-flex align-items-center justify-content-center shadow-none"
                                                        style="width: 38px; height: 38px; border-radius: 6px;"
                                                        title="Làm mới">
                                                        <i class="fas fa-sync-alt" style="font-size: 0.8rem;"></i>
                                                    </a>
                                                </form>
                                            </div>

                                            <div class="card-body p-0">
                                                <div class="table-responsive">
                                                    <table class="table table-hover align-middle mb-0">
                                                        <thead
                                                            class="bg-light text-secondary small text-uppercase fw-bold">
                                                            <tr>
                                                                <th class="ps-4 py-3">ID</th>
                                                                <th>Người dùng</th>
                                                                <th>Email</th>
                                                                <th>Vai trò</th>
                                                                <th class="text-center">Trạng thái</th>
                                                                <th class="text-end pe-4">Hành động</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="user" items="${users}">
                                                                <tr
                                                                    class="table-custom-row ${user.isLocked ? 'bg-light opacity-75' : ''}">
                                                                    <td class="ps-4 fw-bold">#${user.id}</td>
                                                                    <td>
                                                                        <div class="d-flex align-items-center">
                                                                            <div class="icon-shape bg-light text-secondary me-2"
                                                                                style="width: 32px; height: 32px;">
                                                                                <i class="fas fa-user small"></i>
                                                                            </div>
                                                                            <span
                                                                                class="fw-bold text-dark">${user.fullName}</span>
                                                                        </div>
                                                                    </td>
                                                                    <td>${user.email}</td>
                                                                    <td><span
                                                                            class="badge bg-info-subtle text-info border border-info opacity-75">${user.role.name}</span>
                                                                    </td>
                                                                    <td class="text-center">
                                                                        <c:choose>
                                                                            <c:when test="${!user.isLocked}"><span
                                                                                    class="badge bg-success-subtle text-success border border-success px-3">Hoạt
                                                                                    động</span></c:when>
                                                                            <c:otherwise><span
                                                                                    class="badge bg-danger-subtle text-danger border border-danger px-3">Đã
                                                                                    khóa</span></c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td class="text-end pe-4">
                                                                        <div class="d-flex justify-content-end gap-1">
                                                                            <form action="/admin/user/lock/${user.id}"
                                                                                method="POST" class="m-0">
                                                                                <input type="hidden"
                                                                                    name="${_csrf.parameterName}"
                                                                                    value="${_csrf.token}" />
                                                                                <c:choose>
                                                                                    <c:when test="${!user.isLocked}">
                                                                                        <button
                                                                                            class="btn btn-sm btn-outline-warning"
                                                                                            title="Khóa"
                                                                                            onclick="return confirm('Khóa người dùng này?');">
                                                                                            <i class="fas fa-lock"></i>
                                                                                        </button>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <button
                                                                                            class="btn btn-sm btn-outline-success"
                                                                                            title="Mở khóa">
                                                                                            <i
                                                                                                class="fas fa-lock-open"></i>
                                                                                        </button>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </form>
                                                                            <a href="/admin/user/delete/${user.id}"
                                                                                class="btn btn-sm btn-outline-danger"
                                                                                onclick="return confirm('Xóa vĩnh viễn người dùng này?');">
                                                                                <i class="fas fa-trash-alt"></i>
                                                                            </a>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                        </div>
                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>