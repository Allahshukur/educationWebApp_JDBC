<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="az">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- SEO Meta Teqləri -->
    <meta name="description" content="Education App - Dünyanın ən qabaqcıl mütəxəssislərindən öyrənin və karyeranızı yeni zirvələrə daşıyın. Ən yaxşı onlayn kurslar platforması.">
    <meta name="keywords" content="təhsil, onlayn kurslar, proqramlaşdırma, dizayn, sertifikat, öyrənmək, education app, azərbaycan">
    <meta name="author" content="Sukur">
    <meta name="robots" content="index, follow">

    <!-- Open Graph (Sosial media paylaşımları üçün) -->
    <meta property="og:title" content="Education App - Gələcəyinizi Bizimlə Qurun">
    <meta property="og:description" content="Onlayn təhsil platformamızda peşəkar təlimçilər və beynəlxalq sertifikatlarla gələcəyinizi kəşf edin.">
    <meta property="og:type" content="website">
    <meta property="og:url" content="https://www.educationapp.az">
    <meta property="og:image" content="https://img.freepik.com/free-vector/online-learning-concept-illustration_114360-4089.jpg">

    <title>Education App - Gələcəyinizi Bizimlə Qurun</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <!-- AOS CSS -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="css/style.css?v=3.4" rel="stylesheet">
    <link href="css/dark-mode.css?v=1.1" rel="stylesheet">
    <!-- Google Fonts - Outfit + Sora -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700;800;900&family=Sora:wght@400;600;700&display=swap" rel="stylesheet">
</head>
<body class="overflow-hidden-init" style="overflow-x:hidden;max-width:100vw;">

<!-- Elan Xətti -->
<div id="announcementBar">
    <div class="ticker-wrap">
        <div class="ticker">
            <span class="ticker-item">🎉 Yeni: 50+ Kurs Əlavə Edildi! &nbsp;|&nbsp;</span>
            <span class="ticker-item">🔥 Bu Həftə 30% Endirim — Kod: <strong>EDU30</strong> &nbsp;|&nbsp;</span>
            <span class="ticker-item">🏆 15,000+ Tələbə Artıq Bizimlə Öyrənir &nbsp;|&nbsp;</span>
            <span class="ticker-item">📱 Mobil Tətbiq Hazırdır — iOS & Android &nbsp;|&nbsp;</span>
            <span class="ticker-item">✅ Beynəlxalq Sertifikat — LinkedIn-də Paylaş &nbsp;|&nbsp;</span>
            <span class="ticker-item">🎉 Yeni: 50+ Kurs Əlavə Edildi! &nbsp;|&nbsp;</span>
            <span class="ticker-item">🔥 Bu Həftə 30% Endirim — Kod: <strong>EDU30</strong> &nbsp;|&nbsp;</span>
            <span class="ticker-item">🏆 15,000+ Tələbə Artıq Bizimlə Öyrənir &nbsp;|&nbsp;</span>
            <span class="ticker-item">📱 Mobil Tətbiq Hazırdır — iOS & Android &nbsp;|&nbsp;</span>
            <span class="ticker-item">✅ Beynəlxalq Sertifikat — LinkedIn-də Paylaş &nbsp;|&nbsp;</span>
        </div>
    </div>
</div>


<!-- Toast Container -->
<div id="toastContainer"></div>

<!-- Page Loader -->
<div id="loader">
    <div class="loader-content">
        <div class="loader-circle"></div>
        <div class="loader-circle"></div>
        <div class="loader-circle"></div>
        <div class="loader-subtext">Gözləyin, səhifə hazırlanır...</div>
    </div>
</div>

<%
    request.setAttribute("isHome", true);
%>
<jsp:include page="header.jsp" />

<header class="hero-section overflow-hidden py-5" style="position:relative;">
    <canvas id="heroCanvas"></canvas>
    <div class="container py-lg-5">
        <div class="row align-items-center min-vh-75 position-relative">
            <!-- Arxa fon Blobu -->
            <div class="blob-shape"></div>
            
            <div class="col-lg-6 text-center text-lg-start z-index-1" data-aos="fade-right">
                <div class="d-flex gap-2 justify-content-center justify-content-lg-start mb-4 flex-wrap">
                    <div class="badge bg-primary bg-opacity-10 text-primary px-3 py-2 rounded-pill border border-primary border-opacity-25">
                        <i class="bi bi-rocket-takeoff me-2"></i>Təhsilin Yeni Nəsli
                    </div>
                    <div class="online-badge">
                        <span class="online-dot"></span> Canlı Dərslər
                    </div>
                </div>
                <h1 class="display-2 fw-bold mb-4">Gələcəyinizi <span class="text-primary text-gradient">Bizimlə</span> <span id="typingText"></span><span class="typing-cursor"></span></h1>
                <p class="lead text-muted mb-5 fs-4">Dünyanın ən qabaqcıl mütəxəssislərindən öyrənin və karyeranızı yeni zirvələrə daşıyın. 500-dən çox peşəkar kurs sizi gözləyir.</p>
                <div class="d-grid gap-3 d-sm-flex justify-content-sm-center justify-content-lg-start">
                    <button type="button" class="btn btn-primary btn-lg px-5 py-3 rounded-pill shadow-lg hover-lift">
                        İndi Başla <i class="bi bi-arrow-right ms-2"></i>
                    </button>
                    <button type="button" class="btn btn-outline-primary btn-lg px-5 py-3 rounded-pill hover-lift">
                        Kursları Gör
                    </button>
                </div>
                
                <div class="mt-5 d-flex align-items-center justify-content-center justify-content-lg-start gap-4">
                    <div class="d-flex align-items-center">
                        <div class="avatar-group d-flex me-3">
                            <img src="https://i.pravatar.cc/40?u=1" class="rounded-circle border border-2 border-white shadow-sm" style="width: 40px; margin-right: -10px;">
                            <img src="https://i.pravatar.cc/40?u=2" class="rounded-circle border border-2 border-white shadow-sm" style="width: 40px; margin-right: -10px;">
                            <img src="https://i.pravatar.cc/40?u=3" class="rounded-circle border border-2 border-white shadow-sm" style="width: 40px;">
                        </div>
                        <span class="small text-muted fw-bold">15k+ Tələbə</span>
                    </div>
                    <div class="vr h-25 opacity-25"></div>
                    <div>
                        <span class="small text-muted fw-bold"><i class="bi bi-star-fill text-warning me-1"></i> 4.9/5 Reytinq</span>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 mt-5 mt-lg-0 z-index-1" data-aos="fade-left">
                <div class="hero-img-wrapper" style="position:relative;">
                    <img src="https://img.freepik.com/free-vector/online-learning-concept-illustration_114360-4089.jpg" alt="Education" class="img-fluid rounded-4 shadow-2xl floating-img">
                    <!-- Video Play Düyməsi -->
    <div class="play-btn-overlay" onclick="openVideoModal()" title="Tanıtım Videosuna Bax">
                        <i class="bi bi-play-fill ms-1"></i>
                    </div>
                    <!-- Üzən Kartlar -->
                    <div class="position-absolute top-10 start-0 translate-middle-x bg-white p-3 rounded-4 shadow-lg d-none d-md-block animate-float-slow">
                        <div class="d-flex align-items-center gap-3">
                            <div class="bg-success bg-opacity-10 text-success p-2 rounded-3">
                                <i class="bi bi-check-circle-fill fs-4"></i>
                            </div>
                            <div>
                                <h6 class="mb-0 fw-bold">Sertifikatlı Təhsil</h6>
                                <small class="text-muted">Beynəlxalq tanınma</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>

<!-- Statistika Bloku -->
<section class="py-0">
    <div class="container">
        <div class="stats-section p-4 p-lg-5" data-aos="zoom-in">
            <div class="row g-4 text-center">
                <div class="col-6 col-md-3">
                    <div class="stat-item">
                        <h2 class="counter-value" data-target="15000">0</h2>
                        <p class="mb-0 opacity-75">Cəmi Tələbə</p>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="stat-item">
                        <h2 class="counter-value" data-target="450">0</h2>
                        <p class="mb-0 opacity-75">Peşəkar Müəllim</p>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="stat-item">
                        <h2 class="counter-value" data-target="580">0</h2>
                        <p class="mb-0 opacity-75">Onlayn Kurs</p>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="stat-item">
                        <h2 class="counter-value" data-target="98">0</h2>
                        <p class="mb-0 opacity-75">Məmnuniyyət %</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Geri Sayım - Xüsusi Təklif -->
<div id="countdown-section">
    <div class="container">
        <div class="row align-items-center justify-content-between gy-4">
            <div class="col-lg-5" data-aos="fade-right">
                <span class="badge bg-warning text-dark fw-bold px-3 py-2 rounded-pill mb-3 d-inline-block">
                    ⚡ Məhdud Müddətli Təklif
                </span>
                <h3 class="fw-bold mb-2" style="font-family:'Sora',sans-serif;">Bütün Kurslarda <span style="color:#fbbf24;">30% Endirim!</span></h3>
                <p class="opacity-75 mb-0">Kod: <strong>EDU30</strong> — Yalnız bu həftə qüvvədədir</p>
            </div>
            <div class="col-lg-5" data-aos="fade-left">
                <div class="d-flex gap-3 justify-content-center justify-content-lg-end flex-wrap">
                    <div class="countdown-box">
                        <span class="num" id="cd-days">00</span>
                        <div class="lbl">Gün</div>
                    </div>
                    <div class="countdown-box">
                        <span class="num" id="cd-hours">00</span>
                        <div class="lbl">Saat</div>
                    </div>
                    <div class="countdown-box">
                        <span class="num" id="cd-mins">00</span>
                        <div class="lbl">Dəqiqə</div>
                    </div>
                    <div class="countdown-box">
                        <span class="num" id="cd-secs">00</span>
                        <div class="lbl">Saniyə</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Trend Mövzular -->
<section class="py-4 border-bottom">
    <div class="container">
        <div class="d-flex align-items-center gap-3 mb-3">
            <span class="fw-bold text-primary"><i class="bi bi-graph-up-arrow me-1"></i> Trend:</span>
        </div>
        <div class="trending-scroll">
            <span class="topic-pill" style="color:#4f46e5;border-color:#4f46e5;background:rgba(79,70,229,0.07)">🐍 Python</span>
            <span class="topic-pill" style="color:#0ea5e9;border-color:#0ea5e9;background:rgba(14,165,233,0.07)">⚛️ React</span>
            <span class="topic-pill" style="color:#f59e0b;border-color:#f59e0b;background:rgba(245,158,11,0.07)">🤖 Süni İntellekt</span>
            <span class="topic-pill" style="color:#10b981;border-color:#10b981;background:rgba(16,185,129,0.07)">☕ Java</span>
            <span class="topic-pill" style="color:#ec4899;border-color:#ec4899;background:rgba(236,72,153,0.07)">🎨 UI/UX Dizayn</span>
            <span class="topic-pill" style="color:#8b5cf6;border-color:#8b5cf6;background:rgba(139,92,246,0.07)">📊 Data Science</span>
            <span class="topic-pill" style="color:#ef4444;border-color:#ef4444;background:rgba(239,68,68,0.07)">🛡️ Kibertəhlükəsizlik</span>
            <span class="topic-pill" style="color:#06b6d4;border-color:#06b6d4;background:rgba(6,182,212,0.07)">☁️ Cloud (AWS)</span>
            <span class="topic-pill" style="color:#84cc16;border-color:#84cc16;background:rgba(132,204,22,0.07)">📱 Flutter</span>
            <span class="topic-pill" style="color:#f97316;border-color:#f97316;background:rgba(249,115,22,0.07)">🎯 DevOps</span>
        </div>
    </div>
</section>

<section id="features" class="py-5 mt-5">
    <div class="container py-5">
        <div class="text-center mb-5" data-aos="fade-up">
            <span class="text-primary fw-bold text-uppercase letter-spacing-2">Üstünlüklərimiz</span>
            <h2 class="fw-bold display-4 mt-2">Niyə Biz?</h2>
            <p class="text-muted lead mx-auto" style="max-width: 600px;">Platformamız tələbələr üçün ən müasir və effektiv öyrənmə metodikasını təklif edir.</p>
        </div>
        <div class="row g-4">
            <div class="col-md-4" data-aos="fade-up" data-aos-delay="100">
                <div class="card h-100 border-0 shadow-sm p-4 feature-card glass-card">
                    <div class="feature-icon bg-primary bg-opacity-10 text-primary mb-4 rounded-4 d-inline-flex align-items-center justify-content-center" style="width: 70px; height: 70px;">
                        <i class="bi bi-clock-history fs-2"></i>
                    </div>
                    <h4 class="fw-bold mb-3">İstənilən Zaman</h4>
                    <p class="text-muted fs-5">Dərslərə öz vaxtınıza uyğun, 7/24 daxil ola bilərsiniz. Limitsiz giriş imkanı.</p>
                    <a href="#" class="text-primary text-decoration-none fw-bold mt-auto">Ətraflı <i class="bi bi-arrow-right ms-1"></i></a>
                </div>
            </div>
            <div class="col-md-4" data-aos="fade-up" data-aos-delay="200">
                <div class="card h-100 border-0 shadow-sm p-4 feature-card active glass-card border-primary border-opacity-10">
                    <div class="feature-icon bg-primary bg-opacity-10 text-primary mb-4 rounded-4 d-inline-flex align-items-center justify-content-center" style="width: 70px; height: 70px;">
                        <i class="bi bi-person-badge fs-2"></i>
                    </div>
                    <h4 class="fw-bold mb-3">Peşəkar Təlimçilər</h4>
                    <p class="text-muted fs-5">Sahəsinin mütəxəssisləri tərəfindən hazırlanmış real layihələr üzərində qurulan kurslar.</p>
                    <a href="#" class="text-primary text-decoration-none fw-bold mt-auto">Ətraflı <i class="bi bi-arrow-right ms-1"></i></a>
                </div>
            </div>
            <div class="col-md-4" data-aos="fade-up" data-aos-delay="300">
                <div class="card h-100 border-0 shadow-sm p-4 feature-card glass-card">
                    <div class="feature-icon bg-primary bg-opacity-10 text-primary mb-4 rounded-4 d-inline-flex align-items-center justify-content-center" style="width: 70px; height: 70px;">
                        <i class="bi bi-award fs-2"></i>
                    </div>
                    <h4 class="fw-bold mb-3">Sertifikat</h4>
                    <p class="text-muted fs-5">Kursu bitirdikdə beynəlxalq dərəcəli, LinkedIn-də paylaşıla bilən sertifikat.</p>
                    <a href="#" class="text-primary text-decoration-none fw-bold mt-auto">Ətraflı <i class="bi bi-arrow-right ms-1"></i></a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Kurslar Bölməsi -->
<section id="courses" class="py-5 bg-light border-top border-bottom">
    <div class="container py-5">
        <div class="d-md-flex align-items-center justify-content-between mb-5" data-aos="fade-up">
            <div>
                <h2 class="fw-bold display-5 mb-0">Populyar Kurslar</h2>
                <p class="text-muted lead mb-0">Ən çox tələb olunan sahələr</p>
            </div>
            <div class="mt-4 mt-md-0">
                <a href="#" class="btn btn-primary rounded-pill px-4 py-2">Bütün Kurslara Bax</a>
            </div>
        </div>
        
        <div class="row g-4">
            <!-- Java Kursu -->
            <div class="col-lg-4 col-md-6" data-aos="zoom-in" data-aos-delay="100">
                <div class="card h-100 course-card shadow-sm border-0">
                    <div class="course-img-wrapper position-relative">
                        <img src="https://images.unsplash.com/photo-1587620962725-abab7fe55159?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60" class="card-img-top" alt="Java">
                        <span class="badge bg-primary course-badge">Bestseller</span>
                        <div class="course-overlay">
                            <button class="btn btn-light rounded-pill px-4">İndi Qoşul</button>
                        </div>
                    </div>
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <span class="badge bg-primary bg-opacity-10 text-primary px-3 py-2 rounded-pill">Backend</span>
                            <span class="text-muted small"><i class="bi bi-clock me-1"></i> 48 Saat</span>
                        </div>
                        <h5 class="fw-bold card-title mb-3">Java Proqramlaşdırma: Sıfırdan Peşəkara</h5>
                        <div class="d-flex align-items-center mb-4">
                            <img src="https://i.pravatar.cc/32?u=9" class="rounded-circle me-2" alt="Instructor">
                            <span class="small text-muted">Nicat Məmmədov</span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center pt-3 border-top">
                            <div class="text-primary fw-bold fs-4">99.00 ₼</div>
                            <div class="text-warning small">
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <span class="text-muted ms-1">(120)</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- UI/UX Kursu -->
            <div class="col-lg-4 col-md-6" data-aos="zoom-in" data-aos-delay="200">
                <div class="card h-100 course-card shadow-sm border-0">
                    <div class="course-img-wrapper position-relative">
                        <img src="https://images.unsplash.com/photo-1561070791-2526d30994b5?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60" class="card-img-top" alt="UI/UX">
                        <span class="badge bg-success course-badge">Yeni</span>
                        <div class="course-overlay">
                            <button class="btn btn-light rounded-pill px-4">İndi Qoşul</button>
                        </div>
                    </div>
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <span class="badge bg-success bg-opacity-10 text-success px-3 py-2 rounded-pill">Dizayn</span>
                            <span class="text-muted small"><i class="bi bi-clock me-1"></i> 32 Saat</span>
                        </div>
                        <h5 class="fw-bold card-title mb-3">Müasir UI/UX Dizayn və Figma</h5>
                        <div class="d-flex align-items-center mb-4">
                            <img src="https://i.pravatar.cc/32?u=12" class="rounded-circle me-2" alt="Instructor">
                            <span class="small text-muted">Aysel Əliyeva</span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center pt-3 border-top">
                            <div class="text-primary fw-bold fs-4">79.00 ₼</div>
                            <div class="text-warning small">
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-half"></i>
                                <span class="text-muted ms-1">(85)</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Data Science Kursu -->
            <div class="col-lg-4 col-md-6" data-aos="zoom-in" data-aos-delay="300">
                <div class="card h-100 course-card shadow-sm border-0">
                    <div class="course-img-wrapper position-relative">
                        <img src="https://upload.wikimedia.org/wikipedia/commons/c/c3/Python-logo-notext.svg" class="card-img-top" alt="Data Science">
                        <div class="course-overlay">
                            <button class="btn btn-light rounded-pill px-4">İndi Qoşul</button>
                        </div>
                    </div>
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <span class="badge bg-info bg-opacity-10 text-info px-3 py-2 rounded-pill">Data Science</span>
                            <span class="text-muted small"><i class="bi bi-clock me-1"></i> 60 Saat</span>
                        </div>
                        <h5 class="fw-bold card-title mb-3">Python ilə Data Science və ML</h5>
                        <div class="d-flex align-items-center mb-4">
                            <img src="https://i.pravatar.cc/32?u=4" class="rounded-circle me-2" alt="Instructor">
                            <span class="small text-muted">Elvin Həsənov</span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center pt-3 border-top">
                            <div class="text-primary fw-bold fs-4">120.00 ₼</div>
                            <div class="text-warning small">
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i>
                                <span class="text-muted ms-1">(154)</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Necə İşləyir -->
<section id="how-it-works" class="py-5 bg-primary bg-opacity-5">
    <div class="container py-5">
        <div class="text-center mb-5" data-aos="fade-up">
            <span class="text-primary fw-bold text-uppercase letter-spacing-2">Necə İşləyir</span>
            <h2 class="fw-bold display-4 mt-2">3 Sadə Addımda Başlayın</h2>
        </div>
        <div class="row g-4">
            <div class="col-md-4 text-center" data-aos="fade-up" data-aos-delay="100">
                <div class="step-number bg-primary bg-opacity-10 text-primary mx-auto mb-4">1</div>
                <h4 class="fw-bold mb-3">Qeydiyyatdan Keçin</h4>
                <p class="text-muted">Email və şifrə ilə sürətli qeydiyyat. Facebook və ya Google ilə də giriş edə bilərsiniz.</p>
            </div>
            <div class="col-md-4 text-center" data-aos="fade-up" data-aos-delay="200">
                <div class="step-number bg-primary bg-opacity-10 text-primary mx-auto mb-4">2</div>
                <h4 class="fw-bold mb-3">Kurs Seçin</h4>
                <p class="text-muted">Minlərlə kurs arasından maraqlarınıza uyğun olanı seçin və ya kateqoriyalara baxın.</p>
            </div>
            <div class="col-md-4 text-center" data-aos="fade-up" data-aos-delay="300">
                <div class="step-number bg-primary bg-opacity-10 text-primary mx-auto mb-4">3</div>
                <h4 class="fw-bold mb-3">Öyrənməyə Başlayın</h4>
                <p class="text-muted">Video dərslər, tapşırıqlar və real layihələrlə biliklərinizi artırın.</p>
            </div>
        </div>
    </div>
</section>

<!-- Müəllimlər Bölməsi -->
<section id="instructors" class="py-5">
    <div class="container py-5">
        <div class="text-center mb-5" data-aos="fade-up">
            <span class="text-primary fw-bold text-uppercase letter-spacing-2">Təlimçilərimiz</span>
            <h2 class="fw-bold display-4 mt-2">Peşəkar Müəllimlər Komandası</h2>
            <p class="text-muted lead mx-auto" style="max-width: 600px;">Sahəsinin ən yaxşı mütəxəssisləri sizə ən keyfiyyətli təhsili təqdim edir.</p>
        </div>
        <div class="row g-4">
            <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
                <div class="card border-0 shadow-sm text-center instructor-card">
                    <div class="card-body p-4">
                        <img src="https://i.pravatar.cc/150?u=inst1" class="rounded-circle mb-3 shadow" alt="Instructor" style="width: 120px; height: 120px; object-fit: cover;">
                        <h5 class="fw-bold mb-1">Nicat Məmmədov</h5>
                        <p class="text-primary small mb-3">Java Backend Developer</p>
                        <div class="d-flex justify-content-center gap-3">
                            <a href="#" class="text-muted"><i class="bi bi-linkedin fs-5"></i></a>
                            <a href="#" class="text-muted"><i class="bi bi-github fs-5"></i></a>
                            <a href="#" class="text-muted"><i class="bi bi-twitter-x fs-5"></i></a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
                <div class="card border-0 shadow-sm text-center instructor-card">
                    <div class="card-body p-4">
                        <img src="https://i.pravatar.cc/150?u=inst2" class="rounded-circle mb-3 shadow" alt="Instructor" style="width: 120px; height: 120px; object-fit: cover;">
                        <h5 class="fw-bold mb-1">Aysel Əliyeva</h5>
                        <p class="text-primary small mb-3">UX/UI Designer</p>
                        <div class="d-flex justify-content-center gap-3">
                            <a href="#" class="text-muted"><i class="bi bi-linkedin fs-5"></i></a>
                            <a href="#" class="text-muted"><i class="bi bi-dribbble fs-5"></i></a>
                            <a href="#" class="text-muted"><i class="bi bi-behance fs-5"></i></a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                <div class="card border-0 shadow-sm text-center instructor-card">
                    <div class="card-body p-4">
                        <img src="https://i.pravatar.cc/150?u=inst3" class="rounded-circle mb-3 shadow" alt="Instructor" style="width: 120px; height: 120px; object-fit: cover;">
                        <h5 class="fw-bold mb-1">Elvin Həsənov</h5>
                        <p class="text-primary small mb-3">Data Scientist</p>
                        <div class="d-flex justify-content-center gap-3">
                            <a href="#" class="text-muted"><i class="bi bi-linkedin fs-5"></i></a>
                            <a href="#" class="text-muted"><i class="bi bi-github fs-5"></i></a>
                            <a href="#" class="text-muted"><i class="bi bi-kaggle fs-5"></i></a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                <div class="card border-0 shadow-sm text-center instructor-card">
                    <div class="card-body p-4">
                        <img src="https://i.pravatar.cc/150?u=inst4" class="rounded-circle mb-3 shadow" alt="Instructor" style="width: 120px; height: 120px; object-fit: cover;">
                        <h5 class="fw-bold mb-1">Sara Əkbərova</h5>
                        <p class="text-primary small mb-3">Frontend Developer</p>
                        <div class="d-flex justify-content-center gap-3">
                            <a href="#" class="text-muted"><i class="bi bi-linkedin fs-5"></i></a>
                            <a href="#" class="text-muted"><i class="bi bi-github fs-5"></i></a>
                            <a href="#" class="text-muted"><i class="bi bi-twitter-x fs-5"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Bacarıq Statistikaları -->
<section class="py-5">
    <div class="container py-5">
        <div class="row align-items-center g-5">
            <div class="col-lg-5" data-aos="fade-right">
                <span class="text-primary fw-bold text-uppercase" style="letter-spacing:2px;">Niyə Bizi Seçirlər</span>
                <h2 class="fw-bold display-4 mt-2 mb-4">Rəqəmlər Özü Danışır</h2>
                <p class="text-muted lead mb-4">Platformamızdakı tələbələrin 95%-i kursdan sonra yeni iş tapır və ya maaşını artırır.</p>
                <div id="skillBars">
                    <div class="skill-bar-wrap">
                        <div class="skill-label"><span>Tələbə Məmnuniyyəti</span><span class="text-primary">98%</span></div>
                        <div class="skill-track"><div class="skill-fill" data-width="98"></div></div>
                    </div>
                    <div class="skill-bar-wrap">
                        <div class="skill-label"><span>İş Tapma Faizi</span><span class="text-primary">95%</span></div>
                        <div class="skill-track"><div class="skill-fill" data-width="95" style="background:linear-gradient(90deg,#0ea5e9,#6366f1)"></div></div>
                    </div>
                    <div class="skill-bar-wrap">
                        <div class="skill-label"><span>Kurs Tamamlama</span><span class="text-primary">87%</span></div>
                        <div class="skill-track"><div class="skill-fill" data-width="87" style="background:linear-gradient(90deg,#10b981,#0ea5e9)"></div></div>
                    </div>
                    <div class="skill-bar-wrap">
                        <div class="skill-label"><span>Geri Qayıdan Tələbə</span><span class="text-primary">76%</span></div>
                        <div class="skill-track"><div class="skill-fill" data-width="76" style="background:linear-gradient(90deg,#f59e0b,#ef4444)"></div></div>
                    </div>
                </div>
            </div>
            <div class="col-lg-7" data-aos="fade-left">
                <div class="row g-4">
                    <div class="col-6">
                        <div class="card border-0 rounded-4 p-4 h-100 text-center" style="background:linear-gradient(135deg,#ede9fe,#ddd6fe)">
                            <i class="bi bi-mortarboard-fill text-primary mb-3" style="font-size:2.5rem;"></i>
                            <h3 class="fw-bold text-primary mb-1">5,000+</h3>
                            <p class="text-muted mb-0 fw-semibold">Uğurlu Məzun</p>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="card border-0 rounded-4 p-4 h-100 text-center" style="background:linear-gradient(135deg,#d1fae5,#a7f3d0)">
                            <i class="bi bi-briefcase-fill mb-3" style="font-size:2.5rem;color:#059669;"></i>
                            <h3 class="fw-bold mb-1" style="color:#059669;">150+</h3>
                            <p class="text-muted mb-0 fw-semibold">Şirkət Partnyor</p>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="card border-0 rounded-4 p-4 h-100 text-center" style="background:linear-gradient(135deg,#fef3c7,#fde68a)">
                            <i class="bi bi-award-fill mb-3" style="font-size:2.5rem;color:#d97706;"></i>
                            <h3 class="fw-bold mb-1" style="color:#d97706;">580+</h3>
                            <p class="text-muted mb-0 fw-semibold">Onlayn Kurs</p>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="card border-0 rounded-4 p-4 h-100 text-center" style="background:linear-gradient(135deg,#fce7f3,#fbcfe8)">
                            <i class="bi bi-globe2 mb-3" style="font-size:2.5rem;color:#db2777;"></i>
                            <h3 class="fw-bold mb-1" style="color:#db2777;">40+</h3>
                            <p class="text-muted mb-0 fw-semibold">Ölkədən Tələbə</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Şirkətlər/Partnyorlar -->
<section class="py-5 bg-light border-top border-bottom">
    <div class="container py-4">
        <div class="text-center mb-4" data-aos="fade-up">
            <p class="text-muted small fw-bold text-uppercase mb-0">İşə Götürən Şirkətlər</p>
        </div>
        <div class="d-flex flex-wrap justify-content-center align-items-center gap-5 opacity-50" data-aos="fade-up">
            <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Google_2015_logo.svg/2560px-Google_2015_logo.svg.png" alt="Google" height="30">
            <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/Meta-Logo.png/2560px-Meta-Logo.png" alt="Meta" height="30">
            <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/96/Microsoft_logo_%282012%29.svg/2560px-Microsoft_logo_%282012%29.svg.png" alt="Microsoft" height="30">
            <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/IBM_logo.svg/2560px-IBM_logo.svg.png" alt="IBM" height="30">
            <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Amazon_logo.svg/2560px-Amazon_logo.svg.png" alt="Amazon" height="30">
        </div>
    </div>
</section>

<!-- Rəylər Bölməsi -->
<section class="py-5 overflow-hidden">
    <div class="container py-5">
        <div class="row align-items-center">
            <div class="col-lg-5 mb-5 mb-lg-0" data-aos="fade-right">
                <span class="text-primary fw-bold text-uppercase letter-spacing-2">Tələbə Rəyləri</span>
                <h2 class="fw-bold display-4 mt-2">Tələbələrimiz Nə Deyir?</h2>
                <p class="text-muted lead mt-4 mb-5 pe-lg-5">Məzunlarımızın uğur hekayələri bizim üçün ən böyük motivasiyadır. Siz də onlardan biri olun.</p>
                <div class="d-flex gap-4">
                    <div class="text-center">
                        <h3 class="fw-bold text-primary mb-0">5000+</h3>
                        <p class="text-muted small fw-bold">Uğurlu Məzun</p>
                    </div>
                    <div class="vr"></div>
                    <div class="text-center">
                        <h3 class="fw-bold text-primary mb-0">150+</h3>
                        <p class="text-muted small fw-bold">Şirkət İnteqrasiyası</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-7" data-aos="fade-left">
                <div class="card border-0 shadow-lg p-4 p-lg-5 glass-card position-relative">
                    <i class="bi bi-quote text-primary opacity-10 position-absolute end-0 bottom-0 display-1 me-4 mb-4"></i>
                    <div class="d-flex align-items-center mb-4">
                        <img src="https://i.pravatar.cc/80?u=student1" class="rounded-circle shadow me-3" alt="Student">
                        <div>
                            <h5 class="fw-bold mb-0">Orxan Bağırov</h5>
                            <p class="text-muted small mb-0">Java Developer @ Google</p>
                        </div>
                    </div>
                    <p class="fs-5 text-muted fst-italic mb-0">"Bu platforma sayəsində proqramlaşdırma dünyasına ilk addımlarımı atdım. Kursların keyfiyyəti və müəllimlərin dəstəyi mənim karyeramda dönüş nöqtəsi oldu."</p>
                    <div class="text-warning mt-3">
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- FAQ Bölməsi -->
<section id="faq" class="py-5 bg-light">
    <div class="container py-5">
        <div class="text-center mb-5" data-aos="fade-up">
            <span class="text-primary fw-bold text-uppercase letter-spacing-2">FAQ</span>
            <h2 class="fw-bold display-4 mt-2">Tez-tez Verilən Suallar</h2>
        </div>
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="accordion" id="faqAccordion">
                    <div class="accordion-item border-0 mb-3 shadow-sm" data-aos="fade-up" data-aos-delay="100">
                        <h2 class="accordion-header">
                            <button class="accordion-button fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#faq1">
                                Kurslara necə qoşula bilərəm?
                            </button>
                        </h2>
                        <div id="faq1" class="accordion-collapse collapse show" data-bs-parent="#faqAccordion">
                            <div class="accordion-body text-muted">
                                Qeydiyyatdan keçdikdən sonra istədiyiniz kursu seçin və "İndi Başla" düyməsinə klikləyin. Kurs dərhal sizin hesabınıza əlavə olunacaq.
                            </div>
                        </div>
                    </div>
                    <div class="accordion-item border-0 mb-3 shadow-sm" data-aos="fade-up" data-aos-delay="200">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#faq2">
                                Sertifikat necə əldə edə bilərəm?
                            </button>
                        </h2>
                        <div id="faq2" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                            <div class="accordion-body text-muted">
                                Kursu 100% tamamladıqdan və bütün tapşırıqları yerinə yetirdikdən sonra avtomatik olaraq sertifikat əldə edəcəksiniz.
                            </div>
                        </div>
                    </div>
                    <div class="accordion-item border-0 mb-3 shadow-sm" data-aos="fade-up" data-aos-delay="300">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#faq3">
                                Ödəniş üsulları hansılardır?
                            </button>
                        </h2>
                        <div id="faq3" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                            <div class="accordion-body text-muted">
                                Visa, MasterCard, bank kartları və bir çox elektron pul kisəsi ilə ödəniş edə bilərsiniz. Bütün ödənişlər təhlükəsizdir.
                            </div>
                        </div>
                    </div>
                    <div class="accordion-item border-0 shadow-sm" data-aos="fade-up" data-aos-delay="400">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#faq4">
                                Pulsuz kurslar varmı?
                            </button>
                        </h2>
                        <div id="faq4" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                            <div class="accordion-body text-muted">
                                Bəli! Platformamızda 50+-dən çox pulsuz kurs mövcuddur. Bundan əlavə, ilk qeydiyyatda 20% endirim kuponu əldə edirsiniz.
                            </div>
                        </div>
                    </div>
                    <div class="accordion-item border-0 shadow-sm mt-3" data-aos="fade-up" data-aos-delay="500">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#faq5">
                                Mobil tətbiq mövcuddurmu?
                            </button>
                        </h2>
                        <div id="faq5" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                            <div class="accordion-body text-muted">
                                Bəli! iOS və Android üçün mobil tətbiqimiz mövcuddur. Tətbiqi yükləyərək dərslərə istənilən yerdən, internet olmadan da daxil ola bilərsiniz.
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Newsletter -->
<section class="py-5 bg-primary">
    <div class="container py-5">
        <div class="row align-items-center">
            <div class="col-lg-6 text-white mb-4 mb-lg-0" data-aos="fade-right">
                <h2 class="fw-bold display-5 mb-3">Yeniliklərdən Xəbərdar Olun</h2>
                <p class="opacity-75 mb-0">Ən yeni kurslar, endirimler və məqalələr haqqında email alın.</p>
            </div>
            <div class="col-lg-6" data-aos="fade-left">
                <form class="d-flex gap-2">
                    <input type="email" class="form-control form-control-lg rounded-pill" placeholder="Email ünvanınız...">
                    <button type="submit" class="btn btn-light btn-lg rounded-pill px-4 fw-bold">Abunə Ol</button>
                </form>
            </div>
        </div>
    </div>
</section>

<!-- CTA Bölməsi -->
<section class="py-5">
    <div class="container py-5">
        <div class="card bg-primary border-0 rounded-4 p-5 text-center text-white position-relative overflow-hidden" data-aos="zoom-in">
            <div class="blob-shape-light"></div>
            <div class="position-relative z-index-1">
                <h2 class="fw-bold display-4 mb-3">Gələcəyinizi Bugün Başladın!</h2>
                <p class="lead opacity-75 mb-4 mx-auto" style="max-width: 600px;">Minlərlə tələbə artıq karyeralarını dəyişib. Siz də bu gün başlayın və 7 gün ərzində tam pul geri zəmanəti əldə edin.</p>
                <div class="d-flex flex-wrap justify-content-center gap-3">
                    <a href="register.jsp" class="btn btn-light btn-lg rounded-pill px-5 fw-bold">
                        <i class="bi bi-person-plus me-2"></i>Qeydiyyatdan Keç
                    </a>
                    <a href="#courses" class="btn btn-outline-light btn-lg rounded-pill px-5">
                        <i class="bi bi-grid me-2"></i>Kurslara Bax
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="footer.jsp" />

<!-- Yuxarı Qayıt Düyməsi -->
<button id="backToTop" class="btn btn-primary">
    <i class="bi bi-arrow-up"></i>
</button>

<!-- Video Modal -->
<div id="videoModal" onclick="closeVideoModal()">
    <div class="modal-inner" onclick="event.stopPropagation()">
        <button class="modal-close-btn" onclick="closeVideoModal()">×</button>
        <div class="modal-placeholder">
            <i class="bi bi-play-circle-fill" style="font-size:4rem;color:#6366f1;"></i>
            <h4 class="mt-3">Tanıtım Videosu</h4>
            <p class="opacity-60">Videonu izləmək üçün YouTube linki əlavə edin</p>
        </div>
    </div>
</div>

<!-- Canlı Dəstək Widget -->
<button id="chatBubble" onclick="toggleChat()" title="Dəstək ilə əlaqə">
    <i class="bi bi-chat-dots-fill"></i>
</button>
<div id="chatPanel">
    <div class="chat-header d-flex align-items-center gap-3">
        <div style="width:40px;height:40px;background:rgba(255,255,255,0.2);border-radius:50%;display:flex;align-items:center;justify-content:center;">
            <i class="bi bi-headset"></i>
        </div>
        <div>
            <div class="fw-bold">Canlı Dəstək</div>
            <div style="font-size:12px;opacity:0.8;"><span class="online-dot d-inline-block me-1"></span> Onlayn</div>
        </div>
        <button onclick="toggleChat()" style="margin-left:auto;background:none;border:none;color:white;font-size:18px;">×</button>
    </div>
    <div class="chat-body">
        <div class="chat-msg">Salam! 👋 Sizə necə kömək edə bilərəm?</div>
        <div class="chat-msg mt-2">Kurslar, qiymətlər və ya digər suallarınız üçün buradayam!</div>
    </div>
    <div class="chat-input-row">
        <input type="text" id="chatInput" class="form-control rounded-pill form-control-sm" placeholder="Mesaj yazın...">
        <button class="btn btn-primary btn-sm rounded-pill px-3" onclick="sendChat()"><i class="bi bi-send-fill"></i></button>
    </div>
</div>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- AOS JS -->
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<!-- Custom JS -->
<script src="js/script.js?v=2.2"></script>
<script>
    AOS.init({ duration: 1000, once: true, offset: 100 });
</script>

</body>
</html>