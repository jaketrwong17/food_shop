<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <jsp:include page="../layout/header.jsp" />
            <style>
                #page-content-wrapper {
                    background-color: #f8f9fa;
                    min-height: 100vh;
                }

                .card {
                    border-radius: 8px;
                    border: none;
                }

                .table thead {
                    background-color: #ffffff;
                    border-bottom: 2px solid #f1f1f1;
                }

                .table th {
                    color: #333;
                    font-weight: 600;
                    text-transform: none;
                    font-size: 0.9rem;
                }

                .badge-code {
                    background-color: #e7f1ff;
                    color: #0d6efd;
                    border: 1px solid #cfe2ff;
                    padding: 6px 12px;
                    font-weight: 600;
                }

                .btn-action {
                    border-radius: 4px;
                    padding: 5px 8px;
                }
            </style>
        </head>

        <body>
            <div class="d-flex" id="wrapper">
                <jsp:include page="../layout/sidebar.jsp" />

                <div id="page-content-wrapper" class="w-100">
                    <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom px-4 py-3">
                        <h4 class="mb-0 text-dark fw-bold">Quản lý Mã giảm giá</h4>
                    </nav>

                    <div class="container-fluid px-4 py-4">
                        <div class="card shadow-sm mb-4">
                            <div class="card-header bg-white py-3">
                                <div class="row align-items-center">
                                    <div class="col-md-9">
                                        <form action="/admin/voucher" method="GET"
                                            class="d-flex gap-2 align-items-center">
                                            <div class="input-group" style="max-width: 250px;">
                                                <select name="categoryId" class="form-select shadow-none">
                                                    <option value="">-- Tất cả mã --</option>
                                                    <option value="-1" ${categoryId==-1 ? 'selected' : '' }>Toàn bộ sàn
                                                    </option>
                                                    <c:forEach var="cate" items="${categories}">
                                                        <option value="${cate.id}" ${categoryId==cate.id ? 'selected'
                                                            : '' }>
                                                            ${cate.name}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>


                                            <input type="text" name="keyword" class="form-control" placeholder=""
                                                value="${keyword}" style="max-width: 400px;">
                                            <button class="btn btn-outline-primary ms-2"><i
                                                    class="fas fa-search"></i></button>

                                        </form>
                                    </div>
                                    <div class="col-md-3 text-end">
                                        <a href="/admin/voucher/create" class="btn btn-success fw-bold px-3">
                                            <i class="fas fa-plus me-1"></i> THÊM MÃ MỚI
                                        </a>
                                    </div>
                                </div>
                            </div>

                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle mb-0">
                                        <thead>
                                            <tr class="text-secondary">
                                                <th class="ps-4">ID</th>
                                                <th>Mã Code</th>
                                                <th>Giảm (%)</th>
                                                <th>Phạm vi áp dụng</th>
                                                <th class="text-end pe-4">Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="v" items="${vouchers}">
                                                <tr>
                                                    <td class="ps-4 fw-bold text-muted">#${v.id}</td>
                                                    <td>
                                                        <span class="badge badge-code text-uppercase">
                                                            <i class="fas fa-ticket-alt me-1"></i> ${v.code}
                                                        </span>
                                                    </td>
                                                    <td><span class="text-success fw-bold">${v.discount}%</span></td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${v.all}">
                                                                <span class="badge rounded-pill bg-primary px-3">Toàn bộ
                                                                    sàn</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:forEach var="cat" items="${v.categories}">
                                                                    <span
                                                                        class="badge rounded-pill bg-secondary bg-opacity-75 me-1">${cat.name}</span>
                                                                </c:forEach>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="text-end pe-4">
                                                        <a href="/admin/voucher/update/${v.id}"
                                                            class="btn btn-sm btn-warning text-white btn-action">
                                                            <i class="fas fa-edit"></i>
                                                        </a>
                                                        <a href="/admin/voucher/delete/${v.id}"
                                                            class="btn btn-sm btn-danger btn-action"
                                                            onclick="return confirm('Xóa mã này?')">
                                                            <i class="fas fa-trash"></i>
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