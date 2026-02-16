<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

        <!DOCTYPE html>
        <html lang="vi">
        <jsp:include page="../layout/header.jsp" />

        <style>
            .img-card {
                position: relative;
                width: 100px;
                height: 100px;
                border: 1px solid #ddd;
                border-radius: 8px;
                overflow: hidden;
                background: #fff;
            }

            .img-card img {
                width: 100%;
                height: 100%;
                object-fit: contain;
            }

            .upload-btn-wrapper {
                width: 100px;
                height: 100px;
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
                top: 0;
                right: 0;
                background: rgba(255, 0, 0, 0.8);
                color: white;
                border: none;
                width: 20px;
                height: 20px;
                font-size: 10px;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
            }
        </style>

        <body>
            <div class="d-flex" id="wrapper">
                <jsp:include page="../layout/sidebar.jsp">
                    <jsp:param name="active" value="category" />
                </jsp:include>

                <div id="page-content-wrapper">
                    <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom px-4 py-3">
                        <h4 class="mb-0 text-dark fw-bold">Thêm Danh Mục Mới</h4>
                    </nav>

                    <div class="container-fluid px-4 py-4">
                        <div class="row justify-content-center">
                            <div class="col-lg-6">
                                <div class="card shadow-sm border-0 rounded-3">
                                    <div class="card-body p-4">
                                        <form:form action="/admin/category/create" method="POST"
                                            modelAttribute="newCategory" enctype="multipart/form-data">

                                            <div class="mb-3">
                                                <label class="form-label fw-bold">Tên danh mục <span
                                                        class="text-danger">*</span></label>
                                                <form:input path="name" class="form-control form-control-lg"
                                                    required="true" />
                                                <form:errors path="name" cssClass="text-danger" />
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label fw-bold">Biểu tượng (Icon)</label>
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
                                                        <i class="fas fa-plus fa-2x"></i>
                                                    </label>
                                                </div>
                                                <input type="file" id="imgFile" name="imgFile"
                                                    accept=".png, .jpg, .jpeg" style="display: none;"
                                                    onchange="previewImage(this)">
                                                <div class="form-text mt-2">Nên chọn ảnh vuông (VD: 64x64px)</div>
                                            </div>

                                            <div class="mb-4">
                                                <label class="form-label fw-bold">Mô tả</label>
                                                <form:textarea path="description" class="form-control" rows="4" />
                                            </div>

                                            <div class="d-grid gap-2">
                                                <button type="submit" class="btn btn-primary btn-lg">Lưu danh
                                                    mục</button>
                                                <a href="/admin/category"
                                                    class="btn btn-light btn-lg text-secondary">Hủy bỏ</a>
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
            // ... Thay thế đoạn script cũ bằng đoạn này ...
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

                // Xóa preview không cần hỏi
                function removePreview() {
                    document.getElementById('imgFile').value = "";
                    document.getElementById('previewContainer').style.display = 'none';
                    document.getElementById('uploadBtnLabel').style.display = 'flex';
                }
            </script>
        </body>

        </html>