<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="az">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Davamiyyət</title>

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons CDN -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <!-- Google Fonts Outfit -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">

    <!-- AOS CSS -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

    <!-- Project CSS -->
    <link rel="stylesheet" href="css/style.css?v=3.5">
    <link rel="stylesheet" href="css/dark-mode.css?v=1.0">
    <link rel="stylesheet" href="css/edu-features.css?v=1.0">
    <link rel="stylesheet" href="css/attendance.css?v=1.0">

</head>
<body>
    <%
        request.setAttribute("pageLabel", "Davamiyyət");
    %>

    <!-- Header Include -->
    <jsp:include page="header.jsp" />

    <!-- Hero Section -->
    <section class="edu-hero edu-hero-attendance py-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-12">
                    <h1 class="display-4 fw-800 mb-3">
                        <i class="bi bi-calendar2-check-fill me-2"></i>Davamiyyət
                    </h1>
                    <p class="lead text-muted mb-0">Dərs davamiyyətini kurs üzrə izlə</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <main class="edu-main py-5">
        <div class="container">

            <%
                // Attendance data
                String[] courses = {
                    "Java Əsasları",
                    "OOP Konseptləri",
                    "Spring Framework",
                    "HTML & CSS",
                    "JavaScript",
                    "Python"
                };

                int[] presentCount = {18, 16, 19, 20, 15, 17};
                int[] absentCount = {2, 3, 1, 0, 4, 2};
                int[] lateCount = {0, 1, 0, 0, 1, 1};
                int totalClasses = 20;

                // Weekly attendance pattern (4 weeks × 5 days)
                // P=Present, B=Absent, G=Gecikmə (Late)
                String[][] weeklyPattern = {
                    {"P", "P", "P", "P", "P"},
                    {"P", "B", "P", "P", "P"},
                    {"P", "P", "G", "P", "P"},
                    {"P", "P", "P", "B", "P"}
                };

                String[] weekLabels = {"1-ci Həftə", "2-ci Həftə", "3-ci Həftə", "4-cü Həftə"};
                String[] dayLabels = {"B.E.", "Çərş.A.", "Çərşənbə", "Cümə A.", "Cümə"};

                // Total stats
                int totalPresent = 0, totalAbsent = 0, totalLate = 0;
                for (int i = 0; i < presentCount.length; i++) {
                    totalPresent += presentCount[i];
                    totalAbsent += absentCount[i];
                    totalLate += lateCount[i];
                }
            %>

            <!-- Stats Cards -->
            <div class="row mb-5">
                <div class="col-6 col-md-3 mb-3">
                    <div class="edu-stat-card bg-white rounded-4 p-4 text-center">
                        <div class="mb-3">
                            <i class="bi bi-calendar-event text-info" style="font-size: 2rem;"></i>
                        </div>
                        <h3 class="display-6 fw-800 mb-1"><%= totalClasses %></h3>
                        <p class="text-muted small mb-0">Ümumi</p>
                    </div>
                </div>

                <div class="col-6 col-md-3 mb-3">
                    <div class="edu-stat-card bg-white rounded-4 p-4 text-center">
                        <div class="mb-3">
                            <i class="bi bi-check-circle-fill text-success" style="font-size: 2rem;"></i>
                        </div>
                        <h3 class="display-6 fw-800 mb-1"><%= totalPresent %></h3>
                        <p class="text-muted small mb-0">İştirak</p>
                    </div>
                </div>

                <div class="col-6 col-md-3 mb-3">
                    <div class="edu-stat-card bg-white rounded-4 p-4 text-center">
                        <div class="mb-3">
                            <i class="bi bi-x-circle-fill text-danger" style="font-size: 2rem;"></i>
                        </div>
                        <h3 class="display-6 fw-800 mb-1"><%= totalAbsent %></h3>
                        <p class="text-muted small mb-0">Buraxdı</p>
                    </div>
                </div>

                <div class="col-6 col-md-3 mb-3">
                    <div class="edu-stat-card bg-white rounded-4 p-4 text-center">
                        <div class="mb-3">
                            <i class="bi bi-clock-history text-warning" style="font-size: 2rem;"></i>
                        </div>
                        <h3 class="display-6 fw-800 mb-1"><%= totalLate %></h3>
                        <p class="text-muted small mb-0">Gecikmə</p>
                    </div>
                </div>
            </div>

            <!-- Weekly Attendance Calendar Card -->
            <div class="edu-card rounded-4 p-4 mb-5">
                <h2 class="h4 fw-800 mb-4">Həftəlik Davamiyyət Cədvəli (Aprel 2026)</h2>
                <div class="table-responsive">
                    <table class="table mb-0">
                        <thead class="table-light">
                            <tr>
                                <th class="fw-700">Həftə</th>
                                <% for (String day : dayLabels) { %>
                                <th class="fw-700 text-center"><%= day %></th>
                                <% } %>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (int w = 0; w < weeklyPattern.length; w++) { %>
                            <tr>
                                <td class="fw-600 align-middle"><%= weekLabels[w] %></td>
                                <% for (int d = 0; d < weeklyPattern[w].length; d++) { %>
                                <td class="text-center align-middle">
                                    <%
                                        String status = weeklyPattern[w][d];
                                        String attClass = "";
                                        String display = "";

                                        if ("P".equals(status)) {
                                            attClass = "att-present";
                                            display = "İ";
                                        } else if ("B".equals(status)) {
                                            attClass = "att-absent";
                                            display = "B";
                                        } else if ("G".equals(status)) {
                                            attClass = "att-late";
                                            display = "G";
                                        }
                                    %>
                                    <div class="att-day <%= attClass %>"><%= display %></div>
                                </td>
                                <% } %>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>

                <!-- Legend -->
                <div class="mt-4 pt-4 border-top">
                    <p class="text-muted small mb-3">Göstərici:</p>
                    <div class="row g-3">
                        <div class="col-auto">
                            <span class="att-legend-dot att-present"></span>
                            <span class="small ms-2">İştirak</span>
                        </div>
                        <div class="col-auto">
                            <span class="att-legend-dot att-absent"></span>
                            <span class="small ms-2">Buraxdı</span>
                        </div>
                        <div class="col-auto">
                            <span class="att-legend-dot att-late"></span>
                            <span class="small ms-2">Gecikmə</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Course Attendance Card -->
            <div class="edu-card rounded-4 p-4">
                <h2 class="h4 fw-800 mb-4">Kurs Üzrə Davamiyyət</h2>

                <% for (int i = 0; i < courses.length; i++) {
                    int totalCourseClasses = presentCount[i] + absentCount[i] + lateCount[i];
                    double attendancePercentage = (totalCourseClasses > 0) ? (presentCount[i] * 100.0 / totalCourseClasses) : 0;
                    String percentClass = "text-success";
                    if (attendancePercentage < 85) percentClass = "text-warning";
                    if (attendancePercentage < 70) percentClass = "text-danger";
                %>

                <div class="mb-4 pb-4 border-bottom" <% if (i == courses.length - 1) { %>style="border-bottom: none !important;"<% } %>>
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <label class="fw-600"><%= courses[i] %></label>
                        <span class="fw-700 <%= percentClass %>"><%= String.format("%.0f", attendancePercentage) %>%</span>
                    </div>
                    <div class="edu-progress-wrap">
                        <div class="edu-progress-bar" style="width: <%= String.format("%.0f", attendancePercentage) %>%; background: <%= attendancePercentage >= 85 ? "#10b981" : attendancePercentage >= 70 ? "#f59e0b" : "#ef4444" %>;"></div>
                    </div>
                    <div class="mt-2 small text-muted">
                        <span class="me-3">
                            <i class="bi bi-check-circle-fill text-success"></i>
                            İştirak: <%= presentCount[i] %>
                        </span>
                        <span class="me-3">
                            <i class="bi bi-x-circle-fill text-danger"></i>
                            Buraxdı: <%= absentCount[i] %>
                        </span>
                        <span>
                            <i class="bi bi-clock-history text-warning"></i>
                            Gecikmə: <%= lateCount[i] %>
                        </span>
                    </div>
                </div>

                <% } %>

            </div>

        </div>
    </main>

    <!-- Footer Include -->
    <jsp:include page="footer.jsp" />

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- AOS JS -->
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script src="js/script.js?v=2.2"></script>
    <script>AOS.init({duration:800,easing:"ease-in-out"});</script>

</body>
</html>
