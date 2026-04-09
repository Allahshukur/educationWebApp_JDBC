<%@ page import="java.util.List" %>
<%@ page import="com.sukur.educationwebapp.student.entity.Student" %>
<%@ page import="com.sukur.educationwebapp.student.service.StudentService" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String idParam = request.getParameter("id");
    int studentId = 0;
    Student student = null;

    if (idParam != null) {
        try { studentId = Integer.parseInt(idParam); } catch (NumberFormatException ignored) {}
    }

    StudentService studentService = new StudentService();
    List<Student> allStudents = studentService.findAll();
    for (Student s : allStudents) {
        if (s.getId() == studentId) { student = s; break; }
    }

    String fullName   = (student != null) ? student.getName() + " " + student.getSurname() : "Tələbə Tapılmadı";
    String initials   = (student != null && student.getName().length() > 0 && student.getSurname().length() > 0)
                        ? (student.getName().substring(0,1) + student.getSurname().substring(0,1)).toUpperCase() : "?";
    String teacherStr = (student != null && student.getTeacher() != null && !student.getTeacher().equals("0"))
                        ? student.getTeacher() : "Müəllim təyin edilməyib";
%>
<!DOCTYPE html>
<html lang="az">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= fullName %> — Şəxsi Səhifə</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="css/style.css?v=4.3" rel="stylesheet">
    <link href="css/dark-mode.css?v=2.1" rel="stylesheet">
    <link href="css/student-page.css?v=2.0" rel="stylesheet">
</head>
<body class="overflow-hidden-init" style="background:#f8fafc;">

<div id="loader">
    <div class="loader-content">
        <div class="loader-circle"></div>
        <div class="loader-circle"></div>
        <div class="loader-circle"></div>
        <div class="loader-subtext">Tələbə profili yüklənir...</div>
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
                    <a href="students.jsp" class="text-decoration-none"><i class="bi bi-people"></i>Tələbələr</a>
                </li>
                <li class="breadcrumb-item active" aria-current="page">
                    <i class="bi bi-person"></i><%= fullName %>
                </li>
            </ol>
        </nav>
    </div>
</div>

<% if (student == null) { %>
<div class="container py-5 mt-5">
    <div class="sp-not-found">
        <div class="sp-not-found-icon"><i class="bi bi-person-x"></i></div>
        <h3 class="fw-bold text-dark mb-2">Tələbə Tapılmadı</h3>
        <p class="text-muted mb-4">ID: <strong><%= idParam %></strong> olan tələbə mövcud deyil.</p>
        <a href="students.jsp" class="btn btn-primary rounded-pill px-4">
            <i class="bi bi-arrow-left me-2"></i>Tələbələr Siyahısına Qayıt
        </a>
    </div>
</div>
<% } else { %>

<!-- HERO -->
<div class="sp-hero">
    <div class="container">
        <div class="d-flex flex-column flex-md-row align-items-center align-items-md-start gap-4">
            <div class="sp-avatar-wrap flex-shrink-0">
                <div class="sp-avatar-ring"></div>
                <div class="sp-avatar-ring2"></div>
                <div class="sp-avatar"><%= initials %></div>
                <div class="sp-avatar-edit" title="Şəkil yüklə"><i class="bi bi-camera-fill"></i></div>
            </div>
            <div class="text-center text-md-start flex-grow-1">
                <div class="d-flex flex-wrap gap-2 justify-content-center justify-content-md-start mb-2">
                    <span class="sp-id-badge"><i class="bi bi-hash"></i><%= student.getId() %></span>
                    <span class="sp-hero-status"><i class="bi bi-circle-fill" style="font-size:7px;"></i>Aktiv</span>
                </div>
                <div class="sp-hero-name mb-1"><%= student.getName() %> <%= student.getSurname() %></div>
                <div class="sp-hero-sub">
                    <i class="bi bi-mortarboard me-1"></i>Java Proqramlaşdırma
                    &nbsp;·&nbsp;<i class="bi bi-geo-alt me-1"></i>Bakı, Azərbaycan
                </div>
                <div class="mt-3">
                    <a href="students.jsp" class="sp-back-btn">
                        <i class="bi bi-arrow-left"></i>Tələbələr siyahısı
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- CONTENT -->
<div class="sp-content">
    <div class="container pb-5">

        <!-- Flip Stat kartlar -->
        <div class="row g-3 mb-4">
            <!-- Orta Qiymət -->
            <div class="col-6 col-md-3">
                <div class="sp-stat-flip">
                    <div class="sp-stat-flip-inner">
                        <div class="sp-stat-flip-front">
                            <div class="sp-stat-icon" style="background:#ede9fe;">
                                <i class="bi bi-star-fill" style="color:#4f46e5;font-size:1.3rem;"></i>
                            </div>
                            <div class="sp-stat-value">88%</div>
                            <div class="sp-stat-label">Orta Qiymət</div>
                        </div>
                        <div class="sp-stat-flip-back" style="background:linear-gradient(135deg,#4f46e5,#7c3aed);">
                            <div class="sp-stat-back-value">Bu semester: 91%<br>Keçən: 85%</div>
                            <div class="sp-stat-back-label">📈 Yüksəliş dinamikası</div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Davamiyyət -->
            <div class="col-6 col-md-3">
                <div class="sp-stat-flip">
                    <div class="sp-stat-flip-inner">
                        <div class="sp-stat-flip-front">
                            <div class="sp-stat-icon" style="background:#d1fae5;">
                                <i class="bi bi-check2-circle" style="color:#059669;font-size:1.3rem;"></i>
                            </div>
                            <div class="sp-stat-value">92%</div>
                            <div class="sp-stat-label">Davamiyyət</div>
                        </div>
                        <div class="sp-stat-flip-back" style="background:linear-gradient(135deg,#059669,#34d399);">
                            <div class="sp-stat-back-value">Dərs: 46/50<br>İş: 4 qaib</div>
                            <div class="sp-stat-back-label">✅ Əla davamiyyət</div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Tapşırıq -->
            <div class="col-6 col-md-3">
                <div class="sp-stat-flip">
                    <div class="sp-stat-flip-inner">
                        <div class="sp-stat-flip-front">
                            <div class="sp-stat-icon" style="background:#fef3c7;">
                                <i class="bi bi-journal-text" style="color:#d97706;font-size:1.3rem;"></i>
                            </div>
                            <div class="sp-stat-value">14</div>
                            <div class="sp-stat-label">Tapşırıq</div>
                        </div>
                        <div class="sp-stat-flip-back" style="background:linear-gradient(135deg,#d97706,#f59e0b);">
                            <div class="sp-stat-back-value">Tamamlandı: 12<br>Gözləmədə: 2</div>
                            <div class="sp-stat-back-label">📝 Bu ay</div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Sertifikat -->
            <div class="col-6 col-md-3">
                <div class="sp-stat-flip">
                    <div class="sp-stat-flip-inner">
                        <div class="sp-stat-flip-front">
                            <div class="sp-stat-icon" style="background:#dbeafe;">
                                <i class="bi bi-trophy-fill" style="color:#2563eb;font-size:1.3rem;"></i>
                            </div>
                            <div class="sp-stat-value">3</div>
                            <div class="sp-stat-label">Sertifikat</div>
                        </div>
                        <div class="sp-stat-flip-back" style="background:linear-gradient(135deg,#2563eb,#38bdf8);">
                            <div class="sp-stat-back-value">Java Core ✓<br>Spring Boot ✓<br>SQL Basics ✓</div>
                            <div class="sp-stat-back-label">🏆 Qazanılmış</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <!-- Sol: Şəxsi məlumatlar -->
            <div class="col-12 col-lg-5">
                <div class="sp-info-card">
                    <div class="sp-info-card-title"><i class="bi bi-person-badge"></i>Şəxsi Məlumatlar</div>
                    <div class="sp-info-row">
                        <div class="sp-info-icon" style="background:#ede9fe;"><i class="bi bi-person-fill" style="color:#4f46e5;"></i></div>
                        <div><div class="sp-info-label">Ad Soyad</div><div class="sp-info-value"><%= student.getName() %> <%= student.getSurname() %></div></div>
                    </div>
                    <div class="sp-info-row">
                        <div class="sp-info-icon" style="background:#dbeafe;"><i class="bi bi-envelope-fill" style="color:#2563eb;"></i></div>
                        <div><div class="sp-info-label">E-poçt</div>
                            <div class="sp-info-value"><a href="mailto:<%= student.getEmail() %>" class="text-decoration-none" style="color:#4f46e5;"><%= student.getEmail() %></a></div>
                        </div>
                    </div>
                    <div class="sp-info-row">
                        <div class="sp-info-icon" style="background:#d1fae5;"><i class="bi bi-calendar-heart-fill" style="color:#059669;"></i></div>
                        <div><div class="sp-info-label">Yaş</div><div class="sp-info-value"><%= student.getAge() %> yaş</div></div>
                    </div>
                    <div class="sp-info-row">
                        <div class="sp-info-icon" style="background:#fef3c7;"><i class="bi bi-mortarboard-fill" style="color:#d97706;"></i></div>
                        <div><div class="sp-info-label">İxtisas</div><div class="sp-info-value">Java Proqramlaşdırma</div></div>
                    </div>
                    <div class="sp-info-row">
                        <div class="sp-info-icon" style="background:#fce7f3;"><i class="bi bi-geo-alt-fill" style="color:#db2777;"></i></div>
                        <div><div class="sp-info-label">Ünvan</div><div class="sp-info-value">Bakı, Azərbaycan</div></div>
                    </div>
                    <div class="sp-info-row">
                        <div class="sp-info-icon" style="background:#f0fdf4;"><i class="bi bi-shield-fill-check" style="color:#16a34a;"></i></div>
                        <div><div class="sp-info-label">Status</div>
                            <div class="sp-info-value">
                                <span class="badge rounded-pill px-3 py-1" style="background:#d1fae5;color:#059669;font-size:0.8rem;">
                                    <i class="bi bi-circle-fill me-1" style="font-size:6px;"></i>Aktiv
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sağ: Müəllim + İrəliləyiş + Aktivlik -->
            <div class="col-12 col-lg-7">
                <div class="d-flex flex-column gap-4">

                    <!-- Müəllimlər -->
                    <div class="sp-info-card">
                        <div class="sp-info-card-title"><i class="bi bi-person-workspace"></i>Təyin Olunmuş Müəllimlər</div>
                        <div class="d-flex flex-wrap gap-1 mt-1">
                            <% if (teacherStr.equals("Müəllim təyin edilməyib")) { %>
                            <span class="sp-teacher-chip text-muted"><i class="bi bi-dash-circle"></i>Müəllim təyin edilməyib</span>
                            <% } else {
                                String[] teachers = teacherStr.split(",");
                                for (String t : teachers) { %>
                            <span class="sp-teacher-chip"><i class="bi bi-person-fill"></i><%= t.trim() %></span>
                            <% } } %>
                        </div>
                    </div>

                    <!-- İrəliləyiş — SVG Dairəvi -->
                    <div class="sp-info-card">
                        <div class="sp-info-card-title"><i class="bi bi-graph-up-arrow"></i>Tədris İrəliləyişi</div>
                        <div class="sp-circle-grid">
                            <!-- Java Əsasları -->
                            <div class="sp-circle-item">
                                <div class="sp-circle-wrap">
                                    <svg class="sp-circle-svg" viewBox="0 0 96 96">
                                        <circle class="sp-circle-bg" cx="48" cy="48" r="40"/>
                                        <circle class="sp-circle-fill" cx="48" cy="48" r="40"
                                                data-pct="95" stroke="#4f46e5"/>
                                    </svg>
                                    <div class="sp-circle-center">
                                        <span class="sp-circle-pct">95%</span>
                                        <span class="sp-circle-sub">Java</span>
                                    </div>
                                </div>
                                <div class="sp-circle-label">Java Əsasları</div>
                            </div>
                            <!-- OOP -->
                            <div class="sp-circle-item">
                                <div class="sp-circle-wrap">
                                    <svg class="sp-circle-svg" viewBox="0 0 96 96">
                                        <circle class="sp-circle-bg" cx="48" cy="48" r="40"/>
                                        <circle class="sp-circle-fill" cx="48" cy="48" r="40"
                                                data-pct="82" stroke="#059669"/>
                                    </svg>
                                    <div class="sp-circle-center">
                                        <span class="sp-circle-pct">82%</span>
                                        <span class="sp-circle-sub">OOP</span>
                                    </div>
                                </div>
                                <div class="sp-circle-label">OOP Konseptləri</div>
                            </div>
                            <!-- Spring -->
                            <div class="sp-circle-item">
                                <div class="sp-circle-wrap">
                                    <svg class="sp-circle-svg" viewBox="0 0 96 96">
                                        <circle class="sp-circle-bg" cx="48" cy="48" r="40"/>
                                        <circle class="sp-circle-fill" cx="48" cy="48" r="40"
                                                data-pct="68" stroke="#d97706"/>
                                    </svg>
                                    <div class="sp-circle-center">
                                        <span class="sp-circle-pct">68%</span>
                                        <span class="sp-circle-sub">Spring</span>
                                    </div>
                                </div>
                                <div class="sp-circle-label">Spring Framework</div>
                            </div>
                            <!-- SQL -->
                            <div class="sp-circle-item">
                                <div class="sp-circle-wrap">
                                    <svg class="sp-circle-svg" viewBox="0 0 96 96">
                                        <circle class="sp-circle-bg" cx="48" cy="48" r="40"/>
                                        <circle class="sp-circle-fill" cx="48" cy="48" r="40"
                                                data-pct="75" stroke="#2563eb"/>
                                    </svg>
                                    <div class="sp-circle-center">
                                        <span class="sp-circle-pct">75%</span>
                                        <span class="sp-circle-sub">SQL</span>
                                    </div>
                                </div>
                                <div class="sp-circle-label">Verilənlər Bazası</div>
                            </div>
                        </div>
                    </div>

                    <!-- Son aktivlik -->
                    <div class="sp-info-card">
                        <div class="sp-info-card-title"><i class="bi bi-clock-history"></i>Son Aktivliklər</div>
                        <div class="sp-timeline-wrap">
                            <div class="sp-timeline-item">
                                <div class="sp-timeline-dot" style="background:#ede9fe;"><i class="bi bi-patch-check-fill" style="color:#4f46e5;"></i></div>
                                <div><div class="sp-timeline-title">Java OOP Tapşırığı Təhvil Verildi</div><div class="sp-timeline-time"><i class="bi bi-clock me-1"></i>2 saat əvvəl</div></div>
                            </div>
                            <div class="sp-timeline-item">
                                <div class="sp-timeline-dot" style="background:#d1fae5;"><i class="bi bi-trophy-fill" style="color:#059669;"></i></div>
                                <div><div class="sp-timeline-title">Spring Boot Sertifikatı Qazanıldı</div><div class="sp-timeline-time"><i class="bi bi-clock me-1"></i>1 gün əvvəl</div></div>
                            </div>
                            <div class="sp-timeline-item">
                                <div class="sp-timeline-dot" style="background:#dbeafe;"><i class="bi bi-book-fill" style="color:#2563eb;"></i></div>
                                <div><div class="sp-timeline-title">Verilənlər Bazası Dərsinə Qatıldı</div><div class="sp-timeline-time"><i class="bi bi-clock me-1"></i>3 gün əvvəl</div></div>
                            </div>
                            <div class="sp-timeline-item">
                                <div class="sp-timeline-dot" style="background:#fef3c7;"><i class="bi bi-star-fill" style="color:#d97706;"></i></div>
                                <div><div class="sp-timeline-title">Sınaqda 92 bal topladı</div><div class="sp-timeline-time"><i class="bi bi-clock me-1"></i>5 gün əvvəl</div></div>
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
<script src="js/student-page.js?v=2.0"></script>
<canvas id="sp-confetti"></canvas>
</body>
</html>
