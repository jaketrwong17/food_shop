<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <jsp:include page="../layout/header.jsp" />
                <style>
                    .category-scroll {
                        max-height: 250px;
                        overflow-y: auto;
                        border: 1px solid #dee2e6;
                        padding: 15px;
                        border-radius: 8px;
                        background-color: #f8f9fa;
                    }

                    .category-item {
                        padding: 8px;
                        border-bottom: 1px solid #eee;
                        transition: background-color 0.2s;
                    }

                    .category-item:hover {
                        background-color: #fff;
                    }

                    .category-item:last-child {
                        border-bottom: none;
                    }

                    #page-content-wrapper {
                        background-color: #f4f7f6;
                        min-height: 100vh;
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
                            <div class="card shadow-sm border-0 rounded-3">
                                <div class="card-header bg-white py-3 border-bottom">
                                    <h5 class="mb-0 fw-bold text-warning">
                                        <i class="fas fa-edit me-2"></i>Cập nhật Mã giảm giá
                                    </h5>
                                </div>

                                <div class="card-body p-4">
                                    <form:form method="post" action="/admin/voucher/update" modelAttribute="newVoucher">
                                        <form:hidden path="id" />

                                        <div class="row g-4">
                                            <div class="col-md-6">
                                                <label class="form-label fw-bold">Tên mã (Code):</label>
                                                <form:input path="code" class="form-control" required="true"
                                                    placeholder="Ví dụ: WOLF2026" />
                                            </div>

                                            <div class="col-md-6">
                                                <label class="form-label fw-bold">Phần trăm giảm (%):</label>
                                                <form:input type="number" path="discount" class="form-control"
                                                    required="true" min="1" max="100" />
                                            </div>

                                            <div class="col-12">
                                                <div class="form-check form-switch mb-3 p-0 ps-5">
                                                    <form:checkbox path="all" class="form-check-input ms-n5"
                                                        id="isAllVoucher" />
                                                    <label class="form-check-label fw-bold text-primary"
                                                        for="isAllVoucher">
                                                        Áp dụng cho TOÀN BỘ sản phẩm trên sàn
                                                    </label>
                                                </div>

                                                <div id="categorySection" class="mt-3">
                                                    <label class="form-label fw-bold d-block mb-2">Chọn danh mục áp
                                                        dụng:</label>
                                                    <div class="category-scroll shadow-sm">
                                                        <div class="row">
                                                            <c:forEach var="cat" items="${categories}">
                                                                <div class="col-md-4 category-item">
                                                                    <div class="form-check">
                                                                        <input class="form-check-input" type="checkbox"
                                                                            name="appliedCategories" value="${cat.id}"
                                                                            id="cat-${cat.id}" <c:forEach var="vCat"
                                                                            items="${newVoucher.categories}">
                                                                        <c:if test="${vCat.id == cat.id}">checked</c:if>
                                                            </c:forEach>
                                                            >
                                                            <label class="form-check-label text-truncate w-100"
                                                                for="cat-${cat.id}">
                                                                ${cat.name}
                                                            </label>
                                                        </div>
                                                    </div>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </div>
                                </div>

                                <div class="col-12 text-end mt-4 pt-3 border-top">
                                    <a href="/admin/voucher" class="btn btn-light px-4 me-2 border">Quay lại</a>
                                    <button type="submit" class="btn btn-warning px-5 shadow fw-bold text-dark">
                                        Cập nhật mã
                                    </button>
                                </div>
                            </div>
                            </form:form>
                        </div>
                    </div>
                </div>
                </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        const isAllSwitch = document.getElementById('isAllVoucher');
                        const categoryBox = document.getElementById('categorySection');

                        function toggleCategoryUI() {
                            if (isAllSwitch.checked) {
                                categoryBox.style.opacity = "0.4";
                                categoryBox.style.pointerEvents = "none";
                            } else {
                                categoryBox.style.opacity = "1";
                                categoryBox.style.pointerEvents = "auto";
                            }
                        }

                        isAllSwitch.addEventListener('change', toggleCategoryUI);
                        toggleCategoryUI();
                    });
                </script>
            </body>

            </html>