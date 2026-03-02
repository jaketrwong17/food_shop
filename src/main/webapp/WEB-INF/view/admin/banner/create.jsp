<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

        <!DOCTYPE html>
        <html lang="vi">
        <jsp:include page="../layout/header.jsp" />

        <style>
            .img-card {
                position: relative;
                width: 300px;
                /* Banner thường dài nên để preview rộng hơn */
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
                background: rgba(255, 0, 0, 0.8);
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
                        <h4 class="mb-0 text-dark fw-bold">Thêm Banner Mới</h4>
                    </nav>

                    <div class="container-fluid px-4 py-4">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="card shadow-sm border-0 rounded-3">
                                    <div class="card-body p-4">
                                        <form:form action="/admin/banner/create" method="POST"
                                            modelAttribute="newBanner" enctype="multipart/form-data">

                                            <div class="mb-3">
                                                <label class="form-label fw-bold">Tên Banner (Ví dụ: Siêu sale mùng 5/5)
                                                    <span class="text-danger">*</span></label>
                                                <form:input path="name" class="form-control form-control-lg"
                                                    required="true" />
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label fw-bold">Hình ảnh Banner <span
                                                        class="text-danger">*</span></label>
                                                <div class="d-flex gap-2 align-items-center">
                                                    <div id="previewContainer" style="display: none;">
                                                        <div class="img-card">
                                                            <img id="imgPreview" src="" alt="Preview">
                                                            <button type="button" class="btn-delete-img"
                                                                onclick="removePreview()">
                                                                <i class="fas fa-times"></i>
                                                            </button>
                                                        </div>
                                                    </div>

                                                    <label class="upload-btn-wrapper" for="imgFile" id="uploadBtnLabel">
                                                        <div class="text-center">
                                                            <i class="fas fa-image fa-2x mb-2"></i>
                                                            <div>Chọn ảnh Banner</div>
                                                        </div>
                                                    </label>
                                                </div>
                                                <input type="file" id="imgFile" name="imgFile"
                                                    accept=".png, .jpg, .jpeg" style="display: none;"
                                                    onchange="previewImage(this)" required>
                                                <div class="form-text mt-2 text-primary">Khuyên dùng ảnh tỷ lệ ngang (Ví
                                                    dụ: 1200x400px)</div>
                                            </div>

                                            <div class="mb-4">
                                                <label class="form-label fw-bold">Đường dẫn khi khách click vào
                                                    (Link)</label>
                                                <form:input path="link" class="form-control"
                                                    placeholder="Ví dụ: /product/1 hoặc https://..." />
                                                <div class="form-text mt-1 text-muted">Có thể để trống.</div>
                                            </div>

                                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                                <a href="/admin/banner" class="btn btn-light px-4">Hủy bỏ</a>
                                                <button type="submit" class="btn btn-primary px-5 fw-bold">Lưu
                                                    Banner</button>
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
                    const previewContainer = document.getElementById('previewContainer');
                    const imgPreview = document.getElementById('imgPreview');
                    const uploadBtnLabel = document.getElementById('uploadBtnLabel');

                    if (input.files && input.files[0]) {
                        const reader = new FileReader();
                        reader.onload = function (e) {
                            imgPreview.src = e.target.result;
                            previewContainer.style.display = 'block';
                            uploadBtnLabel.style.display = 'none';
                        }
                        reader.readAsDataURL(input.files[0]);
                    }
                }

                function removePreview() {
                    document.getElementById('imgFile').value = "";
                    document.getElementById('previewContainer').style.display = 'none';
                    document.getElementById('uploadBtnLabel').style.display = 'flex';
                }
            </script>
        </body>

        </html>