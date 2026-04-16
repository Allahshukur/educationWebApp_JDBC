<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="az">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Haqqımızda — Education App</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link href="css/style.css?v=3.5" rel="stylesheet">
    <link href="css/dark-mode.css?v=1.0" rel="stylesheet">
    <link href="css/ads.css?v=4.0" rel="stylesheet">
    <link href="css/about.css?v=1.0" rel="stylesheet">
    <style>.page-breadcrumb-bar{display:none!important}</style>
</head>
<body class="overflow-hidden-init ab-page">

<div id="loader">
    <div class="loader-content">
        <div class="loader-circle"></div><div class="loader-circle"></div><div class="loader-circle"></div>
        <div class="loader-subtext">Yüklənir...</div>
    </div>
</div>

<% request.setAttribute("pageLabel","Haqqımızda"); request.setAttribute("isHome",false); %>
<jsp:include page="header.jsp"/>

<!-- ══ HERO ══════════════════════════════════════ -->
<div class="ab-hero">
    <div class="container position-relative" style="z-index:2;">

        <nav class="d-flex align-items-center gap-2 justify-content-center mb-4" style="font-size:.80rem;font-weight:600;color:rgba(255,255,255,.55);">
            <a href="index.jsp" style="color:rgba(255,255,255,.55);text-decoration:none;"><i class="bi bi-house-fill me-1"></i>Anasəhfə</a>
            <i class="bi bi-chevron-right" style="font-size:.65rem;"></i>
            <span style="color:#a5b4fc;">Haqqımızda</span>
        </nav>

        <div class="ab-hero-label" data-aos="fade-down">
            <i class="bi bi-mortarboard-fill"></i> Azərbaycanın Aparıcı Online Məktəbi
        </div>
        <h1 class="ab-hero-title" data-aos="fade-up" data-aos-delay="60">
            Bilik <span>Gücə</span><br>Dönüşür
        </h1>
        <p class="ab-hero-sub mx-auto" data-aos="fade-up" data-aos-delay="120">
            Biz 2020-ci ildən bəri Azərbaycanın gənclərini rəqəmsal dünyaya hazırlayır,
            peşəkar müəllimlərimizlə keyfiyyətli təhsil imkanı yaradırıq.
        </p>

        <div class="ab-hero-stats" data-aos="fade-up" data-aos-delay="180">
            <div class="ab-hstat">
                <div class="ab-hstat-val">500+</div>
                <div class="ab-hstat-lbl">Mezun</div>
            </div>
            <div class="ab-hstat">
                <div class="ab-hstat-val">10</div>
                <div class="ab-hstat-lbl">Aktiv Kurs</div>
            </div>
            <div class="ab-hstat">
                <div class="ab-hstat-val">15+</div>
                <div class="ab-hstat-lbl">Müəllim</div>
            </div>
            <div class="ab-hstat">
                <div class="ab-hstat-val">4.8★</div>
                <div class="ab-hstat-lbl">Ortalama Reytinq</div>
            </div>
        </div>
    </div>
</div>

<!-- ══ MİSSİYA / VİZYON ════════════════════════════ -->
<div class="ab-section" style="background:#fff;">
<div class="container">
    <div class="row g-4 align-items-center">
        <div class="col-lg-5" data-aos="fade-right">
            <span class="ab-section-label">Kimik Biz?</span>
            <h2 class="ab-section-title">Missiya &amp; Vizyon</h2>
            <p class="ab-section-sub">
                Hər gənci texnologiya sahəsində inkişaf etdirmək,
                onlara peşəkar karyera qurmaq üçün lazım olan bilik
                və bacarıqları vermək — bizim əsas missiyamızdır.
            </p>
        </div>
        <div class="col-lg-7">
            <div class="row g-3">
                <div class="col-sm-6" data-aos="fade-up" data-aos-delay="0">
                    <div class="ab-mv-card" style="background:linear-gradient(135deg,rgba(79,70,229,.05),rgba(124,58,237,.05));">
                        <div class="ab-mv-icon" style="background:rgba(79,70,229,.12);">
                            <i class="bi bi-bullseye" style="color:#4f46e5;font-size:1.4rem;"></i>
                        </div>
                        <div class="ab-mv-title">Missiyamız</div>
                        <p class="ab-mv-text">
                            Keyfiyyətli, əlçatan və praktik təhsil vasitəsilə
                            Azərbaycanın rəqəmsal gələcəyini formalaşdırmaq.
                        </p>
                    </div>
                </div>
                <div class="col-sm-6" data-aos="fade-up" data-aos-delay="80">
                    <div class="ab-mv-card" style="background:linear-gradient(135deg,rgba(16,185,129,.05),rgba(13,148,136,.05));">
                        <div class="ab-mv-icon" style="background:rgba(16,185,129,.12);">
                            <i class="bi bi-eye-fill" style="color:#10b981;font-size:1.4rem;"></i>
                        </div>
                        <div class="ab-mv-title">Vizyonumuz</div>
                        <p class="ab-mv-text">
                            2030-cu ilə qədər Azərbaycanın hər rayonunda
                            rəqəmsal savad səviyyəsini yüksəltmək.
                        </p>
                    </div>
                </div>
                <div class="col-sm-6" data-aos="fade-up" data-aos-delay="160">
                    <div class="ab-mv-card" style="background:linear-gradient(135deg,rgba(245,158,11,.05),rgba(220,38,38,.05));">
                        <div class="ab-mv-icon" style="background:rgba(245,158,11,.12);">
                            <i class="bi bi-star-fill" style="color:#f59e0b;font-size:1.4rem;"></i>
                        </div>
                        <div class="ab-mv-title">Keyfiyyət</div>
                        <p class="ab-mv-text">
                            Hər kurs sənaye standartlarına uyğun hazırlanır,
                            real layihələrlə dəstəklənir.
                        </p>
                    </div>
                </div>
                <div class="col-sm-6" data-aos="fade-up" data-aos-delay="240">
                    <div class="ab-mv-card" style="background:linear-gradient(135deg,rgba(14,165,233,.05),rgba(79,70,229,.05));">
                        <div class="ab-mv-icon" style="background:rgba(14,165,233,.12);">
                            <i class="bi bi-people-fill" style="color:#0ea5e9;font-size:1.4rem;"></i>
                        </div>
                        <div class="ab-mv-title">İcma</div>
                        <p class="ab-mv-text">
                            Tələbələrimiz məzun olduqdan sonra da güclü
                            peşəkar şəbəkəyə qoşulur.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>

<!-- ══ DƏYƏRLƏR ════════════════════════════════════ -->
<div class="ab-section">
<div class="container">
    <div class="text-center mb-5" data-aos="fade-up">
        <span class="ab-section-label">Nə Üçün Biz?</span>
        <h2 class="ab-section-title mx-auto" style="max-width:500px;">Əsas Dəyərlərimiz</h2>
    </div>
    <div class="row g-3">
        <%
        String[][] values = {
            {"bi-lightning-charge-fill","rgba(79,70,229,.12)","#4f46e5","Praktik Yanaşma","Hər dərs real dünya nümunələri ilə dəstəklənir. Nəzəriyyəni öyrən, dərhal tətbiq et."},
            {"bi-clock-fill","rgba(245,158,11,.12)","#f59e0b","Çevik Qrafik","Öz sürətinlə öyrən. Dərslər 24/7 əlçatandır, sən seçirsən."},
            {"bi-shield-check-fill","rgba(16,185,129,.12)","#10b981","Sertifikatlı Kurslar","Hər kurs tamamlandıqda beynəlxalq standartlara uyğun sertifikat alırsın."},
            {"bi-headset","rgba(14,165,233,.12)","#0ea5e9","Davamlı Dəstək","Müəllimlər 24 saat içərisində suallarına cavab verir."},
            {"bi-graph-up-arrow","rgba(124,58,237,.12)","#7c3aed","Karyera Dəstəyi","Mezunlara CV hazırlama, müsahibə hazırlığı, iş axtarışında kömək edirik."},
            {"bi-translate","rgba(244,63,94,.12)","#f43f5e","Azərbaycan dilində","Bütün kurslar ana dilimizdə — anlamaq çətin olmayacaq."}
        };
        for (int i=0;i<values.length;i++) { %>
        <div class="col-sm-6 col-lg-4" data-aos="fade-up" data-aos-delay="<%= i*60 %>">
            <div class="ab-value">
                <div class="ab-value-icon" style="background:<%= values[i][1] %>;">
                    <i class="bi <%= values[i][0] %>" style="color:<%= values[i][2] %>;font-size:1.1rem;"></i>
                </div>
                <div>
                    <div class="ab-value-title"><%= values[i][3] %></div>
                    <div class="ab-value-text"><%= values[i][4] %></div>
                </div>
            </div>
        </div>
        <% } %>
    </div>
</div>
</div>

<!-- ══ KOMANDA ══════════════════════════════════════ -->
<div class="ab-section" style="background:#fff;">
<div class="container">
    <div class="text-center mb-5" data-aos="fade-up">
        <span class="ab-section-label">Müəllimlərimiz</span>
        <h2 class="ab-section-title">Komandamız</h2>
        <p class="ab-section-sub mx-auto">Sənaye təcrübəsi olan, öyrətmək üçün deyil, ilhamlandırmaq üçün olan müəllimlər.</p>
    </div>
    <div class="row g-4 justify-content-center">
        <%
        String[][] team = {
            {"Əli","Əliyev","ƏƏ","linear-gradient(135deg,#4f46e5,#7c3aed)","Senior Java Developer","10+ il Java, Spring Boot, Microservices təcrübəsi. Google sertifikatı."},
            {"Nigar","Hüseynova","NH","linear-gradient(135deg,#db2777,#7c3aed)","Frontend & UI/UX","React.js, Figma, CSS Animation. 150+ tələbə mezun etmişdir."},
            {"Rauf","Məmmədov","RM","linear-gradient(135deg,#059669,#0d9488)","Database & DevOps","MySQL, PostgreSQL, Docker, Kubernetes mütəxəssisi. 8+ il."},
            {"Sevinc","Quliyeva","SQ","linear-gradient(135deg,#d97706,#dc2626)","Python & Data Science","NumPy, Pandas, ML/AI. Beynəlxalq data yarışması qalibi."}
        };
        for (int i=0;i<team.length;i++) { %>
        <div class="col-sm-6 col-lg-3" data-aos="fade-up" data-aos-delay="<%= i*80 %>">
            <div class="ab-team-card">
                <div class="ab-avatar" style="background:<%= team[i][3] %>;">
                    <%= team[i][2] %>
                </div>
                <div class="ab-team-name"><%= team[i][0] %> <%= team[i][1] %></div>
                <div class="ab-team-role"><%= team[i][4] %></div>
                <p class="ab-team-bio"><%= team[i][5] %></p>
                <div class="ab-team-socials">
                    <a href="#" class="ab-social"><i class="bi bi-linkedin"></i></a>
                    <a href="#" class="ab-social"><i class="bi bi-github"></i></a>
                    <a href="#" class="ab-social"><i class="bi bi-envelope-fill"></i></a>
                </div>
            </div>
        </div>
        <% } %>
    </div>
</div>
</div>

<!-- ══ TARİX ════════════════════════════════════════ -->
<div class="ab-section">
<div class="container">
    <div class="row g-4 align-items-center">
        <div class="col-lg-5" data-aos="fade-right">
            <span class="ab-section-label">Yolumuz</span>
            <h2 class="ab-section-title">Tariximiz</h2>
            <p class="ab-section-sub">Kiçik bir arzudan böyük bir platforma — hər addımda tələbələrimiz var idi.</p>
            <div class="mt-4">
                <jsp:include page="ads-infeed.jsp"/>
            </div>
        </div>
        <div class="col-lg-7" data-aos="fade-left">
            <div class="ab-timeline">
                <div class="ab-tl-item">
                    <div class="ab-tl-dot"></div>
                    <div class="ab-tl-year">2020</div>
                    <div class="ab-tl-title">Başlanğıc — İlk 3 Kurs</div>
                    <p class="ab-tl-text">Java, HTML/CSS və Python kursları ilə 45 tələbə ilə yola çıxdıq.</p>
                </div>
                <div class="ab-tl-item">
                    <div class="ab-tl-dot"></div>
                    <div class="ab-tl-year">2021</div>
                    <div class="ab-tl-title">Genişlənmə — 5 Yeni Müəllim</div>
                    <p class="ab-tl-text">Komandaya 5 yeni müəllim qoşuldu, kurs sayı 8-ə yüksəldi.</p>
                </div>
                <div class="ab-tl-item">
                    <div class="ab-tl-dot"></div>
                    <div class="ab-tl-year">2022</div>
                    <div class="ab-tl-title">100+ Mezun Mərhələsi</div>
                    <p class="ab-tl-text">İlk 100 mezunumuz sənayedə işə başladı. Uğur hekayələri çoxaldı.</p>
                </div>
                <div class="ab-tl-item">
                    <div class="ab-tl-dot"></div>
                    <div class="ab-tl-year">2023</div>
                    <div class="ab-tl-title">Online Platform — Hər Yerdən Giriş</div>
                    <p class="ab-tl-text">Tam online sistemə keçildi. Rayonlardakı tələbələr də qoşuldu.</p>
                </div>
                <div class="ab-tl-item" style="padding-bottom:0;">
                    <div class="ab-tl-dot" style="background:#10b981;box-shadow:0 0 0 3px rgba(16,185,129,.25);"></div>
                    <div class="ab-tl-year" style="color:#10b981;">2024 — Bu Gün</div>
                    <div class="ab-tl-title">500+ Mezun, 10 Kurs, 15+ Müəllim</div>
                    <p class="ab-tl-text">Azərbaycanın aparıcı IT təhsil platformalarından biri olaraq böyüməyə davam edirik.</p>
                </div>
            </div>
        </div>
    </div>
</div>
</div>

<!-- ══ CTA ══════════════════════════════════════════ -->
<div class="ab-section" style="background:#fff; padding-top:0;">
<div class="container">
    <div class="ab-cta" data-aos="zoom-in">
        <div class="position-relative" style="z-index:2;">
            <h2 class="ab-cta-title">Sən də Qoşul!</h2>
            <p class="ab-cta-sub">Kurslarımızdan birini seç, bu gün başla, sabah karyerana investisiya et.</p>
            <div class="d-flex gap-3 justify-content-center flex-wrap">
                <a href="courses.jsp" class="ab-cta-btn">
                    <i class="bi bi-journal-bookmark-fill"></i> Kurslara Bax
                </a>
                <a href="dashboard.jsp"
                   class="btn btn-outline-light fw-700 rounded-3 px-4 py-3 d-inline-flex align-items-center gap-2">
                    <i class="bi bi-speedometer2"></i> Dashboard
                </a>
            </div>
        </div>
    </div>
</div>
</div>

<jsp:include page="footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script src="js/script.js?v=3.0"></script>
<script src="js/ads.js?v=4.0"></script>
<script>AOS.init({duration:700,once:true,offset:60});</script>
</body>
</html>
