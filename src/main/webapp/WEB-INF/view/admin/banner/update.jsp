<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

            <!DOCTYPE html>
            <html lang="vi">
            <jsp:include page="../layout/header.jsp" />

            <style>
                .img-card {
                    position: relative;
                    width: 300px;
                    height: 120px;
                    border: 1px solid #ddd;
                    border-radius: 8px;
                    overflow: hidden;
                    background: #fff;
                }

                .img-card img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }

                .upload-btn-wrapper {
                    width: 300px;
                    height: 120px;
                    border: 2px dashed #0d6efd;
                    border-radius: 8px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    cursor: pointer;
                    color: #0d6efd;
                    background: #f8f9fa;
                    transition: 0.2s;
                }

                .upload-btn-wrapper:hover {
                    background: #e9ecef;
                }

                .btn-delete-img {
                    position: absolute;
                    top: 5px;
                    right: 5px;
                    background: rgba(220, 53, 69, 0.9);
                    color: white;
                    border: none;
                    border-radius: 50%;
                    width: 24px;
                    height: 24px;
                    font-size: 12px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    cursor: pointer;
                }
            </style>

            <body>
                <div class="d-flex" id="wrapper">
                    <jsp:include page="../layout/sidebar.jsp">
                        <jsp:param name="active" value="banner" />
                    </jsp:include>

                    <div id="page-content-wrapper">
                        <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom px-4 py-3">
                            <h4 class="mb-0 text-dark fw-bold">Cập nhật Banner</h4>
                        </nav>

                        <div class="container-fluid px-4 py-4">
                            <div class="row justify-content-center">
                                <div class="col-lg-8">
                                    <div class="card shadow-sm border-0 rounded-3">
                                        <div class="card-body p-4">
                                            <form:form action="/admin/banner/update" method="POST"
                                                modelAttribute="newBanner" enctype="multipart/form-data">

                                                <form:hidden path="id" />

                                                <div class="mb-3">
                                                    <label class="form-label fw-bold">Tên Banner <span
                                                            class="text-danger">*</span></label>
                                                    <form:input path="name" class="form-control form-control-lg"
                                                        required="true" />
                                                </div>

                                                <div class="mb-3">
                                                    <label class="form-label fw-bold">Đường dẫn khi khách click vào
                                                        (Link)</label>
                                                    <form:input path="link" class="form-control" />
                                                </div>

                                                <div class="mb-4">
                                                    <label class="form-label fw-bold">Trạng thái hiển thị trên Trang
                                                        chủ</label>
                                                    <form:select path="active" class="form-select w-50">
                                                        <form:option value="true">Bật (Hiển thị)</form:option>
                                                        <form:option value="false">Tắt (Ẩn đi)</form:option>
                                                    </form:select>
                                                </div>

                                                <div class="mb-4 border-top pt-3">
                                                    <label class="form-label fw-bold">Cập nhật hình ảnh (Tùy
                                                        chọn)</label>
                                                    <div class="d-flex gap-3 align-items-start mt-2">

                                                        <div class="img-card" id="currentImageContainer">
                                                            <img src="/images/${newBanner.imageUrl}"
                                                                alt="Banner hiện tại">
                                                        </div>

                                                        <div id="previewContainer" style="display: none;">
                                                            <div class="img-card border-primary border-2">
                                                                <img id="imgPreview" src="" alt="Preview">
                                                                <button type="button" class="btn-delete-img"
                                                                    onclick="removePreview()">
                                                                    <i class="fas fa-times"></i>
                                                                </button>
                                                            </div>
                                                        </div>

                                                        <label class="upload-btn-wrapper" for="imgFile"
                                                            id="uploadBtnLabel">
                                                            <div class="text-center">
                                                                <i class="fas fa-cloud-upload-alt fa-2x mb-1"></i>
                                                                <div style="font-size: 13px;">Chọn ảnh mới để thay thế
                                                                </div>
                                                            </div>
                                                        </label>
                                                    </div>

                                                    <input type="file" id="imgFile" name="imgFile" accept="image/*"
                                                        style="display: none;" onchange="previewImage(this)" />
                                                    <div class="form-text mt-2 text-muted">
                                                        <i class="fas fa-info-circle me-1"></i>Để trống phần này nếu bạn
                                                        muốn giữ nguyên hình ảnh cũ.
                                                    </div>
                                                </div>

                                                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                                    <a href="/admin/banner" class="btn btn-light px-4">Hủy bỏ</a>
                                                    <button type="submit"
                                                        class="btn btn-warning px-5 fw-bold text-white">Cập
                                                        nhật</button>
                                                </div>
                                            </form:form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    function previewImage(input) {
                        if (input.files && input.files[0]) {
                            const reader = new FileReader();
                            reader.onload = function (e) {
                                document.getElementById('imgPreview').src = e.target.result;
                                document.getElementById('previewContainer').style.display = 'block';
                                document.getElementById('uploadBtnLabel').style.display = 'none';

                                // Ẩn ảnh cũ đi khi chọn ảnh mới
                                const currentImg = document.getElementById('currentImageContainer');
                                if (currentImg) currentImg.style.display = 'none';
                            }
                            reader.readAsDataURL(input.files[0]);
                        }
                    }

                    function removePreview() {
                        document.getElementById('imgFile').value = "";
                        document.getElementById('previewContainer').style.display = 'none';
                        document.getElementById('uploadBtnLabel').style.display = 'flex';

                        // Hiện lại ảnh cũ khi hủy bỏ ảnh preview
                        const currentImg = document.getElementById('currentImageContainer');
                        if (currentImg) currentImg.style.display = 'block';
                    }
                </script>
            </body>

            </html>