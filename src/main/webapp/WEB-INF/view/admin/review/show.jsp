<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">
            <jsp:include page="../layout/header.jsp" />

            <head>
                <meta charset="UTF-8">
                <title>Quản lý đánh giá</title>
                <style>
                    .action-group {
                        display: flex;
                        justify-content: flex-end;
                        gap: 8px;
                    }

                    .star-rating i {
                        margin-right: 1px;
                    }

                    .text-warning {
                        color: #ffc107 !important;
                    }

                    /* Đồng bộ CSS với trang thống kê/đơn hàng */
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
                        <jsp:param name="active" value="review" />
                    </jsp:include>

                    <div id="page-content-wrapper" class="bg-light w-100">
                        <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom px-4 py-3 mb-4">
                            <h4 class="mb-0 text-dark fw-bold">Quản lý Đánh giá</h4>
                        </nav>

                        <div class="container-fluid px-4 py-4">

                            <%--==================== THUẬT TOÁN ĐẾM & BẢNG THỐNG KÊ====================--%>
                                <c:set var="total" value="0" />
                                <c:set var="star5" value="0" />
                                <c:set var="star4" value="0" />
                                <c:set var="star3" value="0" />
                                <c:set var="star2" value="0" />
                                <c:set var="star1" value="0" />

                                <c:forEach var="r" items="${reviews}">
                                    <c:set var="total" value="${total + 1}" />
                                    <c:choose>
                                        <c:when test="${r.rating == 5}">
                                            <c:set var="star5" value="${star5 + 1}" />
                                        </c:when>
                                        <c:when test="${r.rating == 4}">
                                            <c:set var="star4" value="${star4 + 1}" />
                                        </c:when>
                                        <c:when test="${r.rating == 3}">
                                            <c:set var="star3" value="${star3 + 1}" />
                                        </c:when>
                                        <c:when test="${r.rating == 2}">
                                            <c:set var="star2" value="${star2 + 1}" />
                                        </c:when>
                                        <c:when test="${r.rating == 1}">
                                            <c:set var="star1" value="${star1 + 1}" />
                                        </c:when>
                                    </c:choose>
                                </c:forEach>

                                <div class="row g-3 mb-4">
                                    <div class="col-xl-2 col-md-4 col-6">
                                        <div class="card card-stats shadow-sm h-100 border-start border-dark border-4">
                                            <div class="card-body p-3 text-center">
                                                <p class="text-muted mb-1 small fw-bold">TỔNG ĐÁNH GIÁ</p>
                                                <h4 class="fw-bold mb-0">${total}</h4>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-2 col-md-4 col-6">
                                        <div
                                            class="card card-stats shadow-sm h-100 border-start border-success border-4">
                                            <div class="card-body p-3 text-center">
                                                <p class="text-muted mb-1 small fw-bold">5 SAO</p>
                                                <h4 class="fw-bold text-success mb-0">${star5}</h4>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-2 col-md-4 col-6">
                                        <div
                                            class="card card-stats shadow-sm h-100 border-start border-primary border-4">
                                            <div class="card-body p-3 text-center">
                                                <p class="text-muted mb-1 small fw-bold">4 SAO</p>
                                                <h4 class="fw-bold text-primary mb-0">${star4}</h4>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-2 col-md-4 col-6">
                                        <div class="card card-stats shadow-sm h-100 border-start border-info border-4">
                                            <div class="card-body p-3 text-center">
                                                <p class="text-muted mb-1 small fw-bold">3 SAO</p>
                                                <h4 class="fw-bold text-info mb-0">${star3}</h4>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-2 col-md-4 col-6">
                                        <div
                                            class="card card-stats shadow-sm h-100 border-start border-warning border-4">
                                            <div class="card-body p-3 text-center">
                                                <p class="text-muted mb-1 small fw-bold">2 SAO</p>
                                                <h4 class="fw-bold text-warning mb-0">${star2}</h4>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-2 col-md-4 col-6">
                                        <div
                                            class="card card-stats shadow-sm h-100 border-start border-danger border-4">
                                            <div class="card-body p-3 text-center">
                                                <p class="text-muted mb-1 small fw-bold">1 SAO</p>
                                                <h4 class="fw-bold text-danger mb-0">${star1}</h4>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="card shadow-sm border-0 rounded-3">
                                    <div class="card-header bg-white py-3 border-bottom">
                                        <div class="row">
                                            <div class="col-md-8">
                                                <form action="/admin/review" method="GET"
                                                    class="d-flex gap-2 align-items-center flex-wrap">

                                                    <select name="rating" class="form-select fw-bold"
                                                        style="max-width: 150px; color: ${empty param.rating ? '#212529' : '#ffc107'};"
                                                        onchange="this.style.color = this.value === '' ? '#212529' : '#ffc107'">

                                                        <option value="" style="color: #212529;">-- Số sao --</option>
                                                        <option value="5" style="color: #ffc107;" ${param.rating=='5'
                                                            ? 'selected' : '' }>★★★★★</option>
                                                        <option value="4" style="color: #ffc107;" ${param.rating=='4'
                                                            ? 'selected' : '' }>★★★★</option>
                                                        <option value="3" style="color: #ffc107;" ${param.rating=='3'
                                                            ? 'selected' : '' }>★★★</option>
                                                        <option value="2" style="color: #ffc107;" ${param.rating=='2'
                                                            ? 'selected' : '' }>★★</option>
                                                        <option value="1" style="color: #ffc107;" ${param.rating=='1'
                                                            ? 'selected' : '' }>★</option>

                                                    </select>

                                                    <input type="text" name="keyword" class="form-control"
                                                        placeholder="Tên SP, khách hàng..." value="${keyword}"
                                                        style="max-width: 300px;">

                                                    <button
                                                        class="btn btn-outline-primary d-flex align-items-center justify-content-center shadow-none"
                                                        type="submit"
                                                        style="width: 38px; height: 38px; border-radius: 6px;">
                                                        <i class="fas fa-search"></i>
                                                    </button>

                                                    <a href="/admin/review"
                                                        class="btn btn-outline-secondary d-flex align-items-center justify-content-center shadow-none"
                                                        style="width: 38px; height: 38px; border-radius: 6px;"
                                                        title="Làm mới">
                                                        <i class="fas fa-sync-alt" style="font-size: 0.8rem;"></i>
                                                    </a>
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
                                                        <th>Sản phẩm</th>
                                                        <th>Người dùng</th>
                                                        <th>Đánh giá (Sao)</th>
                                                        <th>Ngày giờ</th>
                                                        <th class="text-end pe-4">Thao tác</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="review" items="${reviews}">
                                                        <tr>
                                                            <td class="ps-4 fw-bold">#${review.id}</td>
                                                            <td>
                                                                <div class="d-flex align-items-center">
                                                                    <c:if test="${not empty review.product.images}">
                                                                        <img src="/images/${review.product.images[0].imageUrl}"
                                                                            class="rounded border me-2" width="40"
                                                                            height="40" style="object-fit: cover;">
                                                                    </c:if>
                                                                    <span class="text-truncate"
                                                                        style="max-width: 200px;">${review.product.name}</span>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div class="fw-bold">${review.user.fullName}</div>
                                                                <small class="text-muted">${review.user.email}</small>
                                                            </td>
                                                            <td>
                                                                <div class="star-rating text-warning small">
                                                                    <c:forEach begin="1" end="${review.rating}">
                                                                        <i class="fas fa-star"></i>
                                                                    </c:forEach>
                                                                    <c:forEach begin="1" end="${5 - review.rating}">
                                                                        <i
                                                                            class="far fa-star text-muted opacity-25"></i>
                                                                    </c:forEach>
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <fmt:formatDate value="${review.createdAt}"
                                                                    pattern="dd/MM/yyyy HH:mm" />
                                                            </td>
                                                            <td class="pe-4">
                                                                <div class="action-group">
                                                                    <button type="button"
                                                                        class="btn btn-sm btn-light border text-primary"
                                                                        onclick="showReviewDetail('${review.id}', '${review.user.fullName}', '${review.product.name}', '${review.rating}', '<fmt:formatDate value='${review.createdAt}' pattern='dd/MM/yyyy HH:mm' />', `${review.content}`, '${not empty review.product.images ? review.product.images[0].imageUrl : ''}')">
                                                                        <i class="fas fa-eye"></i>
                                                                    </button>

                                                                    <form action="/admin/review/delete/${review.id}"
                                                                        method="POST"
                                                                        onsubmit="return confirm('Xóa đánh giá này?');"
                                                                        style="margin:0;">
                                                                        <input type="hidden"
                                                                            name="${_csrf.parameterName}"
                                                                            value="${_csrf.token}" />
                                                                        <button type="submit"
                                                                            class="btn btn-sm btn-outline-danger"><i
                                                                                class="fas fa-trash-alt"></i></button>
                                                                    </form>
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

                <div class="modal fade" id="reviewDetailModal" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered modal-lg">
                        <div class="modal-content border-0 shadow">
                            <div class="modal-header border-0">
                                <h5 class="modal-title fw-bold"><i class="fas fa-comments text-primary me-2"></i>Chi
                                    tiết đánh giá</h5>
                                <button type="button" class="btn-close shadow-none" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body pt-0">
                                <div class="row">
                                    <div class="col-md-5 text-center border-end">
                                        <div class="p-2 border rounded bg-white shadow-sm mb-3">
                                            <img id="modalProductImg" src="" class="img-fluid"
                                                style="max-height: 200px; object-fit: contain;">
                                        </div>
                                        <h6 class="fw-bold text-primary px-2" id="modalProductName"></h6>
                                    </div>
                                    <div class="col-md-7">
                                        <div class="d-flex justify-content-between align-items-start mb-3">
                                            <div>
                                                <h6 class="fw-bold mb-0 text-dark" id="modalUser"></h6>
                                                <small class="text-muted" id="modalDate"></small>
                                            </div>
                                            <div class="star-rating text-warning fs-5" id="modalRating"></div>
                                        </div>
                                        <div class="p-3 bg-light rounded border">
                                            <label class="small text-muted fw-bold mb-1 text-uppercase">Nội dung đánh
                                                giá:</label>
                                            <p class="mb-0 text-dark lh-base" style="white-space: pre-wrap;"
                                                id="modalContent"></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer border-0">
                                <button type="button" class="btn btn-secondary px-4 fw-bold"
                                    data-bs-dismiss="modal">Đóng</button>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    function showReviewDetail(id, user, product, rating, date, content, imgUrl) {
                        document.getElementById('modalUser').innerText = user;
                        document.getElementById('modalProductName').innerText = product;
                        document.getElementById('modalDate').innerText = date;
                        document.getElementById('modalContent').innerText = content;

                        const imgElement = document.getElementById('modalProductImg');
                        imgElement.src = imgUrl ? "/images/" + imgUrl : "";
                        imgElement.parentElement.style.display = imgUrl ? 'block' : 'none';

                        let starsHtml = '';
                        for (let i = 1; i <= 5; i++) {
                            starsHtml += i <= rating ? '<i class="fas fa-star"></i>' : '<i class="far fa-star text-muted opacity-25"></i>';
                        }
                        document.getElementById('modalRating').innerHTML = starsHtml;

                        new bootstrap.Modal(document.getElementById('reviewDetailModal')).show();
                    }
                </script>
            </body>

            </html>