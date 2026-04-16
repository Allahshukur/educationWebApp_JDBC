<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    int totalStudents = 247;
    int activeCourses = 10;
    int monthlyRegistrations = 38;
    double averageScore = 84.2;
%>
<!DOCTYPE html>
<html lang="az">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Analitika — Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="css/admin.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    <style>
        .chart-card {
            background: #fff;
            border-radius: 20px;
            border: 1px solid rgba(0,0,0,.06);
            box-shadow: 0 2px 14px rgba(0,0,0,.06);
            padding: 24px;
        }
        .chart-title {
            font-size: .88rem;
            font-weight: 700;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: .5px;
            margin-bottom: 20px;
        }
        .dark-mode .chart-card {
            background: #1e293b;
            border-color: rgba(255,255,255,.07);
        }
        .dark-mode .chart-title {
            color: #94a3b8;
        }
    </style>
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
                <span class="adm-breadcrumb-cur">Analitika</span>
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
                <h1 class="adm-page-title"><i class="bi bi-graph-up me-2 adm-text-accent"></i>Analitika Paneli</h1>
                <p class="adm-page-sub">Detalı statistika və təhlil məlumatları — real vaxt göstəriciləri</p>
            </div>
            <div class="d-flex gap-2 flex-wrap">
                <button class="adm-btn adm-btn-outline" onclick="location.reload()">
                    <i class="bi bi-arrow-clockwise"></i> Yenilə
                </button>
                <a href="reports.jsp" class="adm-btn adm-btn-primary">
                    <i class="bi bi-download"></i> Ixrac Et
                </a>
            </div>
        </div>

        <!-- STAT CARDS -->
        <div class="row g-3 mb-4">
            <div class="col-sm-6 col-xl-3">
                <div class="adm-stat adm-stat-indigo">
                    <div class="adm-stat-icon"><i class="bi bi-people-fill"></i></div>
                    <div>
                        <div class="adm-stat-val"><%= totalStudents %></div>
                        <div class="adm-stat-label">Cəmi Tələbələr</div>
                        <div class="adm-stat-trend up"><i class="bi bi-arrow-up-right"></i> +8.2%</div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-xl-3">
                <div class="adm-stat adm-stat-teal">
                    <div class="adm-stat-icon"><i class="bi bi-journal-bookmark-fill"></i></div>
                    <div>
                        <div class="adm-stat-val"><%= activeCourses %></div>
                        <div class="adm-stat-label">Aktiv Kurslar</div>
                        <div class="adm-stat-trend up"><i class="bi bi-arrow-up-right"></i> +1</div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-xl-3">
                <div class="adm-stat adm-stat-green">
                    <div class="adm-stat-icon"><i class="bi bi-person-plus-fill"></i></div>
                    <div>
                        <div class="adm-stat-val"><%= monthlyRegistrations %></div>
                        <div class="adm-stat-label">Bu Ay Qeydiyyat</div>
                        <span class="adm-badge adm-badge-green" style="font-size:.7rem; margin-top:4px;">+12%</span>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-xl-3">
                <div class="adm-stat adm-stat-amber">
                    <div class="adm-stat-icon"><i class="bi bi-trophy-fill"></i></div>
                    <div>
                        <div class="adm-stat-val"><%= averageScore %></div>
                        <div class="adm-stat-label">Ortalama Qiymət</div>
                        <div class="adm-stat-trend up"><i class="bi bi-arrow-up-right"></i> +2.1</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- CHARTS ROW 1 -->
        <div class="row g-3 mb-4">
            <div class="col-lg-8">
                <div class="chart-card">
                    <div class="chart-title"><i class="bi bi-graph-up me-2"></i>Aylıq Qeydiyyat Artımı</div>
                    <canvas id="monthlyChart" height="300"></canvas>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="chart-card">
                    <div class="chart-title"><i class="bi bi-pie-chart-fill me-2"></i>Kurs Paylanması</div>
                    <canvas id="courseDistChart"></canvas>
                </div>
            </div>
        </div>

        <!-- CHARTS ROW 2 -->
        <div class="row g-3 mb-4">
            <div class="col-lg-6">
                <div class="chart-card">
                    <div class="chart-title"><i class="bi bi-bar-chart me-2"></i>Kurs Üzrə Ortalama Qiymət</div>
                    <canvas id="gradeChart" height="280"></canvas>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="chart-card">
                    <div class="chart-title"><i class="bi bi-person-workspace me-2"></i>Müəllim Aktivliyi</div>
                    <canvas id="teacherChart" height="280"></canvas>
                </div>
            </div>
        </div>

        <!-- DATA TABLE -->
        <div class="row g-3">
            <div class="col-12">
                <div class="adm-card">
                    <div class="adm-card-header">
                        <span class="adm-card-title"><i class="bi bi-star-fill"></i>Ən Aktiv Tələbələr</span>
                        <span class="adm-badge adm-badge-blue ms-auto">Top 8</span>
                    </div>
                    <div class="adm-table-wrap">
                        <table class="adm-table">
                            <thead><tr>
                                <th>#</th><th data-sort>Ad Soyad</th><th data-sort>Kurs</th>
                                <th data-sort>Ortalama</th><th data-sort>Davamiyyət</th><th>Status</th>
                            </tr></thead>
                            <tbody>
                            <tr>
                                <td class="adm-text-muted fw-600">1</td>
                                <td><div class="d-flex align-items-center gap-2"><div class="adm-mini-avatar">Ə</div><span class="fw-700">Əli Əliyev</span></div></td>
                                <td>Java Əsasları</td><td><strong>92</strong></td><td><span class="badge bg-success">96%</span></td>
                                <td><span class="adm-badge adm-badge-green">Aktiv</span></td>
                            </tr>
                            <tr>
                                <td class="adm-text-muted fw-600">2</td>
                                <td><div class="d-flex align-items-center gap-2"><div class="adm-mini-avatar">N</div><span class="fw-700">Nigar Hüseynova</span></div></td>
                                <td>JavaScript</td><td><strong>88</strong></td><td><span class="badge bg-success">92%</span></td>
                                <td><span class="adm-badge adm-badge-green">Aktiv</span></td>
                            </tr>
                            <tr>
                                <td class="adm-text-muted fw-600">3</td>
                                <td><div class="d-flex align-items-center gap-2"><div class="adm-mini-avatar">R</div><span class="fw-700">Rauf Məmmədov</span></div></td>
                                <td>Spring Framework</td><td><strong>91</strong></td><td><span class="badge bg-success">94%</span></td>
                                <td><span class="adm-badge adm-badge-green">Aktiv</span></td>
                            </tr>
                            <tr>
                                <td class="adm-text-muted fw-600">4</td>
                                <td><div class="d-flex align-items-center gap-2"><div class="adm-mini-avatar">S</div><span class="fw-700">Sevinc Quliyeva</span></div></td>
                                <td>Python</td><td><strong>85</strong></td><td><span class="badge bg-warning">85%</span></td>
                                <td><span class="adm-badge adm-badge-green">Aktiv</span></td>
                            </tr>
                            <tr>
                                <td class="adm-text-muted fw-600">5</td>
                                <td><div class="d-flex align-items-center gap-2"><div class="adm-mini-avatar">A</div><span class="fw-700">Aynur Tağiyeva</span></div></td>
                                <td>OOP Konseptləri</td><td><strong>79</strong></td><td><span class="badge bg-warning">78%</span></td>
                                <td><span class="adm-badge adm-badge-green">Aktiv</span></td>
                            </tr>
                            <tr>
                                <td class="adm-text-muted fw-600">6</td>
                                <td><div class="d-flex align-items-center gap-2"><div class="adm-mini-avatar">B</div><span class="fw-700">Behnam Balayev</span></div></td>
                                <td>React.js</td><td><strong>82</strong></td><td><span class="badge bg-success">89%</span></td>
                                <td><span class="adm-badge adm-badge-green">Aktiv</span></td>
                            </tr>
                            <tr>
                                <td class="adm-text-muted fw-600">7</td>
                                <td><div class="d-flex align-items-center gap-2"><div class="adm-mini-avatar">D</div><span class="fw-700">Dilşah Đəbəyeva</span></div></td>
                                <td>Verilənlər Bazası</td><td><strong>76</strong></td><td><span class="badge bg-danger">62%</span></td>
                                <td><span class="adm-badge adm-badge-gray">Pasif</span></td>
                            </tr>
                            <tr>
                                <td class="adm-text-muted fw-600">8</td>
                                <td><div class="d-flex align-items-center gap-2"><div class="adm-mini-avatar">E</div><span class="fw-700">Elvin Səfərov</span></div></td>
                                <td>Kibertəhlükəsizlik</td><td><strong>80</strong></td><td><span class="badge bg-warning">71%</span></td>
                                <td><span class="adm-badge adm-badge-green">Aktiv</span></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div><!-- /adm-content -->
</div><!-- /adm-main -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/admin.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function () {

    // Detect dark mode
    function isDarkMode() {
        return document.body.classList.contains('dark-mode');
    }

    function getChartColors() {
        const dark = isDarkMode();
        return {
            gridColor: dark ? 'rgba(255,255,255,.08)' : 'rgba(0,0,0,.06)',
            textColor: dark ? '#cbd5e1' : '#64748b',
            borderColor: dark ? 'rgba(255,255,255,.1)' : 'rgba(0,0,0,.1)'
        };
    }

    Chart.defaults.font.family = "'Outfit', sans-serif";

    // Monthly Chart (Line)
    const monthlyCtx = document.getElementById('monthlyChart').getContext('2d');
    const colors = getChartColors();

    const monthlyGradient = monthlyCtx.createLinearGradient(0, 0, 0, 300);
    monthlyGradient.addColorStop(0, 'rgba(79,70,229,.35)');
    monthlyGradient.addColorStop(1, 'rgba(79,70,229,.0)');

    new Chart(monthlyCtx, {
        type: 'line',
        data: {
            labels: ['Noyabr', 'Dekabr', 'Yanvar', 'Fevral', 'Mart', 'Aprel'],
            datasets: [
                {
                    label: 'Yeni Tələbələr',
                    data: [28, 35, 31, 42, 39, 38],
                    borderColor: '#4f46e5',
                    backgroundColor: monthlyGradient,
                    borderWidth: 2.5,
                    fill: true,
                    tension: 0.4,
                    pointRadius: 4,
                    pointBackgroundColor: '#4f46e5',
                    pointBorderColor: '#fff',
                    pointBorderWidth: 2
                },
                {
                    label: 'Aktiv İstifadəçilər',
                    data: [180, 195, 188, 210, 220, 234],
                    borderColor: '#0d9488',
                    backgroundColor: 'transparent',
                    borderWidth: 2.5,
                    fill: false,
                    tension: 0.4,
                    pointRadius: 4,
                    pointBackgroundColor: '#0d9488',
                    pointBorderColor: '#fff',
                    pointBorderWidth: 2
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            plugins: {
                legend: {
                    display: true,
                    position: 'top',
                    labels: {
                        color: colors.textColor,
                        font: { weight: 600, size: 12 },
                        padding: 15,
                        usePointStyle: true
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: { color: colors.gridColor, drawBorder: false },
                    ticks: { color: colors.textColor, font: { weight: 600 } }
                },
                x: {
                    grid: { display: false },
                    ticks: { color: colors.textColor, font: { weight: 600 } }
                }
            }
        }
    });

    // Course Distribution Chart (Doughnut)
    const courseCtx = document.getElementById('courseDistChart').getContext('2d');
    new Chart(courseCtx, {
        type: 'doughnut',
        data: {
            labels: ['Java Əsasları', 'HTML & CSS', 'JavaScript', 'Python', 'OOP', 'Digər'],
            datasets: [{
                data: [45, 38, 32, 28, 24, 80],
                backgroundColor: ['#4f46e5', '#f43f5e', '#f59e0b', '#0ea5e9', '#10b981', '#8b5cf6'],
                borderColor: isDarkMode() ? '#1e293b' : '#fff',
                borderWidth: 2
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: {
                        color: colors.textColor,
                        font: { weight: 600, size: 11 },
                        padding: 12
                    }
                }
            }
        }
    });

    // Grade Chart (Bar)
    const gradeCtx = document.getElementById('gradeChart').getContext('2d');
    new Chart(gradeCtx, {
        type: 'bar',
        data: {
            labels: ['Java', 'OOP', 'Spring', 'HTML&CSS', 'JS', 'Python'],
            datasets: [{
                label: 'Ortalama Qiymət',
                data: [85, 79, 91, 96, 72, 88],
                backgroundColor: ['#4f46e5', '#8b5cf6', '#f43f5e', '#f59e0b', '#0ea5e9', '#10b981'],
                borderRadius: 8,
                borderSkipped: false
            }]
        },
        options: {
            indexAxis: 'x',
            responsive: true,
            maintainAspectRatio: true,
            plugins: {
                legend: { display: false }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    max: 100,
                    grid: { color: colors.gridColor },
                    ticks: { color: colors.textColor, font: { weight: 600 } }
                },
                x: {
                    grid: { display: false },
                    ticks: { color: colors.textColor, font: { weight: 600 } }
                }
            }
        }
    });

    // Teacher Activity Chart (Horizontal Bar)
    const teacherCtx = document.getElementById('teacherChart').getContext('2d');
    new Chart(teacherCtx, {
        type: 'bar',
        data: {
            labels: ['Nigar Hüseynova', 'Rauf Məmmədov', 'Əli Əliyev', 'Sevinc Quliyeva'],
            datasets: [{
                label: 'Ders sayı',
                data: [32, 28, 30, 18],
                backgroundColor: ['#f43f5e', '#8b5cf6', '#4f46e5', '#0ea5e9'],
                borderRadius: 8,
                borderSkipped: false
            }]
        },
        options: {
            indexAxis: 'y',
            responsive: true,
            maintainAspectRatio: true,
            plugins: {
                legend: { display: false }
            },
            scales: {
                x: {
                    beginAtZero: true,
                    grid: { color: colors.gridColor },
                    ticks: { color: colors.textColor, font: { weight: 600 } }
                },
                y: {
                    grid: { display: false },
                    ticks: { color: colors.textColor, font: { weight: 600 } }
                }
            }
        }
    });

    // Dark mode toggle support
    const darkToggleBtn = document.querySelector('[data-adm-dark-toggle]');
    if (darkToggleBtn) {
        darkToggleBtn.addEventListener('click', function() {
            setTimeout(() => {
                location.reload();
            }, 100);
        });
    }
});
</script>
</body>
</html>
