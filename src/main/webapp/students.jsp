<%@ page import="java.util.List" %>
<%@ page import="com.sukur.educationwebapp.student.entity.Student" %>
<%@ page import="com.sukur.educationwebapp.student.service.StudentService" %>
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
    String search = request.getParameter("search");
    StudentService studentService = new StudentService();
    List<Student> allStudents = studentService.findAll();
    List<Student> students;

    if (search != null && !search.trim().isEmpty()) {
        students = studentService.search(search.trim());
    } else {
        students = allStudents;
    }

    int totalStudents = students.size();
    int totalAllStudents = allStudents.size();
    int activeStudents = totalAllStudents == 0 ? 0 : Math.max(1, (int) Math.round(totalAllStudents * 0.70));
    int graduatedStudents = totalAllStudents == 0 ? 0 : Math.max(0, (int) Math.round(totalAllStudents * 0.18));
    int passiveStudents = Math.max(0, totalAllStudents - activeStudents - graduatedStudents);
    int javaStudents = totalAllStudents == 0 ? 0 : Math.max(1, (int) Math.round(totalAllStudents * 0.54));
    int designStudents = totalAllStudents == 0 ? 0 : Math.max(0, (int) Math.round(totalAllStudents * 0.27));
    int analyticsStudents = Math.max(0, totalAllStudents - javaStudents - designStudents);
%>
<!DOCTYPE html>
<html lang="az">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Telebeler - Education App</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="css/style.css?v=4.3" rel="stylesheet">
    <link href="css/dark-mode.css?v=1.1" rel="stylesheet">
</head>
<body class="overflow-hidden-init">

<div id="loader">
    <div class="loader-content">
        <div class="loader-circle"></div>
        <div class="loader-circle"></div>
        <div class="loader-circle"></div>
        <div class="loader-subtext">Telebe paneli yuklenir...</div>
    </div>
</div>

<%
    request.setAttribute("pageLabel", "Tələbələr");
    request.setAttribute("isHome", false);
%>
<jsp:include page="header.jsp"/>

<section class="py-5 students-section min-vh-100">
    <div class="container py-4 student-shell">
        <div class="row g-4 mb-4">
            <div class="col-6 col-xl-3" data-aos="fade-up" data-aos-delay="0">
                <div class="stat-card-modern primary-card">
                    <div class="stat-icon-wrap"><i class="bi bi-people-fill"></i></div>
                    <div class="stat-info">
                        <span class="stat-label">Cemi Telebe</span>
                        <span class="stat-value"><%= totalAllStudents %></span>
                    </div>
                    <div class="stat-bg-icon"><i class="bi bi-people-fill"></i></div>
                </div>
            </div>
            <div class="col-6 col-xl-3" data-aos="fade-up" data-aos-delay="100">
                <div class="stat-card-modern success-card">
                    <div class="stat-icon-wrap"><i class="bi bi-check2-circle"></i></div>
                    <div class="stat-info">
                        <span class="stat-label">Aktiv Telebe</span>
                        <span class="stat-value"><%= activeStudents %></span>
                    </div>
                    <div class="stat-bg-icon"><i class="bi bi-check2-circle"></i></div>
                </div>
            </div>
            <div class="col-6 col-xl-3" data-aos="fade-up" data-aos-delay="200">
                <div class="stat-card-modern warning-card">
                    <div class="stat-icon-wrap"><i class="bi bi-mortarboard-fill"></i></div>
                    <div class="stat-info">
                        <span class="stat-label">Mezunlar</span>
                        <span class="stat-value"><%= graduatedStudents %></span>
                    </div>
                    <div class="stat-bg-icon"><i class="bi bi-mortarboard-fill"></i></div>
                </div>
            </div>
            <div class="col-6 col-xl-3" data-aos="fade-up" data-aos-delay="300">
                <div class="stat-card-modern danger-card">
                    <div class="stat-icon-wrap"><i class="bi bi-star-fill"></i></div>
                    <div class="stat-info">
                        <span class="stat-label">Ortalama Qiymet</span>
                        <span class="stat-value">88.5%</span>
                    </div>
                    <div class="stat-bg-icon"><i class="bi bi-star-fill"></i></div>
                </div>
            </div>
        </div>

        <div class="row g-4 mb-4 student-analytics-row">
            <div class="col-lg-4" data-aos="fade-up" data-aos-delay="50">
                <div class="student-analytics-card student-distribution-card">
                    <div class="student-card-head">
                        <h5 class="mb-1">Telebe Paylanmasi</h5>
                        <span class="student-card-note">Cari bolgu</span>
                    </div>
                    <div class="student-distribution-wrap">
                        <div class="student-distribution-chart"
                             style="--seg-a:<%= activeStudents %>; --seg-b:<%= graduatedStudents %>; --seg-c:<%= passiveStudents %>;">
                            <div class="student-distribution-center">
                                <strong><%= totalAllStudents %>
                                </strong>
                                <span>Telebe</span>
                            </div>
                        </div>
                        <div class="student-distribution-legend">
                            <div class="distribution-item"><span
                                    class="distribution-dot dot-blue"></span><span>Aktiv <strong><%= activeStudents %></strong></span>
                            </div>
                            <div class="distribution-item"><span
                                    class="distribution-dot dot-green"></span><span>Mezun <strong><%= graduatedStudents %></strong></span>
                            </div>
                            <div class="distribution-item"><span class="distribution-dot dot-orange"></span><span>Diger aktiv <strong><%= passiveStudents %></strong></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-8" data-aos="fade-up" data-aos-delay="100">
                <div class="student-analytics-card student-performance-card">
                    <div class="student-card-head">
                        <h5 class="mb-1">Performans Deyisikliyi</h5>
                        <span class="student-card-note">Qiymet, istirak ve ireliyis</span>
                    </div>
                    <div class="student-performance-legend">
                        <span><i class="bi bi-square-fill text-primary"></i> Qiymet</span>
                        <span><i class="bi bi-square-fill text-success"></i> Istirak</span>
                        <span><i class="bi bi-square-fill text-info"></i> Ireliyis</span>
                    </div>
                    <div class="student-performance-chart">
                        <div class="chart-grid"></div>
                        <div class="chart-line line-primary">
                            <span style="left:0%;bottom:58%;"></span><span style="left:16%;bottom:46%;"></span><span
                                style="left:32%;bottom:62%;"></span><span style="left:48%;bottom:54%;"></span><span
                                style="left:64%;bottom:69%;"></span><span style="left:80%;bottom:57%;"></span><span
                                style="left:96%;bottom:76%;"></span>
                        </div>
                        <div class="chart-line line-success">
                            <span style="left:0%;bottom:42%;"></span><span style="left:16%;bottom:35%;"></span><span
                                style="left:32%;bottom:49%;"></span><span style="left:48%;bottom:60%;"></span><span
                                style="left:64%;bottom:48%;"></span><span style="left:80%;bottom:54%;"></span><span
                                style="left:96%;bottom:44%;"></span>
                        </div>
                        <div class="chart-line line-info">
                            <span style="left:0%;bottom:66%;"></span><span style="left:16%;bottom:57%;"></span><span
                                style="left:32%;bottom:53%;"></span><span style="left:48%;bottom:68%;"></span><span
                                style="left:64%;bottom:63%;"></span><span style="left:80%;bottom:50%;"></span><span
                                style="left:96%;bottom:72%;"></span>
                        </div>
                        <div class="chart-months">
                            <span>Yan</span><span>Mar</span><span>May</span><span>Iyn</span><span>Avq</span><span>Sen</span><span>Okt</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row g-4 align-items-start">
            <div class="col-xl-3 col-lg-4" data-aos="fade-right" data-aos-delay="80">
                <div class="student-sidebar-card">
                    <div class="student-card-head">
                        <h5 class="mb-1">Status</h5>
                        <span class="student-card-note">Umumi gosterici</span>
                    </div>
                    <div class="student-sidebar-list">
                        <div class="student-sidebar-item"><span class="sidebar-bullet bullet-blue"></span><span>Davam edir</span><strong><%= activeStudents %>
                        </strong></div>
                        <div class="student-sidebar-item"><span
                                class="sidebar-bullet bullet-green"></span><span>Mezun</span><strong><%= graduatedStudents %>
                        </strong></div>
                        <div class="student-sidebar-item"><span class="sidebar-bullet bullet-slate"></span><span>Qeyri-aktiv</span><strong><%= passiveStudents %>
                        </strong></div>
                    </div>
                    <div class="student-card-head mt-4">
                        <h5 class="mb-1">Ixtisas</h5>
                        <span class="student-card-note">Movcud qruplar</span>
                    </div>
                    <div class="student-sidebar-list">
                        <div class="student-sidebar-item"><span class="sidebar-bullet bullet-blue"></span><span>Java Proqramlasdirma</span><strong><%= javaStudents %>
                        </strong></div>
                        <div class="student-sidebar-item"><span class="sidebar-bullet bullet-cyan"></span><span>Data Analitikasi</span><strong><%= analyticsStudents %>
                        </strong></div>
                        <div class="student-sidebar-item"><span class="sidebar-bullet bullet-indigo"></span><span>UI/UX Dizayn</span><strong><%= designStudents %>
                        </strong></div>
                    </div>
                </div>
            </div>

            <div class="col-xl-9 col-lg-8" data-aos="fade-up" data-aos-delay="100">
                <div class="card custom-table-card border-0 student-list-card" id="studentTableCard">
                    <div class="card-header border-0 bg-transparent p-0">
                        <div class="student-table-topbar">
                            <div class="student-table-title">
                                <h5 class="fw-bold mb-0 text-dark d-flex align-items-center gap-2">
                                    <i class="bi bi-table text-primary"></i> Telebe Siyahisi
                                    <span class="badge bg-primary-subtle text-primary ms-1 rounded-pill"
                                          style="font-size:0.75rem;"><%= totalAllStudents %> nefer</span>
                                </h5>
                            </div>
                            <div class="student-table-actions">
                                <div class="d-flex gap-2 flex-wrap justify-content-lg-end">
                                    <form action="students.jsp" method="get" class="d-flex gap-2 flex-grow-1">
                                        <div class="input-group search-group flex-grow-1 student-search-box">
                                            <span class="input-group-text bg-white border-end-0 rounded-start-pill ps-3"><i
                                                    class="bi bi-search text-muted"></i></span>
                                            <input type="text" name="search" value="<%= search != null ? search : "" %>"
                                                   class="form-control border-start-0 border-end-0 py-2"
                                                   placeholder="Ad ve ya soyad ile axtar...">
                                            <button type="submit" class="btn btn-primary rounded-end-pill px-4">Axtar
                                            </button>
                                        </div>
                                        <% if (search != null && !search.trim().isEmpty()) { %>
                                        <a href="students.jsp" class="btn btn-outline-secondary rounded-pill px-3"
                                           title="Sifirla"><i class="bi bi-x-lg"></i></a>
                                        <% } %>
                                    </form>
                                    <button class="btn btn-primary btn-add-new px-4 py-2 shadow-sm"
                                            data-bs-toggle="modal" data-bs-target="#addStudentModal"><i
                                            class="bi bi-person-plus-fill me-2"></i>Yeni Telebe
                                    </button>
                                    <div class="table-toolbar d-none d-md-flex">
                                        <button class="btn-toolbar-action" title="Export"
                                                onclick="openExportModal('studentTable','Telebe Siyahisi','telebeler',<%= totalAllStudents %>, getStudentExportData())">
                                            <i class="bi bi-box-arrow-up text-primary"></i> Export
                                        </button>
                                        <button class="btn-toolbar-action"
                                                onclick="printTable('#studentTable','Telebe Siyahisi')" title="Cap et">
                                            <i class="bi bi-printer"></i></button>
                                    </div>
                                    <div class="table-toolbar d-flex d-md-none mt-2">
                                        <button class="btn-toolbar-action w-100" title="Export"
                                                onclick="openExportModal('studentTable','Telebe Siyahisi','telebeler',<%= totalAllStudents %>, getStudentExportData())">
                                            <i class="bi bi-box-arrow-up text-primary"></i> Export
                                        </button>
                                        <button class="btn-toolbar-action w-100"
                                                onclick="printTable('#studentTable','Telebe Siyahisi')" title="Cap et">
                                            <i class="bi bi-printer"></i></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="edu-smart-toolbar">
                        <div class="d-flex align-items-center gap-2 flex-wrap">
                            <span class="edu-toolbar-lbl">FILTR:</span>
                            <button class="edu-qf active" data-filter="all" onclick="studentFilter(this,'all')"><i
                                    class="bi bi-grid-3x3-gap-fill"></i> Hamisi <span class="edu-fc"
                                                                                      id="sfc-all"><%= totalStudents %></span>
                            </button>
                            <button class="edu-qf" data-filter="active" onclick="studentFilter(this,'active')"><i
                                    class="bi bi-circle-fill"
                                    style="color:#10b981;font-size:7px;vertical-align:middle;"></i> Aktiv <span
                                    class="edu-fc" id="sfc-active">-</span></button>
                            <button class="edu-qf" data-filter="graduated" onclick="studentFilter(this,'graduated')"><i
                                    class="bi bi-mortarboard"></i> Mezun <span class="edu-fc" id="sfc-grad">-</span>
                            </button>
                            <button class="edu-qf" data-filter="paused" onclick="studentFilter(this,'paused')"><i
                                    class="bi bi-pause-circle"></i> Fasile <span class="edu-fc" id="sfc-pause">-</span>
                            </button>
                        </div>
                        <div class="d-flex align-items-center gap-2">
                            <div class="dropdown">
                                <button class="edu-tool-btn" data-bs-toggle="dropdown" title="Sutunlari idare et"><i
                                        class="bi bi-layout-three-columns"></i></button>
                                <ul class="dropdown-menu dropdown-menu-end shadow border-0 rounded-3 p-2"
                                    style="min-width:200px">
                                    <li><h6 class="dropdown-header small fw-bold text-muted">SUTUNLAR</h6></li>
                                    <li><label class="dropdown-item edu-col-lbl"><input type="checkbox"
                                                                                        class="form-check-input m-0 edu-col-chk"
                                                                                        data-colidx="0"
                                                                                        data-export-index="0"
                                                                                        data-label="ID" checked>
                                        ID</label></li>
                                    <li><label class="dropdown-item edu-col-lbl"><input type="checkbox"
                                                                                        class="form-check-input m-0 edu-col-chk"
                                                                                        data-colidx="1"
                                                                                        data-export-index="1"
                                                                                        data-label="Telebe" checked>
                                        Telebe</label></li>
                                    <li><label class="dropdown-item edu-col-lbl"><input type="checkbox"
                                                                                        class="form-check-input m-0 edu-col-chk"
                                                                                        data-colidx="2"
                                                                                        data-export-index="2"
                                                                                        data-label="Email">
                                        Email</label></li>
                                    <li><label class="dropdown-item edu-col-lbl"><input type="checkbox"
                                                                                        class="form-check-input m-0 edu-col-chk"
                                                                                        data-colidx="3"
                                                                                        data-export-index="3"
                                                                                        data-label="Yas" checked>
                                        Yas</label></li>
                                    <li><label class="dropdown-item edu-col-lbl"><input type="checkbox"
                                                                                        class="form-check-input m-0 edu-col-chk"
                                                                                        data-colidx="4"
                                                                                        data-export-index="4"
                                                                                        data-label="Ixtisas" checked>
                                        Ixtisas</label></li>
                                    <li><label class="dropdown-item edu-col-lbl"><input type="checkbox"
                                                                                        class="form-check-input m-0 edu-col-chk"
                                                                                        data-colidx="5"
                                                                                        data-export-index="5"
                                                                                        data-label="Status" checked>
                                        Status</label></li>
                                </ul>
                            </div>
                            <div class="dropdown">
                                <button class="edu-tool-btn" data-bs-toggle="dropdown" title="Sira sixligi"><i
                                        class="bi bi-distribute-vertical"></i></button>
                                <ul class="dropdown-menu dropdown-menu-end shadow border-0 rounded-3 p-2">
                                    <li><h6 class="dropdown-header small fw-bold text-muted">SIXLIQ</h6></li>
                                    <li>
                                        <button class="dropdown-item rounded-2 py-2" onclick="stuDensity('compact')"><i
                                                class="bi bi-list me-2"></i>Kompakt
                                        </button>
                                    </li>
                                    <li>
                                        <button class="dropdown-item rounded-2 py-2 fw-semibold"
                                                onclick="stuDensity('normal')"><i class="bi bi-view-list me-2"></i>Normal
                                        </button>
                                    </li>
                                    <li>
                                        <button class="dropdown-item rounded-2 py-2"
                                                onclick="stuDensity('comfortable')"><i class="bi bi-card-list me-2"></i>Genis
                                        </button>
                                    </li>
                                </ul>
                            </div>
                            <button class="edu-tool-btn" id="stuFsBtn" onclick="stuFullscreen()" title="Tam ekran"><i
                                    class="bi bi-fullscreen" id="stuFsIcon"></i></button>
                            <button class="edu-tool-btn" data-bs-toggle="popover" data-bs-placement="left"
                                    data-bs-trigger="click" data-bs-html="true"
                                    data-bs-content="<div style='font-size:12px'><div class='d-flex justify-content-between gap-3 mb-2'><kbd>Alt+N</kbd><span class='text-muted'>Yeni telebe</span></div><div class='d-flex justify-content-between gap-3'><kbd>Esc</kbd><span class='text-muted'>Modali bagla</span></div></div>"
                                    title="Qisayollar"><i class="bi bi-keyboard"></i></button>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <table class="student-table table table-hover align-middle mb-0 responsive-table sortable-table"
                               id="studentTable">
                            <thead>
                            <tr>
                                <th class="ps-4 col-id" data-sort>ID</th>
                                <th class="col-student" data-sort>Telebe</th>
                                <th class="text-center col-email" style="display:none;">Email</th>
                                <th class="text-center col-age" data-sort>Yas</th>
                                <th class="text-center col-subject">Ixtisas</th>
                                <th class="text-center col-status">Status</th>
                                <th class="text-center col-actions">Emeliyyat</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%
                                if (students.isEmpty()) {
                            %>
                            <tr>
                                <td colspan="7" class="text-center py-5">
                                    <div class="empty-state">
                                        <i class="bi bi-person-x display-4 text-muted d-block mb-3"></i>
                                        <p class="text-muted mb-0">
                                            <% if (search != null && !search.trim().isEmpty()) { %>
                                            "<strong><%= search %>
                                        </strong>" uzre netice tapilmadi.
                                            <% } else { %>
                                            Hele hec bir telebe elave edilmeyib.
                                            <% } %>
                                        </p>
                                    </div>
                                </td>
                            </tr>
                            <%
                            } else {
                                for (Student student : students) {
                                    String initials = student.getName().substring(0, 1).toUpperCase() + student.getSurname().substring(0, 1).toUpperCase();
                            %>
                            <tr class="stagger-item row-clickable" data-sid="<%= student.getId() %>" data-export-email="<%= student.getEmail() %>" data-status="active">
                                <td class="ps-4"><span class="id-badge"><%= student.getId() %></span></td>
                                <td data-export="<%= student.getName() %> <%= student.getSurname() %>">
                                    <div class="d-flex align-items-center gap-3">
                                        <div class="avatar-circle bg-primary text-white flex-shrink-0"><%= initials %>
                                        </div>
                                        <div>
                                            <div class="fw-semibold text-dark lh-sm"><%= student.getName() %> <%= student.getSurname() %>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td class="text-center col-email" style="display:none;"
                                    data-export="<%= student.getEmail() %>"><span
                                        class="text-muted small"><%= student.getEmail() %></span></td>
                                <td class="text-center"><span class="age-badge"><%= student.getAge() %></span></td>
                                <td class="text-center"><span class="badge rounded-pill px-3 py-2 subject-badge"><i
                                        class="bi bi-code-slash me-1"></i>Java Proqramlasdirma</span></td>
                                <td class="text-center"><span
                                        class="badge badge-soft-success rounded-pill px-3 py-2 student-status-badge"><i
                                        class="bi bi-circle-fill me-1" style="font-size:6px;"></i>Davam edir</span></td>
                                <td class="text-center">
                                    <div class="d-flex justify-content-center gap-2">
                                        <button class="btn btn-action btn-view shadow-sm" title="Statusu deaktiv et"><i
                                                class="bi bi-eye"></i></button>
                                        <button class="btn btn-action btn-edit shadow-sm" title="Redakte et"
                                                data-bs-toggle="modal" data-bs-target="#editStudentModal"
                                                data-id="<%= student.getId() %>" data-name="<%= student.getName() %>"
                                                data-surname="<%= student.getSurname() %>"
                                                data-age="<%= student.getAge() %>"
                                                data-email="<%= student.getEmail() %>"><i
                                                class="bi bi-pencil-square"></i></button>
                                        <button class="btn btn-action btn-delete shadow-sm" title="Sil"
                                                data-bs-toggle="modal" data-bs-target="#deleteStudentModal"
                                                data-id="<%= student.getId() %>"
                                                data-name="<%= student.getName() %> <%= student.getSurname() %>"><i
                                                class="bi bi-trash3"></i></button>
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

                    <div class="card-footer bg-white border-0 px-4 py-3">
                        <nav aria-label="Telebe sehifelemesi">
                            <ul class="pagination pagination-sm justify-content-center mb-0" id="pagination-student">
                                <li class="page-item"><a class="page-link rounded-circle me-1 border-0 bg-light"
                                                         href="#" id="prev-student"><i
                                        class="bi bi-chevron-left"></i></a></li>
                                <li class="page-item"><a class="page-link rounded-circle border-0 bg-light" href="#"
                                                         id="next-student"><i class="bi bi-chevron-right"></i></a></li>
                            </ul>
                        </nav>
                    </div>

                    <div class="edu-status-bar">
                        <div class="d-flex align-items-center gap-3">
                            <span class="edu-sb-item"><i class="bi bi-table text-primary me-1"></i><span
                                    id="stu-visible-count"><%= totalStudents %></span> setir</span>
                            <span class="edu-sb-sep">|</span>
                            <span class="edu-sb-item"><i class="bi bi-funnel text-muted me-1"></i><span
                                    id="stu-filter-label">Filtr yoxdur</span></span>
                        </div>
                        <div class="d-flex align-items-center gap-2">
                            <span class="edu-sb-item text-muted"><i class="bi bi-clock me-1"></i><span
                                    id="stu-load-time"></span></span>
                            <span class="edu-live-wrap"><span class="edu-live-dot"></span><span class="edu-sb-item"
                                                                                                style="font-size:11px">Canli</span></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<div class="modal fade" id="addStudentModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-4">
            <div class="modal-header border-0 px-4 pt-4 pb-2">
                <div class="d-flex align-items-center gap-2">
                    <div class="modal-icon-box bg-primary text-white"><i class="bi bi-person-plus-fill"></i></div>
                    <h5 class="modal-title fw-bold mb-0">Yeni Telebe Elave Et</h5>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body px-4 pb-4">
                <form action="student" method="POST">
                    <input type="hidden" name="action" value="create">
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-muted">Ad</label>
                        <input type="text" name="name" class="form-control rounded-3 px-3" placeholder="Mes: Sukur"
                               required>
                        <div class="invalid-feedback"></div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-muted">Soyad</label>
                        <input type="text" name="surname" class="form-control rounded-3 px-3" placeholder="Mes: Agayev"
                               required>
                        <div class="invalid-feedback"></div>
                    </div>
                    <div class="row g-3 mb-3">
                        <div class="col-6">
                            <label class="form-label small fw-semibold text-muted">Yas</label>
                            <input type="number" name="age" class="form-control rounded-3 px-3" placeholder="Mes: 22"
                                   min="14" max="80" required>
                            <div class="invalid-feedback"></div>
                        </div>
                        <div class="col-6">
                            <label class="form-label small fw-semibold text-muted">Email</label>
                            <input type="email" name="email" class="form-control rounded-3 px-3"
                                   placeholder="sukur@email.com" required>
                            <div class="invalid-feedback"></div>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary w-100 rounded-3 py-2 mt-2 fw-semibold"><i
                            class="bi bi-check2-circle me-2"></i>Yadda Saxla
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="editStudentModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-4">
            <div class="modal-header border-0 px-4 pt-4 pb-2">
                <div class="d-flex align-items-center gap-2">
                    <div class="modal-icon-box bg-warning text-white"><i class="bi bi-pencil-square"></i></div>
                    <h5 class="modal-title fw-bold mb-0">Telebeni Redakte Et</h5>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body px-4 pb-4">
                <form action="student" method="POST">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" id="edit-student-id-hidden">
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-muted">ID (deyisdirilmir)</label>
                        <input type="text" id="edit-student-id-display"
                               class="form-control rounded-3 px-3 bg-light text-muted" disabled>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-muted">Ad</label>
                        <input type="text" name="name" id="edit-student-name" class="form-control rounded-3 px-3"
                               required>
                        <div class="invalid-feedback"></div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-muted">Soyad</label>
                        <input type="text" name="surname" id="edit-student-surname" class="form-control rounded-3 px-3"
                               required>
                        <div class="invalid-feedback"></div>
                    </div>
                    <div class="row g-3 mb-3">
                        <div class="col-6">
                            <label class="form-label small fw-semibold text-muted">Yas</label>
                            <input type="number" name="age" id="edit-student-age" class="form-control rounded-3 px-3"
                                   min="14" max="80" required>
                            <div class="invalid-feedback"></div>
                        </div>
                        <div class="col-6">
                            <label class="form-label small fw-semibold text-muted">Email</label>
                            <input type="email" name="email" id="edit-student-email" class="form-control rounded-3 px-3"
                                   required>
                            <div class="invalid-feedback"></div>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-warning w-100 rounded-3 py-2 mt-2 fw-semibold text-white"><i
                            class="bi bi-arrow-repeat me-2"></i>Yenile
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="deleteStudentModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-sm">
        <div class="modal-content border-0 shadow-lg rounded-4">
            <div class="modal-body p-4 text-center">
                <div class="delete-icon-wrap mb-3"><i class="bi bi-trash3-fill text-danger"></i></div>
                <h5 class="fw-bold mb-2">Telebeni Sil</h5>
                <p class="text-muted mb-4"><span class="fw-semibold text-dark" id="delete-student-name"></span> adli
                    telebeni silmek istediyinize eminsiniz?</p>
                <form action="student" method="POST">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" id="delete-student-id">
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-light w-100 rounded-3 py-2" data-bs-dismiss="modal">Legv
                            Et
                        </button>
                        <button type="submit" class="btn btn-danger w-100 rounded-3 py-2 fw-semibold"><i
                                class="bi bi-trash3 me-1"></i>Sil
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
<jsp:include page="export-modal.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script src="https://cdn.jsdelivr.net/npm/exceljs@4.3.0/dist/exceljs.min.js"></script>
<script src="js/cfb.min.js?v=4.3"></script>
<script src="js/xlsx-style.min.js?v=4.3"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.8.2/jspdf.plugin.autotable.min.js"></script>
<script src="js/script.js?v=4.3"></script>
<script src="js/excel-export.js?v=4.3"></script>
<script>
    AOS.init({duration: 800, once: true, offset: 80});
    setupPagination('#studentTable', 'pagination-student', 10);
</script>
<script>
    document.getElementById('stu-load-time').textContent =
        new Date().toLocaleTimeString('az-AZ', {hour: '2-digit', minute: '2-digit', second: '2-digit'});

    (function initStudentCounts() {
        refreshStudentCounts();
    })();

    var _stuAllRows = null;

    function studentFilter(btn, type) {
        document.querySelectorAll('.edu-qf').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        const tbody = document.querySelector('#studentTable tbody');
        if (!_stuAllRows) _stuAllRows = Array.from(tbody.querySelectorAll('tr.stagger-item'));
        _stuAllRows.forEach(r => {
            if (!tbody.contains(r)) tbody.appendChild(r);
        });
        if (type !== 'all') {
            _stuAllRows.forEach(r => {
                const show =
                    (type === 'active' && r.dataset.status === 'active') ||
                    (type === 'graduated' && r.dataset.status === 'graduated') ||
                    (type === 'paused' && r.dataset.status === 'paused');
                if (!show && tbody.contains(r)) tbody.removeChild(r);
            });
        }
        setupPagination('#studentTable', 'pagination-student', 10);
        updateStudentVisibleCount();
        const lblMap = {
            all: 'Filtr yoxdur',
            active: 'Aktiv telebeler',
            graduated: 'Mezunlar',
            paused: 'Fasiledeki telebeler'
        };
        document.getElementById('stu-filter-label').textContent = lblMap[type];
    }

    function getStudentExportData() {
        return {
            headers: ['ID', 'Tələbə', 'Email', 'Yaş', 'İxtisas', 'Status'],
            dataRows: [
                    <% for (int i = 0; i < allStudents.size(); i++) {
                        Student exportStudent = allStudents.get(i);
                    %>[
                    "<%= exportStudent.getId() %>",
                    "<%= escJs(exportStudent.getName() + " " + exportStudent.getSurname()) %>",
                    "<%= escJs(exportStudent.getEmail()) %>",
                    "<%= exportStudent.getAge() %>",
                    "Java Proqramlasdirma",
                    "Aktiv"
                ]<%= i < allStudents.size() - 1 ? "," : "" %>
                <% } %>
            ]
        };
    }


    function refreshStudentCounts() {
        const rows = _stuAllRows || Array.from(document.querySelectorAll('#studentTable tbody tr.stagger-item'));
        let active = 0, grad = 0, paused = 0;
        rows.forEach(r => {
            if (r.dataset.status === 'graduated') grad++;
            else if (r.dataset.status === 'paused') paused++;
            else active++;
        });
        document.getElementById('sfc-all').textContent = rows.length;
        document.getElementById('sfc-active').textContent = active;
        document.getElementById('sfc-grad').textContent = grad;
        document.getElementById('sfc-pause').textContent = paused;
    }

    function updateStudentVisibleCount() {
        const visibleRows = document.querySelectorAll('#studentTable tbody tr.stagger-item:not([style*="display: none"]):not(.d-none)').length;
        document.getElementById('stu-visible-count').textContent = visibleRows;
    }

    document.querySelectorAll('.edu-col-chk').forEach(chk => {
        chk.addEventListener('change', function () {
            const idx = parseInt(this.dataset.colidx, 10);
            document.querySelectorAll('#studentTable tr').forEach(row => {
                const cell = row.children[idx];
                if (cell) cell.style.display = this.checked ? '' : 'none';
            });
        });
    });

    function stuDensity(mode) {
        const t = document.getElementById('studentTable');
        t.classList.remove('edu-compact', 'edu-normal', 'edu-comfortable');
        t.classList.add('edu-' + mode);
    }

    function stuFullscreen() {
        const card = document.getElementById('studentTableCard');
        const icon = document.getElementById('stuFsIcon');
        const btn  = document.getElementById('stuFsBtn');

        if (!card.classList.contains('edu-tbl-fullscreen')) {
            /* ── Fullscreen girişi ──
               AOS-un parent-də saxladığı transform: translate3d(0,0,0)
               position:fixed-i viewport-a deyil parent-ə bağlayır.
               Bunu aradan qaldırmaq üçün kartı birbaşa <body>-ə köçürürük. */
            card._origParent  = card.parentElement;
            card._origNextSib = card.nextSibling || null;
            document.body.appendChild(card);
            card.classList.add('edu-tbl-fullscreen');
            icon.className = 'bi bi-fullscreen-exit';
            btn.classList.add('fs-active');
            document.body.style.overflow = 'hidden';
            document.body.classList.add('has-fullscreen');
        } else {
            /* ── Fullscreen çıxışı ── */
            card.classList.remove('edu-tbl-fullscreen');
            if (card._origParent) {
                card._origParent.insertBefore(card, card._origNextSib);
            }
            icon.className = 'bi bi-fullscreen';
            btn.classList.remove('fs-active');
            document.body.style.overflow = '';
            document.body.classList.remove('has-fullscreen');
        }
    }

    /* ─── Esc → fullscreen bağla ─── */
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            const card = document.getElementById('studentTableCard');
            if (card && card.classList.contains('edu-tbl-fullscreen')) {
                stuFullscreen();
            }
        }
    });

    document.querySelectorAll('#studentTable .btn-edit, #studentTable .btn-delete').forEach(btn => {
        btn.dataset.modalToggle = btn.getAttribute('data-bs-toggle') || '';
        btn.dataset.modalTarget = btn.getAttribute('data-bs-target') || '';
    });

    document.getElementById('studentTable').addEventListener('click', function (event) {
        const viewBtn = event.target.closest('.btn-view');
        if (!viewBtn) return;

        event.preventDefault();
        const row = viewBtn.closest('tr.stagger-item');
        if (!row) return;

        const shouldPause = row.dataset.status !== 'paused';
        const statusBadge = row.querySelector('.student-status-badge');
        const icon = viewBtn.querySelector('i');

        row.classList.toggle('row-passive', shouldPause);
        row.dataset.status = shouldPause ? 'paused' : 'active';

        if (statusBadge) {
            statusBadge.className = shouldPause
                ? 'badge badge-soft-danger rounded-pill px-3 py-2 student-status-badge'
                : 'badge badge-soft-success rounded-pill px-3 py-2 student-status-badge';
            statusBadge.innerHTML = shouldPause
                ? '<i class="bi bi-pause-circle-fill me-1"></i>Deaktiv'
                : '<i class="bi bi-circle-fill me-1" style="font-size:6px;"></i>Davam edir';
        }

        if (icon) icon.className = shouldPause ? 'bi bi-eye-slash' : 'bi bi-eye';
        viewBtn.classList.toggle('btn-view-passive', shouldPause);
        viewBtn.setAttribute('title', shouldPause ? 'Telebeni aktiv et' : 'Statusu deaktiv et');

        row.querySelectorAll('.btn-edit, .btn-delete').forEach(btn => {
            btn.disabled = shouldPause;
            btn.classList.toggle('disabled', shouldPause);
            btn.setAttribute('aria-disabled', shouldPause ? 'true' : 'false');
            if (shouldPause) {
                btn.removeAttribute('data-bs-toggle');
                btn.removeAttribute('data-bs-target');
            } else {

                if (btn.dataset.modalToggle) btn.setAttribute('data-bs-toggle', 'modal');
                if (btn.dataset.modalTarget) btn.setAttribute('data-bs-target', btn.dataset.modalTarget);
            }
        });
    });
</script>

<script>
/* ── Tələbə sətrinə klik → student-page.jsp ── */
(function initRowClick() {
    document.addEventListener('DOMContentLoaded', function () {
        document.querySelectorAll('#studentTable tbody tr.row-clickable').forEach(function (row) {
            row.style.cursor = 'pointer';
            row.addEventListener('click', function (e) {
                // Əgər klik düyməyə, checkboxa və ya modal trigger-ə aiddisə — keç
                if (e.target.closest('.btn-action, .btn-edit, .btn-delete, .btn-view, button, input, a')) return;
                var sid = row.dataset.sid;
                if (sid) window.location.href = 'student-page.jsp?id=' + sid;
            });
        });
    });
})();
</script>

<jsp:include page="footer.jsp"/>
</body>
</html>
