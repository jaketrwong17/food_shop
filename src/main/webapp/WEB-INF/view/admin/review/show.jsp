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
                </style>
            </head>

            <body>
                <div class="d-flex" id="wrapper">
                    <jsp:include page="../layout/sidebar.jsp">
                        <jsp:param name="active" value="review" />
                    </jsp:include>

                    <div id="page-content-wrapper">
                        <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom px-4 py-3">
                            <h4 class="mb-0 text-dark fw-bold">Quản lý Đánh giá</h4>
                        </nav>

                        <div class="container-fluid px-4 py-4">
                            <div class="card shadow-sm border-0 rounded-3">

                                <div class="card-header bg-white py-3">
                                    <div class="row">
                                        <div class="col-md-6">

                                            <form action="/admin/review" method="GET"
                                                class="d-flex gap-2 align-items-center">
                                                <input type="text" name="keyword" class="form-control" placeholder=""
                                                    value="${keyword}" style="max-width: 400px;">
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
                                                                    <i class="far fa-star text-muted opacity-25"></i>
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
                                                                    onclick="showReviewDetail(
                                                        '${review.id}',
                                                        '${review.user.fullName}',
                                                        '${review.product.name}',
                                                        '${review.rating}',
                                                        '<fmt:formatDate value='${review.createdAt}' pattern='dd/MM/yyyy HH:mm' />', 
                                                        `${review.content}`,
                                                        '${not empty review.product.images ? review.product.images[0].imageUrl : ''}'
                                                        )">
                                                                    <i class="fas fa-eye"></i>
                                                                </button>

                                                                <form action="/admin/review/delete/${review.id}"
                                                                    method="POST"
                                                                    onsubmit="return confirm('Xóa đánh giá này?');"
                                                                    style="margin:0;">
                                                                    <input type="hidden" name="${_csrf.parameterName}"
                                                                        value="${_csrf.token}" />
                                                                    <button type="submit"
                                                                        class="btn btn-sm btn-danger"><i
                                                                            class="fas fa-trash"></i></button>
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
                        <div class="modal-content">
                            <div class="modal-header border-0">
                                <h5 class="modal-title fw-bold"><i class="fas fa-comments text-primary me-2"></i>Chi
                                    tiết đánh giá</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body pt-0">
                                <div class="row">
                                    <div class="col-md-5 text-center border-end">
                                        <img id="modalProductImg" src="" class="img-fluid rounded border shadow-sm mb-3"
                                            style="max-height: 250px; object-fit: contain;">
                                        <h6 class="fw-bold text-primary mb-1" id="modalProductName"></h6>
                                    </div>

                                    <div class="col-md-7">
                                        <div class="d-flex justify-content-between align-items-start mb-3">
                                            <div>
                                                <h6 class="fw-bold mb-0" id="modalUser"></h6>
                                                <small class="text-muted" id="modalDate"></small>
                                            </div>
                                            <div class="star-rating text-warning fs-5" id="modalRating"></div>
                                        </div>

                                        <div class="p-3 bg-light rounded border">
                                            <label class="small text-muted fw-bold mb-1">Nội dung:</label>
                                            <p class="mb-0 text-dark" style="white-space: pre-wrap; font-size: 1rem;"
                                                id="modalContent"></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer border-0">
                                <button type="button" class="btn btn-secondary px-4"
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
                        if (imgUrl) {
                            imgElement.src = "/images/" + imgUrl;
                            imgElement.style.display = 'block';
                        } else {
                            imgElement.style.display = 'none';
                        }

                        let starsHtml = '';
                        for (let i = 1; i <= 5; i++) {
                            if (i <= rating) starsHtml += '<i class="fas fa-star"></i>';
                            else starsHtml += '<i class="far fa-star text-muted opacity-25"></i>';
                        }
                        document.getElementById('modalRating').innerHTML = starsHtml;

                        var myModal = new bootstrap.Modal(document.getElementById('reviewDetailModal'));
                        myModal.show();
                    }
                </script>
            </body>

            </html>