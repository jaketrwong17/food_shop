<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <title>Hồ sơ cá nhân - 16Home</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
                <style>
                    body {
                        background-color: #f5f5fa;
                        min-height: 100vh;
                        display: flex;
                        flex-direction: column;
                    }

                    .main-wrapper {
                        flex: 1;
                    }

                    .content-box {
                        background: #fff;
                        border-radius: 8px;
                        box-shadow: 0 .125rem .25rem rgba(0, 0, 0, .075);
                        padding: 1.5rem;
                        min-height: 100%;
                    }

                    .form-label-custom {
                        color: #6c757d;
                        font-weight: 500;
                    }
                </style>
            </head>

            <body>
                <jsp:include page="../layout/header.jsp" />

                <div class="main-wrapper">
                    <div class="container mt-4 mb-5">
                        <nav aria-label="breadcrumb" class="mb-4">
                            <ol class="breadcrumb mb-0">
                                <li class="breadcrumb-item"><a href="/" class="text-decoration-none text-muted">Trang
                                        chủ</a></li>
                                <li class="breadcrumb-item active text-primary">Thông tin tài khoản</li>
                            </ol>
                        </nav>

                        <div class="row g-4">
                            <div class="col-lg-3">
                                <jsp:include page="sidebar.jsp">
                                    <jsp:param name="activePage" value="profile" />
                                </jsp:include>
                            </div>

                            <div class="col-lg-9">
                                <div class="content-box">
                                    <h5 class="fw-bold text-uppercase mb-4 pb-3 border-bottom text-primary">
                                        <i class="fas fa-user-circle me-2"></i>Hồ sơ của tôi
                                    </h5>

                                    <c:if test="${not empty successMsg}">
                                        <div class="alert alert-success alert-dismissible fade show mb-4" role="alert">
                                            <i class="fas fa-check-circle me-2"></i> ${successMsg}
                                            <button type="button" class="btn-close" data-bs-dismiss="alert"
                                                aria-label="Close"></button>
                                        </div>
                                    </c:if>

                                    <c:if test="${not empty errorMsg}">
                                        <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
                                            <i class="fas fa-exclamation-circle me-2"></i> ${errorMsg}
                                            <button type="button" class="btn-close" data-bs-dismiss="alert"
                                                aria-label="Close"></button>
                                        </div>
                                    </c:if>
                                    <form:form action="/profile" method="post" modelAttribute="user">
                                        <div class="row mb-4 align-items-center">
                                            <label class="col-md-3 text-md-end form-label-custom">Email</label>
                                            <div class="col-md-8">
                                                <form:input path="email" class="form-control bg-light"
                                                    readonly="true" />
                                            </div>
                                        </div>
                                        <div class="row mb-4 align-items-center">
                                            <label class="col-md-3 text-md-end form-label-custom">Họ và tên</label>
                                            <div class="col-md-8">
                                                <form:input path="fullName" class="form-control" />
                                            </div>
                                        </div>
                                        <div class="row mb-4 align-items-center">
                                            <label class="col-md-3 text-md-end form-label-custom">Số điện thoại</label>
                                            <div class="col-md-8">
                                                <form:input path="phone" class="form-control" type="tel"
                                                    pattern="0[0-9]{9}"
                                                    title="Số điện thoại phải bắt đầu bằng số 0 và đủ 10 chữ số"
                                                    required="true" />
                                            </div>
                                        </div>
                                        <div class="row mb-4">
                                            <label class="col-md-3 text-md-end mt-2 form-label-custom">Địa chỉ</label>
                                            <div class="col-md-8">
                                                <form:textarea path="address" class="form-control" rows="3" />
                                            </div>
                                        </div>
                                        <div class="row mt-5">
                                            <div class="col-md-8 offset-md-3">
                                                <button type="submit"
                                                    class="btn btn-primary px-5 rounded-pill fw-bold">Lưu thay
                                                    đổi</button>
                                            </div>
                                        </div>
                                    </form:form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <jsp:include page="../layout/footer.jsp" />


            </body>

            </html>