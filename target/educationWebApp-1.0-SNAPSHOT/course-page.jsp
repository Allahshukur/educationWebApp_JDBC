<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    /* ── URL parametri: ?id=1..10 ───────────────── */
    int courseId = 1;
    try {
        String idParam = request.getParameter("id");
        if (idParam != null) courseId = Integer.parseInt(idParam.trim());
        if (courseId < 1 || courseId > 10) courseId = 1;
    } catch (NumberFormatException ignored) {}

    int idx = courseId - 1;   /* 0-based massiv indeksi */

    /* ── Kurs məlumatları ───────────────────────── */
    String[] cNames = {
        "Java Əsasları",
        "OOP Konseptləri",
        "Spring Framework",
        "Verilənlər Bazası",
        "HTML & CSS",
        "JavaScript Əsasları",
        "React.js",
        "Python Proqramlaşdırma",
        "Kibertəhlükəsizlik",
        "DevOps & Docker"
    };
    String[] cDescs = {
        "Java proqramlaşdırma dilinin temel konseptləri: dəyişənlər, dövrələr, şərtlər və metodlar. Sıfırdan başlayaraq OOP-a qədər.",
        "Obyekt yönümlü proqramlaşdırmanın prinsipləri: inkapsulyasiya, miras, polimorfizm və abstraksiya. Real layihələrlə öyrən.",
        "Spring Boot ilə müasir Java veb tətbiqlərinin qurulması. IoC, Dependency Injection, REST API, JPA.",
        "MySQL və PostgreSQL ilə işləmə. SQL sorğuları, JOIN əməliyyatları, indeksləmə, normallaşdırma.",
        "Müasir veb dizaynının əsasları. Flexbox, CSS Grid, animasiyalar, Bootstrap 5 ilə responsive dizayn.",
        "Veb səhifələri interaktiv etmək üçün JavaScript: DOM manipulation, Events, Fetch API, ES6+.",
        "Meta-nın populyar UI kitabxanası ilə komponent əsaslı veb tətbiqlər qurmaq. Hooks, Context, Router.",
        "Data analizi, skript yazma və süni intellekt üçün Python. NumPy, Pandas, Matplotlib, Scikit-learn.",
        "Şəbəkə təhlükəsizliyi, kriptografiya, zəifliklərin aşkarlanması, Kali Linux və etik hacking.",
        "CI/CD prosesləri, konteynerləşdirmə, Docker Compose, Kubernetes ilə müasir deployment."
    };
    String[] cTeachers = {
        "Əli Əliyev", "Nigar Hüseynova", "Rauf Məmmədov",
        "Sevinc Quliyeva", "Əli Əliyev", "Nigar Hüseynova",
        "Rauf Məmmədov", "Sevinc Quliyeva", "Əli Əliyev", "Rauf Məmmədov"
    };
    String[] cTitles = {
        "Senior Java Developer", "OOP & Architecture Mütəxəssisi",
        "Spring Boot Eksperti", "Database Administratoru",
        "Frontend Developer", "JavaScript Engineer",
        "React.js Mütəxəssisi", "Data Scientist",
        "Cybersecurity Analitik", "DevOps Engineer"
    };
    String[] cStudents = {"85","62","74","91","58","103","67","80","45","72"};
    String[] cHours    = {"36","28","42","32","24","30","38","35","40","26"};
    String[] cRatings  = {"4.9","4.7","4.8","4.6","5.0","4.8","4.7","4.9","4.6","4.8"};
    String[] cLessons  = {"42","35","54","40","30","38","46","44","50","33"};
    String[] cLevels   = {"Başlanğıc","Başlanğıc","Orta","Orta","Başlanğıc","Başlanğıc","Orta","Orta","İrəliləmiş","İrəliləmiş"};
    String[] cLang     = {"Azərbaycanca","Azərbaycanca","Azərbaycanca","Azərbaycanca","Azərbaycanca","Azərbaycanca","Azərbaycanca","Azərbaycanca","Azərbaycanca","Azərbaycanca"};

    String[] gFrom = {"#4338ca","#059669","#d97706","#db2777","#0891b2","#7c3aed","#ea580c","#2563eb","#0f172a","#065f46"};
    String[] gTo   = {"#7c3aed","#0d9488","#dc2626","#7c3aed","#0f766e","#db2777","#d97706","#4f46e5","#334155","#047857"};
    String[] icons = {
        "bi-code-slash","bi-diagram-3-fill","bi-layers-fill","bi-database-fill",
        "bi-brush-fill","bi-braces-asterisk","bi-filetype-js","bi-robot",
        "bi-shield-lock-fill","bi-cloud-upload-fill"
    };

    /* Öyrənəcəkləriniz — hər kurs üçün 6 maddə */
    String[][] cLearn = {
        {"Java sintaksisini","Dəyişən və tip sistemini","Dövrə konstruksiyalarını","Metodlar və sinifləri","Massivlər və kolleksiyaları","İstisna idarəetməsini"},
        {"İnkapsulyasiya prinsipini","Miras mexanizmini","Polimorfizmi","Abstraksiya sinfini","İnterfeys işlətməyi","SOLID prinsiplərini"},
        {"Spring IoC konteynerini","Dependency Injection-ı","REST API qurmağı","Spring Data JPA-nı","Spring Security-ni","Layihəni Deploy etməyi"},
        {"SQL əsaslarını","JOIN növlərini","Tranzaksiyaları","İndeksləməni","Normallaşdırmanı","Stored procedure-ları"},
        {"HTML5 semantikasını","CSS Flexbox-u","CSS Grid sistemini","Bootstrap 5-i","Animasiyalar yazmağı","Responsive dizaynı"},
        {"DOM manipulyasiyasını","Event Listener-ləri","Fetch API-ni","ES6+ xüsusiyyətlərini","Async/Await-i","Local Storage-i"},
        {"React komponentlərini","useState/useEffect-i","React Router-i","Context API-ni","Custom Hooks yazmağı","Performans optimallaşdırmanı"},
        {"Python sintaksisini","NumPy-ni","Pandas DataFrame-i","Matplotlib ilə vizualizasiya","Scikit-learn-i","Model qurmağı"},
        {"Şəbəkə protokollarını","Kali Linux alətlərini","SQL injection-ı","XSS hücumlarını","Şifrələməni","Penetrasiya testini"},
        {"Docker konseptlərini","Dockerfile yazmağı","Docker Compose-u","Jenkins CI/CD-ni","Kubernetes basics-i","Cloud deployment-i"}
    };

    /* Modul adları — hər kurs üçün 4 modul */
    String[][] cModules = {
        {"Giriş və Quraşdırma","Əsas Proqram Strukturu","OOP-a Giriş","Proyekt: Tələbə İdarəetmə"},
        {"OOP Nədir?","Miras və Polimorfizm","Abstraksiya və İnterfeys","Proyekt: Bank Sistemi"},
        {"Spring-ə Giriş","REST API İnkişafı","Verilənlər Bazası İnteqrasiyası","Proyekt: Blog API"},
        {"SQL Əsasları","İlişkilər və JOIN","Performans Optimallaşdırma","Proyekt: E-ticarət DB"},
        {"HTML5 Əsasları","CSS-ə Giriş","Bootstrap 5","Proyekt: Portfolio Saytı"},
        {"JS Əsasları","DOM və Events","Asinxron JavaScript","Proyekt: Hava Tətbiqi"},
        {"React Əsasları","State və Props","Routing və API","Proyekt: E-ticarət Saytı"},
        {"Python Əsasları","Data Analizi","Maşın Öyrənməsi","Proyekt: Proqnoz Modeli"},
        {"Şəbəkə Əsasları","Hücum Növləri","Müdafiə Metodları","Proyekt: CTF Yarışması"},
        {"Docker Əsasları","Konteyner Orkestrasiyası","CI/CD Boru Xətti","Proyekt: Microservice Deploy"}
    };

    String name     = cNames[idx];
    String desc     = cDescs[idx];
    String teacher  = cTeachers[idx];
    String tTitle   = cTitles[idx];
    String rating   = cRatings[idx];
    String students = cStudents[idx];
    String hours    = cHours[idx];
    String lessons  = cLessons[idx];
    String level    = cLevels[idx];
    String lang     = cLang[idx];
    String g1       = gFrom[idx];
    String g2       = gTo[idx];
    String icon     = icons[idx];
    String[] learn  = cLearn[idx];
    String[] modules = cModules[idx];

    /* Müəllim baş hərfi (avatar üçün) */
    String teacherInitial = teacher.length() > 0 ? String.valueOf(teacher.charAt(0)) : "?";

    /* Kurs qiyməti (dekorativ) */
    int price = 49 + idx * 10;
    int oldPrice = price + 30;
%>
<!DOCTYPE html>
<html lang="az">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= name %> — Education App</title>

    <!-- Dinamik gradient CSS dəyişəni -->
    <style>
        :root {
            --cp-g1: <%= g1 %>;
            --cp-g2: <%= g2 %>;
        }
    </style>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="css/style.css?v=3.5" rel="stylesheet">
    <link href="css/dark-mode.css?v=1.0" rel="stylesheet">
    <link href="css/ads.css?v=4.0" rel="stylesheet">
    <link href="css/course-page.css?v=1.0" rel="stylesheet">
    <!-- Header-in 2 pilleli breadcrumb-unu gizlət; hero-da 3 pilleli öz breadcrumb-umuz var -->
    <style>.page-breadcrumb-bar { display: none !important; }</style>
</head>
<body class="overflow-hidden-init cp-page">

<!-- Yükləmə ekranı -->
<div id="loader">
    <div class="loader-content">
        <div class="loader-circle"></div>
        <div class="loader-circle"></div>
        <div class="loader-circle"></div>
        <div class="loader-subtext">Kurs yüklənir...</div>
    </div>
</div>

<%
    request.setAttribute("pageLabel", name);
    request.setAttribute("isHome", false);
%>
<jsp:include page="header.jsp"/>

<!-- ══════════════════════════════════════════════
     HERO
══════════════════════════════════════════════ -->
<div class="cp-hero">
    <div class="cp-hero-deco cp-hero-deco-1"></div>
    <div class="cp-hero-deco cp-hero-deco-2"></div>
    <div class="cp-hero-deco cp-hero-deco-3"></div>

    <div class="container">
        <div class="row align-items-center g-4">

            <!-- Sol -->
            <div class="col-lg-7" data-aos="fade-right">

                <!-- Breadcrumb -->
                <nav class="cp-breadcrumb">
                    <a href="index.jsp"><i class="bi bi-house-fill me-1"></i>Ana səyfə</a>
                    <i class="bi bi-chevron-right sep"></i>
                    <a href="courses.jsp">Kurslar</a>
                    <i class="bi bi-chevron-right sep"></i>
                    <span class="current"><%= name %></span>
                </nav>

                <!-- Label -->
                <div class="cp-label">
                    <i class="bi bi-journal-bookmark-fill"></i>
                    <%= level %> Səviyyə &nbsp;·&nbsp; <%= lang %>
                </div>
                <span class="tp-hero-status"><i class="bi bi-circle-fill" style="font-size:7px;"></i>Aktiv</span>

                <!-- Başlıq -->
                <h1 class="cp-hero-title"><%= name %></h1>

                <!-- Qısa təsvir -->
                <p class="cp-hero-desc"><%= desc %></p>

                <!-- Stat cipləri -->
                <div class="cp-hero-chips">
                    <span class="cp-chip">
                        <i class="bi bi-star-fill" style="color:#fcd34d;"></i>
                        <%= rating %> Reytinq
                    </span>
                    <span class="cp-chip">
                        <i class="bi bi-people-fill"></i>
                        <%= students %> Tələbə
                    </span>
                    <span class="cp-chip">
                        <i class="bi bi-clock-fill"></i>
                        <%= hours %> Saat
                    </span>
                    <span class="cp-chip">
                        <i class="bi bi-collection-play-fill"></i>
                        <%= lessons %> Dərs
                    </span>
                </div>

            </div>

            <!-- Sağ — Böyük İkon -->
            <div class="col-lg-5 d-flex justify-content-center" data-aos="fade-left" data-aos-delay="120">
                <div class="cp-hero-icon-box">
                    <div class="cp-hero-icon-ring"></div>
                    <i class="bi <%= icon %>"></i>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- ══════════════════════════════════════════════
     ƏSAS MƏZMUN
══════════════════════════════════════════════ -->
<div class="cp-main">
    <div class="container">
        <div class="row g-4">

            <!-- Sol — Əsas Kontent -->
            <div class="col-lg-8">

                <!-- Stat Kartları -->
                <div class="cp-stats-row" data-aos="fade-up">
                    <div class="cp-stat-card">
                        <div class="cp-stat-icon" style="background:rgba(79,70,229,.12);">
                            <i class="bi bi-star-fill" style="color:#4f46e5;"></i>
                        </div>
                        <div>
                            <div class="cp-stat-val" data-count="<%= rating %>"><%= rating %></div>
                            <div class="cp-stat-lbl">Reytinq</div>
                        </div>
                    </div>
                    <div class="cp-stat-card">
                        <div class="cp-stat-icon" style="background:rgba(16,185,129,.12);">
                            <i class="bi bi-people-fill" style="color:#10b981;"></i>
                        </div>
                        <div>
                            <div class="cp-stat-val" data-count="<%= students %>"><%= students %></div>
                            <div class="cp-stat-lbl">Tələbə</div>
                        </div>
                    </div>
                    <div class="cp-stat-card">
                        <div class="cp-stat-icon" style="background:rgba(245,158,11,.12);">
                            <i class="bi bi-clock-fill" style="color:#f59e0b;"></i>
                        </div>
                        <div>
                            <div class="cp-stat-val" data-count="<%= hours %>"><%= hours %></div>
                            <div class="cp-stat-lbl">Saat</div>
                        </div>
                    </div>
                    <div class="cp-stat-card">
                        <div class="cp-stat-icon" style="background:rgba(56,189,248,.12);">
                            <i class="bi bi-collection-play-fill" style="color:#0ea5e9;"></i>
                        </div>
                        <div>
                            <div class="cp-stat-val" data-count="<%= lessons %>"><%= lessons %></div>
                            <div class="cp-stat-lbl">Dərs</div>
                        </div>
                    </div>
                </div>

                <!-- TABS -->
                <div class="cp-tabs" data-aos="fade-up" data-aos-delay="60">
                    <button class="cp-tab-btn active" data-tab="about">
                        <i class="bi bi-info-circle-fill"></i> Haqqında
                    </button>
                    <button class="cp-tab-btn" data-tab="curriculum">
                        <i class="bi bi-list-ol"></i> Proqram
                    </button>
                    <button class="cp-tab-btn" data-tab="teacher">
                        <i class="bi bi-person-badge-fill"></i> Müəllim
                    </button>
                </div>

                <!-- ── TAB: Haqqında ── -->
                <div class="cp-tab-panel active" id="tab-about" data-aos="fade-up" data-aos-delay="80">

                    <!-- Kurs haqqında -->
                    <div class="cp-about-card">
                        <div class="cp-section-title">
                            <span class="cp-stat-icon" style="background:rgba(79,70,229,.10);">
                                <i class="bi bi-journal-text" style="color:#4f46e5;"></i>
                            </span>
                            Kurs Haqqında
                        </div>
                        <p class="cp-about-text"><%= desc %></p>
                        <p class="cp-about-text mt-2">
                            Bu kurs həm nəzəri bilikləri, həm də praktiki tapşırıqları əhatə edir.
                            Hər dərsdən sonra quiz və praktik layihə ilə öyrəndiklərini möhkəmləndir.
                            Kursu bitirdikdən sonra sertifikat alacaqsan.
                        </p>
                    </div>

                    <!-- Nə öyrənəcəksiniz -->
                    <div class="cp-about-card">
                        <div class="cp-section-title">
                            <span class="cp-stat-icon" style="background:rgba(16,185,129,.10);">
                                <i class="bi bi-check-circle-fill" style="color:#10b981;"></i>
                            </span>
                            Nə Öyrənəcəksiniz?
                        </div>
                        <ul class="cp-learn-list">
                            <% for (String item : learn) { %>
                            <li>
                                <i class="bi bi-check2-circle"></i>
                                <%= item %>
                            </li>
                            <% } %>
                        </ul>
                    </div>

                    <!-- Tələblər -->
                    <div class="cp-about-card">
                        <div class="cp-section-title">
                            <span class="cp-stat-icon" style="background:rgba(245,158,11,.10);">
                                <i class="bi bi-clipboard-check-fill" style="color:#f59e0b;"></i>
                            </span>
                            Tələblər
                        </div>
                        <ul class="cp-learn-list">
                            <li><i class="bi bi-check2-circle"></i>Komputer (Windows/Mac/Linux)</li>
                            <li><i class="bi bi-check2-circle"></i>İnternet bağlantısı</li>
                            <li><i class="bi bi-check2-circle"></i>Öyrənmə həvəsi</li>
                            <li><i class="bi bi-check2-circle"></i>Gündə 1-2 saat vaxt</li>
                        </ul>
                    </div>

                    <!-- Bacarıq səviyyəsi barları -->
                    <div class="cp-about-card">
                        <div class="cp-section-title">
                            <span class="cp-stat-icon" style="background:rgba(99,102,241,.10);">
                                <i class="bi bi-bar-chart-fill" style="color:#6366f1;"></i>
                            </span>
                            Əhatə Olunan Mövzular
                        </div>
                        <div class="cp-skill-bar-label"><span>Nəzəriyyə</span><span>75%</span></div>
                        <div class="cp-skill-bar-track">
                            <div class="cp-skill-bar-fill" data-width="75"></div>
                        </div>
                        <div class="cp-skill-bar-label"><span>Praktika</span><span>90%</span></div>
                        <div class="cp-skill-bar-track">
                            <div class="cp-skill-bar-fill" data-width="90"></div>
                        </div>
                        <div class="cp-skill-bar-label"><span>Layihə</span><span>60%</span></div>
                        <div class="cp-skill-bar-track">
                            <div class="cp-skill-bar-fill" data-width="60"></div>
                        </div>
                        <div class="cp-skill-bar-label"><span>Quiz</span><span>45%</span></div>
                        <div class="cp-skill-bar-track">
                            <div class="cp-skill-bar-fill" data-width="45"></div>
                        </div>
                    </div>

                </div><!-- /tab-about -->

                <!-- ── TAB: Proqram ── -->
                <div class="cp-tab-panel" id="tab-curriculum">

                    <% for (int m = 0; m < modules.length; m++) { %>
                    <div class="cp-module" data-aos="fade-up" data-aos-delay="<%= m * 60 %>">
                        <div class="cp-module-header">
                            <div class="cp-module-num"><%= (m + 1) %></div>
                            <div class="cp-module-name"><%= modules[m] %></div>
                            <div class="cp-module-meta">
                                <i class="bi bi-collection-play me-1"></i>
                                <%= (4 + m * 2) %> dərs
                            </div>
                            <i class="bi bi-chevron-down cp-module-arrow"></i>
                        </div>
                        <div class="cp-module-body">

                            <!-- Dərs 1 — Pulsuz -->
                            <div class="cp-lesson">
                                <div class="cp-lesson-icon"><i class="bi bi-play-circle-fill"></i></div>
                                <div class="cp-lesson-name">Giriş Dərsi — <%= modules[m] %></div>
                                <span class="cp-lesson-free">Pulsuz</span>
                                <div class="cp-lesson-dur">08:30</div>
                            </div>

                            <!-- Dərs 2 -->
                            <div class="cp-lesson">
                                <div class="cp-lesson-icon"><i class="bi bi-play-circle"></i></div>
                                <div class="cp-lesson-name">Əsas Konseptlər</div>
                                <div class="cp-lesson-dur">14:20</div>
                            </div>

                            <!-- Dərs 3 -->
                            <div class="cp-lesson">
                                <div class="cp-lesson-icon"><i class="bi bi-code-square"></i></div>
                                <div class="cp-lesson-name">Praktik Tapşırıq</div>
                                <div class="cp-lesson-dur">22:45</div>
                            </div>

                            <!-- Dərs 4 -->
                            <div class="cp-lesson">
                                <div class="cp-lesson-icon"><i class="bi bi-patch-question"></i></div>
                                <div class="cp-lesson-name">Quiz — Biliyi Yoxla</div>
                                <div class="cp-lesson-dur">10:00</div>
                            </div>

                            <% if (m % 2 == 0) { %>
                            <!-- Bonus dərs -->
                            <div class="cp-lesson">
                                <div class="cp-lesson-icon"><i class="bi bi-gift-fill" style="color:#f59e0b;"></i></div>
                                <div class="cp-lesson-name">Bonus: Real Dünya Nümunəsi</div>
                                <div class="cp-lesson-dur">18:15</div>
                            </div>
                            <% } %>

                        </div>
                    </div>
                    <% } %>

                </div><!-- /tab-curriculum -->

                <!-- ── TAB: Müəllim ── -->
                <div class="cp-tab-panel" id="tab-teacher">
                    <div class="cp-teacher-card" data-aos="fade-up">
                        <div class="d-flex align-items-center gap-3 mb-18" style="margin-bottom:18px;">
                            <div class="cp-teacher-avatar-placeholder">
                                <%= teacherInitial %>
                            </div>
                            <div>
                                <div class="cp-teacher-name"><%= teacher %></div>
                                <div class="cp-teacher-title"><%= tTitle %></div>
                                <!-- Rating -->
                                <div class="d-flex align-items-center gap-2 mt-1">
                                    <div class="cp-stars">
                                        <i class="bi bi-star-fill"></i>
                                        <i class="bi bi-star-fill"></i>
                                        <i class="bi bi-star-fill"></i>
                                        <i class="bi bi-star-fill"></i>
                                        <i class="bi bi-star-half"></i>
                                    </div>
                                    <span class="cp-rating-val"><%= rating %></span>
                                    <span class="cp-rating-count">(<%= students %> rəy)</span>
                                </div>
                            </div>
                        </div>

                        <p class="cp-teacher-bio">
                            <%= teacher %> 8 ildən artıq sənayedə aktiv çalışan,
                            <%= tTitle.toLowerCase() %> mütəxəssisidir.
                            Xaricə miqrasiya etmiş onlarca tələbəsi var.
                            Dərsləri sadə, praktik və real dünya nümunələri ilə zəngindir.
                            Tələbə suallarına 24 saat içərisində cavab verir.
                        </p>

                        <div class="row g-3">
                            <div class="col-6 col-md-3">
                                <div class="cp-teacher-stat">
                                    <i class="bi bi-people-fill"></i>
                                    <div>
                                        <div class="fw-800" style="font-size:.95rem;"><%= students %>+</div>
                                        <div style="font-size:.75rem;color:#94a3b8;">Tələbə</div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-6 col-md-3">
                                <div class="cp-teacher-stat">
                                    <i class="bi bi-journal-bookmark-fill"></i>
                                    <div>
                                        <div class="fw-800" style="font-size:.95rem;">5</div>
                                        <div style="font-size:.75rem;color:#94a3b8;">Kurs</div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-6 col-md-3">
                                <div class="cp-teacher-stat">
                                    <i class="bi bi-star-fill"></i>
                                    <div>
                                        <div class="fw-800" style="font-size:.95rem;"><%= rating %></div>
                                        <div style="font-size:.75rem;color:#94a3b8;">Reytinq</div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-6 col-md-3">
                                <div class="cp-teacher-stat">
                                    <i class="bi bi-clock-fill"></i>
                                    <div>
                                        <div class="fw-800" style="font-size:.95rem;">8+</div>
                                        <div style="font-size:.75rem;color:#94a3b8;">İl Təcrübə</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div><!-- /tab-teacher -->

            </div><!-- /col-lg-8 -->

            <!-- Sağ — Sidebar -->
            <div class="col-lg-4" data-aos="fade-left" data-aos-delay="150">
                <div class="cp-enroll-card">

                    <!-- Preview -->
                    <div class="cp-enroll-preview"
                         style="background: linear-gradient(140deg, <%= g1 %> 0%, <%= g2 %> 100%);">
                        <i class="bi <%= icon %>"></i>
                    </div>

                    <div class="cp-enroll-body">

                        <!-- Qiymət -->
                        <div class="cp-enroll-price">
                            <%= price %> ₼
                            <span><%= oldPrice %> ₼</span>
                        </div>
                        <div class="cp-enroll-discount">
                            <i class="bi bi-lightning-fill me-1"></i>
                            <%= Math.round(((double)(oldPrice - price) / oldPrice) * 100) %>% Endirim
                        </div>

                        <!-- Düymələr -->
                        <button class="cp-enroll-btn" id="cpEnrollBtn">
                            <i class="bi bi-lightning-charge-fill"></i>
                            İndi Qeydiyyatdan Keç
                        </button>
                        <button class="cp-try-btn" id="cpTryBtn">
                            <i class="bi bi-play-circle-fill"></i>
                            Pulsuz Sına (3 Dərs)
                        </button>

                        <!-- Nə daxildir -->
                        <ul class="cp-enroll-features">
                            <li><i class="bi bi-check-circle-fill"></i><%= hours %> saat video məzmun</li>
                            <li><i class="bi bi-check-circle-fill"></i><%= lessons %> dərs</li>
                            <li><i class="bi bi-check-circle-fill"></i>Ömürlük giriş</li>
                            <li><i class="bi bi-check-circle-fill"></i>Mobil və masaüstü</li>
                            <li><i class="bi bi-check-circle-fill"></i>Tamamlama sertifikatı</li>
                            <li><i class="bi bi-check-circle-fill"></i>Müəllim dəstəyi</li>
                        </ul>

                    </div>
                </div>

                <!-- Paylaş / Geri düymələri -->
                <div class="d-flex gap-2 mt-3">
                    <button id="cpBackBtn"
                            class="btn btn-outline-secondary flex-fill rounded-3 py-2 fw-600">
                        <i class="bi bi-arrow-left me-1"></i> Geri
                    </button>
                    <button id="cpShareBtn"
                            class="btn btn-outline-secondary rounded-3 py-2 px-3">
                        <i class="bi bi-share-fill"></i>
                    </button>
                    <a href="courses.jsp"
                       class="btn btn-outline-secondary rounded-3 py-2 px-3"
                       title="Bütün Kurslar">
                        <i class="bi bi-grid-3x3-gap-fill"></i>
                    </a>
                </div>

                <!-- Reklam -->
                <div class="mt-4">
                    <jsp:include page="ads-infeed.jsp"/>
                </div>

            </div><!-- /col-lg-4 -->

        </div><!-- /row -->
    </div><!-- /container -->
</div><!-- /cp-main -->

<jsp:include page="footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script src="js/script.js?v=3.0"></script>
<script src="js/ads.js?v=4.0"></script>
<script src="js/course-page.js?v=1.0"></script>
<script>
    AOS.init({ duration: 700, once: true, offset: 50 });
</script>
</body>
</html>
