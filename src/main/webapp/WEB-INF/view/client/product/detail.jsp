<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <title>${product.name} - 16Home</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
                <style>
                    .carousel-inner img {
                        height: 400px;
                        object-fit: contain;
                        background: #fff;
                    }

                    .thumbnails-wrap {
                        display: flex;
                        gap: 8px;
                        margin-top: 10px;
                        overflow-x: auto;
                        padding: 5px 0;
                    }

                    .thumb-item {
                        width: 60px;
                        height: 60px;
                        border: 1px solid #eee;
                        border-radius: 4px;
                        cursor: pointer;
                        object-fit: cover;
                        transition: 0.2s;
                        flex-shrink: 0;
                    }

                    .thumb-item.active {
                        border-color: #ee4d2d;
                        box-shadow: 0 0 0 1px #ee4d2d;
                    }

                    .input-group-small {
                        width: 100px !important;
                    }

                    .input-group-small .btn,
                    .input-group-small .form-control {
                        height: 34px;
                        font-size: 0.85rem;
                        padding: 0.2rem 0.4rem;
                    }

                    .btn-shopee-small {
                        background-color: #ee4d2d;
                        color: white;
                        border: none;
                        height: 34px;
                        font-size: 0.85rem;
                        padding: 0 18px;
                        font-weight: bold;
                    }

                    .btn-shopee-small:hover {
                        background-color: #d73211;
                        color: white;
                    }

                    .btn-shopee-small:disabled {
                        background-color: #ccc;
                        cursor: not-allowed;
                    }

                    /* Bảng thông số */
                    .specs-table {
                        border-collapse: collapse;
                        width: 100%;
                        border: 1px solid #dee2e6;
                    }

                    .specs-table td {
                        padding: 10px 12px;
                        font-size: 13px;
                        border: 1px solid #dee2e6 !important;
                        color: #333;
                        font-weight: normal !important;
                    }

                    .specs-table td:first-child {
                        background-color: #f1f3f5;
                        width: 40%;
                    }

                    .detail-content {
                        line-height: 1.6;
                        color: #444;
                        font-size: 0.95rem;
                    }

                    .detail-content p,
                    .short-desc-content p {
                        margin-bottom: 10px;
                    }

                    .short-desc-content {
                        font-size: 14px;
                        line-height: 1.25;
                        color: #555;
                        text-align: justify;
                    }

                    .short-desc-content img {
                        max-width: 100%;
                        height: auto;
                        border-radius: 5px;
                        margin: 10px 0;
                    }

                    .review-item:last-child {
                        border-bottom: none !important;
                        margin-bottom: 0 !important;
                        padding-bottom: 0 !important;
                    }

                    .star-rating-input {
                        display: flex;
                        flex-direction: row-reverse;
                        justify-content: flex-start;
                        gap: 5px;
                    }

                    .star-rating-input input {
                        display: none;
                    }

                    .star-rating-input label {
                        cursor: pointer;
                        font-size: 1.8rem;
                        color: #e4e5e9;
                        transition: color 0.2s;
                    }

                    .star-rating-input label:hover,
                    .star-rating-input label:hover~label,
                    .star-rating-input input:checked~label {
                        color: #ffc107;
                    }
                </style>
            </head>

            <body class="bg-light">
                <jsp:include page="../layout/header.jsp" />

                <div class="container mt-4">

                    <nav aria-label="breadcrumb" class="mb-3">
                        <ol class="breadcrumb mb-0 small">
                            <li class="breadcrumb-item">
                                <a href="/" class="text-decoration-none text-muted">Trang chủ</a>
                            </li>
                            <li class="breadcrumb-item active text-primary" aria-current="page">
                                ${product.category.name}
                            </li>
                        </ol>
                    </nav>

                    <div class="row g-4">
                        <div class="col-lg-7">
                            <div class="bg-white p-3 rounded shadow-sm border h-100 text-center">
                                <div id="productCarousel" class="carousel slide" data-bs-ride="false">
                                    <div class="carousel-inner">
                                        <c:forEach var="img" items="${product.images}" varStatus="status">
                                            <div class="carousel-item ${status.first ? 'active' : ''}">
                                                <img src="/images/${img.imageUrl}" class="d-block w-100">
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <button class="carousel-control-prev" type="button"
                                        data-bs-target="#productCarousel" data-bs-slide="prev">
                                        <span class="carousel-control-prev-icon bg-dark rounded-circle"
                                            aria-hidden="true" style="width: 2rem; height: 2rem;"></span>
                                    </button>
                                    <button class="carousel-control-next" type="button"
                                        data-bs-target="#productCarousel" data-bs-slide="next">
                                        <span class="carousel-control-next-icon bg-dark rounded-circle"
                                            aria-hidden="true" style="width: 2rem; height: 2rem;"></span>
                                    </button>
                                </div>
                                <div class="thumbnails-wrap">
                                    <c:forEach var="img" items="${product.images}" varStatus="status">
                                        <img src="/images/${img.imageUrl}"
                                            class="thumb-item ${status.first ? 'active' : ''}"
                                            data-bs-target="#productCarousel" data-bs-slide-to="${status.index}"
                                            onclick="activateThumb(this)">
                                    </c:forEach>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-5">
                            <div class="bg-white p-4 rounded shadow-sm border h-100">

                                <h2 class="fw-bold mb-2" style="font-size: 1.5rem;">${product.name}</h2>

                                <div class="rating mb-3 small">
                                    <c:choose>
                                        <c:when test="${product.reviewCount > 0}">
                                            <span class="text-warning">
                                                <c:forEach begin="1" end="${product.averageRating.intValue()}">
                                                    <i class="fas fa-star"></i>
                                                </c:forEach>
                                                <c:if test="${product.averageRating % 1 >= 0.5}">
                                                    <i class="fas fa-star-half-alt"></i>
                                                </c:if>
                                                <c:forEach begin="1"
                                                    end="${5 - product.averageRating.intValue() - (product.averageRating % 1 >= 0.5 ? 1 : 0)}">
                                                    <i class="far fa-star text-secondary opacity-50"></i>
                                                </c:forEach>
                                                <span class="text-muted ms-2">(${product.reviewCount} đánh giá)</span>
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach begin="1" end="5">
                                                <i class="far fa-star text-secondary opacity-50"></i>
                                            </c:forEach>
                                            <span class="text-muted small ms-2">Chưa có đánh giá</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="price-section mb-3 border-top pt-3">
                                    <c:choose>
                                        <c:when test="${product.active}">
                                            <h2 class="text-danger fw-bold d-inline-block mb-0">
                                                <fmt:formatNumber value="${product.price}" type="currency"
                                                    currencySymbol="đ" />
                                            </h2>
                                        </c:when>
                                        <c:otherwise>
                                            <h3 class="text-danger fw-bold d-inline-block mb-0 text-uppercase">
                                                Ngừng kinh doanh
                                            </h3>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="mb-4 p-3 bg-light rounded border-start border-primary border-4">
                                    <h6 class="fw-bold small text-uppercase mb-2">Đặc điểm nổi bật:</h6>
                                    <div class="detail-content text-secondary short-desc-content">
                                        <c:out value="${product.shortDesc}" escapeXml="false" />
                                    </div>
                                </div>

                                <form action="/add-product-to-cart/${product.id}" method="POST" id="addToCartForm">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                    <div class="mb-4">
                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                            <label class="fw-bold small text-uppercase">Số lượng:</label>
                                            <span id="stock-display" class="text-secondary small">
                                            </span>
                                        </div>

                                        <div class="d-flex gap-2 align-items-center">
                                            <div class="input-group input-group-small">
                                                <button class="btn btn-outline-secondary" type="button"
                                                    onclick="changeQty(-1)" ${!product.active ? 'disabled' : ''
                                                    }>-</button>

                                                <input type="number" name="quantity" id="inputQuantity" value="1"
                                                    min="1" class="form-control text-center border-secondary"
                                                    ${!product.active ? 'disabled' : '' }>

                                                <button class="btn btn-outline-secondary" type="button"
                                                    onclick="changeQty(1)" ${!product.active ? 'disabled' : ''
                                                    }>+</button>
                                            </div>

                                            <c:choose>
                                                <c:when test="${product.active}">
                                                    <button type="submit" id="btnSubmit"
                                                        class="btn btn-shopee-small rounded-pill text-uppercase">
                                                        <i class="fas fa-cart-plus me-2"></i>Thêm vào giỏ hàng
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <button type="button" disabled
                                                        class="btn btn-secondary rounded-pill text-uppercase"
                                                        style="cursor: not-allowed; opacity: 0.7;">
                                                        <i class="fas fa-ban me-2"></i>Ngừng kinh doanh
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div id="error-msg" class="text-danger small mt-2" style="display:none;">Số
                                            lượng vượt quá
                                            kho hàng!</div>
                                    </div>
                                </form>

                                <div class="mt-4 pt-3 border-top d-flex gap-4 small text-muted">
                                    <span><i class="fas fa-undo-alt text-primary me-1"></i> 30 ngày đổi trả</span>
                                    <span><i class="fas fa-shield-alt text-primary me-1"></i> Chính hãng 100%</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-4 g-4">
                        <div class="col-lg-8">
                            <div class="bg-white p-4 rounded shadow-sm border mb-4">
                                <h5 class="fw-bold border-bottom pb-3 mb-3 text-uppercase">
                                    <i class="fas fa-info-circle text-primary me-2"></i>Thông tin sản phẩm
                                </h5>
                                <div class="detail-content">${product.detailDesc}</div>
                            </div>

                            <div class="bg-white p-4 rounded shadow-sm border" id="review-section">
                                <h5 class="fw-bold border-bottom pb-3 mb-4 text-uppercase">
                                    <i class="fas fa-star text-warning me-2"></i>Đánh giá sản phẩm <span
                                        class="text-muted small">(${reviews.size()})</span>
                                </h5>

                                <c:if test="${canReview}">
                                    <div class="card bg-light border-0 mb-4">
                                        <div class="card-body">
                                            <h6 class="fw-bold mb-3 text-primary"><i class="fas fa-pen me-2"></i>Viết
                                                đánh giá của
                                                bạn</h6>
                                            <form action="/product/add-review" method="POST">
                                                <input type="hidden" name="${_csrf.parameterName}"
                                                    value="${_csrf.token}" />
                                                <input type="hidden" name="productId" value="${product.id}" />

                                                <div class="mb-3">
                                                    <label class="form-label small text-muted fw-bold">Mức độ hài
                                                        lòng:</label>
                                                    <div class="star-rating-input">
                                                        <input type="radio" id="star5" name="rating" value="5"
                                                            required />
                                                        <label for="star5" title="Tuyệt vời"><i
                                                                class="fas fa-star"></i></label>

                                                        <input type="radio" id="star4" name="rating" value="4" />
                                                        <label for="star4" title="Tốt"><i
                                                                class="fas fa-star"></i></label>

                                                        <input type="radio" id="star3" name="rating" value="3" />
                                                        <label for="star3" title="Bình thường"><i
                                                                class="fas fa-star"></i></label>

                                                        <input type="radio" id="star2" name="rating" value="2" />
                                                        <label for="star2" title="Tệ"><i
                                                                class="fas fa-star"></i></label>

                                                        <input type="radio" id="star1" name="rating" value="1" />
                                                        <label for="star1" title="Rất tệ"><i
                                                                class="fas fa-star"></i></label>
                                                    </div>
                                                </div>

                                                <div class="mb-3">
                                                    <textarea name="content" class="form-control" rows="3"
                                                        placeholder="Chia sẻ cảm nhận của bạn về sản phẩm..."
                                                        required></textarea>
                                                </div>
                                                <button type="submit" class="btn btn-primary px-4">Gửi đánh giá</button>
                                            </form>
                                        </div>
                                    </div>
                                </c:if>

                                <c:if test="${not canReview}">
                                    <div class="alert alert-secondary small mb-4 d-flex align-items-center">
                                        <i class="fas fa-info-circle me-2 fs-5"></i>
                                        <div>
                                            <c:choose>
                                                <c:when test="${hasReviewed}">
                                                    <strong>Bạn đã đánh giá sản phẩm này.</strong> Cảm ơn bạn đã chia
                                                    sẻ!
                                                </c:when>
                                                <c:otherwise>
                                                    Bạn cần <strong>mua sản phẩm</strong> này và đơn hàng phải hoàn
                                                    thành để viết
                                                    đánh giá.
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </c:if>

                                <div class="review-list">
                                    <c:if test="${empty reviews}">
                                        <div class="text-center py-4 text-muted">
                                            <i class="far fa-comment-dots fa-2x mb-2"></i>
                                            <p>Chưa có đánh giá nào cho sản phẩm này.</p>
                                        </div>
                                    </c:if>
                                    <c:forEach var="rv" items="${reviews}">
                                        <div class="review-item border-bottom pb-3 mb-3">
                                            <div class="d-flex justify-content-between align-items-start">
                                                <div class="d-flex align-items-center">
                                                    <div class="bg-light rounded-circle d-flex align-items-center justify-content-center me-3 fw-bold text-primary border"
                                                        style="width: 40px; height: 40px;">
                                                        ${rv.user.fullName.charAt(0)}
                                                    </div>
                                                    <div>
                                                        <div class="fw-bold text-dark">${rv.user.fullName}</div>
                                                        <div class="text-warning small">
                                                            <c:forEach begin="1" end="${rv.rating}"><i
                                                                    class="fas fa-star"></i>
                                                            </c:forEach>
                                                            <c:forEach begin="1" end="${5 - rv.rating}"><i
                                                                    class="far fa-star text-secondary opacity-25"></i>
                                                            </c:forEach>
                                                        </div>
                                                    </div>
                                                </div>
                                                <small class="text-muted">
                                                    <fmt:formatDate value="${rv.createdAt}" pattern="dd/MM/yyyy" />
                                                </small>
                                            </div>
                                            <div class="mt-2 ms-5 ps-2 text-secondary" style="font-size: 0.95rem;">
                                                ${rv.content}
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-4">
                            <div class="specs-box p-3 shadow-sm border bg-white">
                                <h6 class="fw-bold mb-3 text-primary text-uppercase small"><i
                                        class="fas fa-list-ul me-2"></i>Cấu
                                    hình chi tiết</h6>
                                <table class="specs-table">
                                    <tbody>
                                        <c:forEach var="s" items="${product.specs}">
                                            <tr>
                                                <td>${s.specName}</td>
                                                <td>${s.specValue}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <jsp:include page="../layout/footer.jsp" />

                <script>
                    const inputQty = document.getElementById('inputQuantity');
                    const btnSubmit = document.getElementById('btnSubmit');
                    const stockDisplay = document.getElementById('stock-display');
                    const errorMsg = document.getElementById('error-msg');

                    function activateThumb(element) {
                        document.querySelectorAll('.thumb-item').forEach(t => t.classList.remove('active'));
                        element.classList.add('active');
                    }

                    // Lấy số lượng tồn kho trực tiếp từ Product (vì không còn Color)
                    // Lưu ý: Đảm bảo biến ${product.quantity} tồn tại trong model backend
                    const currentStock = ${ product.quantity };

                    function changeQty(amt) {
                        inputQty.value = Math.max(1, parseInt(inputQty.value) + amt);
                        validateQuantity();
                    }

                    function validateQuantity() {
                        let val = parseInt(inputQty.value);
                        if (val > currentStock) {
                            inputQty.value = currentStock;
                            errorMsg.style.display = 'block';
                            setTimeout(() => { errorMsg.style.display = 'none'; }, 2000);
                        }
                        // Chỉ enable nút submit nếu có hàng
                        if (btnSubmit) {
                            btnSubmit.disabled = (currentStock <= 0);
                        }
                    }

                    if (inputQty) {
                        inputQty.addEventListener('change', validateQuantity);
                    }

                    window.addEventListener('DOMContentLoaded', () => {
                        const isProductActive = ${ product.active };

                        if (isProductActive) {
                            if (currentStock > 0) {
                                stockDisplay.innerText = `(Còn lại: \${currentStock} sản phẩm)`;
                            } else {
                                stockDisplay.innerText = "(Tạm hết hàng)";
                                if (btnSubmit) btnSubmit.disabled = true;
                                if (inputQty) inputQty.disabled = true;
                            }
                        } else {
                            stockDisplay.innerText = "(Sản phẩm này đã ngừng bán)";
                            if (btnSubmit) btnSubmit.disabled = true;
                            if (inputQty) inputQty.disabled = true;
                        }
                    });
                </script>
            </body>

            </html>