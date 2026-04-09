<%@ page import="com.sukur.educationwebapp.teacher.service.TeacherService" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sukur.educationwebapp.teacher.entity.Teacher" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%!
    private String escJs(String value) {
        if (value == null) {
            return "";
        }
        return value
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\r", " ")
                .replace("\n", " ");
    }
%>
<%
    TeacherService teacherService = new TeacherService();
    String searchWord = request.getParameter("search");
    List<Teacher> allTeachers = teacherService.findAll();
    List<Teacher> teachers;
    if (searchWord != null && !searchWord.trim().isEmpty()) {
        teachers = teacherService.search(searchWord.trim());
    } else {
        teachers = allTeachers;
    }
    int totalTeachers = teachers.size();
    int totalAllTeachers = allTeachers.size();
%>
<!DOCTYPE html>
<html lang="az">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Müəllimlər - Education App</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="css/style.css?v=3.9" rel="stylesheet">
    <link href="css/dark-mode.css?v=1.1" rel="stylesheet">
    <style>body { font-family: 'Outfit', sans-serif; }</style>
</head>
<body class="overflow-hidden-init">

<!-- Page Loader -->
<div id="loader">
    <div class="loader-content">
        <div class="loader-circle"></div>
        <div class="loader-circle"></div>
        <div class="loader-circle"></div>
        <div class="loader-subtext">Müəllim paneli yüklənir...</div>
    </div>
</div>

<%
    request.setAttribute("pageLabel", "Müəllimlər");
    request.setAttribute("isHome", false);
%>
<jsp:include page="header.jsp"/>

<section class="teacher-galaxy-section min-vh-100">
    <div class="container py-4">

        <!-- ── 4 Stat Kartı ── -->
        <div class="row g-3 mb-4">
            <div class="col-6 col-md-3" data-aos="fade-up" data-aos-delay="0">
                <div class="tg-stat-card tg-stat-blue">
                    <div class="tg-stat-icon"><i class="bi bi-mortarboard-fill"></i></div>
                    <div>
                        <div class="tg-stat-val"><%= totalTeachers %></div>
                        <div class="tg-stat-lbl">Cəmi Müəllim</div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-3" data-aos="fade-up" data-aos-delay="80">
                <div class="tg-stat-card tg-stat-green">
                    <div class="tg-stat-icon"><i class="bi bi-book-half"></i></div>
                    <div>
                        <div class="tg-stat-val"><%= totalTeachers * 3 %></div>
                        <div class="tg-stat-lbl">Aktiv Kurslar</div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-3" data-aos="fade-up" data-aos-delay="160">
                <div class="tg-stat-card tg-stat-yellow">
                    <div class="tg-stat-icon"><i class="bi bi-star-fill"></i></div>
                    <div>
                        <div class="tg-stat-val">4.7 / 5</div>
                        <div class="tg-stat-lbl">Orta Reytinq</div>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-3" data-aos="fade-up" data-aos-delay="240">
                <div class="tg-stat-card tg-stat-purple">
                    <div class="tg-stat-icon"><i class="bi bi-bell-fill"></i></div>
                    <div>
                        <div class="tg-stat-val">3</div>
                        <div class="tg-stat-lbl">Yeni Bildirişlər</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- ── 3 Sütunlu Layout ── -->
        <div class="row g-3">

            <!-- ════ SOL SIDEBAR ════ -->
            <div class="col-12 col-lg-3">

                <!-- Müəllim Profili -->
                <div class="tg-card mb-3" data-aos="fade-right">
                    <div class="tg-card-title"><i class="bi bi-person-badge me-2"></i>Müəllim Profili</div>
                    <div class="tg-profile-box">
                        <img src="foto/teacher.jpg" alt="Profil" class="tg-profile-img">
                        <div class="tg-profile-name">Elvin Məmmədov</div>
                        <div class="tg-profile-role">Kompüter Elmləri</div>
                        <div class="tg-profile-stats">
                            <div class="tg-pstat">
                                <span class="tg-pstat-val">12</span>
                                <span class="tg-pstat-lbl">Kurs</span>
                            </div>
                            <div class="tg-pstat-divider"></div>
                            <div class="tg-pstat">
                                <span class="tg-pstat-val">4.7</span>
                                <span class="tg-pstat-lbl">Reytinq</span>
                            </div>
                            <div class="tg-pstat-divider"></div>
                            <div class="tg-pstat">
                                <span class="tg-pstat-val">240</span>
                                <span class="tg-pstat-lbl">Tələbə</span>
                            </div>
                        </div>
                        <div class="tg-profile-email"><i class="bi bi-envelope me-1"></i>e.memmedov@example.com</div>
                    </div>
                </div>

                <!-- Bacarım Profili -->
                <div class="tg-card mb-3" data-aos="fade-right" data-aos-delay="80">
                    <div class="tg-card-title"><i class="bi bi-bar-chart-fill me-2"></i>Bacarım Profili</div>
                    <div>
                        <div class="tg-skill-item">
                            <div class="d-flex justify-content-between mb-1">
                                <span class="tg-skill-name"><i class="bi bi-code-slash me-1"></i>Proqramlaşdırma</span>
                                <span class="tg-skill-pct">92%</span>
                            </div>
                            <div class="progress tg-progress"><div class="progress-bar tg-bar-blue" style="width:92%"></div></div>
                        </div>
                        <div class="tg-skill-item">
                            <div class="d-flex justify-content-between mb-1">
                                <span class="tg-skill-name"><i class="bi bi-cpu me-1"></i>Süni İntellekt</span>
                                <span class="tg-skill-pct">78%</span>
                            </div>
                            <div class="progress tg-progress"><div class="progress-bar tg-bar-purple" style="width:78%"></div></div>
                        </div>
                        <div class="tg-skill-item">
                            <div class="d-flex justify-content-between mb-1">
                                <span class="tg-skill-name"><i class="bi bi-diagram-3 me-1"></i>Müasir Riyaziyyat</span>
                                <span class="tg-skill-pct">85%</span>
                            </div>
                            <div class="progress tg-progress"><div class="progress-bar tg-bar-cyan" style="width:85%"></div></div>
                        </div>
                    </div>
                </div>

                <!-- Top Müəllimlər -->
                <div class="tg-card" data-aos="fade-right" data-aos-delay="160">
                    <div class="tg-card-title"><i class="bi bi-trophy-fill me-2"></i>Top Müəllimlər</div>
                    <div>
                        <div class="tg-top-item">
                            <div class="tg-top-avatar tg-av-blue">EM</div>
                            <div class="tg-top-info">
                                <div class="tg-top-name">E. Məmmədov</div>
                                <div class="tg-top-sub">Proqramlaşdırma</div>
                            </div>
                            <div class="tg-top-rating"><i class="bi bi-star-fill"></i> 4.9</div>
                        </div>
                        <div class="tg-top-item">
                            <div class="tg-top-avatar tg-av-green">SR</div>
                            <div class="tg-top-info">
                                <div class="tg-top-name">S. Rəhimova</div>
                                <div class="tg-top-sub">Tarix</div>
                            </div>
                            <div class="tg-top-rating"><i class="bi bi-star-fill"></i> 4.8</div>
                        </div>
                        <div class="tg-top-item">
                            <div class="tg-top-avatar tg-av-purple">SN</div>
                            <div class="tg-top-info">
                                <div class="tg-top-name">S. Nəsirov</div>
                                <div class="tg-top-sub">Süni İntellekt</div>
                            </div>
                            <div class="tg-top-rating"><i class="bi bi-star-fill"></i> 4.7</div>
                        </div>
                    </div>
                </div>

            </div><!-- /SOL SIDEBAR -->

            <!-- ════ MƏRKƏZ — CƏDVƏL ════ -->
            <div class="col-12 col-lg-6">

        <!-- ===== CƏDVƏL KARTI ===== -->
        <div class="card custom-table-card border-0" data-aos="fade-up" data-aos-delay="100" id="teacherTableCard">

            <!-- Kart Başlığı: Axtarış -->
            <div class="card-header border-0 p-4 bg-white">
                <div class="row align-items-center g-3">
                    <!-- Sol: Başlıq -->
                    <div class="col-12 col-md-5">
                        <h5 class="fw-bold mb-0 text-dark d-flex align-items-center gap-2 flex-wrap">
                            <i class="bi bi-table text-info"></i> Müəllim Siyahısı
                            <span class="badge bg-info-subtle text-info ms-1 rounded-pill" style="font-size:0.75rem;">
                                <%= totalTeachers %> nəfər
                            </span>
                        </h5>
                    </div>
                    <!-- Sağ: Search + Yeni Müəllim + Export + Çap -->
                    <div class="col-12 col-md-7">
                        <div class="d-flex gap-2 flex-wrap align-items-center">
                            <form action="teachers.jsp" method="get" class="d-flex gap-2 flex-grow-1">
                                <div class="input-group search-group flex-grow-1">
                                    <span class="input-group-text bg-white border-end-0 rounded-start-pill ps-3">
                                        <i class="bi bi-search text-muted"></i>
                                    </span>
                                    <input type="text" name="search"
                                           value="<%= searchWord != null ? searchWord : "" %>"
                                           class="form-control border-start-0 border-end-0 py-2"
                                           placeholder="Ad və ya soyad ilə axtar...">
                                    <button type="submit" class="btn btn-info rounded-end-pill px-4 text-white">Axtar</button>
                                </div>
                                <% if (searchWord != null && !searchWord.trim().isEmpty()) { %>
                                <a href="teachers.jsp" class="btn btn-outline-secondary rounded-pill px-3" title="Sıfırla">
                                    <i class="bi bi-x-lg"></i>
                                </a>
                                <% } %>
                            </form>
                            <!-- Yeni Müəllim + Export + Çap (vahid toolbar) -->
                            <div class="table-toolbar">
                                <button class="btn-toolbar-action" title="Yeni Müəllim"
                                        data-bs-toggle="modal" data-bs-target="#addTeacherModal">
                                    <i class="bi bi-person-plus-fill text-info"></i> Yeni Müəllim
                                </button>
                                <button class="btn-toolbar-action" title="Export"
                                        onclick="openExportModal('teacherTable','Müəllim Siyahısı','muellimler',<%= totalAllTeachers %>, getTeacherExportData())">
                                    <i class="bi bi-box-arrow-up text-primary"></i> Export
                                </button>
                                <button class="btn-toolbar-action" onclick="printTable('#teacherTable','Müəllim Siyahısı')" title="Çap et">
                                    <i class="bi bi-printer"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ════════════════════════════════════════════════
                 YENİ: SMART TOOLBAR  (cədvəlin üstündə)
            ════════════════════════════════════════════════ -->
            <div class="edu-smart-toolbar edu-smart-toolbar-info">
                <div class="d-flex align-items-center gap-2 flex-wrap">
                    <span class="edu-toolbar-lbl">FİLTR:</span>
                    <button class="edu-qf-info active" data-filter="all"      onclick="teacherFilter(this,'all')">
                        <i class="bi bi-grid-3x3-gap-fill"></i> Hamısı <span class="edu-fc-info" id="tfc-all"><%= totalTeachers %></span>
                    </button>
                    <button class="edu-qf-info"         data-filter="active"   onclick="teacherFilter(this,'active')">
                        <i class="bi bi-circle-fill" style="color:#10b981;font-size:7px;vertical-align:middle;"></i> Aktiv <span class="edu-fc-info" id="tfc-active">–</span>
                    </button>
                    <button class="edu-qf-info"         data-filter="inactive" onclick="teacherFilter(this,'inactive')">
                        <i class="bi bi-pause-circle"></i> Qeyri-aktiv <span class="edu-fc-info" id="tfc-inactive">–</span>
                    </button>
                </div>
                <div class="d-flex align-items-center gap-2">
                    <!-- Column Visibility -->
                    <div class="dropdown">
                        <button class="edu-tool-btn-info" data-bs-toggle="dropdown" title="Sütunları idarə et">
                            <i class="bi bi-layout-three-columns"></i>
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end shadow border-0 rounded-3 p-2" style="min-width:200px">
                            <li><h6 class="dropdown-header small fw-bold text-muted">SÜTUNLAR</h6></li>
                            <li><label class="dropdown-item edu-col-lbl-t"><input type="checkbox" class="form-check-input m-0 edu-col-chk-t" data-colidx="0" data-export-index="0" data-label="ID" checked> ID</label></li>
                            <li><label class="dropdown-item edu-col-lbl-t"><input type="checkbox" class="form-check-input m-0 edu-col-chk-t" data-colidx="1" data-export-index="1" data-label="Müəllim" checked> Müəllim</label></li>
                            <li><label class="dropdown-item edu-col-lbl-t"><input type="checkbox" class="form-check-input m-0 edu-col-chk-t" data-export-index="2" data-label="Email" checked> Email</label></li>
                            <li><label class="dropdown-item edu-col-lbl-t"><input type="checkbox" class="form-check-input m-0 edu-col-chk-t" data-colidx="2" data-export-index="3" data-label="Yaş" checked> Yaş</label></li>
                            <li><label class="dropdown-item edu-col-lbl-t"><input type="checkbox" class="form-check-input m-0 edu-col-chk-t" data-colidx="3" data-export-index="4" data-label="Sahə" checked> Sahə</label></li>
                            <li><label class="dropdown-item edu-col-lbl-t"><input type="checkbox" class="form-check-input m-0 edu-col-chk-t" data-colidx="4" data-export-index="5" data-label="Status" checked> Status</label></li>
                        </ul>
                    </div>
                    <!-- Row Density -->
                    <div class="dropdown">
                        <button class="edu-tool-btn-info" data-bs-toggle="dropdown" title="Sıra sıxlığı">
                            <i class="bi bi-distribute-vertical"></i>
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end shadow border-0 rounded-3 p-2">
                            <li><h6 class="dropdown-header small fw-bold text-muted">SXILIQ</h6></li>
                            <li><button class="dropdown-item rounded-2 py-2" onclick="tchDensity('compact')"><i class="bi bi-list me-2"></i>Kompakt</button></li>
                            <li><button class="dropdown-item rounded-2 py-2 fw-semibold" onclick="tchDensity('normal')"><i class="bi bi-view-list me-2"></i>Normal</button></li>
                            <li><button class="dropdown-item rounded-2 py-2" onclick="tchDensity('comfortable')"><i class="bi bi-card-list me-2"></i>Geniş</button></li>
                        </ul>
                    </div>
                    <!-- Fullscreen -->
                    <button class="edu-tool-btn-info" id="tchFsBtn" onclick="tchFullscreen()" title="Tam ekran">
                        <i class="bi bi-fullscreen" id="tchFsIcon"></i>
                    </button>
                    <!-- Shortcuts info -->
                    <button class="edu-tool-btn-info"
                            data-bs-toggle="popover" data-bs-placement="left" data-bs-trigger="click"
                            data-bs-html="true"
                            data-bs-content="<div style='font-size:12px'><div class='d-flex justify-content-between gap-3 mb-2'><kbd>Alt+N</kbd><span class='text-muted'>Yeni müəllim</span></div><div class='d-flex justify-content-between gap-3'><kbd>Esc</kbd><span class='text-muted'>Modalı bağla</span></div></div>"
                            title="⌨️ Qısayollar">
                        <i class="bi bi-keyboard"></i>
                    </button>
                </div>
            </div>
            <!-- ═══════ SMART TOOLBAR SON ═══════ -->

            <!-- Cədvəl -->
            <div class="table-responsive">
                <table class="teacher-table table table-hover align-middle mb-0 responsive-table" id="teacherTable">
                    <thead>
                    <tr>
                        <th class="ps-4 col-id">ID</th>
                        <th class="col-teacher">Müəllim</th>
                        <th class="text-center col-age">Yaş</th>
                        <th class="text-center col-field">Sahə</th>
                        <th class="text-center col-status">Status</th>
                        <th class="text-center col-actions">Əməliyyat</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        if (teachers.isEmpty()) {
                    %>
                    <tr>
                        <td colspan="6" class="text-center py-5">
                            <div class="empty-state">
                                <i class="bi bi-person-x display-4 text-muted d-block mb-3"></i>
                                <p class="text-muted mb-0">
                                    <% if (searchWord != null && !searchWord.trim().isEmpty()) { %>
                                    "<strong><%= searchWord %></strong>" üzrə nəticə tapılmadı.
                                    <% } else { %>
                                    Hələ heç bir müəllim əlavə edilməyib.
                                    <% } %>
                                </p>
                            </div>
                        </td>
                    </tr>
                    <%
                        } else {
                            for (Teacher teacher : teachers) {
                                String initials = teacher.getName().substring(0, 1).toUpperCase()
                                        + teacher.getSurname().substring(0, 1).toUpperCase();
                    %>
                    <tr class="stagger-item" data-export-email="<%= teacher.getEmail() %>">
                        <td class="ps-4">
                            <span class="id-badge"><%= teacher.getId() %></span>
                        </td>
                        <td data-export="<%= teacher.getName() %> <%= teacher.getSurname() %>">
                            <div class="d-flex align-items-center gap-3">
                                <div class="avatar-circle bg-info text-white flex-shrink-0">
                                    <img src="foto/teacher.jpg" alt="Teacher Logo" class="avatar-circle" style="width: 50px; height: 50px;">
                                </div>
                                <div>
                                    <div class="fw-semibold text-dark lh-sm"><%= teacher.getName() %> <%= teacher.getSurname() %></div>
                                    <small class="text-muted row-email-inline"><%= teacher.getEmail() %></small>
                                </div>
                            </div>
                        </td>
                        <td class="text-center">
                            <span class="age-badge"><%= teacher.getAge() %></span>
                        </td>
                        <td class="text-center">
                            <span class="badge rounded-pill px-3 py-2 subject-badge-info">
                                <i class="bi bi-cpu me-1"></i>Kompüter Elmləri
                            </span>
                        </td>
                        <td class="text-center">
                            <span class="badge badge-soft-success rounded-pill px-3 py-2">
                                <i class="bi bi-circle-fill me-1" style="font-size:6px;"></i>Aktiv
                            </span>
                        </td>
                        <td class="text-center">
                            <div class="d-flex justify-content-center gap-2">
                                <button class="btn btn-action btn-view shadow-sm" title="Email gizlət/göstər">
                                    <i class="bi bi-eye"></i>
                                </button>
                                <button class="btn btn-action btn-edit shadow-sm"
                                        title="Redaktə et"
                                        data-bs-toggle="modal"
                                        data-bs-target="#editTeacherModal"
                                        data-id="<%= teacher.getId() %>"
                                        data-name="<%= teacher.getName() %>"
                                        data-surname="<%= teacher.getSurname() %>"
                                        data-age="<%= teacher.getAge() %>"
                                        data-email="<%= teacher.getEmail() %>">
                                    <i class="bi bi-pencil-square"></i>
                                </button>
                                <button class="btn btn-action btn-delete shadow-sm"
                                        title="Sil"
                                        data-bs-toggle="modal"
                                        data-bs-target="#deleteTeacherModal"
                                        data-id="<%= teacher.getId() %>"
                                        data-name="<%= teacher.getName() %> <%= teacher.getSurname() %>">
                                    <i class="bi bi-trash3"></i>
                                </button>
                            </div>
                        </td>
                    </tr>
                    <%
                            }
                        }
                    %>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <div class="card-footer bg-white border-0 px-4 py-3">
                <nav aria-label="Müəllim səhifələməsi">
                    <ul class="pagination pagination-sm justify-content-center mb-0" id="pagination-teacher">
                        <li class="page-item">
                            <a class="page-link rounded-circle me-1 border-0 bg-light" href="#" id="prev-teacher">
                                <i class="bi bi-chevron-left"></i>
                            </a>
                        </li>
                        <li class="page-item">
                            <a class="page-link rounded-circle border-0 bg-light" href="#" id="next-teacher">
                                <i class="bi bi-chevron-right"></i>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>

            <!-- ════ YENİ: STATUS BAR ════ -->
            <div class="edu-status-bar edu-status-bar-info">
                <div class="d-flex align-items-center gap-3">
                    <span class="edu-sb-item"><i class="bi bi-table text-info me-1"></i><span id="tch-visible-count"><%= totalTeachers %></span> sətir</span>
                    <span class="edu-sb-sep">|</span>
                    <span class="edu-sb-item"><i class="bi bi-funnel text-muted me-1"></i><span id="tch-filter-label">Filtr yoxdur</span></span>
                </div>
                <div class="d-flex align-items-center gap-2">
                    <span class="edu-sb-item text-muted"><i class="bi bi-clock me-1"></i><span id="tch-load-time"></span></span>
                    <span class="edu-live-wrap"><span class="edu-live-dot"></span><span class="edu-sb-item" style="font-size:11px">Canlı</span></span>
                </div>
            </div>
            <!-- ════ STATUS BAR SON ════ -->
        </div><!-- /custom-table-card -->
            </div><!-- /col-lg-6 mərkəz -->

            <!-- ════ SAĞ SIDEBAR ════ -->
            <div class="col-12 col-lg-3">

                <!-- Cəm Müəllimlər -->
                <div class="tg-card mb-3" data-aos="fade-left">
                    <div class="tg-card-title"><i class="bi bi-people-fill me-2"></i>Cəm Müəllimlər</div>
                    <div>
                        <div class="tg-av-row">
                            <div class="tg-big-avatar" style="background:linear-gradient(135deg,#4f46e5,#7c3aed)">EM</div>
                            <div>
                                <div class="tg-av-name">Elvin M.</div>
                                <div class="tg-av-sub">Aktiv Reytinq</div>
                                <div class="tg-av-rating"><i class="bi bi-star-fill"></i> 3.7 / 5</div>
                            </div>
                        </div>
                        <div class="tg-av-row">
                            <div class="tg-big-avatar" style="background:linear-gradient(135deg,#06b6d4,#0284c7)">SR</div>
                            <div>
                                <div class="tg-av-name">Solmaz R.</div>
                                <div class="tg-av-sub">Orta Reytinq</div>
                                <div class="tg-av-rating"><i class="bi bi-star-fill"></i> 4.1 / 5</div>
                            </div>
                        </div>
                        <div class="tg-av-row">
                            <div class="tg-big-avatar" style="background:linear-gradient(135deg,#059669,#10b981)">TD</div>
                            <div>
                                <div class="tg-av-name">Tural D.</div>
                                <div class="tg-av-sub">Aktiv Reytinq</div>
                                <div class="tg-av-rating"><i class="bi bi-star-fill"></i> 4.5 / 5</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Kurs Statistikası (donut) -->
                <div class="tg-card mb-3" data-aos="fade-left" data-aos-delay="80">
                    <div class="tg-card-title"><i class="bi bi-pie-chart-fill me-2"></i>Kurs Statistikası</div>
                    <div class="tg-pie-wrap">
                        <div class="tg-pie-chart">
                            <div class="tg-pie-inner">
                                <span class="tg-pie-val"><%= totalTeachers * 3 %></span>
                                <span class="tg-pie-lbl">Yeni Kurs</span>
                            </div>
                        </div>
                    </div>
                    <div class="tg-legend">
                        <div class="tg-legend-item"><span class="tg-legend-dot" style="background:#7c3aed"></span>Aktiv</div>
                        <div class="tg-legend-item"><span class="tg-legend-dot" style="background:#06b6d4"></span>Müvəqqəti</div>
                        <div class="tg-legend-item"><span class="tg-legend-dot" style="background:#f59e0b"></span>Yeni</div>
                    </div>
                </div>

                <!-- Son Şərhlər -->
                <div class="tg-card" data-aos="fade-left" data-aos-delay="160">
                    <div class="tg-card-title"><i class="bi bi-chat-dots-fill me-2"></i>Son Şərhlər</div>
                    <div>
                        <div class="tg-comment-item">
                            <div class="tg-comment-av" style="background:linear-gradient(135deg,#7c3aed,#4f46e5)">LM</div>
                            <div>
                                <div class="tg-comment-name">Leyla Məmmədova</div>
                                <div class="tg-comment-text">"Çox gözəl dərs keçdi!"</div>
                            </div>
                        </div>
                        <div class="tg-comment-item">
                            <div class="tg-comment-av" style="background:linear-gradient(135deg,#06b6d4,#0284c7)">AS</div>
                            <div>
                                <div class="tg-comment-name">Anar Sultanov</div>
                                <div class="tg-comment-text">"Çox gözəl dərs keçdi, təşəkkür!"</div>
                            </div>
                        </div>
                        <div class="tg-comment-item">
                            <div class="tg-comment-av" style="background:linear-gradient(135deg,#d97706,#f59e0b)">RN</div>
                            <div>
                                <div class="tg-comment-name">Rəna Nəsirlı</div>
                                <div class="tg-comment-text">"İzahlar çox aydın idi!"</div>
                            </div>
                        </div>
                    </div>
                </div>

            </div><!-- /SAĞ SIDEBAR -->

        </div><!-- /row g-3 3-sütun -->
    </div><!-- /container -->
</section>

<!-- ===== MODAL: Yeni Müəllim ===== -->
<div class="modal fade" id="addTeacherModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-4">
            <div class="modal-header border-0 px-4 pt-4 pb-2">
                <div class="d-flex align-items-center gap-2">
                    <div class="modal-icon-box bg-info text-white">
                        <i class="bi bi-person-workspace"></i>
                    </div>
                    <h5 class="modal-title fw-bold mb-0">Yeni Müəllim Əlavə Et</h5>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body px-4 pb-4">
                <form action="teacher" method="POST">
                    <input type="hidden" name="action" value="create">
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-muted">Ad</label>
                        <input type="text" name="name" class="form-control rounded-3 px-3"
                               placeholder="Məs: Murad" required>
                        <div class="invalid-feedback"></div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-muted">Soyad</label>
                        <input type="text" name="surname" class="form-control rounded-3 px-3"
                               placeholder="Məs: Qasımov" required>
                        <div class="invalid-feedback"></div>
                    </div>
                    <div class="row g-3 mb-3">
                        <div class="col-6">
                            <label class="form-label small fw-semibold text-muted">Yaş</label>
                            <input type="number" name="age" class="form-control rounded-3 px-3"
                                   placeholder="Məs: 35" min="20" max="80" required>
                            <div class="invalid-feedback"></div>
                        </div>
                        <div class="col-6">
                            <label class="form-label small fw-semibold text-muted">Email</label>
                            <input type="email" name="email" class="form-control rounded-3 px-3"
                                   placeholder="murad@email.com" required>
                            <div class="invalid-feedback"></div>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-info w-100 rounded-3 py-2 mt-2 fw-semibold text-white">
                        <i class="bi bi-check2-circle me-2"></i>Yadda Saxla
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- ===== MODAL: Müəllim Redaktə ===== -->
<div class="modal fade" id="editTeacherModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-4">
            <div class="modal-header border-0 px-4 pt-4 pb-2">
                <div class="d-flex align-items-center gap-2">
                    <div class="modal-icon-box bg-warning text-white">
                        <i class="bi bi-pencil-square"></i>
                    </div>
                    <h5 class="modal-title fw-bold mb-0">Müəllimi Redaktə Et</h5>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body px-4 pb-4">
                <form action="teacher" method="POST">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" id="edit-teacher-id-hidden">
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-muted">ID (dəyişdirilmir)</label>
                        <input type="text" id="edit-teacher-id-display"
                               class="form-control rounded-3 px-3 bg-light text-muted" disabled>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-muted">Ad</label>
                        <input type="text" name="name" id="edit-teacher-name"
                               class="form-control rounded-3 px-3" required>
                        <div class="invalid-feedback"></div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-muted">Soyad</label>
                        <input type="text" name="surname" id="edit-teacher-surname"
                               class="form-control rounded-3 px-3" required>
                        <div class="invalid-feedback"></div>
                    </div>
                    <div class="row g-3 mb-3">
                        <div class="col-6">
                            <label class="form-label small fw-semibold text-muted">Yaş</label>
                            <input type="number" name="age" id="edit-teacher-age"
                                   class="form-control rounded-3 px-3" min="20" max="80" required>
                            <div class="invalid-feedback"></div>
                        </div>
                        <div class="col-6">
                            <label class="form-label small fw-semibold text-muted">Email</label>
                            <input type="email" name="email" id="edit-teacher-email"
                                   class="form-control rounded-3 px-3" required>
                            <div class="invalid-feedback"></div>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-warning w-100 rounded-3 py-2 mt-2 fw-semibold text-white">
                        <i class="bi bi-arrow-repeat me-2"></i>Yenilə
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- ===== MODAL: Müəllim Sil ===== -->
<div class="modal fade" id="deleteTeacherModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-sm">
        <div class="modal-content border-0 shadow-lg rounded-4">
            <div class="modal-body p-4 text-center">
                <div class="delete-icon-wrap mb-3">
                    <i class="bi bi-trash3-fill text-danger"></i>
                </div>
                <h5 class="fw-bold mb-2">Müəllimi Sil</h5>
                <p class="text-muted mb-4">
                    <span class="fw-semibold text-dark" id="delete-teacher-name"></span>
                    adlı müəllimi silmək istədiyinizə əminsiniz?
                </p>
                <form action="teacher" method="POST">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" id="delete-teacher-id">
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-light w-100 rounded-3 py-2"
                                data-bs-dismiss="modal">Ləğv Et</button>
                        <button type="submit" class="btn btn-danger w-100 rounded-3 py-2 fw-semibold">
                            <i class="bi bi-trash3 me-1"></i>Sil
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Yuxarı Qayıt Düyməsi -->
<button id="backToTop" class="btn btn-primary">
    <i class="bi bi-arrow-up"></i>
</button>

<jsp:include page="footer.jsp"/>

<!-- Modal HTML skriptlərdən ƏVVƏL gəlməlidir -->
<jsp:include page="export-modal.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<!-- Export kitabxanaları -->
<!-- ExcelJS - rəngli excel export üçün -->
<script src="https://cdn.jsdelivr.net/npm/exceljs@4.3.0/dist/exceljs.min.js"></script>
<script src="js/cfb.min.js?v=4.1"></script>
<script src="js/xlsx-style.min.js?v=4.1"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.8.2/jspdf.plugin.autotable.min.js"></script>
<script src="js/script.js?v=4.0"></script>
<script src="js/excel-export.js?v=4.1"></script>
<script>
    AOS.init({ duration: 800, once: true, offset: 80 });
    setupPagination('#teacherTable', 'pagination-teacher', 10);
</script>

<!-- ══════════════════════════════════════════════════════════
     YENİ TEXNOLOGİYALAR — STİL + JS  (cədvələ toxunmur)
══════════════════════════════════════════════════════════ -->
<style>
/* ─── Smart Toolbar (info theme) ─── */
.edu-smart-toolbar-info {
    display: flex; align-items: center; justify-content: space-between;
    flex-wrap: wrap; gap: 8px; padding: 10px 20px;
    background: linear-gradient(135deg, #f0fbff, #e8f7ff);
    border-top: 1px solid #e9ecef; border-bottom: 1px solid #e9ecef;
}
.edu-toolbar-lbl { font-size: 11px; font-weight: 600; color: #8a9ab5; letter-spacing: .5px; white-space: nowrap; }

/* ─── Quick filter (info theme) ─── */
.edu-qf-info {
    display: inline-flex; align-items: center; gap: 5px;
    padding: 5px 13px; border-radius: 20px;
    border: 1px solid #dee2e6; background: #fff;
    font-size: 12px; font-weight: 500; cursor: pointer; color: #6c757d;
    transition: all .2s; white-space: nowrap;
}
.edu-qf-info:hover  { border-color: #0dcaf0; color: #0dcaf0; background: #f0fbff; }
.edu-qf-info.active { background: #0dcaf0; border-color: #0dcaf0; color: #fff; box-shadow: 0 2px 8px rgba(13,202,240,.22); }
.edu-fc-info {
    background: rgba(255,255,255,.3); border-radius: 10px;
    padding: 1px 7px; font-size: 10px; font-weight: 700; min-width: 20px; text-align: center;
}
.edu-qf-info:not(.active) .edu-fc-info { background: #e9ecef; color: #495057; }

/* ─── Tool buttons (info theme) ─── */
.edu-tool-btn-info {
    width: 32px; height: 32px;
    display: inline-flex; align-items: center; justify-content: center;
    border: 1px solid #dee2e6; border-radius: 8px;
    background: #fff; color: #6c757d; cursor: pointer; font-size: 14px; transition: all .2s;
}
.edu-tool-btn-info:hover      { border-color: #0dcaf0; color: #0dcaf0; background: #f0fbff; transform: translateY(-1px); }
.edu-tool-btn-info.fs-active  { border-color: #0dcaf0; color: #0dcaf0; background: #e0f8ff; }
.edu-col-lbl-t { display: flex; align-items: center; gap: 8px; cursor: pointer; padding: 8px 12px; border-radius: 6px; }

/* ─── Fullscreen ─── */
.edu-tbl-fullscreen { position: fixed !important; inset: 0 !important; z-index: 9999 !important; border-radius: 0 !important; overflow: auto !important; }

/* ─── Density ─── */
#teacherTable.edu-compact     td, #teacherTable.edu-compact     th { padding-top: 5px !important; padding-bottom: 5px !important; }
#teacherTable.edu-comfortable td, #teacherTable.edu-comfortable th { padding-top: 16px !important; padding-bottom: 16px !important; }

/* ─── Status Bar (info theme) ─── */
.edu-status-bar-info {
    display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 8px;
    padding: 9px 20px; border-top: 1px solid #e8f7ff; background: #f0fbff;
}
.edu-sb-item { font-size: 11.5px; color: #6c757d; }
.edu-sb-sep  { color: #dee2e6; }
.edu-live-wrap { display: inline-flex; align-items: center; gap: 5px; }
.edu-live-dot  { width: 7px; height: 7px; border-radius: 50%; background: #10b981; display: inline-block; animation: eduPulse 2s infinite; }
@keyframes eduPulse { 0%,100%{opacity:1;box-shadow:0 0 0 0 rgba(16,185,129,.4);}  50%{opacity:.8;box-shadow:0 0 0 4px rgba(16,185,129,0);} }
</style>

<script>
/* ─── Load time ─── */
document.getElementById('tch-load-time').textContent =
    new Date().toLocaleTimeString('az-AZ', {hour:'2-digit', minute:'2-digit', second:'2-digit'});

/* ─── Count statuses ─── */
(function initTeacherCounts() {
    const rows = document.querySelectorAll('#teacherTable tbody tr.stagger-item');
    let active = 0, inactive = 0;
    rows.forEach(r => {
        const t = r.querySelector('[class*="badge-soft"], [class*="badge"]')?.textContent?.trim() || '';
        if (t.includes('Aktiv')) active++; else inactive++;
    });
    document.getElementById('tfc-active').textContent   = active   || rows.length;
    document.getElementById('tfc-inactive').textContent = inactive;
})();

/* ─────────────────────────────────────────────────────────────
   QUICK FILTER  — DOM-a əsaslanan düzgün həll
   Export / Print / Search heç bir şəkildə təsirlənmir
───────────────────────────────────────────────────────────── */
var _tchAllRows = null;

function teacherFilter(btn, type) {
    document.querySelectorAll('.edu-qf-info').forEach(b => b.classList.remove('active'));
    btn.classList.add('active');

    const tbody = document.querySelector('#teacherTable tbody');

    if (!_tchAllRows) {
        _tchAllRows = Array.from(tbody.querySelectorAll('tr.stagger-item'));
    }

    /* Bütün sətirləri geri qay­tar */
    _tchAllRows.forEach(r => { if (!tbody.contains(r)) tbody.appendChild(r); });

    /* Uyğun olmayanları çıxar */
    if (type !== 'all') {
        _tchAllRows.forEach(r => {
            const t = r.querySelector('[class*="badge-soft"], [class*="badge"]')?.textContent?.trim() || '';
            const show = (type === 'active' && t.includes('Aktiv')) ||
                         (type === 'inactive' && !t.includes('Aktiv'));
            if (!show) tbody.removeChild(r);
        });
    }

    /* Pagination-ı yenidən qur */
    setupPagination('#teacherTable', 'pagination-teacher', 10);

    /* Status bar yenilə */
    updateTeacherVisibleCount();
    const lblMap = { all:'Filtr yoxdur', active:'Aktiv müəllimlər', inactive:'Qeyri-aktiv müəllimlər' };
    document.getElementById('tch-filter-label').textContent = lblMap[type];
}

function getTeacherExportData() {
    return {
        headers: ['ID', 'Müəllim', 'Email', 'Yaş', 'Sahə', 'Status'],
        dataRows: [
            <% for (int i = 0; i < allTeachers.size(); i++) {
                Teacher exportTeacher = allTeachers.get(i);
            %>[
                "<%= exportTeacher.getId() %>",
                "<%= escJs(exportTeacher.getName() + " " + exportTeacher.getSurname()) %>",
                "<%= escJs(exportTeacher.getEmail()) %>",
                "<%= exportTeacher.getAge() %>",
                "Kompüter Elmləri",
                "Aktiv"
            ]<%= i < allTeachers.size() - 1 ? "," : "" %>
            <% } %>
        ]
    };
}

function updateTeacherVisibleCount() {
    const visibleRows = document.querySelectorAll('#teacherTable tbody tr.stagger-item:not([style*="display: none"]):not(.d-none)').length;
    document.getElementById('tch-visible-count').textContent = visibleRows;
}

/* ─── Column Visibility ─── */
document.querySelectorAll('.edu-col-chk-t').forEach(chk => {
    chk.addEventListener('change', function () {
        const idx = parseInt(this.dataset.colidx);
        document.querySelectorAll('#teacherTable tr').forEach(row => {
            const cell = row.children[idx];
            if (cell) cell.style.display = this.checked ? '' : 'none';
        });
    });
});

/* ─── Row Density ─── */
function tchDensity(mode) {
    const t = document.getElementById('teacherTable');
    t.classList.remove('edu-compact', 'edu-normal', 'edu-comfortable');
    t.classList.add('edu-' + mode);
}

/* ─── Fullscreen ─── */
function tchFullscreen() {
    const card = document.getElementById('teacherTableCard');
    const icon = document.getElementById('tchFsIcon');
    const btn  = document.getElementById('tchFsBtn');
    const isFs = card.classList.toggle('edu-tbl-fullscreen');
    icon.className = isFs ? 'bi bi-fullscreen-exit' : 'bi bi-fullscreen';
    btn.classList.toggle('fs-active', isFs);
    document.body.classList.toggle('has-fullscreen', isFs);
    document.body.style.overflow = isFs ? 'hidden' : '';
}

/* ─── Esc → fullscreen bağla ─── */
document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') {
        const card = document.getElementById('teacherTableCard');
        if (card && card.classList.contains('edu-tbl-fullscreen')) {
            tchFullscreen();
        }
    }
});

/* ─── Init popovers ─── */
document.querySelectorAll('[data-bs-toggle="popover"]').forEach(el => new bootstrap.Popover(el));
document.addEventListener('table:pageChanged', function(event) {
    if (event.detail && event.detail.tableId === '#teacherTable') {
        updateTeacherVisibleCount();
    }
});
updateTeacherVisibleCount();
</script>
</body>
</