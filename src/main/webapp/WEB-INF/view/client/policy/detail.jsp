<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


        <!DOCTYPE html>
        <html lang="vi">



        <head>

            <meta charset="UTF-8">
            <title>${policy.name} - GreenFood</title>

            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

            <jsp:include page="../layout/header.jsp" />

        </head>



        <body style="background-color: #f5f6fa;">
            <%-- <jsp:include page="../../layout/navbar.jsp" /> --%>

            <div class="container mt-4 mb-3">
                <div class="fs-6">
                    <a href="/" class="text-decoration-none text-dark">Trang chủ</a>
                    <span class="text-muted mx-2">/</span>
                    <span style="color: #3c8a2e;">${policy.name}</span>
                </div>
            </div>

            <div class="container mb-5">
                <div class="card border-0 shadow-sm rounded-3">
                    <div class="card-body p-4 p-md-5">
                        <h3 class="text-center fw-bold text-uppercase mb-4" style="color: #212529;">
                            ${policy.name}
                        </h3>

                        <div class="policy-content" style="line-height: 1.8; color: #333;">
                            ${policy.content}
                        </div>
                    </div>
                </div>
            </div>


            <jsp:include page="../layout/footer.jsp" />


        </body>



        </html>