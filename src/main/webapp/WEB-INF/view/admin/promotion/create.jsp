<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8">
                    <title>Tạo mới khuyến mại</title>
                    <jsp:include page="../layout/header.jsp" />
                    <style>
                        /* (Giữ nguyên CSS cũ của bạn) */
                        .product-scroll-area {
                            max-height: 450px;
                            overflow-y: auto;
                            overflow-x: hidden;
                            border: 1px solid #dee2e6;
                            border-top: none;
                            border-radius: 0 0 8px 8px;
                            background: #fff;
                        }

                        .product-table-header {
                            background-color: #f8f9fa;
                            border: 1px solid #dee2e6;
                            border-radius: 8px 8px 0 0;
                            padding: 10px;
                            font-weight: bold;
                            color: #495057;
                            font-size: 0.85rem;
                        }

                        .product-item {
                            border-bottom: 1px solid #f0f0f0;
                            padding: 10px;
                            transition: background 0.2s;
                        }

                        .product-item:hover {
                            background-color: #f8f9fa;
                        }

                        .product-item.selected-bg {
                            background-color: #e0f2fe;
                        }

                        .product-img {
                            width: 45px;
                            height: 45px;
                            object-fit: cover;
                            border-radius: 4px;
                            border: 1px solid #e2e8f0;
                        }

                        .form-check-input.big-checkbox {
                            width: 1.3em;
                            height: 1.3em;
                            margin-top: 0;
                            cursor: pointer;
                            border: 2px solid #ced4da;
                        }

                        .form-check-input.big-checkbox:checked {
                            background-color: #0d6efd;
                            border-color: #0d6efd;
                        }

                        .hidden-item {
                            display: none !important;
                        }
                    </style>
                </head>

                <body class="bg-light">
                    <div class="d-flex" id="wrapper">
                        <jsp:include page="../layout/sidebar.jsp">
                            <jsp:param name="active" value="promotion" />
                        </jsp:include>

                        <div id="page-content-wrapper">
                            <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom px-4 py-3">
                                <h4 class="mb-0 fw-bold text-uppercase">Tạo Mới Chiến Dịch</h4>
                            </nav>

                            <div class="container-fluid px-4 py-4">
                                <form:form action="/admin/promotion/create" method="POST" modelAttribute="newPromotion">
                                    <div class="row">
                                        <div class="col-lg-4">
                                            <div class="card shadow-sm border-0 rounded-3 mb-4">
                                                <div class="card-header bg-white py-3">
                                                    <h6 class="m-0 fw-bold text-primary">THÔNG TIN CƠ BẢN</h6>
                                                </div>
                                                <div class="card-body p-4">
                                                    <div class="mb-3">
                                                        <label class="form-label fw-bold small">Tên chiến dịch *</label>
                                                        <form:input path="name" class="form-control" required="true" />
                                                    </div>
                                                    <div class="row mb-3">
                                                        <div class="col-6">
                                                            <label class="form-label fw-bold small">Mức giảm (%)</label>
                                                            <form:input path="discountRate" type="number"
                                                                class="form-control text-danger fw-bold" min="1"
                                                                max="100" value="10" />
                                                        </div>
                                                        <div class="col-6">
                                                            <label class="form-label fw-bold small">Trạng thái</label>
                                                            <form:select path="active" class="form-select">
                                                                <form:option value="true">Kích hoạt</form:option>
                                                                <form:option value="false">Tạm dừng</form:option>
                                                            </form:select>
                                                        </div>
                                                    </div>

                                                    <div class="mb-3">
                                                        <label class="form-label fw-bold small">Bắt đầu (Ngày -
                                                            Giờ)</label>
                                                        <input type="datetime-local" name="startDate"
                                                            class="form-control" required />
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label fw-bold small">Kết thúc (Ngày -
                                                            Giờ)</label>
                                                        <input type="datetime-local" name="endDate" class="form-control"
                                                            required />
                                                    </div>

                                                    <div class="mb-0">
                                                        <label class="form-label fw-bold small">Mô tả</label>
                                                        <form:textarea path="description" class="form-control"
                                                            rows="3" />
                                                    </div>
                                                    <div class="mt-4">
                                                        <button type="submit"
                                                            class="btn btn-primary w-100 fw-bold text-uppercase py-2">
                                                            <i class="fas fa-save me-2"></i> Lưu Chiến Dịch
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-lg-8">
                                            <div class="card shadow-sm border-0 rounded-3 h-100">
                                                <div
                                                    class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                                                    <h6 class="m-0 fw-bold text-primary">PHẠM VI ÁP DỤNG</h6>
                                                    <span class="badge bg-primary rounded-pill">Đã chọn: <span
                                                            id="selectedCount">0</span></span>
                                                </div>
                                                <div class="card-body bg-white">
                                                    <div class="row g-2 mb-3">
                                                        <div class="col-md-4">
                                                            <select id="categoryFilter"
                                                                class="form-select form-select-sm">
                                                                <option value="all">-- Tất cả danh mục --</option>
                                                                <c:forEach var="cat" items="${categories}">
                                                                    <option value="${cat.id}">${cat.name}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <input type="text" id="productSearch"
                                                                class="form-control form-control-sm"
                                                                placeholder="Tìm tên hoặc ID sản phẩm...">
                                                        </div>
                                                    </div>

                                                    <div class="product-table-header d-flex align-items-center">
                                                        <div style="width: 50px;" class="text-center">
                                                            <input class="form-check-input big-checkbox" type="checkbox"
                                                                id="selectAllHeader"
                                                                title="Chọn toàn bộ danh sách đang hiện">
                                                        </div>
                                                        <div style="width: 60px;">Ảnh</div>
                                                        <div class="flex-grow-1 ps-2">Tên sản phẩm</div>
                                                        <div style="width: 100px;" class="text-end">Giá gốc</div>
                                                        <div style="width: 70px;" class="text-center">Kho</div>
                                                        <div style="width: 80px;" class="text-center">TT</div>
                                                    </div>

                                                    <div class="product-scroll-area">
                                                        <c:forEach var="p" items="${products}">
                                                            <c:set var="isSelected" value="false" />
                                                            <c:if test="${newPromotion.products != null}">
                                                                <c:forEach var="promotedP"
                                                                    items="${newPromotion.products}">
                                                                    <c:if test="${promotedP.id == p.id}">
                                                                        <c:set var="isSelected" value="true" />
                                                                    </c:if>
                                                                </c:forEach>
                                                            </c:if>

                                                            <div class="product-item d-flex align-items-center ${isSelected ? 'selected-bg' : ''}"
                                                                data-category-id="${p.category.id}"
                                                                data-product-name="${p.name.toLowerCase()}">

                                                                <div style="width: 50px;" class="text-center">
                                                                    <input
                                                                        class="form-check-input big-checkbox product-checkbox"
                                                                        type="checkbox" name="selectedProducts"
                                                                        value="${p.id}" ${isSelected ? 'checked' : '' }>
                                                                </div>
                                                                <div style="width: 60px;">
                                                                    <img src="/images/${p.image}" class="product-img"
                                                                        onerror="this.src='https://placehold.co/45x45?text=Img'">
                                                                </div>
                                                                <div class="flex-grow-1 ps-2">
                                                                    <div class="fw-bold text-dark small">${p.name}</div>
                                                                    <div class="text-muted" style="font-size: 0.75rem;">
                                                                        #${p.id} | ${p.category.name}</div>
                                                                </div>
                                                                <div style="width: 100px;"
                                                                    class="text-end fw-bold text-primary small">
                                                                    <fmt:formatNumber value="${p.price}" type="currency"
                                                                        currencySymbol="đ" />
                                                                </div>
                                                                <div style="width: 70px;" class="text-center small">
                                                                    ${p.quantity}</div>
                                                                <div style="width: 80px;" class="text-center">
                                                                    <span
                                                                        class="badge ${p.active ? 'bg-success' : 'bg-secondary'} rounded-pill"
                                                                        style="font-size: 0.6rem;">
                                                                        ${p.active ? 'MỞ BÁN' : 'ẨN'}
                                                                    </span>
                                                                </div>
                                                            </div>
                                                        </c:forEach>
                                                        <div id="noResultMsg"
                                                            class="text-center py-4 text-muted hidden-item">Không tìm
                                                            thấy sản phẩm.</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form:form>
                            </div>
                        </div>
                    </div>

                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                    <script>
                        document.addEventListener("DOMContentLoaded", function () {
                            const categoryFilter = document.getElementById('categoryFilter');
                            const productSearch = document.getElementById('productSearch');
                            const productItems = document.querySelectorAll('.product-item');
                            const selectAllHeader = document.getElementById('selectAllHeader');
                            const noResultMsg = document.getElementById('noResultMsg');
                            const selectedCountSpan = document.getElementById('selectedCount');

                            function filterProducts() {
                                const selectedCatId = categoryFilter.value;
                                const keyword = productSearch.value.toLowerCase().trim();
                                let visibleCount = 0;

                                productItems.forEach(item => {
                                    const itemCatId = item.getAttribute('data-category-id');
                                    const itemName = item.getAttribute('data-product-name');
                                    const matchCategory = (selectedCatId === 'all') || (selectedCatId === itemCatId);
                                    const matchKeyword = itemName.includes(keyword);

                                    if (matchCategory && matchKeyword) {
                                        item.classList.remove('hidden-item');
                                        item.classList.add('visible-item');
                                        visibleCount++;
                                    } else {
                                        item.classList.add('hidden-item');
                                        item.classList.remove('visible-item');
                                    }
                                });

                                if (visibleCount === 0) noResultMsg.classList.remove('hidden-item');
                                else noResultMsg.classList.add('hidden-item');
                                updateSelectAllCheckboxState();
                            }

                            function updateSelectAllCheckboxState() {
                                const visibleCheckboxes = document.querySelectorAll('.product-item.visible-item .product-checkbox');
                                if (visibleCheckboxes.length === 0) {
                                    selectAllHeader.checked = false; selectAllHeader.disabled = true; return;
                                }
                                selectAllHeader.disabled = false;
                                const allChecked = Array.from(visibleCheckboxes).every(cb => cb.checked);
                                selectAllHeader.checked = allChecked;
                            }

                            function updateRowStyle(checkbox) {
                                const row = checkbox.closest('.product-item');
                                if (checkbox.checked) row.classList.add('selected-bg');
                                else row.classList.remove('selected-bg');
                                selectedCountSpan.textContent = document.querySelectorAll('.product-checkbox:checked').length;
                            }

                            categoryFilter.addEventListener('change', filterProducts);
                            productSearch.addEventListener('keyup', filterProducts);

                            selectAllHeader.addEventListener('click', function () {
                                const isChecked = this.checked;
                                const visibleCheckboxes = document.querySelectorAll('.product-item.visible-item .product-checkbox');
                                visibleCheckboxes.forEach(cb => {
                                    cb.checked = isChecked;
                                    updateRowStyle(cb);
                                });
                            });

                            document.querySelectorAll('.product-checkbox').forEach(cb => {
                                cb.addEventListener('change', function () {
                                    updateRowStyle(this);
                                    updateSelectAllCheckboxState();
                                });
                            });

                            filterProducts();
                            document.querySelectorAll('.product-checkbox:checked').forEach(cb => updateRowStyle(cb));
                        });
                    </script>
                </body>

                </html>