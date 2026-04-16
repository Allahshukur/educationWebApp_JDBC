<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Assignment Data
    String[][] assignments = {
        {"Java Layihə 1", "Java Əsasları", "Əli Əliyev", "15 Aprel", "graded", "Klassik kalkulyator proqramı yazın", "90/100", "indigo"},
        {"HTML Portfolio", "HTML & CSS", "Nigar Hüseynova", "18 Aprel", "pending", "Şəxsi portfel vebsəhifəsi yaradın", "", "amber"},
        {"Python Skript", "Python", "Sevinc Quliyeva", "20 Aprel", "submitted", "CSV faylı emalı proqramı", "", "sky"},
        {"OOP Sinif Dizaynı", "OOP Konseptləri", "Əli Əliyev", "22 Aprel", "graded", "Bank hesab idarə sistemi", "85/100", "teal"},
        {"Spring REST API", "Spring Framework", "Rauf Məmmədov", "25 Aprel", "pending", "Şəhər məlumatları API-si", "", "violet"},
        {"JavaScript DOM", "JavaScript", "Nigar Hüseynova", "28 Aprel", "submitted", "İnteraktiv TODO siyahısı", "", "rose"},
        {"React Komponent", "React.js", "Nigar Hüseynova", "30 Aprel", "pending", "Saat komponentini yaradın", "", "orange"},
        {"Verilənlər Bazası", "VB", "Rauf Məmmədov", "5 May", "pending", "E-ticarət bazası seması", "", "green"}
    };
%>
<!DOCTYPE html>
<html lang="az">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tapşırıqlar — Education App</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css?v=3.5">
    <link rel="stylesheet" href="css/dark-mode.css?v=1.0">
    <link rel="stylesheet" href="css/edu-features.css?v=1.0">
    <link rel="stylesheet" href="css/assignments.css?v=1.0">
</head>
<body>
<%
    request.setAttribute("pageLabel", "Tapşırıqlar");
    request.setAttribute("isHome", false);
%>

<jsp:include page="header.jsp" />

<!-- Hero Section -->
<div class="edu-hero edu-hero-assignments">
    <div class="container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb breadcrumb-dark">
                <li class="breadcrumb-item"><a href="index.jsp">Anasəhfə</a></li>
                <li class="breadcrumb-item active">Tapşırıqlar</li>
            </ol>
        </nav>
        <div class="row align-items-center">
            <div class="col-lg-7">
                <h1 class="display-5 fw-900 mb-3">
                    <i class="bi bi-journal-check me-2"></i>Tapşırıqlar
                </h1>
                <p class="lead text-muted">Müəllimlər tərəfindən verilmiş tapşırıqları izlə</p>
            </div>
            <div class="col-lg-5">
                <div class="d-flex gap-2 flex-wrap">
                    <div class="hero-stat">
                        <span>8</span><br>
                        Cəmi
                    </div>
                    <div class="hero-stat">
                        <span>3</span><br>
                        Gözləyir
                    </div>
                    <div class="hero-stat">
                        <span>3</span><br>
                        Təqdim
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Main Content -->
<div class="edu-main">
    <div class="container">

        <!-- Filter Bar -->
        <div class="row mb-4 g-3">
            <div class="col-12 col-md-6 col-lg-4">
                <label class="form-label small fw-600 text-muted">Vəziyyət</label>
                <select class="form-select" id="statusFilter" onchange="applyFilters()">
                    <option value="">Hamısı</option>
                    <option value="pending">Gözləyir</option>
                    <option value="submitted">Təqdim Edildi</option>
                    <option value="graded">Qiymətləndirildi</option>
                </select>
            </div>
            <div class="col-12 col-md-6 col-lg-4">
                <label class="form-label small fw-600 text-muted">Kurs</label>
                <select class="form-select" id="courseFilter" onchange="applyFilters()">
                    <option value="">Hamısı</option>
                    <option value="Java Əsasları">Java Əsasları</option>
                    <option value="HTML & CSS">HTML & CSS</option>
                    <option value="Python">Python</option>
                    <option value="OOP Konseptləri">OOP Konseptləri</option>
                    <option value="Spring Framework">Spring Framework</option>
                    <option value="JavaScript">JavaScript</option>
                    <option value="React.js">React.js</option>
                    <option value="VB">Verilənlər Bazası</option>
                </select>
            </div>
            <div class="col-12 col-lg-4 d-flex align-items-end">
                <button class="btn btn-outline-secondary w-100" onclick="resetFilters()">
                    <i class="bi bi-arrow-clockwise me-1"></i>Sıfırla
                </button>
            </div>
        </div>

        <!-- Stats Row -->
        <div class="row g-3 mb-4">
            <div class="col-6 col-md-3">
                <div class="stat-card">
                    <h6 class="text-muted">Cəmi</h6>
                    <div class="stat-number">8</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-card pending">
                    <h6 class="text-muted">Gözləyir</h6>
                    <div class="stat-number">3</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-card submitted">
                    <h6 class="text-muted">Təqdim</h6>
                    <div class="stat-number">3</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-card graded">
                    <h6 class="text-muted">Qiymət</h6>
                    <div class="stat-number">2</div>
                </div>
            </div>
        </div>

        <!-- Assignments Grid -->
        <div class="row g-4" id="assignmentsContainer">
            <%
                for (int i = 0; i < assignments.length; i++) {
                    String[] a = assignments[i];
                    String title = a[0];
                    String course = a[1];
                    String teacher = a[2];
                    String dueDate = a[3];
                    String status = a[4];
                    String desc = a[5];
                    String score = a[6];
                    String color = a[7];

                    String statusText = "";
                    String statusClass = "";
                    if ("pending".equals(status)) {
                        statusText = "Gözləyir";
                        statusClass = "pending";
                    } else if ("submitted".equals(status)) {
                        statusText = "Təqdim Edildi";
                        statusClass = "submitted";
                    } else if ("graded".equals(status)) {
                        statusText = "Qiymətləndirildi";
                        statusClass = "graded";
                    }

                    // Map color name to hex for badge
                    String badgeColor = "#4f46e5";
                    if ("amber".equals(color)) badgeColor = "#f59e0b";
                    else if ("sky".equals(color)) badgeColor = "#0ea5e9";
                    else if ("teal".equals(color)) badgeColor = "#14b8a6";
                    else if ("violet".equals(color)) badgeColor = "#a855f7";
                    else if ("rose".equals(color)) badgeColor = "#f43f5e";
                    else if ("orange".equals(color)) badgeColor = "#f97316";
                    else if ("green".equals(color)) badgeColor = "#10b981";
            %>
            <div class="col-12 col-md-6 col-lg-4 assignment-item" data-status="<%= status %>" data-course="<%= course %>">
                <div class="edu-card assignment-card <%= color %>">
                    <div class="card-body">
                        <!-- Header -->
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <div>
                                <span class="badge me-2" style="font-size: 0.75rem; background: <%= badgeColor %>; color: #fff;">
                                    <%= course %>
                                </span>
                                <span class="status-badge <%= statusClass %>">
                                    <i class="bi bi-<% if ("pending".equals(status)) { %>clock<% } else if ("submitted".equals(status)) { %>check-circle<% } else { %>star-fill<% } %>"></i>
                                    <%= statusText %>
                                </span>
                            </div>
                        </div>

                        <!-- Title and Description -->
                        <h6 class="fw-800 mb-2 assignment-title"><%= title %></h6>
                        <p class="text-muted small assignment-desc"><%= desc %></p>

                        <!-- Meta Information -->
                        <div class="assignment-meta mb-3">
                            <p class="mb-1">
                                <i class="bi bi-person-fill me-1"></i><strong><%= teacher %></strong>
                            </p>
                            <p class="mb-0">
                                <i class="bi bi-calendar-event me-1"></i>Vaxt: <strong><%= dueDate %></strong>
                            </p>
                        </div>

                        <!-- Action Button -->
                        <div class="d-grid">
                            <% if ("pending".equals(status)) { %>
                                <button class="btn btn-sm btn-primary" onclick="openSubmitModal('<%= title %>')">
                                    <i class="bi bi-cloud-upload me-1"></i>Təqdim Et
                                </button>
                            <% } else if ("submitted".equals(status)) { %>
                                <button class="btn btn-sm btn-outline-secondary" disabled>
                                    <i class="bi bi-eye me-1"></i>Baxışda
                                </button>
                            <% } else { %>
                                <button class="btn btn-sm btn-outline-success" disabled>
                                    <i class="bi bi-award me-1"></i>Qiymət: <%= score %>
                                </button>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
        </div>

    </div>
</div>

<!-- Submit Modal -->
<div class="modal fade" id="submitModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content edu-card">
            <div class="modal-header border-0">
                <h5 class="modal-title fw-800">Tapşırığı Təqdim Et</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Bağla"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label class="form-label small fw-600">Tapşırığın Adı</label>
                    <input type="text" class="form-control" id="assignmentName" disabled>
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-600">Qeydlər (İxtiyari)</label>
                    <textarea class="form-control" id="assignmentNotes" rows="3" placeholder="Tapşırığınız haqqında qeydlər qeyd edin..."></textarea>
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-600">Faylı Əlavə Et</label>
                    <div class="border-2 border-dashed rounded-2 p-4 text-center" style="cursor: pointer; transition: all 0.2s;" onmouseover="this.style.borderColor='#4f46e5'; this.style.backgroundColor='rgba(79,70,229,.05)'" onmouseout="this.style.borderColor=''; this.style.backgroundColor=''">
                        <i class="bi bi-cloud-upload text-muted" style="font-size: 2rem;"></i>
                        <p class="text-muted small mt-2 mb-0">Sürüklə və buraya at<br>və ya klik et</p>
                        <input type="file" style="display: none;">
                    </div>
                </div>
            </div>
            <div class="modal-footer border-0">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Ləğv Et</button>
                <button type="button" class="btn btn-primary" onclick="submitAssignment()">
                    <i class="bi bi-check-circle me-1"></i>Təqdim Et
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Success Toast -->
<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11;">
    <div class="toast" id="successToast" role="alert">
        <div class="toast-header bg-success text-white border-0">
            <i class="bi bi-check-circle me-2"></i>
            <strong class="me-auto">Uğurlu</strong>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
        </div>
        <div class="toast-body">
            Tapşırıq uğurla təqdim edildi!
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script src="js/script.js?v=2.2"></script>
<script src="js/assignments.js?v=1.0"></script>

</body>
</html>
