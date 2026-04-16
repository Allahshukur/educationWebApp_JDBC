<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String uri = request.getRequestURI();
    if (uri == null) uri = "";
    boolean isHome    = uri.endsWith("/") || uri.endsWith("index.jsp")    || uri.equals("");
    boolean isStudent = uri.endsWith("students.jsp");
    boolean isTeacher = uri.endsWith("teachers.jsp");
    boolean isCourse  = uri.endsWith("courses.jsp");
    String pageLabel  = isHome ? "Ana Səhifə" : isStudent ? "Tələbələr" : isTeacher ? "Müəllimlər" : isCourse ? "Kurslar" : "";
%>
<!-- Dropdown fix -->
<style>
#navbarNav { overflow: visible !important; }
.navbar { overflow: visible !important; }
.navbar .dropdown-menu {
    z-index: 9999 !important;
    display: none;
    animation: ddFadeIn .18s ease;
}
.navbar .dropdown-menu.show { display: block; }
@keyframes ddFadeIn {
    from { opacity:0; transform:translateY(-6px); }
    to   { opacity:1; transform:translateY(0); }
}

/* ── Desktop dropdown hover ── */
.navbar .dropdown-item:hover {
    background: rgba(79,70,229,.08) !important;
    color: #4f46e5 !important;
}

/* ── Mobile/Tablet dropdown (collapsed navbar) ── */
@media (max-width: 991.98px) {
    .navbar .dropdown-menu {
        position: static !important;
        float: none !important;
        transform: none !important;
        inset: auto !important;
        background: rgba(255,255,255,0.10) !important;
        border: 1px solid rgba(255,255,255,0.18) !important;
        border-radius: 14px !important;
        width: 100% !important;
        max-width: 100% !important;
        margin: 6px 0 4px 0 !important;
        padding: 6px !important;
        box-shadow: none !important;
        backdrop-filter: blur(10px) !important;
    }
    .navbar .dropdown-menu .dropdown-divider {
        border-color: rgba(255,255,255,0.15) !important;
        margin: 3px 6px !important;
    }
    .navbar .dropdown-item {
        color: #fff !important;
        border-radius: 10px !important;
        padding: 7px 10px !important;
        margin: 1px 0 !important;
        font-size: 0.85rem !important;
        font-weight: 600 !important;
        display: flex !important;
        align-items: center !important;
        gap: 8px !important;
        white-space: nowrap !important;
        overflow: hidden !important;
        text-overflow: ellipsis !important;
    }
    .navbar .dropdown-item:hover,
    .navbar .dropdown-item:focus {
        background: rgba(255,255,255,0.15) !important;
        color: #fff !important;
    }
    /* Kiçik ikon qutusu */
    .navbar .dropdown-item > span[style*="border-radius:8px"] {
        width: 20px !important;
        height: 20px !important;
        min-width: 20px !important;
        border-radius: 6px !important;
        background: rgba(255,255,255,0.15) !important;
        flex-shrink: 0 !important;
        display: flex !important;
        align-items: center !important;
        justify-content: center !important;
    }
    .navbar .dropdown-item > span[style*="border-radius:8px"] i {
        color: #fff !important;
        font-size: 0.72rem !important;
    }
}

/* ── Dark mode — Desktop dropdown ── */
.dark-mode .navbar .dropdown-menu {
    background: #1e293b !important;
    border-color: rgba(255,255,255,0.08) !important;
}
.dark-mode .navbar .dropdown-item {
    color: #cbd5e1 !important;
}
.dark-mode .navbar .dropdown-item:hover {
    background: rgba(79,70,229,0.14) !important;
    color: #a5b4fc !important;
}
.dark-mode .navbar .dropdown-menu .dropdown-divider {
    border-color: rgba(255,255,255,0.07) !important;
}

/* ── Dark mode — Mobile dropdown ── */
@media (max-width: 991.98px) {
    .dark-mode .navbar .dropdown-menu {
        background: rgba(15,23,42,0.75) !important;
        border-color: rgba(255,255,255,0.10) !important;
    }
    .dark-mode .navbar .dropdown-item {
        color: #e2e8f0 !important;
    }
    .dark-mode .navbar .dropdown-item:hover {
        background: rgba(79,70,229,0.20) !important;
        color: #a5b4fc !important;
    }
}
</style>
<!-- RESPONSIVE NAVBAR -->
<nav id="mainNavbar" class="navbar navbar-expand-lg fixed-top navbar-responsive py-0"
     style="background:linear-gradient(135deg,#4f46e5 0%,#7c3aed 100%);
            box-shadow:0 2px 20px rgba(79,70,229,0.35);z-index:1030;">
    <div class="container">

        <!-- LOGO -->
        <a class="navbar-brand navbar-logo flex-shrink-0 p-0" href="index.jsp">
            <img src="foto/logo.svg" alt="Education App" class="header-logo-img" id="navLogo"
                 style="height:48px;width:auto;transition:filter .3s;">
        </a>

        <!-- MOBILE: Language + Dark + Hamburger -->
        <div class="d-flex d-lg-none align-items-center gap-2 ms-auto">
            <!-- Language Button (mobile) — lang-pill class lazımdır ki script.js tanısın -->
            <div class="lang-pill lang-pill-mobile" id="langPickerMobile" title="Dil seç">
                <i class="bi bi-globe2"></i>
                <span class="lang-pill-cur">AZ</span>
            </div>

            <!-- Dark/Light Toggle -->
            <div id="darkToggleMobile" class="dark-toggle-pill" title="Dark/Light" style="cursor:pointer;padding:6px 10px;border-radius:10px;">
                <span class="dtp-knob"><i class="bi bi-moon-stars-fill"></i></span>
            </div>

            <!-- Hamburger Menu -->
            <button class="navbar-toggler btn-hamburger border-0 flex-shrink-0 collapsed"
                    type="button"
                    data-bs-toggle="collapse"
                    data-bs-target="#navbarNav"
                    aria-controls="navbarNav"
                    aria-expanded="false"
                    aria-label="Menü">
                <span class="hamburger-line"></span>
                <span class="hamburger-line"></span>
                <span class="hamburger-line"></span>
            </button>
        </div>

        <!-- TABLET+: Navigation Collapse -->
        <div class="collapse navbar-collapse" id="navbarNav">

            <!-- Nav Links -->
            <ul class="navbar-nav navbar-nav-responsive align-items-lg-center ms-auto gap-lg-1">
                <li class="nav-item">
                    <a class="nav-link nav-btn fw-semibold <%= isHome ? "nav-active" : "" %>"
                       href="index.jsp">
                        <i class="bi bi-house me-1"></i>Ana Səhifə
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-btn fw-semibold <%= isCourse ? "nav-active" : "" %>"
                       href="courses.jsp">
                        <i class="bi bi-journal-bookmark me-1"></i>Kurslar
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-btn fw-semibold <%= isStudent ? "nav-active" : "" %>"
                       href="students.jsp">
                        <i class="bi bi-people me-1"></i>Tələbələr
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-btn fw-semibold <%= isTeacher ? "nav-active" : "" %>"
                       href="teachers.jsp">
                        <i class="bi bi-person-workspace me-1"></i>Müəllimlər
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-btn fw-semibold" href="#features">
                        <i class="bi bi-stars me-1"></i>Üstünlüklər
                    </a>
                </li>

                <!-- Daha çox dropdown -->
                <li class="nav-item dropdown">
                    <a class="nav-link nav-btn fw-semibold dropdown-toggle" href="#"
                       id="moreDropdown" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-grid-3x3-gap-fill me-1"></i>Daha çox
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end shadow border-0 rounded-4 py-2 mt-2"
                        aria-labelledby="moreDropdown"
                        style="min-width:220px;backdrop-filter:blur(12px);">
                        <li>
                            <a class="dropdown-item rounded-3 mx-1 fw-600 d-flex align-items-center gap-2 py-2"
                               href="dashboard.jsp">
                                <span style="width:28px;height:28px;border-radius:8px;background:rgba(79,70,229,.12);display:flex;align-items:center;justify-content:center;">
                                    <i class="bi bi-speedometer2" style="color:#4f46e5;font-size:.85rem;"></i>
                                </span>
                                Dashboard
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item rounded-3 mx-1 fw-600 d-flex align-items-center gap-2 py-2"
                               href="schedule.jsp">
                                <span style="width:28px;height:28px;border-radius:8px;background:rgba(8,145,178,.12);display:flex;align-items:center;justify-content:center;">
                                    <i class="bi bi-calendar3-week-fill" style="color:#0891b2;font-size:.85rem;"></i>
                                </span>
                                Dərs Cədvəli
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item rounded-3 mx-1 fw-600 d-flex align-items-center gap-2 py-2"
                               href="certificate.jsp">
                                <span style="width:28px;height:28px;border-radius:8px;background:rgba(16,185,129,.12);display:flex;align-items:center;justify-content:center;">
                                    <i class="bi bi-patch-check-fill" style="color:#10b981;font-size:.85rem;"></i>
                                </span>
                                Sertifikat
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item rounded-3 mx-1 fw-600 d-flex align-items-center gap-2 py-2"
                               href="about.jsp">
                                <span style="width:28px;height:28px;border-radius:8px;background:rgba(124,58,237,.12);display:flex;align-items:center;justify-content:center;">
                                    <i class="bi bi-info-circle-fill" style="color:#7c3aed;font-size:.85rem;"></i>
                                </span>
                                Haqqımızda
                            </a>
                        </li>
                        <li><hr class="dropdown-divider mx-3 my-1"></li>
                        <li>
                            <a class="dropdown-item rounded-3 mx-1 fw-600 d-flex align-items-center gap-2 py-2"
                               href="quiz.jsp">
                                <span style="width:28px;height:28px;border-radius:8px;background:rgba(124,58,237,.12);display:flex;align-items:center;justify-content:center;">
                                    <i class="bi bi-patch-question-fill" style="color:#7c3aed;font-size:.85rem;"></i>
                                </span>
                                Quiz
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item rounded-3 mx-1 fw-600 d-flex align-items-center gap-2 py-2"
                               href="assignments.jsp">
                                <span style="width:28px;height:28px;border-radius:8px;background:rgba(217,119,6,.12);display:flex;align-items:center;justify-content:center;">
                                    <i class="bi bi-journal-check" style="color:#d97706;font-size:.85rem;"></i>
                                </span>
                                Tapşırıqlar
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item rounded-3 mx-1 fw-600 d-flex align-items-center gap-2 py-2"
                               href="grades.jsp">
                                <span style="width:28px;height:28px;border-radius:8px;background:rgba(5,150,105,.12);display:flex;align-items:center;justify-content:center;">
                                    <i class="bi bi-trophy-fill" style="color:#059669;font-size:.85rem;"></i>
                                </span>
                                Qiymətlər
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item rounded-3 mx-1 fw-600 d-flex align-items-center gap-2 py-2"
                               href="attendance.jsp">
                                <span style="width:28px;height:28px;border-radius:8px;background:rgba(2,132,199,.12);display:flex;align-items:center;justify-content:center;">
                                    <i class="bi bi-calendar2-check-fill" style="color:#0284c7;font-size:.85rem;"></i>
                                </span>
                                Davamiyyət
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item rounded-3 mx-1 fw-600 d-flex align-items-center gap-2 py-2"
                               href="announcements.jsp">
                                <span style="width:28px;height:28px;border-radius:8px;background:rgba(219,39,119,.12);display:flex;align-items:center;justify-content:center;">
                                    <i class="bi bi-megaphone-fill" style="color:#db2777;font-size:.85rem;"></i>
                                </span>
                                Elanlar
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item rounded-3 mx-1 fw-600 d-flex align-items-center gap-2 py-2"
                               href="payment.jsp">
                                <span style="width:28px;height:28px;border-radius:8px;background:rgba(16,185,129,.12);display:flex;align-items:center;justify-content:center;">
                                    <i class="bi bi-credit-card-fill" style="color:#10b981;font-size:.85rem;"></i>
                                </span>
                                Ödəniş
                            </a>
                        </li>
                        <li><hr class="dropdown-divider mx-3 my-1"></li>
                        <li>
                            <a class="dropdown-item rounded-3 mx-1 fw-600 d-flex align-items-center gap-2 py-2"
                               href="404.jsp">
                                <span style="width:28px;height:28px;border-radius:8px;background:rgba(239,68,68,.10);display:flex;align-items:center;justify-content:center;">
                                    <i class="bi bi-exclamation-triangle-fill" style="color:#ef4444;font-size:.85rem;"></i>
                                </span>
                                404 Səhifəsi
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>

            <!-- Sağ hissə: axtarış, dil, dark, notif, giriş -->
            <div class="d-flex align-items-center gap-2 mt-3 mt-lg-0">

                <!-- Axtarış (desktop) -->
                <div class="nav-search-wrap d-none d-lg-flex align-items-center"
                     style="background:rgba(255,255,255,0.12);border-radius:10px;
                            padding:6px 14px;border:1px solid rgba(255,255,255,0.2);">
                    <i class="bi bi-search text-white opacity-75 me-2" style="font-size:0.85rem;"></i>
                    <input id="globalSearch" type="text" placeholder="Axtar... (Ctrl+K)"
                           autocomplete="off"
                           style="background:transparent;border:none;outline:none;color:white;
                                  font-size:0.88rem;width:130px;transition:width 0.3s;"
                           onfocus="this.style.width='190px'" onblur="this.style.width='130px'">
                </div>

                <!-- Axtarış (mobil) -->
                <div class="nav-search-wrap d-flex d-lg-none align-items-center"
                     style="background:rgba(255,255,255,0.12);border-radius:10px;
                            padding:6px 14px;border:1px solid rgba(255,255,255,0.2);">
                    <i class="bi bi-search text-white opacity-75 me-2" style="font-size:0.85rem;"></i>
                    <input id="globalSearchMobile" type="text" placeholder="Axtar..."
                           autocomplete="off"
                           style="background:transparent;border:none;outline:none;color:white;
                                  font-size:0.88rem;width:100px;transition:width 0.3s;"
                           onfocus="this.style.width='160px'" onblur="this.style.width='100px'">
                </div>

                <!-- Dil seçici (desktop) -->
                <div id="langPickerDesktop" class="lang-pill d-none d-lg-flex" title="Dil seç">
                    <i class="bi bi-globe2 lang-pill-icon"></i>
                    <span class="lang-pill-cur">AZ</span>
                    <i class="bi bi-chevron-down lang-pill-arrow"></i>
                </div>

                <!-- Dark toggle (desktop) -->
                <div id="darkToggleDesktop" class="dark-toggle-pill d-none d-lg-flex" title="Dark/Light">
                    <span class="dtp-knob"><i class="bi bi-moon-stars-fill"></i></span>
                    <span class="dtp-label">DARK<br>MODE</span>
                </div>

                <!-- Bildiriş -->
                <div class="position-relative flex-shrink-0">
                    <button class="btn-icon-nav" id="notifBtn" title="Bildirişlər">
                        <i class="bi bi-bell-fill"></i>
                        <span class="notif-dot">3</span>
                    </button>
                    <div id="notifPanel"
                         style="display:none;position:absolute;right:0;top:calc(100% + 10px);
                                width:320px;background:white;border-radius:18px;
                                box-shadow:0 20px 60px rgba(0,0,0,0.18);z-index:9999;overflow:hidden;">
                        <div style="background:linear-gradient(135deg,#4f46e5,#7c3aed);padding:14px 18px;color:white;">
                            <div class="d-flex align-items-center justify-content-between">
                                <span class="fw-800">Bildirişlər</span>
                                <div class="d-flex align-items-center gap-2">
                                    <span class="badge bg-white text-primary rounded-pill"
                                          id="notifCountBadge" style="font-size:.72rem;">3 yeni</span>
                                    <button onclick="markAllNotifsRead()"
                                            style="background:rgba(255,255,255,.18);border:none;color:#fff;
                                                   font-size:.70rem;font-weight:700;border-radius:8px;padding:3px 8px;cursor:pointer;">
                                        Hamısını oxu
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div style="max-height:280px;overflow-y:auto;" id="notifList">
                            <div class="notif-item unread" onclick="markNotifRead(this)">
                                <div class="notif-icon" style="background:#ede9fe;color:#7c3aed;">
                                    <i class="bi bi-patch-question-fill"></i></div>
                                <div class="flex-grow-1">
                                    <div class="notif-title">Java Əsasları — Quiz vaxtı</div>
                                    <div class="notif-desc" style="font-size:.72rem;color:#64748b;">Bu gün saat 10:45-də başlayır</div>
                                    <div class="notif-time">5 dəq əvvəl</div>
                                </div>
                            </div>
                            <div class="notif-item unread" onclick="markNotifRead(this)">
                                <div class="notif-icon" style="background:#fef3c7;color:#d97706;">
                                    <i class="bi bi-journal-check"></i></div>
                                <div class="flex-grow-1">
                                    <div class="notif-title">HTML Portfolio — son tarix yaxınlaşır</div>
                                    <div class="notif-desc" style="font-size:.72rem;color:#64748b;">18 Aprel 2026 — 7 gün qalıb</div>
                                    <div class="notif-time">1 saat əvvəl</div>
                                </div>
                            </div>
                            <div class="notif-item unread" onclick="markNotifRead(this)">
                                <div class="notif-icon" style="background:#fce7f3;color:#db2777;">
                                    <i class="bi bi-megaphone-fill"></i></div>
                                <div class="flex-grow-1">
                                    <div class="notif-title">Yeni elan: İmtahan tarixi dəyişdi</div>
                                    <div class="notif-desc" style="font-size:.72rem;color:#64748b;">Əli Əliyev — Java Əsasları</div>
                                    <div class="notif-time">2 saat əvvəl</div>
                                </div>
                            </div>
                            <div class="notif-item" onclick="markNotifRead(this)">
                                <div class="notif-icon" style="background:#d1fae5;color:#059669;">
                                    <i class="bi bi-trophy-fill"></i></div>
                                <div class="flex-grow-1">
                                    <div class="notif-title">OOP imtahan nəticəsi: 82/100</div>
                                    <div class="notif-desc" style="font-size:.72rem;color:#64748b;">Hərf qiymət: B</div>
                                    <div class="notif-time">Dünən</div>
                                </div>
                            </div>
                            <div class="notif-item" onclick="markNotifRead(this)">
                                <div class="notif-icon" style="background:#dbeafe;color:#2563eb;">
                                    <i class="bi bi-calendar2-check-fill"></i></div>
                                <div class="flex-grow-1">
                                    <div class="notif-title">Davamiyyət: 90% — əla nəticə!</div>
                                    <div class="notif-desc" style="font-size:.72rem;color:#64748b;">Spring Framework kursu</div>
                                    <div class="notif-time">2 gün əvvəl</div>
                                </div>
                            </div>
                        </div>
                        <div style="padding:12px 18px;border-top:1px solid #f1f5f9;text-align:center;">
                            <a href="announcements.jsp"
                               style="font-size:.83rem;color:#4f46e5;text-decoration:none;font-weight:700;">
                                Bütün elanları gör →
                            </a>
                        </div>
                    </div>
                    <style>
                    .notif-item { display:flex;align-items:flex-start;gap:12px;padding:12px 18px;
                                  border-bottom:1px solid #f8fafc;cursor:pointer;transition:background .15s; }
                    .notif-item:hover { background:#f8fafc; }
                    .notif-item.unread { background:#fafbff; }
                    .notif-item.unread .notif-title { font-weight:700; }
                    .notif-icon { width:36px;height:36px;border-radius:10px;display:flex;
                                  align-items:center;justify-content:center;font-size:.95rem;flex-shrink:0; }
                    .notif-title { font-size:.82rem;color:#1e293b;font-weight:600; }
                    .notif-time  { font-size:.70rem;color:#94a3b8;margin-top:2px; }
                    </style>
                    <script>
                    function markNotifRead(el) {
                        el.classList.remove('unread');
                        updateNotifCount();
                    }
                    function markAllNotifsRead() {
                        document.querySelectorAll('#notifList .notif-item.unread').forEach(function(el){
                            el.classList.remove('unread');
                        });
                        updateNotifCount();
                    }
                    function updateNotifCount() {
                        var cnt = document.querySelectorAll('#notifList .notif-item.unread').length;
                        var dot = document.querySelector('.notif-dot');
                        var badge = document.getElementById('notifCountBadge');
                        if (dot) { dot.textContent = cnt; dot.style.display = cnt > 0 ? '' : 'none'; }
                        if (badge) badge.textContent = cnt + ' yeni';
                    }
                    </script>
                </div>

                <!-- Giriş düyməsi -->
                <a href="#" class="btn-login flex-shrink-0">
                    <i class="bi bi-box-arrow-in-right me-1"></i>Giriş
                </a>
            </div>
        </div><!-- /collapse -->
    </div><!-- /container -->
</nav>

<!-- Google Translate gizli konteyner -->
<div id="google_translate_element" style="display:none;visibility:hidden;position:absolute;"></div>
<script>
    function googleTranslateElementInit() {
        new google.translate.TranslateElement(
            { pageLanguage: 'az', autoDisplay: false, includedLanguages: 'az,tr,en,ru' },
            'google_translate_element'
        );
    }
</script>
<script src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit" async defer></script>

<% if (request.getAttribute("isHome") == null || !(Boolean)request.getAttribute("isHome")) { %>
<div class="page-breadcrumb-bar bg-light border-bottom">
    <div class="container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item">
                    <a href="index.jsp" class="text-decoration-none">
                        <i class="bi bi-house"></i>Ana Səhifə
                    </a>
                </li>
                <li class="breadcrumb-item active" aria-current="page">
                    <%= request.getAttribute("pageLabel") %>
                </li>
            </ol>
        </nav>
    </div>
</div>
<% } %>

<!-- Hamburger fix -->
<script>
(function() {
    // Dərhal icra et — DOMContentLoaded gözləmə
    var navCollapse = document.getElementById('navbarNav');
    if (navCollapse && window.innerWidth < 992) {
        navCollapse.classList.remove('show');
    }

    document.addEventListener('DOMContentLoaded', function() {
        var nav = document.getElementById('navbarNav');
        if (!nav) return;

        // Yenidən yüklənəndə mobile-da bağlı olsun
        if (window.innerWidth < 992) {
            nav.classList.remove('show');
        }

        // Nav link klikləndikdə mobile-da menünü bağla
        // Dropdown-toggle klikləndikdə BAĞLAMA — dropdown açılsın
        nav.querySelectorAll('a.nav-link').forEach(function(link) {
            link.addEventListener('click', function(e) {
                if (window.innerWidth >= 992) return;
                // Dropdown toggle-sa menünü bağlama, dropdownu aç
                if (this.classList.contains('dropdown-toggle')) return;
                nav.classList.remove('show');
                var toggler = document.querySelector('.btn-hamburger');
                if (toggler) toggler.classList.add('collapsed');
            });
        });

        // Dropdown içindəki item klikləndikdə menünü bağla
        nav.querySelectorAll('.dropdown-item').forEach(function(item) {
            item.addEventListener('click', function() {
                if (window.innerWidth >= 992) return;
                setTimeout(function() {
                    nav.classList.remove('show');
                    var toggler = document.querySelector('.btn-hamburger');
                    if (toggler) toggler.classList.add('collapsed');
                }, 150);
            });
        });

        // Resize: desktop-a keçdikdə menünü gizlət (açıq qalmasın)
        var resizeTimer;
        window.addEventListener('resize', function() {
            clearTimeout(resizeTimer);
            resizeTimer = setTimeout(function() {
                if (window.innerWidth >= 992) {
                    nav.classList.remove('show');
                    var toggler = document.querySelector('.btn-hamburger');
                    if (toggler) toggler.classList.add('collapsed');
                }
            }, 200);
        });
    });
})();
</script>
<script src="js/confetti.js?v=2.0"></script>