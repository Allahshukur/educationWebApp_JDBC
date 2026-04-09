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
<!-- RESPONSIVE NAVBAR -->
<nav id="mainNavbar" class="navbar navbar-expand-lg fixed-top navbar-responsive py-0"
     style="background:linear-gradient(135deg,#4f46e5 0%,#7c3aed 100%);
            box-shadow:0 2px 20px rgba(79,70,229,0.35);z-index:1030;">
    <div class="container">

        <!-- LOGO -->
        <a class="navbar-brand navbar-logo flex-shrink-0 p-0" href="index.jsp">
            <img src="foto/logo.png" alt="Education App" class="header-logo-img">
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
                                width:300px;background:white;border-radius:16px;
                                box-shadow:0 20px 60px rgba(0,0,0,0.18);z-index:9999;overflow:hidden;">
                        <div style="background:linear-gradient(135deg,#4f46e5,#7c3aed);padding:14px 18px;color:white;">
                            <div class="d-flex align-items-center justify-content-between">
                                <span class="fw-bold">Bildirişlər</span>
                                <span class="badge bg-white text-primary rounded-pill"
                                      style="font-size:0.75rem;">3 yeni</span>
                            </div>
                        </div>
                        <div style="max-height:240px;overflow-y:auto;">
                            <div class="notif-item unread">
                                <div class="notif-icon" style="background:#dbeafe;color:#2563eb;">
                                    <i class="bi bi-person-plus-fill"></i></div>
                                <div>
                                    <div class="notif-title">Yeni tələbə qeydiyyatı</div>
                                    <div class="notif-time">2 dəq əvvəl</div>
                                </div>
                            </div>
                            <div class="notif-item unread">
                                <div class="notif-icon" style="background:#d1fae5;color:#059669;">
                                    <i class="bi bi-journal-plus"></i></div>
                                <div>
                                    <div class="notif-title">Yeni kurs əlavə edildi</div>
                                    <div class="notif-time">15 dəq əvvəl</div>
                                </div>
                            </div>
                            <div class="notif-item unread">
                                <div class="notif-icon" style="background:#fef3c7;color:#d97706;">
                                    <i class="bi bi-star-fill"></i></div>
                                <div>
                                    <div class="notif-title">Yeni rəy: 5 ⭐</div>
                                    <div class="notif-time">1 saat əvvəl</div>
                                </div>
                            </div>
                        </div>
                        <div style="padding:10px 18px;border-top:1px solid #f1f5f9;text-align:center;">
                            <a href="#" style="font-size:0.83rem;color:#4f46e5;text-decoration:none;font-weight:600;">
                                Hamısını gör →</a>
                        </div>
                    </div>
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
        nav.querySelectorAll('a.nav-link').forEach(function(link) {
            link.addEventListener('click', function() {
                if (window.innerWidth >= 992) return;
                nav.classList.remove('show');
                var toggler = document.querySelector('.btn-hamburger');
                if (toggler) toggler.classList.add('collapsed');
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
