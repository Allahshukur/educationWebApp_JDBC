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
    <link href="css/style.css?v=3.5" rel="stylesheet">
    <style>body{font-family:'Outfit',sans-serif;}</style>
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


<jsp:include page="header.jsp"/>

<section class="py-5 teachers-section min-vh-100">
    <div class="container py-4">

        <!-- ===== BAŞLIQ ===== -->
        <div class="row mb-5 align-items-center" data-aos="fade-down">
            <div class="col-lg-8">
                <div class="d-flex align-items-center gap-3 mb-2">
                    <div class="page-icon-box bg-info text-white">
                        <i class="bi bi-person-workspace"></i>
                    </div>
                    <div>
                        <h1 class="fw-bold mb-0 page-title">Müəllim Paneli</h1>
                        <p class="text-muted mb-0 mt-1">Tədris heyəti və kursların idarə edilməsi</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 text-lg-end mt-4 mt-lg-0">
                <button class="btn btn-info btn-add-new px-4 py-2 shadow text-white" data-bs-toggle="modal"
                        data-bs-target="#addTeacherModal">
                    <i class="bi bi-person-plus-fill me-2"></i>Yeni Müəllim
                </button>
            </div>
        </div>

        <!-- ===== STATİSTİKA KARTLARI ===== -->
        <div class="row g-4 mb-5">
            <div class="col-sm-6 col-xl-4" data-aos="fade-up" data-aos-delay="0">
                <div class="stat-card-modern info-card">
                    <div class="stat-icon-wrap">
                        <i class="bi bi-mortarboard-fill"></i>
                    </div>
                    <div class="stat-info">
                        <span class="stat-label">Cəmi Müəllim</span>
                        <span class="stat-value"><%= totalTeachers %></span>
                    </div>
                    <div class="stat-bg-icon"><i class="bi bi-mortarboard-fill"></i></div>
                </div>
            </div>
            <div class="col-sm-6 col-xl-4" data-aos="fade-up" data-aos-delay="100">
                <div class="stat-card-modern primary-card">
                    <div class="stat-icon-wrap">
                        <i class="bi bi-book-half"></i>
                    </div>
                    <div class="stat-info">
                        <span class="stat-label">Aktiv Kurslar</span>
                        <span class="stat-value"><%= totalTeachers * 3 %></span>
                    </div>
                    <div class="stat-bg-icon"><i class="bi bi-book-half"></i></div>
                </div>
            </div>
            <div class="col-sm-12 col-xl-4" data-aos="fade-up" data-aos-delay="200">
                <div class="stat-card-modern success-card">
                    <div class="stat-icon-wrap">
                        <i class="bi bi-star-fill"></i>
                    </div>
                    <div class="stat-info">
                        <span class="stat-label">Ümumi Reytinq</span>
                        <span class="stat-value">4.9 / 5</span>
                    </div>
                    <div class="stat-bg-icon"><i class="bi bi-star-fill"></i></div>
                </div>
            </div>
        </div>

        <!-- ===== CƏDVƏL KARTI ===== -->
        <div class="card custom-table-card border-0" data-aos="fade-up" data-aos-delay="100" id="teacherTableCard">

            <!-- Kart Başlığı: Axtarış -->
            <div class="card-header border-0 p-4 bg-white">
                <div class="row align-items-center g-3">
                    <div class="col-md-5">
                        <h5 class="fw-bold mb-0 text-dark d-flex align-items-center gap-2">
                            <i class="bi bi-table text-info"></i> Akademik Heyət
                            <span class="badge bg-info-subtle text-info ms-1 rounded-pill" style="font-size:0.75rem;">
                                <%= totalTeachers %> nəfər
                            </span>
                        </h5>
                    </div>
                    <div class="col-md-7">
                        <div class="d-flex gap-2 flex-wrap">
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
                            <!-- Export / Print Desktop -->
                            <div class="table-toolbar d-none d-md-flex">
                                <button class="btn-toolbar-action" title="Export"
                                        onclick="openExportModal('teacherTable','Müəllim Siyahısı','muellimler',<%= totalAllTeachers %>, getTeacherExportData())">
                                    <i class="bi bi-box-arrow-up text-primary"></i> Export
                                </button>
                                <button class="btn-toolbar-action" onclick="printTable('#teacherTable','Müəllim Siyahısı')" title="Çap et">
                                    <i class="bi bi-printer"></i>
                                </button>
                            </div>
                            <!-- Export / Print Mobile -->
                            <div class="table-toolbar d-flex d-md-none mt-2">
                                <button class="btn-toolbar-action w-100" title="Export"
                                        onclick="openExportModal('teacherTable','Müəllim Siyahısı','muellimler',<%= totalAllTeachers %>, getTeacherExportData())">
                                    <i class="bi bi-box-arrow-up text-primary"></i> Export
                                </button>
                                <button class="btn-toolbar-action w-100" onclick="printTable('#teacherTable','Müəllim Siyahısı')" title="Çap et">
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
        </div>
    </div>
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
}

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
</html>
