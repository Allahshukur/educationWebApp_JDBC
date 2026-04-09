<%@ page import="java.util.List" %>
<%@ page import="com.sukur.educationwebapp.teacher.entity.Teacher" %>
<%@ page import="com.sukur.educationwebapp.teacher.service.TeacherService" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String idParam  = request.getParameter("id");
    int teacherId   = 0;
    Teacher teacher = null;

    if (idParam != null) {
        try { teacherId = Integer.parseInt(idParam); } catch (NumberFormatException ignored) {}
    }

    TeacherService teacherService = new TeacherService();
    List<Teacher> allTeachers = teacherService.findAll();
    for (Teacher t : allTeachers) {
        if (t.getId() == teacherId) { teacher = t; break; }
    }

    String fullName   = (teacher != null) ? teacher.getName() + " " + teacher.getSurname() : "Müəllim Tapılmadı";
    String initials   = (teacher != null && teacher.getName().length() > 0 && teacher.getSurname().length() > 0)
                        ? (teacher.getName().substring(0,1) + teacher.getSurname().substring(0,1)).toUpperCase() : "?";
    String studentStr = (teacher != null && teacher.getStudent() != null && !teacher.getStudent().equals("0"))
                        ? teacher.getStudent() : null;
    int studentCount  = 0;
    if (studentStr != null) {
        studentCount = studentStr.split(",").length;
    }
%>
<!DOCTYPE html>
<html lang="az">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= fullName %> — Müəllim Profili</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="css/style.css?v=4.3" rel="stylesheet">
    <link href="css/dark-mode.css?v=2.1" rel="stylesheet">
    <link href="css/teacher-page.css?v=1.0" rel="stylesheet">
</head>
<body class="overflow-hidden-init" style="background:#f8fafc;">

<div id="loader">
    <div class="loader-content">
        <div class="loader-circle"></div>
        <div class="loader-circle"></div>
        <div class="loader-circle"></div>
        <div class="loader-subtext">Müəllim profili yüklənir...</div>
    </div>
</div>

<%
    request.setAttribute("pageLabel", fullName);
    request.setAttribute("isHome", true);
%>
<jsp:include page="header.jsp"/>

<!-- 3-səviyyəli breadcrumb -->
<div class="page-breadcrumb-bar bg-light border-bottom">
    <div class="container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item">
                    <a href="index.jsp" class="text-decoration-none"><i class="bi bi-house"></i>Ana Səhifə</a>
                </li>
                <li class="breadcrumb-item">
                    <a href="teachers.jsp" class="text-decoration-none"><i class="bi bi-person-workspace"></i>Müəllimlər</a>
                </li>
                <li class="breadcrumb-item active" aria-current="page">
                    <i class="bi bi-person-badge"></i><%= fullName %>
                </li>
            </ol>
        </nav>
    </div>
</div>

<% if (teacher == null) { %>
<div class="container py-5 mt-5">
    <div class="tp-not-found">
        <div class="tp-not-found-icon"><i class="bi bi-person-x"></i></div>
        <h3 class="fw-bold text-dark mb-2">Müəllim Tapılmadı</h3>
        <p class="text-muted mb-4">ID: <strong><%= idParam %></strong> olan müəllim mövcud deyil.</p>
        <a href="teachers.jsp" class="btn rounded-pill px-4 text-white" style="background:#0d9488;">
            <i class="bi bi-arrow-left me-2"></i>Müəllimlər Siyahısına Qayıt
        </a>
    </div>
</div>
<% } else { %>

<!-- ════════════════ HERO ════════════════ -->
<div class="tp-hero">
    <div class="tp-hero-blob"></div>
    <div class="container position-relative">
        <div class="d-flex flex-column flex-md-row align-items-center align-items-md-start gap-4">

            <!-- Avatar -->
            <div class="tp-avatar-wrap flex-shrink-0">
                <div class="tp-avatar-ring"></div>
                <div class="tp-avatar-ring2"></div>
                <div class="tp-avatar"><%= initials %></div>
                <div class="tp-avatar-edit" title="Şəkil yüklə"><i class="bi bi-camera-fill"></i></div>
            </div>

            <!-- Ad / badges -->
            <div class="text-center text-md-start flex-grow-1">
                <div class="d-flex flex-wrap gap-2 justify-content-center justify-content-md-start mb-2">
                    <span class="tp-id-badge"><i class="bi bi-hash"></i><%= teacher.getId() %></span>
                    <span class="tp-hero-status"><i class="bi bi-circle-fill" style="font-size:7px;"></i>Aktiv Müəllim</span>
                    <span class="tp-hero-exp"><i class="bi bi-award-fill"></i>5+ il Təcrübə</span>
                </div>
                <div class="tp-hero-name mb-1"><%= teacher.getName() %> <%= teacher.getSurname() %></div>
                <div class="tp-hero-sub mb-1">
                    <i class="bi bi-briefcase me-1"></i>Senior Java Developer &amp; Müəllim
                    &nbsp;·&nbsp;<i class="bi bi-geo-alt me-1"></i>Bakı, Azərbaycan
                </div>
                <div class="tp-hero-sub">
                    <i class="bi bi-envelope me-1"></i><%= teacher.getEmail() %>
                    &nbsp;·&nbsp;<i class="bi bi-people me-1"></i><%= studentCount %> tələbə
                </div>
                <div class="mt-3">
                    <a href="teachers.jsp" class="tp-back-btn">
                        <i class="bi bi-arrow-left"></i>Müəllimlər siyahısı
                    </a>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- ════════════════ CONTENT ════════════════ -->
<div class="tp-content">
    <div class="container pb-5">

        <!-- ── Stat kartlar ── -->
        <div class="row g-3 mb-4">
            <div class="col-6 col-md-3">
                <div class="tp-stat">
                    <div class="tp-stat-icon" style="background:#ccfbf1;">
                        <i class="bi bi-people-fill" style="color:#0d9488;font-size:1.4rem;"></i>
                    </div>
                    <div class="tp-stat-value tp-count-up" data-target="<%= studentCount %>"><%= studentCount %></div>
                    <div class="tp-stat-label">Tələbə</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="tp-stat">
                    <div class="tp-stat-icon" style="background:#fef3c7;">
                        <i class="bi bi-star-fill" style="color:#d97706;font-size:1.4rem;"></i>
                    </div>
                    <div class="tp-stat-value">4.9</div>
                    <div class="tp-stat-label">Reytinq</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="tp-stat">
                    <div class="tp-stat-icon" style="background:#dbeafe;">
                        <i class="bi bi-journal-bookmark-fill" style="color:#2563eb;font-size:1.4rem;"></i>
                    </div>
                    <div class="tp-stat-value">6</div>
                    <div class="tp-stat-label">Kurs</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="tp-stat">
                    <div class="tp-stat-icon" style="background:#ede9fe;">
                        <i class="bi bi-award-fill" style="color:#7c3aed;font-size:1.4rem;"></i>
                    </div>
                    <div class="tp-stat-value">12</div>
                    <div class="tp-stat-label">Sertifikat</div>
                </div>
            </div>
        </div>

        <div class="row g-4">

            <!-- ── Sol sütun ── -->
            <div class="col-12 col-lg-5">
                <div class="d-flex flex-column gap-4">

                    <!-- Şəxsi məlumatlar -->
                    <div class="tp-card">
                        <div class="tp-card-title"><i class="bi bi-person-badge-fill"></i>Şəxsi Məlumatlar</div>

                        <div class="tp-info-row">
                            <div class="tp-info-icon" style="background:#ccfbf1;"><i class="bi bi-person-fill" style="color:#0d9488;"></i></div>
                            <div><div class="tp-info-label">Ad Soyad</div><div class="tp-info-value"><%= teacher.getName() %> <%= teacher.getSurname() %></div></div>
                        </div>
                        <div class="tp-info-row">
                            <div class="tp-info-icon" style="background:#dbeafe;"><i class="bi bi-envelope-fill" style="color:#2563eb;"></i></div>
                            <div><div class="tp-info-label">E-poçt</div>
                                <div class="tp-info-value"><a href="mailto:<%= teacher.getEmail() %>" class="text-decoration-none" style="color:#0d9488;"><%= teacher.getEmail() %></a></div>
                            </div>
                        </div>
                        <div class="tp-info-row">
                            <div class="tp-info-icon" style="background:#fef3c7;"><i class="bi bi-calendar-heart-fill" style="color:#d97706;"></i></div>
                            <div><div class="tp-info-label">Yaş</div><div class="tp-info-value"><%= teacher.getAge() %> yaş</div></div>
                        </div>
                        <div class="tp-info-row">
                            <div class="tp-info-icon" style="background:#ede9fe;"><i class="bi bi-briefcase-fill" style="color:#7c3aed;"></i></div>
                            <div><div class="tp-info-label">Vəzifə</div><div class="tp-info-value">Senior Java Müəllimi</div></div>
                        </div>
                        <div class="tp-info-row">
                            <div class="tp-info-icon" style="background:#fce7f3;"><i class="bi bi-geo-alt-fill" style="color:#db2777;"></i></div>
                            <div><div class="tp-info-label">Ünvan</div><div class="tp-info-value">Bakı, Azərbaycan</div></div>
                        </div>
                        <div class="tp-info-row">
                            <div class="tp-info-icon" style="background:#f0fdf4;"><i class="bi bi-shield-fill-check" style="color:#16a34a;"></i></div>
                            <div><div class="tp-info-label">Status</div>
                                <div class="tp-info-value">
                                    <span class="badge rounded-pill px-3 py-1" style="background:#ccfbf1;color:#0f766e;font-size:0.8rem;">
                                        <i class="bi bi-circle-fill me-1" style="font-size:6px;"></i>Aktiv
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Reytinq -->
                    <div class="tp-card">
                        <div class="tp-card-title"><i class="bi bi-star-fill"></i>Tələbə Reytinqi</div>
                        <div class="text-center py-2">
                            <div class="tp-rating-value mb-1">4.9</div>
                            <div class="tp-stars mb-1">★★★★★</div>
                            <div class="tp-rating-count">248 rəy əsasında</div>
                        </div>
                        <hr class="my-3" style="border-color:#f0fdf4;">
                        <div class="d-flex justify-content-between align-items-center mb-2" style="font-size:0.8rem;">
                            <span class="text-muted">Dərs keyfiyyəti</span>
                            <div class="d-flex align-items-center gap-2">
                                <div class="tp-progress-bar" style="width:120px;">
                                    <div class="tp-progress-fill" style="width:98%;"></div>
                                </div>
                                <span style="color:#0d9488;font-weight:700;font-size:0.78rem;">98%</span>
                            </div>
                        </div>
                        <div class="d-flex justify-content-between align-items-center mb-2" style="font-size:0.8rem;">
                            <span class="text-muted">Əlaqə qurma</span>
                            <div class="d-flex align-items-center gap-2">
                                <div class="tp-progress-bar" style="width:120px;">
                                    <div class="tp-progress-fill" style="width:96%;"></div>
                                </div>
                                <span style="color:#0d9488;font-weight:700;font-size:0.78rem;">96%</span>
                            </div>
                        </div>
                        <div class="d-flex justify-content-between align-items-center" style="font-size:0.8rem;">
                            <span class="text-muted">Vaxtında cavab</span>
                            <div class="d-flex align-items-center gap-2">
                                <div class="tp-progress-bar" style="width:120px;">
                                    <div class="tp-progress-fill" style="width:94%;"></div>
                                </div>
                                <span style="color:#0d9488;font-weight:700;font-size:0.78rem;">94%</span>
                            </div>
                        </div>
                    </div>

                    <!-- Bacarıqlar -->
                    <div class="tp-card">
                        <div class="tp-card-title"><i class="bi bi-lightning-charge-fill"></i>Bacarıqlar &amp; Texnologiyalar</div>
                        <div class="d-flex flex-wrap gap-1">
                            <span class="tp-skill-badge"><i class="bi bi-code-slash"></i>Java</span>
                            <span class="tp-skill-badge"><i class="bi bi-layers"></i>Spring Boot</span>
                            <span class="tp-skill-badge"><i class="bi bi-database"></i>MySQL</span>
                            <span class="tp-skill-badge"><i class="bi bi-git"></i>Git</span>
                            <span class="tp-skill-badge"><i class="bi bi-boxes"></i>Maven</span>
                            <span class="tp-skill-badge"><i class="bi bi-braces"></i>REST API</span>
                            <span class="tp-skill-badge"><i class="bi bi-shield-check"></i>Spring Security</span>
                            <span class="tp-skill-badge"><i class="bi bi-diagram-3"></i>Microservices</span>
                            <span class="tp-skill-badge"><i class="bi bi-cloud-upload"></i>Docker</span>
                        </div>
                    </div>

                </div>
            </div>

            <!-- ── Sağ sütun ── -->
            <div class="col-12 col-lg-7">
                <div class="d-flex flex-column gap-4">

                    <!-- Tələbələr -->
                    <div class="tp-card">
                        <div class="tp-card-title">
                            <i class="bi bi-people-fill"></i>Tədris etdiyi Tələbələr
                            <span class="ms-auto badge rounded-pill" style="background:#ccfbf1;color:#0f766e;font-size:0.72rem;font-weight:700;"><%= studentCount %> nəfər</span>
                        </div>
                        <div class="d-flex flex-wrap">
                            <% if (studentStr == null) { %>
                            <span class="tp-student-chip text-muted"><i class="bi bi-dash-circle"></i>Tələbə təyin edilməyib</span>
                            <% } else {
                                String[] studs = studentStr.split(",");
                                for (String s : studs) { %>
                            <span class="tp-student-chip"><i class="bi bi-person-fill"></i><%= s.trim() %></span>
                            <% } } %>
                        </div>
                    </div>

                    <!-- İş Təcrübəsi -->
                    <div class="tp-card">
                        <div class="tp-card-title"><i class="bi bi-briefcase-fill"></i>İş Təcrübəsi</div>

                        <div class="tp-exp-item">
                            <div class="tp-exp-icon" style="background:#ccfbf1;">
                                <i class="bi bi-building" style="color:#0d9488;"></i>
                            </div>
                            <div>
                                <div class="tp-exp-role">Senior Java Müəllimi</div>
                                <div class="tp-exp-company">Education App Tədris Mərkəzi</div>
                                <div class="tp-exp-period"><i class="bi bi-calendar3 me-1"></i>2021 — Hazırda &nbsp;·&nbsp; 4 il</div>
                            </div>
                        </div>
                        <div class="tp-exp-item">
                            <div class="tp-exp-icon" style="background:#dbeafe;">
                                <i class="bi bi-laptop" style="color:#2563eb;"></i>
                            </div>
                            <div>
                                <div class="tp-exp-role">Backend Developer</div>
                                <div class="tp-exp-company">Tech Solutions MMC</div>
                                <div class="tp-exp-period"><i class="bi bi-calendar3 me-1"></i>2018 — 2021 &nbsp;·&nbsp; 3 il</div>
                            </div>
                        </div>
                        <div class="tp-exp-item">
                            <div class="tp-exp-icon" style="background:#ede9fe;">
                                <i class="bi bi-code-square" style="color:#7c3aed;"></i>
                            </div>
                            <div>
                                <div class="tp-exp-role">Java Developer (Junior)</div>
                                <div class="tp-exp-company">StartUp Bakı</div>
                                <div class="tp-exp-period"><i class="bi bi-calendar3 me-1"></i>2016 — 2018 &nbsp;·&nbsp; 2 il</div>
                            </div>
                        </div>
                    </div>

                    <!-- Tədris sahəsindəki irəliləyiş -->
                    <div class="tp-card">
                        <div class="tp-card-title"><i class="bi bi-graph-up-arrow"></i>Tədris Sahələri üzrə Səviyyə</div>
                        <div class="mb-3">
                            <div class="d-flex justify-content-between tp-progress-label mb-1"><span>Java Core &amp; OOP</span><span style="color:#0d9488;font-weight:700;">98%</span></div>
                            <div class="tp-progress-bar"><div class="tp-progress-fill" style="width:98%;"></div></div>
                        </div>
                        <div class="mb-3">
                            <div class="d-flex justify-content-between tp-progress-label mb-1"><span>Spring Framework</span><span style="color:#0d9488;font-weight:700;">95%</span></div>
                            <div class="tp-progress-bar"><div class="tp-progress-fill" style="width:95%;"></div></div>
                        </div>
                        <div class="mb-3">
                            <div class="d-flex justify-content-between tp-progress-label mb-1"><span>Verilənlər Bazası</span><span style="color:#059669;font-weight:700;">90%</span></div>
                            <div class="tp-progress-bar"><div class="tp-progress-fill" style="width:90%;background:linear-gradient(90deg,#059669,#34d399);"></div></div>
                        </div>
                        <div class="mb-3">
                            <div class="d-flex justify-content-between tp-progress-label mb-1"><span>Microservices</span><span style="color:#d97706;font-weight:700;">85%</span></div>
                            <div class="tp-progress-bar"><div class="tp-progress-fill" style="width:85%;background:linear-gradient(90deg,#d97706,#fbbf24);"></div></div>
                        </div>
                        <div>
                            <div class="d-flex justify-content-between tp-progress-label mb-1"><span>DevOps &amp; Docker</span><span style="color:#2563eb;font-weight:700;">78%</span></div>
                            <div class="tp-progress-bar"><div class="tp-progress-fill" style="width:78%;background:linear-gradient(90deg,#2563eb,#60a5fa);"></div></div>
                        </div>
                    </div>

                    <!-- Son aktivliklər -->
                    <div class="tp-card">
                        <div class="tp-card-title"><i class="bi bi-clock-history"></i>Son Aktivliklər</div>
                        <div class="tp-timeline-wrap">
                        <div class="tp-timeline-item">
                            <div class="tp-timeline-dot" style="background:#ccfbf1;"><i class="bi bi-patch-check-fill" style="color:#0d9488;"></i></div>
                            <div><div class="tp-timeline-title">Spring Boot Dərsi Keçildi — 18 tələbə</div><div class="tp-timeline-time"><i class="bi bi-clock me-1"></i>1 saat əvvəl</div></div>
                        </div>
                        <div class="tp-timeline-item">
                            <div class="tp-timeline-dot" style="background:#ede9fe;"><i class="bi bi-journal-plus" style="color:#7c3aed;"></i></div>
                            <div><div class="tp-timeline-title">Yeni tapşırıq əlavə edildi — OOP Layihəsi</div><div class="tp-timeline-time"><i class="bi bi-clock me-1"></i>3 saat əvvəl</div></div>
                        </div>
                        <div class="tp-timeline-item">
                            <div class="tp-timeline-dot" style="background:#fef3c7;"><i class="bi bi-trophy-fill" style="color:#d97706;"></i></div>
                            <div><div class="tp-timeline-title">Ən Yaxşı Müəllim — Aprel 2026</div><div class="tp-timeline-time"><i class="bi bi-clock me-1"></i>2 gün əvvəl</div></div>
                        </div>
                        <div class="tp-timeline-item">
                            <div class="tp-timeline-dot" style="background:#dbeafe;"><i class="bi bi-file-earmark-check-fill" style="color:#2563eb;"></i></div>
                            <div><div class="tp-timeline-title">12 tələbənin imtahan nəticəsi yoxlandı</div><div class="tp-timeline-time"><i class="bi bi-clock me-1"></i>4 gün əvvəl</div></div>
                        </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<% } %>

<jsp:include page="footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/script.js?v=4.3"></script>
<script src="js/teacher-page.js?v=1.0"></script>
</body>
</html>
