<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">
            <jsp:include page="../layout/header.jsp" />

            <style>
                /* ... (Giữ nguyên các style cũ của bạn) ... */

                /* Thêm style mới cho phần giá nếu cần tinh chỉnh */
                .price-original {
                    font-size: 0.85rem;
                    color: #6c757d;
                    /* text-muted */
                    text-decoration: line-through;
                }

                .price-discount {
                    font-size: 1rem;
                    color: #dc3545;
                    /* text-danger */
                    font-weight: bold;
                }

                .discount-badge {
                    font-size: 0.85rem;
                    color: #dc3545;
                }
            </style>

            <body>
                <div class="d-flex" id="wrapper">
                    <jsp:include page="../layout/sidebar.jsp">
                        <jsp:param name="active" value="product" />
                    </jsp:include>

                    <div id="page-content-wrapper">
                        <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom px-4 py-3">
                            <h4 class="mb-0 text-dark fw-bold">Quản lý Sản phẩm</h4>
                        </nav>

                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger alert-dismissible fade show m-3">
                                ${errorMessage}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>
                        <c:if test="${not empty successMessage}">
                            <div class="alert alert-success alert-dismissible fade show m-3">
                                ${successMessage}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <div class="container-fluid px-4 py-4">
                            <div class="card shadow-sm border-0 rounded-3">
                                <div class="card-header bg-white py-3">
                                    <div class="row align-items-center">
                                        <div class="col-md-10">
                                            <form action="/admin/product" method="GET"
                                                class="d-flex gap-2 align-items-center flex-wrap">
                                                <div class="input-group" style="max-width: 250px;">
                                                    <span class="input-group-text bg-white"><i
                                                            class="fas fa-list"></i></span>
                                                    <select name="categoryId" class="form-select">
                                                        <option value="">-- Danh mục --</option>
                                                        <c:forEach var="cate" items="${categories}">
                                                            <option value="${cate.id}" ${categoryId==cate.id
                                                                ? 'selected' : '' }> ${cate.name} </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <div class="input-group" style="max-width: 200px;">
                                                    <span class="input-group-text bg-white"><i
                                                            class="fas fa-toggle-on"></i></span>
                                                    <select name="status" class="form-select">
                                                        <option value="all">-- Trạng thái --</option>
                                                        <option value="active" ${status=='active' ? 'selected' : '' }>
                                                            Đang bán</option>
                                                        <option value="inactive" ${status=='inactive' ? 'selected' : ''
                                                            }>Ngừng bán</option>
                                                    </select>
                                                </div>
                                                <div class="input-group" style="max-width: 300px;">
                                                    <input type="text" name="keyword" class="form-control"
                                                        placeholder="Tên sản phẩm..." value="${keyword}">
                                                    <button class="btn btn-primary"><i class="fas fa-search"></i>
                                                        Lọc</button>
                                                </div>
                                            </form>
                                        </div>
                                        <div class="col-md-2 text-end">
                                            <a href="/admin/product/create" class="btn btn-success fw-bold text-nowrap">
                                                <i class="fas fa-plus me-1"></i> THÊM MỚI
                                            </a>
                                        </div>
                                    </div>
                                </div>

                                <div class="card-body p-0">
                                    <table class="table table-hover align-middle mb-0">
                                        <thead class="bg-light text-secondary">
                                            <tr>
                                                <th class="ps-4">ID</th>
                                                <th>Ảnh</th>
                                                <th>Tên sản phẩm</th>
                                                <th>Giá bán</th>
                                                <th>Danh mục</th>
                                                <th>Trạng thái</th>
                                                <th>Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="p" items="${products}">
                                                <tr>
                                                    <td class="ps-4 fw-bold">#${p.id}</td>
                                                    <td>
                                                        <c:if test="${not empty p.images}">
                                                            <div style="width: 60px; height: 60px;">
                                                                <img src="/images/${p.images[0].imageUrl}"
                                                                    class="img-thumbnail w-100 h-100 object-fit-cover">
                                                            </div>
                                                        </c:if>
                                                    </td>
                                                    <td class="fw-bold text-primary">
                                                        ${p.name}
                                                    </td>

                                                    <td>
                                                        <c:choose>
                                                            <%-- Trường hợp CÓ KHUYẾN MÃI --%>
                                                                <c:when test="${p.onSale}">
                                                                    <div class="price-discount">
                                                                        <fmt:formatNumber value="${p.discountedPrice}"
                                                                            type="currency" currencySymbol="đ" />
                                                                    </div>

                                                                    <div>
                                                                        <span class="price-original me-1">
                                                                            <fmt:formatNumber value="${p.price}"
                                                                                type="currency" currencySymbol="đ" />
                                                                        </span>
                                                                        <span class="discount-badge">
                                                                            -${p.discountPercentage}%
                                                                        </span>
                                                                    </div>
                                                                </c:when>

                                                                <%-- Trường hợp KHÔNG CÓ KHUYẾN MÃI --%>
                                                                    <c:otherwise>
                                                                        <div class="text-success fw-bold">
                                                                            <fmt:formatNumber value="${p.price}"
                                                                                type="currency" currencySymbol="đ" />
                                                                        </div>
                                                                    </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td><span class="badge bg-secondary">${p.category.name}</span></td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${p.active}">
                                                                <span class="badge bg-success">Đang bán</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-secondary">Ngừng bán</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <button type="button"
                                                            class="btn btn-sm btn-info text-white me-1"
                                                            data-bs-toggle="modal" data-bs-target="#imageModal"
                                                            data-name="${p.name}"
                                                            data-images="<c:forEach var='img' items='${p.images}' varStatus='status'>/images/${img.imageUrl}${!status.last ? ',' : ''}</c:forEach>">
                                                            <i class="fas fa-eye"></i>
                                                        </button>

                                                        <a href="/admin/product/update/${p.id}"
                                                            class="btn btn-sm btn-warning text-white me-1">
                                                            <i class="fas fa-edit"></i>
                                                        </a>

                                                        <a href="/admin/product/toggle-status/${p.id}"
                                                            class="btn btn-sm ${p.active ? 'btn-danger' : 'btn-success'} me-1"
                                                            title="${p.active ? 'Ngừng kinh doanh' : 'Mở bán lại'}">
                                                            <i class="fas ${p.active ? 'fa-pause' : 'fa-play'}"></i>
                                                        </a>

                                                        <a href="/admin/product/delete/${p.id}"
                                                            class="btn btn-sm btn-outline-danger"
                                                            onclick="return confirm('Bạn có chắc chắn muốn XÓA VĨNH VIỄN? \nLưu ý: Nếu sản phẩm đã có đơn hàng, vui lòng dùng nút Bật/Tắt trạng thái bên cạnh.')">
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

                <div class="modal fade" id="imageModal" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered modal-xl">
                        <div class="modal-content border-0">
                            <div class="modal-header border-bottom bg-light">
                                <h5 class="modal-title fw-bold" id="modalProductName">Chi tiết ảnh sản phẩm</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body p-0">
                                <div class="shopee-modal-content">
                                    <div class="shopee-main-view">
                                        <div id="productCarousel" class="carousel slide" data-bs-ride="false"
                                            data-bs-interval="false">
                                            <div class="carousel-inner" id="carouselInner"></div>
                                            <button class="carousel-control-prev" type="button"
                                                data-bs-target="#productCarousel" data-bs-slide="prev">
                                                <span class="carousel-control-prev-icon"></span>
                                            </button>
                                            <button class="carousel-control-next" type="button"
                                                data-bs-target="#productCarousel" data-bs-slide="next">
                                                <span class="carousel-control-next-icon"></span>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="shopee-side-view">
                                        <h6 class="text-muted mb-3 small fw-bold">DANH SÁCH ẢNH</h6>
                                        <div id="thumbnailList" class="d-flex flex-wrap gap-2"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    // ... (Giữ nguyên script modal ảnh của bạn) ...
                    document.addEventListener("DOMContentLoaded", function () {
                        const imageModalEl = document.getElementById('imageModal');
                        if (imageModalEl) {
                            imageModalEl.addEventListener('show.bs.modal', event => {
                                const button = event.relatedTarget;
                                const imagesString = button.getAttribute('data-images');
                                const productName = button.getAttribute('data-name');
                                const carouselInner = document.getElementById('carouselInner');
                                const thumbnailList = document.getElementById('thumbnailList');
                                const modalTitle = document.getElementById('modalProductName');

                                modalTitle.innerText = productName;
                                carouselInner.innerHTML = "";
                                thumbnailList.innerHTML = "";

                                const images = imagesString.split(',').filter(img => img.trim() !== "");

                                if (images.length > 0) {
                                    images.forEach((imgSrc, index) => {
                                        const activeClass = index === 0 ? 'active' : '';
                                        carouselInner.innerHTML += `<div class="carousel-item \${activeClass}"><img src="\${imgSrc}" class="d-block"></div>`;
                                        const thumbDiv = document.createElement('div');
                                        thumbDiv.className = `thumb-item \${activeClass}`;
                                        thumbDiv.innerHTML = `<img src="\${imgSrc}">`;
                                        thumbDiv.addEventListener('click', () => {
                                            const carousel = new bootstrap.Carousel(document.getElementById('productCarousel'));
                                            carousel.to(index);
                                            document.querySelectorAll('.thumb-item').forEach(t => t.classList.remove('active'));
                                            thumbDiv.classList.add('active');
                                        });
                                        thumbnailList.appendChild(thumbDiv);
                                    });

                                    const myCarousel = document.getElementById('productCarousel');
                                    myCarousel.addEventListener('slid.bs.carousel', function (e) {
                                        const idx = e.to;
                                        document.querySelectorAll('.thumb-item').forEach((t, i) => {
                                            i === idx ? t.classList.add('active') : t.classList.remove('active');
                                        });
                                    });
                                }
                            });
                        }
                    });
                </script>
            </body>

            </html>