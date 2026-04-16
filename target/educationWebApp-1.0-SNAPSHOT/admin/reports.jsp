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
    int totalSt = students != null ? students.size() : 0;
    int totalTe = teachers != null ? teachers.size() : 0;

    int active = 0, deleted = 0;
    if (students != null) {
        for (Student s : students) {
            if (s.getDeleted() != null && s.getDeleted()) deleted++;
            else active++;
        }
    }
%>
<!DOCTYPE html>
<html lang="az">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hesabatlar — Admin</title>
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
                <span class="adm-breadcrumb-cur">Hesabatlar</span>
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

        <div class="adm-page-header">
            <div>
                <h1 class="adm-page-title"><i class="bi bi-bar-chart-fill me-2 adm-text-accent"></i>Hesabatlar</h1>
                <p class="adm-page-sub">Platforma analitikası və statistik hesabatlar</p>
            </div>
            <div class="d-flex gap-2">
                <button class="adm-btn adm-btn-outline" onclick="window.print()">
                    <i class="bi bi-printer-fill"></i> Çap et
                </button>
                <button class="adm-btn adm-btn-primary" onclick="exportCSV()">
                    <i class="bi bi-file-earmark-spreadsheet-fill"></i> CSV Export
                </button>
            </div>
        </div>

        <!-- STATS -->
        <div class="row g-3 mb-4">
            <div class="col-sm-6 col-lg-3">
                <div class="adm-stat adm-stat-blue">
                    <div class="adm-stat-icon"><i class="bi bi-people-fill"></i></div>
                    <div>
                        <div class="adm-stat-val" data-counter="<%= totalSt %>">0</div>
                        <div class="adm-stat-label">Cəmi Tələbə</div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-lg-3">
                <div class="adm-stat adm-stat-green" style="--accent2:#059669;">
                    <div class="adm-stat-icon" style="background:rgba(16,185,129,.12);color:#059669;"><i class="bi bi-person-check-fill"></i></div>
                    <div>
                        <div class="adm-stat-val" data-counter="<%= active %>">0</div>
                        <div class="adm-stat-label">Aktiv Tələbə</div>
                        <div class="adm-stat-trend up"><i class="bi bi-check-circle-fill"></i> Aktiv</div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-lg-3">
                <div class="adm-stat adm-stat-violet">
                    <div class="adm-stat-icon"><i class="bi bi-person-workspace"></i></div>
                    <div>
                        <div class="adm-stat-val" data-counter="<%= totalTe %>">0</div>
                        <div class="adm-stat-label">Müəllim</div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-lg-3">
                <div class="adm-stat adm-stat-amber">
                    <div class="adm-stat-icon"><i class="bi bi-journal-bookmark-fill"></i></div>
                    <div>
                        <div class="adm-stat-val" data-counter="10">0</div>
                        <div class="adm-stat-label">Kurs</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- CHARTS -->
        <div class="row g-3 mb-4">
            <div class="col-lg-8">
                <div class="adm-card">
                    <div class="adm-card-header">
                        <span class="adm-card-title"><i class="bi bi-graph-up-arrow"></i>Aylıq Qeydiyyat Trendi</span>
                        <div class="d-flex gap-1 ms-auto">
                            <button class="adm-btn adm-btn-sm adm-btn-outline" onclick="changeYear(2024)">2024</button>
                            <button class="adm-btn adm-btn-sm adm-btn-primary" id="btnYear2025" onclick="changeYear(2025)">2025</button>
                        </div>
                    </div>
                    <div class="adm-card-body" style="height:280px;"><canvas id="chartLine"></canvas></div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="adm-card">
                    <div class="adm-card-header">
                        <span class="adm-card-title"><i class="bi bi-pie-chart-fill"></i>Tələbə Statusu</span>
                    </div>
                    <div class="adm-card-body" style="height:280px;"><canvas id="chartStatus"></canvas></div>
                </div>
            </div>
        </div>

        <div class="row g-3 mb-4">
            <div class="col-lg-6">
                <div class="adm-card">
                    <div class="adm-card-header">
                        <span class="adm-card-title"><i class="bi bi-bar-chart-fill"></i>Kurs Populyarlığı</span>
                    </div>
                    <div class="adm-card-body" style="height:260px;"><canvas id="chartCourses"></canvas></div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="adm-card">
                    <div class="adm-card-header">
                        <span class="adm-card-title"><i class="bi bi-person-workspace"></i>Müəllim Performansı</span>
                    </div>
                    <div class="adm-card-body" style="height:260px;"><canvas id="chartTeacher"></canvas></div>
                </div>
            </div>
        </div>

        <!-- DATA TABLE -->
        <div class="adm-card">
            <div class="adm-card-header">
                <span class="adm-card-title"><i class="bi bi-table"></i>Tələbə Hesabatı</span>
                <span class="adm-badge adm-badge-blue ms-auto"><%= totalSt %> qeyd</span>
            </div>
            <div class="adm-table-wrap">
                <table class="adm-table" id="tblReport">
                    <thead><tr>
                        <th data-sort>#</th>
                        <th data-sort>Ad Soyad</th>
                        <th data-sort>Email</th>
                        <th data-sort>Yaş</th>
                        <th>Müəllim</th>
                        <th>Status</th>
                    </tr></thead>
                    <tbody>
                    <% if (students != null) { for (Student s : students) {
                        boolean del = s.getDeleted() != null && s.getDeleted();
                        String ini = (s.getName() != null && !s.getName().isEmpty()) ? String.valueOf(s.getName().charAt(0)).toUpperCase() : "?";
                    %>
                    <tr>
                        <td class="adm-text-muted fw-600"><%= s.getId() %></td>
                        <td>
                            <div class="d-flex align-items-center gap-2">
                                <div class="adm-mini-avatar"><%= ini %></div>
                                <span class="fw-700"><%= s.getName() %> <%= s.getSurname() %></span>
                            </div>
                        </td>
                        <td class="adm-text-muted" style="font-size:.82rem;"><%= s.getEmail() != null ? s.getEmail() : "—" %></td>
                        <td class="fw-600"><%= s.getAge() %></td>
                        <td class="adm-text-muted" style="font-size:.82rem;"><%= s.getTeacher() != null ? s.getTeacher() : "—" %></td>
                        <td>
                            <% if (del) { %><span class="adm-badge adm-badge-red">Silindi</span>
                            <% } else { %><span class="adm-badge adm-badge-green">Aktiv</span><% } %>
                        </td>
                    </tr>
                    <% } } %>
                    </tbody>
                </table>
            </div>
            <div class="adm-pagination" id="pgReport"></div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<script src="js/admin.js"></script>
<script>
var lineChartInstance = null;
var months = ['Yan','Fev','Mar','Apr','May','İyun','İyul','Avq','Sen','Okt','Noy','Dek'];
var data2024 = [8,12,10,18,14,22,20,28,24,18,14,12];
var data2025 = [12,19,15,28,22,35,30,42,38,25,20,18];

function changeYear(yr) {
    var data = yr === 2024 ? data2024 : data2025;
    if (lineChartInstance) {
        lineChartInstance.data.datasets[0].data = data;
        lineChartInstance.data.datasets[0].label = yr + ' Qeydiyyat';
        lineChartInstance.update();
    }
}

document.addEventListener('DOMContentLoaded', function () {
    // Line Chart
    var ctx = document.getElementById('chartLine');
    if (ctx) {
        lineChartInstance = new Chart(ctx, {
            type: 'line',
            data: {
                labels: months,
                datasets: [{
                    label: '2025 Qeydiyyat',
                    data: data2025,
                    borderColor: '#4f46e5',
                    backgroundColor: 'rgba(79,70,229,.12)',
                    fill: true,
                    tension: 0.4,
                    pointBackgroundColor: '#4f46e5',
                    pointRadius: 5,
                    pointHoverRadius: 8,
                    borderWidth: 2.5
                }]
            },
            options: {
                responsive: true, maintainAspectRatio: false,
                plugins: { legend: { display: false } },
                scales: {
                    y: { beginAtZero: true, grid: { color: 'rgba(0,0,0,.05)' } },
                    x: { grid: { display: false } }
                }
            }
        });
    }

    // Donut — Status
    admChart.donut('chartStatus',
        ['Aktiv (<%= active %>)','Silindi (<%= deleted %>)'],
        [<%= active %>, <%= deleted + (deleted == 0 ? 1 : 0) %>],
        ['#10b981','#ef4444']
    );

    // Bar — Courses
    admChart.bar('chartCourses',
        ['Java','OOP','Spring','DB','HTML','JS','React','Python','Cyber','DevOps'],
        [{
            label: 'Tələbə Sayı',
            data: [32,28,21,17,45,40,38,25,14,19],
            backgroundColor: ['#4f46e5','#7c3aed','#0d9488','#f59e0b','#f43f5e','#f59e0b','#0ea5e9','#10b981','#dc2626','#64748b'],
            borderRadius: 7, borderSkipped: false
        }],
        { plugins: { legend: { display: false } }, scales: { y: { beginAtZero: true, grid: { color: 'rgba(0,0,0,.05)' } }, x: { grid: { display: false }, ticks: { font: { size: 11 } } } } }
    );

    // Bar — Teachers
    admChart.bar('chartTeacher',
        ['Əli Əliyev','Rauf Məmmədov','Nigar Hüseynova','Sevinc Quliyeva'],
        [{
            label: 'Tələbə Sayı',
            data: [81, 69, 123, 25],
            backgroundColor: ['rgba(79,70,229,.75)','rgba(13,148,136,.75)','rgba(244,63,94,.75)','rgba(245,158,11,.75)'],
            borderRadius: 8, borderSkipped: false
        }],
        { plugins: { legend: { display: false } }, scales: { y: { beginAtZero: true, grid: { color: 'rgba(0,0,0,.05)' } }, x: { grid: { display: false } } } }
    );

    admPaginate('tblReport', 10);
});

// CSV Export
function exportCSV() {
    var rows = [['#','Ad','Soyad','Email','Yaş','Müəllim','Status']];
    document.querySelectorAll('#tblReport tbody tr').forEach(function(tr) {
        var cells = tr.querySelectorAll('td');
        if (cells.length >= 6) {
            rows.push([
                cells[0].textContent.trim(),
                cells[1].textContent.trim(),
                '',
                cells[2].textContent.trim(),
                cells[3].textContent.trim(),
                cells[4].textContent.trim(),
                cells[5].textContent.trim()
            ]);
        }
    });
    var csv = rows.map(function(r) { return r.map(function(c) { return '"' + (c||'').replace(/"/g,'""') + '"'; }).join(','); }).join('\n');
    var blob = new Blob(['\uFEFF' + csv], { type: 'text/csv;charset=utf-8;' });
    var a = document.createElement('a');
    a.href = URL.createObjectURL(blob);
    a.download = 'telebelr-hesabat.csv';
    a.click();
    admToast('CSV faylı yükləndi!', 'success');
}
</script>
<style>
@media print {
    .adm-sidebar, .adm-topbar, .adm-page-header button, .adm-pagination { display: none !important; }
    .adm-main { margin-left: 0 !important; }
    .adm-card { box-shadow: none !important; border: 1px solid #ddd !important; }
}
</style>
</body>
</html>
