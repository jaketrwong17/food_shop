<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="vi">
        <jsp:include page="../layout/header.jsp" />

        <body>
            <div class="d-flex" id="wrapper">
                <jsp:include page="../layout/sidebar.jsp">
                    <jsp:param name="active" value="user" />
                </jsp:include>

                <div id="page-content-wrapper">
                    <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom px-4 py-3">
                        <h4 class="mb-0 text-dark fw-bold">Quản lý Người dùng</h4>
                    </nav>

                    <div class="container-fluid px-4 py-4">

                        <c:if test="${not empty param.error}">
                            <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                <c:choose>
                                    <c:when test="${param.error == 'self_action'}">
                                        <strong>Không thể thực hiện!</strong> Bạn không thể tự khóa hoặc xóa tài khoản
                                        của chính mình.
                                    </c:when>
                                    <c:when test="${param.error == 'active_order'}">
                                        <strong>Không thể khóa!</strong> Người dùng này đang có đơn hàng chưa hoàn tất.
                                        Vui lòng xử lý đơn hàng trước.
                                    </c:when>
                                    <c:when test="${param.error == 'cannot_delete_has_orders'}">
                                        <strong>Không thể xóa!</strong> Người dùng này đã có lịch sử mua hàng. Vui lòng
                                        chọn <b>Khóa tài khoản</b> thay vì xóa để bảo toàn dữ liệu.
                                    </c:when>
                                    <c:otherwise>
                                        Đã xảy ra lỗi trong quá trình xử lý yêu cầu: ${param.error}
                                    </c:otherwise>
                                </c:choose>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"
                                    aria-label="Close"></button>
                            </div>
                        </c:if>

                        <c:if test="${not empty param.message}">
                            <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                                <i class="fas fa-check-circle me-2"></i> ${param.message}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"
                                    aria-label="Close"></button>
                            </div>
                        </c:if>
                        <div class="card shadow-sm border-0 rounded-3">
                            <div class="card-header bg-white py-3">
                                <div class="row align-items-center">
                                    <div class="col-md-12">
                                        <form action="/admin/user" method="GET" class="d-flex">
                                            <input type="text" name="keyword" class="form-control"
                                                placeholder="Tìm kiếm theo tên hoặc email..." value="${keyword}"
                                                style="max-width: 400px;">
                                            <button class="btn btn-outline-primary ms-2"><i
                                                    class="fas fa-search"></i></button>
                                        </form>
                                    </div>
                                </div>
                            </div>

                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle mb-0">
                                        <thead class="bg-light text-secondary">
                                            <tr>
                                                <th class="ps-4">ID</th>
                                                <th>Avatar</th>
                                                <th>Email</th>
                                                <th>Họ và tên</th>
                                                <th>Vai trò</th>
                                                <th class="text-center">Trạng thái</th>
                                                <th>Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="user" items="${users}">
                                                <tr class="${user.isLocked ? 'table-secondary opacity-75' : ''}">

                                                    <td class="ps-4 fw-bold">#${user.id}</td>

                                                    <td>
                                                        <i class="fas fa-user-circle fa-2x text-secondary"></i>
                                                    </td>

                                                    <td>${user.email}</td>

                                                    <td class="fw-bold">${user.fullName}</td>

                                                    <td>
                                                        <span class="badge bg-info text-dark">${user.role.name}</span>
                                                    </td>

                                                    <td class="text-center">
                                                        <c:if test="${!user.isLocked}">
                                                            <span class="badge bg-success">Hoạt động</span>
                                                        </c:if>
                                                        <c:if test="${user.isLocked}">
                                                            <span class="badge bg-danger">Đã khóa</span>
                                                        </c:if>
                                                    </td>

                                                    <td>
                                                        <form action="/admin/user/lock/${user.id}" method="POST"
                                                            style="display:inline;">

                                                            <input type="hidden" name="${_csrf.parameterName}"
                                                                value="${_csrf.token}" />
                                                            <c:if test="${!user.isLocked}">
                                                                <button class="btn btn-sm btn-outline-warning me-1"
                                                                    title="Khóa tài khoản"
                                                                    onclick="return confirm('Bạn có muốn KHÓA tài khoản này không? Người dùng sẽ không thể đăng nhập.');">
                                                                    <i class="fas fa-lock"></i>
                                                                </button>
                                                            </c:if>
                                                            <c:if test="${user.isLocked}">
                                                                <button class="btn btn-sm btn-outline-success me-1"
                                                                    title="Mở khóa tài khoản"
                                                                    onclick="return confirm('Mở khóa cho tài khoản này?');">
                                                                    <i class="fas fa-lock-open"></i>
                                                                </button>
                                                            </c:if>
                                                        </form>

                                                        <a href="/admin/user/delete/${user.id}"
                                                            class="btn btn-sm btn-outline-danger" title="Xóa vĩnh viễn"
                                                            onclick="return confirm('CẢNH BÁO: Hành động này không thể hoàn tác!\nBạn chắc chắn muốn xóa user: ${user.email}?');">
                                                            <i class="fas fa-trash-alt"></i>
                                                        </a>
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