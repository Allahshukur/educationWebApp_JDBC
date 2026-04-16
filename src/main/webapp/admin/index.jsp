<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sukur.educationwebapp.student.service.StudentService" %>
<%@ page import="com.sukur.educationwebapp.student.entity.Student" %>
<%@ page import="com.sukur.educationwebapp.teacher.service.TeacherService" %>
<%@ page import="com.sukur.educationwebapp.teacher.entity.Teacher" %>
<%@ page import="java.util.List" %>
<%
    StudentService ss = new StudentService();
    TeacherService ts = new TeacherService();
    List<Student> students = ss.findAll();
    List<Teacher> teachers = ts.findAll();
    int totalStudents = students != null ? students.size() : 0;
    int totalTeachers = teachers != null ? teachers.size() : 0;
    int totalCourses  = 10;
    int totalRevenue  = totalStudents * 120;
%>
<!DOCTYPE html>
<html lang="az">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard — Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="css/admin.css" rel="stylesheet">
</head>
<body class="adm-body">

<jsp:include page="admin-sidebar.jsp"/>

<div class="adm-main" id="admMain">

    <!-- TOPBAR -->
    <header class="adm-topbar">
        <div class="adm-topbar-left">
            <button class="adm-hamburger" id="admSidebarToggle"><i class="bi bi-list"></i></button>
            <div class="adm-breadcrumb">
                <span class="adm-breadcrumb-home"><i class="bi bi-house-fill"></i></span>
                <i class="bi bi-chevron-right adm-text-muted" style="font-size:.6rem;"></i>
                <span class="adm-breadcrumb-cur">Dashboard</span>
            </div>
        </div>
        <div class="adm-topbar-right">
            <div class="adm-search-wrap">
                <i class="bi bi-search"></i>
                <input id="admSearchInput" type="text" placeholder="Axtar... (Ctrl+K)">
            </div>
            <button class="adm-icon-btn" data-adm-dark-toggle title="Dark/Light Mode">
                <i class="bi bi-moon-stars-fill"></i>
            </button>
            <div class="adm-icon-btn position-relative" title="Bildirişlər">
                <i class="bi bi-bell-fill"></i>
                <span class="adm-notif-badge">3</span>
            </div>
            <div class="adm-top-avatar" title="Admin"><i class="bi bi-person-fill"></i></div>
        </div>
    </header>

    <!-- CONTENT -->
    <div class="adm-content">

        <!-- Page Header -->
        <div class="adm-page-header">
            <div>
                <h1 class="adm-page-title"><i class="bi bi-speedometer2 me-2 adm-text-accent"></i>Dashboard</h1>
                <p class="adm-page-sub">Sistemin ümumi statistikası — real vaxt məlumatları</p>
            </div>
            <div class="d-flex gap-2 flex-wrap">
                <button class="adm-btn adm-btn-outline" onclick="location.reload()">
                    <i class="bi bi-arrow-clockwise"></i> Yenilə
                </button>
                <a href="reports.jsp" class="adm-btn adm-btn-primary">
                    <i class="bi bi-bar-chart-fill"></i> Hesabatlar
                </a>
            </div>
        </div>

        <!-- STAT CARDS -->
        <div class="row g-3 mb-4">
            <div class="col-sm-6 col-xl-3">
                <div class="adm-stat adm-stat-blue">
                    <div class="adm-stat-icon"><i class="bi bi-people-fill"></i></div>
                    <div>
                        <div class="adm-stat-val" data-counter="<%= totalStudents %>">0</div>
                        <div class="adm-stat-label">Cəmi Tələbə</div>
                        <div class="adm-stat-trend up"><i class="bi bi-arrow-up-right"></i> +12% bu ay</div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-xl-3">
                <div class="adm-stat adm-stat-violet">
                    <div class="adm-stat-icon"><i class="bi bi-person-workspace"></i></div>
                    <div>
                        <div class="adm-stat-val" data-counter="<%= totalTeachers %>">0</div>
                        <div class="adm-stat-label">Cəmi Müəllim</div>
                        <div class="adm-stat-trend up"><i class="bi bi-arrow-up-right"></i> +2 yeni</div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-xl-3">
                <div class="adm-stat adm-stat-teal">
                    <div class="adm-stat-icon"><i class="bi bi-journal-bookmark-fill"></i></div>
                    <div>
                        <div class="adm-stat-val" data-counter="<%= totalCourses %>">0</div>
                        <div class="adm-stat-label">Aktiv Kurs</div>
                        <div class="adm-stat-trend up"><i class="bi bi-arrow-up-right"></i> +1 bu ay</div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-xl-3">
                <div class="adm-stat adm-stat-amber">
                    <div class="adm-stat-icon"><i class="bi bi-cash-stack"></i></div>
                    <div>
                        <div class="adm-stat-val" data-counter="<%= totalRevenue %>">0</div>
                        <div class="adm-stat-label">Gəlir (AZN)</div>
                        <div class="adm-stat-trend up"><i class="bi bi-arrow-up-right"></i> +8.5%</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- CHARTS -->
        <div class="row g-3 mb-4">
            <div class="col-lg-8">
                <div class="adm-card">
                    <div class="adm-card-header">
                        <span class="adm-card-title"><i class="bi bi-bar-chart-fill"></i>Aylıq Qeydiyyat</span>
                        <span class="adm-badge adm-badge-blue ms-auto">2025</span>
                    </div>
                    <div class="adm-card-body" style="height:270px;">
                        <canvas id="chartBar"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="adm-card">
                    <div class="adm-card-header">
                        <span class="adm-card-title"><i class="bi bi-pie-chart-fill"></i>Kurs Bölgüsü</span>
                    </div>
                    <div class="adm-card-body" style="height:270px;">
                        <canvas id="chartDonut"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- STUDENTS TABLE + QUICK LINKS -->
        <div class="row g-3 mb-4">
            <div class="col-lg-8">
                <div class="adm-card">
                    <div class="adm-card-header">
                        <span class="adm-card-title"><i class="bi bi-people-fill"></i>Son Tələbələr</span>
                        <a href="students.jsp" class="adm-btn adm-btn-sm adm-btn-outline ms-auto">Hamısını gör</a>
                    </div>
                    <div class="adm-table-wrap">
                        <table class="adm-table">
                            <thead><tr>
                                <th>#</th><th data-sort>Ad Soyad</th>
                                <th data-sort>Email</th><th data-sort>Yaş</th><th>Status</th><th></th>
                            </tr></thead>
                            <tbody>
                            <%
                                int lim = Math.min(7, totalStudents);
                                for (int i = 0; i < lim; i++) {
                                    Student s = students.get(i);
                                    boolean del = s.getDeleted() != null && s.getDeleted();
                                    String ini = (s.getName() != null && !s.getName().isEmpty()) ? String.valueOf(s.getName().charAt(0)) : "?";
                            %>
                            <tr>
                                <td class="adm-text-muted fw-600"><%= s.getId() %></td>
                                <td>
                                    <div class="d-flex align-items-center gap-2">
                                        <div class="adm-mini-avatar"><%= ini %></div>
                                        <span class="fw-700"><%= s.getName() %> <%= s.getSurname() %></span>
                                    </div>
                                </td>
                                <td class="adm-text-muted" style="font-size:.8rem;"><%= s.getEmail() != null ? s.getEmail() : "—" %></td>
                                <td class="fw-600"><%= s.getAge() %></td>
                                <td>
                                    <% if (del) { %><span class="adm-badge adm-badge-red">Silindi</span>
                                    <% } else { %><span class="adm-badge adm-badge-green">Aktiv</span><% } %>
                                </td>
                                <td>
                                    <a href="students.jsp" class="adm-act-btn adm-act-view" title="Bax">
                                        <i class="bi bi-eye-fill"></i>
                                    </a>
                                </td>
                            </tr>
                            <% } %>
                            <% if (totalStudents == 0) { %>
                            <tr><td colspan="6" class="text-center adm-text-muted py-4">
                                <i class="bi bi-inbox display-6 d-block mb-2 opacity-25"></i>Tələbə tapılmadı
                            </td></tr>
                            <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- QUICK LINKS -->
            <div class="col-lg-4">
                <div class="adm-card h-100">
                    <div class="adm-card-header">
                        <span class="adm-card-title"><i class="bi bi-lightning-fill"></i>Sürətli Keçid</span>
                    </div>
                    <div class="adm-card-body d-flex flex-column gap-2 p-3">
                        <a href="students.jsp" class="adm-quick-link">
                            <div class="adm-quick-icon" style="background:rgba(59,130,246,.12);color:#3b82f6;"><i class="bi bi-person-plus-fill"></i></div>
                            <div><div class="adm-quick-label">Tələbələr</div><div class="adm-quick-sub">İdarə et, düzəlt</div></div>
                            <i class="bi bi-chevron-right ms-auto adm-text-muted" style="font-size:.75rem;"></i>
                        </a>
                        <a href="teachers.jsp" class="adm-quick-link">
                            <div class="adm-quick-icon" style="background:rgba(124,58,237,.12);color:#7c3aed;"><i class="bi bi-person-workspace"></i></div>
                            <div><div class="adm-quick-label">Müəllimlər</div><div class="adm-quick-sub">Əlavə et, sil</div></div>
                            <i class="bi bi-chevron-right ms-auto adm-text-muted" style="font-size:.75rem;"></i>
                        </a>
                        <a href="courses.jsp" class="adm-quick-link">
                            <div class="adm-quick-icon" style="background:rgba(13,148,136,.12);color:#0d9488;"><i class="bi bi-journal-bookmark-fill"></i></div>
                            <div><div class="adm-quick-label">Kurslar</div><div class="adm-quick-sub">10 aktiv kurs</div></div>
                            <i class="bi bi-chevron-right ms-auto adm-text-muted" style="font-size:.75rem;"></i>
                        </a>
                        <a href="reports.jsp" class="adm-quick-link">
                            <div class="adm-quick-icon" style="background:rgba(245,158,11,.12);color:#f59e0b;"><i class="bi bi-file-earmark-bar-graph-fill"></i></div>
                            <div><div class="adm-quick-label">Hesabatlar</div><div class="adm-quick-sub">PDF / Excel çap</div></div>
                            <i class="bi bi-chevron-right ms-auto adm-text-muted" style="font-size:.75rem;"></i>
                        </a>
                        <a href="settings.jsp" class="adm-quick-link">
                            <div class="adm-quick-icon" style="background:rgba(100,116,139,.12);color:#64748b;"><i class="bi bi-gear-fill"></i></div>
                            <div><div class="adm-quick-label">Parametrlər</div><div class="adm-quick-sub">Sistem ayarları</div></div>
                            <i class="bi bi-chevron-right ms-auto adm-text-muted" style="font-size:.75rem;"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- PROGRESS -->
        <div class="row g-3">
            <div class="col-lg-6">
                <div class="adm-card">
                    <div class="adm-card-header">
                        <span class="adm-card-title"><i class="bi bi-graph-up"></i>Kurs Doluluk Faizi</span>
                    </div>
                    <div class="adm-card-body">
                        <% String[] pNames = {"Java Əsasları","Spring Framework","React.js","Python","Kibertəhlükəsizlik"};
                           int[]    pVals  = {80, 52, 95, 62, 35};
                           for (int i = 0; i < pNames.length; i++) { %>
                        <div class="adm-prog-label"><span><%= pNames[i] %></span><span class="fw-700"><%= pVals[i] %>%</span></div>
                        <div class="adm-prog-track"><div class="adm-prog-fill" data-width="<%= pVals[i] %>"></div></div>
                        <% } %>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="adm-card">
                    <div class="adm-card-header">
                        <span class="adm-card-title"><i class="bi bi-activity"></i>Son Fəaliyyətlər</span>
                    </div>
                    <div class="adm-card-body p-0">
                        <div style="padding:0 22px;">
                            <div class="adm-activity-item">
                                <div class="adm-activity-icon" style="background:rgba(59,130,246,.12);color:#3b82f6;"><i class="bi bi-person-plus-fill"></i></div>
                                <div><div class="adm-activity-title">Yeni tələbə qeydiyyatı</div><div class="adm-activity-time">5 dəqiqə əvvəl</div></div>
                            </div>
                            <div class="adm-activity-item">
                                <div class="adm-activity-icon" style="background:rgba(16,185,129,.12);color:#059669;"><i class="bi bi-journal-check"></i></div>
                                <div><div class="adm-activity-title">Java kursu yeniləndi</div><div class="adm-activity-time">1 saat əvvəl</div></div>
                            </div>
                            <div class="adm-activity-item">
                                <div class="adm-activity-icon" style="background:rgba(245,158,11,.12);color:#d97706;"><i class="bi bi-star-fill"></i></div>
                                <div><div class="adm-activity-title">Yeni qiymət əlavə edildi</div><div class="adm-activity-time">3 saat əvvəl</div></div>
                            </div>
                            <div class="adm-activity-item">
                                <div class="adm-activity-icon" style="background:rgba(124,58,237,.12);color:#7c3aed;"><i class="bi bi-person-workspace"></i></div>
                                <div><div class="adm-activity-title">Yeni müəllim əlavə edildi</div><div class="adm-activity-time">Dünən</div></div>
                            </div>
                            <div class="adm-activity-item">
                                <div class="adm-activity-icon" style="background:rgba(239,68,68,.12);color:#dc2626;"><i class="bi bi-trash3-fill"></i></div>
                                <div><div class="adm-activity-title">1 tələbə silindi</div><div class="adm-activity-time">Dünən</div></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div><!-- /adm-content -->
</div><!-- /adm-main -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<script src="js/admin.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function () {
    var accent  = '#4f46e5';
    var gridColor = 'rgba(0,0,0,0.05)';

    admChart.bar('chartBar',
        ['Yan','Fev','Mar','Apr','May','İyun','İyul','Avq','Sen','Okt','Noy','Dek'],
        [{
            label: 'Tələbə Qeydiyyatı',
            data: [12,19,15,28,22,35,30,42,38,25,20,18],
            backgroundColor: function(ctx) {
                var g = ctx.chart.ctx.createLinearGradient(0,0,0,260);
                g.addColorStop(0,'rgba(79,70,229,.80)');
                g.addColorStop(1,'rgba(79,70,229,.25)');
                return g;
            },
            borderRadius: 8, borderSkipped: false
        }],
        { plugins:{ legend:{display:false} }, scales:{
            y:{ beginAtZero:true, grid:{color:gridColor}, ticks:{font:{weight:'600'}} },
            x:{ grid:{display:false}, ticks:{font:{weight:'600'}} }
        }}
    );

    admChart.donut('chartDonut',
        ['Java','Web Dev','Python','DevOps','Data','Digər'],
        [30,25,20,10,8,7],
        ['#4f46e5','#0d9488','#f59e0b','#0ea5e9','#8b5cf6','#f43f5e']
    );
});
</script>
</body>
</html>
