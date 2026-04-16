<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String msg = "", msgType = "";
    if ("POST".equals(request.getMethod())) {
        String act = request.getParameter("act");
        if ("general".equals(act)) {
            msg = "Ümumi parametrlər yadda saxlandı."; msgType = "success";
        } else if ("password".equals(act)) {
            String np = request.getParameter("newPass");
            String cp = request.getParameter("confirmPass");
            if (np != null && np.equals(cp) && np.length() >= 6) {
                msg = "Şifrə uğurla dəyişdirildi."; msgType = "success";
            } else {
                msg = "Şifrələr uyğun gəlmir və ya çox qısa (min 6 simvol)."; msgType = "danger";
            }
        } else if ("notif".equals(act)) {
            msg = "Bildiriş parametrləri yadda saxlandı."; msgType = "success";
        }
    }
%>
<!DOCTYPE html>
<html lang="az">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Parametrlər — Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="css/admin.css" rel="stylesheet">
</head>
<body class="adm-body">

<jsp:include page="admin-sidebar.jsp"/>

<div class="adm-main" id="admMain">
    <header class="adm-topbar">
        <div class="adm-topbar-left">
            <button class="adm-hamburger" id="admSidebarToggle"><i class="bi bi-list"></i></button>
            <div class="adm-breadcrumb">
                <a href="index.jsp"><i class="bi bi-house-fill"></i></a>
                <i class="bi bi-chevron-right adm-text-muted" style="font-size:.6rem;"></i>
                <span class="adm-breadcrumb-cur">Parametrlər</span>
            </div>
        </div>
        <div class="adm-topbar-right">
            <div class="adm-search-wrap">
                <i class="bi bi-search"></i>
                <input id="admSearchInput" type="text" placeholder="Axtar... (Ctrl+K)">
            </div>
            <button class="adm-icon-btn" data-adm-dark-toggle title="Dark/Light"><i class="bi bi-moon-stars-fill"></i></button>
            <div class="adm-top-avatar"><i class="bi bi-person-fill"></i></div>
        </div>
    </header>

    <div class="adm-content">

        <% if (!msg.isEmpty()) { %>
        <div class="alert alert-<%= msgType %> alert-dismissible fade show rounded-3 d-flex align-items-center gap-2 mb-3">
            <i class="bi bi-<%= "success".equals(msgType) ? "check-circle-fill" : "exclamation-circle-fill" %>"></i>
            <span><%= msg %></span>
            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
        </div>
        <% } %>

        <div class="adm-page-header">
            <div>
                <h1 class="adm-page-title"><i class="bi bi-gear-fill me-2 adm-text-accent"></i>Parametrlər</h1>
                <p class="adm-page-sub">Sistem konfiqurasiyası və hesab ayarları</p>
            </div>
        </div>

        <!-- TABS -->
        <div class="adm-tabs">
            <button class="adm-tab-btn active" id="tabGeneral" onclick="admTab('tabGeneral','panelGeneral')">
                <i class="bi bi-sliders"></i> Ümumi
            </button>
            <button class="adm-tab-btn" id="tabSecurity" onclick="admTab('tabSecurity','panelSecurity')">
                <i class="bi bi-shield-lock-fill"></i> Güvənlik
            </button>
            <button class="adm-tab-btn" id="tabNotif" onclick="admTab('tabNotif','panelNotif')">
                <i class="bi bi-bell-fill"></i> Bildirişlər
            </button>
            <button class="adm-tab-btn" id="tabAppear" onclick="admTab('tabAppear','panelAppear')">
                <i class="bi bi-palette-fill"></i> Görünüş
            </button>
        </div>

        <!-- PANEL: Ümumi -->
        <div class="adm-tab-panel active" id="panelGeneral">
            <div class="row g-3">
                <div class="col-lg-8">
                    <div class="adm-card">
                        <div class="adm-card-header">
                            <span class="adm-card-title"><i class="bi bi-info-circle-fill"></i>Sayt Məlumatları</span>
                        </div>
                        <div class="adm-card-body">
                            <form method="post">
                                <input type="hidden" name="act" value="general">
                                <div class="row g-3">
                                    <div class="col-12">
                                        <label class="adm-form-label">Sayt Adı</label>
                                        <input type="text" name="siteName" value="Education App" class="adm-form-control">
                                    </div>
                                    <div class="col-12">
                                        <label class="adm-form-label">Sayt Təsviri</label>
                                        <textarea name="siteDesc" class="adm-form-control">Java EE əsaslı təhsil idarəetmə sistemi.</textarea>
                                    </div>
                                    <div class="col-sm-6">
                                        <label class="adm-form-label">Admin Email</label>
                                        <input type="email" name="adminEmail" value="admin@education.az" class="adm-form-control">
                                    </div>
                                    <div class="col-sm-6">
                                        <label class="adm-form-label">Telefon</label>
                                        <input type="text" name="phone" value="+994 50 000 00 00" class="adm-form-control">
                                    </div>
                                    <div class="col-sm-6">
                                        <label class="adm-form-label">Dil</label>
                                        <select name="lang" class="adm-form-control">
                                            <option selected>Azərbaycan dili</option>
                                            <option>Русский</option>
                                            <option>English</option>
                                        </select>
                                    </div>
                                    <div class="col-sm-6">
                                        <label class="adm-form-label">Zaman Dilimi</label>
                                        <select name="tz" class="adm-form-control">
                                            <option selected>UTC+4 (Bakı)</option>
                                            <option>UTC+3 (Moskva)</option>
                                            <option>UTC+0 (London)</option>
                                        </select>
                                    </div>
                                    <div class="col-12 text-end">
                                        <button type="submit" class="adm-btn adm-btn-primary">
                                            <i class="bi bi-floppy-fill"></i> Yadda saxla
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="adm-card">
                        <div class="adm-card-header">
                            <span class="adm-card-title"><i class="bi bi-activity"></i>Sistem Durumu</span>
                        </div>
                        <div class="adm-card-body">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <span class="fw-600">Versiya</span>
                                <span class="adm-badge adm-badge-blue">v2.0.0</span>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <span class="fw-600">Server</span>
                                <span class="adm-badge adm-badge-green">Aktiv</span>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <span class="fw-600">Verilənlər Bazası</span>
                                <span class="adm-badge adm-badge-green">Bağlı</span>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <span class="fw-600">Cache</span>
                                <span class="adm-badge adm-badge-amber">Qismən</span>
                            </div>
                            <hr class="adm-divider">
                            <button class="adm-btn adm-btn-outline w-100" onclick="admToast('Cache təmizləndi!','success')">
                                <i class="bi bi-arrow-clockwise"></i> Cache Sil
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- PANEL: Güvənlik -->
        <div class="adm-tab-panel" id="panelSecurity">
            <div class="row g-3">
                <div class="col-lg-6">
                    <div class="adm-card">
                        <div class="adm-card-header">
                            <span class="adm-card-title"><i class="bi bi-key-fill"></i>Şifrəni Dəyiş</span>
                        </div>
                        <div class="adm-card-body">
                            <form method="post">
                                <input type="hidden" name="act" value="password">
                                <div class="row g-3">
                                    <div class="col-12">
                                        <label class="adm-form-label">Cari Şifrə</label>
                                        <input type="password" name="currentPass" class="adm-form-control" placeholder="••••••••" required>
                                    </div>
                                    <div class="col-12">
                                        <label class="adm-form-label">Yeni Şifrə</label>
                                        <input type="password" name="newPass" id="newPass" class="adm-form-control" placeholder="min 6 simvol" required minlength="6">
                                    </div>
                                    <div class="col-12">
                                        <label class="adm-form-label">Şifrəni Təsdiqlə</label>
                                        <input type="password" name="confirmPass" id="confirmPass" class="adm-form-control" placeholder="Yenidən daxil et" required>
                                    </div>
                                    <div class="col-12">
                                        <div id="passMatchMsg" style="font-size:.8rem;height:18px;"></div>
                                    </div>
                                    <div class="col-12 text-end">
                                        <button type="submit" class="adm-btn adm-btn-primary">
                                            <i class="bi bi-shield-lock-fill"></i> Şifrəni dəyiş
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="adm-card">
                        <div class="adm-card-header">
                            <span class="adm-card-title"><i class="bi bi-person-lock"></i>Sessiya</span>
                        </div>
                        <div class="adm-card-body">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <div><div class="fw-700">Bu Sessiya</div><div class="adm-text-muted" style="font-size:.8rem;">Giriş edildi</div></div>
                                <span class="adm-badge adm-badge-green">Aktiv</span>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <div><div class="fw-700">IP Ünvanı</div><div class="adm-text-muted" style="font-size:.8rem;">127.0.0.1 (Yerli)</div></div>
                                <span class="adm-badge adm-badge-blue">Güvənli</span>
                            </div>
                            <hr class="adm-divider">
                            <a href="login.jsp" class="adm-btn adm-btn-danger w-100">
                                <i class="bi bi-box-arrow-right"></i> Çıxış et
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- PANEL: Bildirişlər -->
        <div class="adm-tab-panel" id="panelNotif">
            <div class="col-lg-7">
                <div class="adm-card">
                    <div class="adm-card-header">
                        <span class="adm-card-title"><i class="bi bi-bell-fill"></i>Bildiriş Ayarları</span>
                    </div>
                    <div class="adm-card-body">
                        <form method="post">
                            <input type="hidden" name="act" value="notif">
                            <% String[][] notifs = {
                                {"newStudent","Yeni tələbə qeydiyyatı"},
                                {"newTeacher","Yeni müəllim əlavə ediləndə"},
                                {"courseUpdate","Kurs yeniləndikdə"},
                                {"loginAlert","Giriş bildirişi"},
                                {"weeklyReport","Həftəlik statistika"}
                            };
                            for (String[] n : notifs) { %>
                            <div class="adm-toggle-wrap mb-3 pb-3" style="border-bottom:1px solid var(--border);">
                                <label class="adm-toggle">
                                    <input type="checkbox" name="<%= n[0] %>" checked>
                                    <span class="adm-toggle-slider"></span>
                                </label>
                                <div class="adm-toggle-label"><%= n[1] %></div>
                            </div>
                            <% } %>
                            <div class="text-end mt-3">
                                <button type="submit" class="adm-btn adm-btn-primary">
                                    <i class="bi bi-floppy-fill"></i> Yadda saxla
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- PANEL: Görünüş -->
        <div class="adm-tab-panel" id="panelAppear">
            <div class="row g-3">
                <div class="col-lg-6">
                    <div class="adm-card">
                        <div class="adm-card-header">
                            <span class="adm-card-title"><i class="bi bi-palette-fill"></i>Rəng Mövzusu</span>
                        </div>
                        <div class="adm-card-body">
                            <div class="row g-2 mb-3">
                                <% String[][] themes = {
                                    {"#4f46e5","İndigo (Standart)","active"},
                                    {"#0d9488","Teal",""},
                                    {"#dc2626","Qırmızı",""},
                                    {"#0ea5e9","Mavi",""},
                                    {"#f59e0b","Sarı",""},
                                    {"#7c3aed","Bənövşəyi",""}
                                };
                                for (String[] th : themes) { %>
                                <div class="col-auto">
                                    <button class="adm-theme-btn <%= th[2] %>"
                                        onclick="setTheme('<%= th[0] %>',this)"
                                        title="<%= th[1] %>"
                                        style="width:40px;height:40px;border-radius:12px;background:<%= th[0] %>;border:<%= th[2].isEmpty() ? "2px solid transparent" : "2px solid var(--text)" %>;cursor:pointer;transition:all .2s;box-shadow:0 3px 10px <%= th[0] %>55;">
                                    </button>
                                </div>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="adm-card">
                        <div class="adm-card-header">
                            <span class="adm-card-title"><i class="bi bi-moon-stars-fill"></i>Qaranlıq/İşıqlı</span>
                        </div>
                        <div class="adm-card-body">
                            <div class="d-flex align-items-center justify-content-between p-3 rounded-3" style="background:var(--input-bg);border:1.5px solid var(--border);">
                                <div>
                                    <div class="fw-700">Dark Mode</div>
                                    <div class="adm-text-muted" style="font-size:.8rem;">Gözlər üçün rahat qaranlıq mövzu</div>
                                </div>
                                <button class="adm-btn adm-btn-primary" data-adm-dark-toggle>
                                    <i class="bi bi-moon-stars-fill"></i> Keçir
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/admin.js"></script>
<script>
// Password match check
(function() {
    var np = document.getElementById('newPass');
    var cp = document.getElementById('confirmPass');
    var msg = document.getElementById('passMatchMsg');
    if (!np || !cp) return;
    function check() {
        if (!cp.value) { msg.innerHTML = ''; return; }
        if (np.value === cp.value) {
            msg.innerHTML = '<span style="color:#059669;font-weight:700;"><i class="bi bi-check-circle-fill me-1"></i>Şifrələr uyğundur</span>';
        } else {
            msg.innerHTML = '<span style="color:#dc2626;font-weight:700;"><i class="bi bi-x-circle-fill me-1"></i>Şifrələr uyğun deyil</span>';
        }
    }
    np.addEventListener('input', check);
    cp.addEventListener('input', check);
})();

// Theme setter
function setTheme(color, btn) {
    document.querySelectorAll('.adm-theme-btn').forEach(function(b) {
        b.style.border = '2px solid transparent';
    });
    btn.style.border = '2px solid var(--text)';
    document.documentElement.style.setProperty('--accent', color);
    admToast('Rəng mövzusu dəyişdirildi!', 'success');
}

// Default tab
document.addEventListener('DOMContentLoaded', function() {
    admTab('tabGeneral','panelGeneral');
});
</script>
</body>
</html>
