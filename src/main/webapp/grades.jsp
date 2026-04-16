<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="az">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Qiymət Kitabçası</title>

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
    <link rel="stylesheet" href="css/grades.css?v=1.0">

</head>
<%!
    String getLetterGrade(int average) {
        if (average >= 90) return "A";
        if (average >= 80) return "B";
        if (average >= 70) return "C";
        if (average >= 60) return "D";
        return "F";
    }

    String getGradeColorClass(int average) {
        if (average >= 90) return "grade-A";
        if (average >= 80) return "grade-B";
        if (average >= 70) return "grade-C";
        if (average >= 60) return "grade-D";
        return "grade-F";
    }

    String getScoreBadgeClass(int score) {
        if (score >= 90) return "bg-success";
        if (score >= 80) return "bg-info";
        if (score >= 70) return "bg-warning";
        return "bg-danger";
    }
%>
<body>
    <%
        request.setAttribute("pageLabel", "Qiymətlər");
    %>

    <!-- Header Include -->
    <jsp:include page="header.jsp" />

    <!-- Hero Section -->
    <section class="edu-hero edu-hero-grades py-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-12">
                    <h1 class="display-4 fw-800 mb-3">
                        <i class="bi bi-trophy-fill me-2"></i>Qiymət Kitabçası
                    </h1>
                    <p class="lead text-muted mb-0">Bütün kurslar üzrə qiymətlərini izlə</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <main class="edu-main py-5">
        <div class="container">

            <%
                // Grade data: course, teacher, quiz1, quiz2, assignment1, assignment2, midterm, final
                Object[][] gradeData = {
                    {"Java Əsasları", "Əli Əliyev", 85, 90, 88, 92, 87, 91},
                    {"OOP Konseptləri", "Əli Əliyev", 78, 82, 80, 75, 79, 83},
                    {"Spring Framework", "Rauf Məmmədov", 92, 88, 95, 90, 91, 89},
                    {"HTML & CSS", "Nigar Hüseynova", 95, 97, 93, 98, 96, 94},
                    {"JavaScript", "Nigar Hüseynova", 72, 68, 74, 70, 71, 73},
                    {"Python", "Sevinc Quliyeva", 88, 85, 86, 89, 87, 90}
                };

                // Calculate course averages
                double[] courseAverages = new double[gradeData.length];
                double totalSum = 0;

                for (int i = 0; i < gradeData.length; i++) {
                    int sum = 0;
                    for (int j = 2; j < 8; j++) {
                        sum += (Integer)gradeData[i][j];
                    }
                    courseAverages[i] = sum / 6.0;
                    totalSum += courseAverages[i];
                }

                double overallAverage = totalSum / gradeData.length;

                // Find min and max averages
                double maxAverage = courseAverages[0];
                double minAverage = courseAverages[0];
                int maxIdx = 0, minIdx = 0;

                for (int i = 1; i < courseAverages.length; i++) {
                    if (courseAverages[i] > maxAverage) {
                        maxAverage = courseAverages[i];
                        maxIdx = i;
                    }
                    if (courseAverages[i] < minAverage) {
                        minAverage = courseAverages[i];
                        minIdx = i;
                    }
                }

                String passingGrade = getLetterGrade((int)overallAverage);
            %>

            <!-- Stats Cards -->
            <div class="row mb-5">
                <div class="col-6 col-md-3 mb-3">
                    <div class="edu-stat-card bg-white rounded-4 p-4 text-center">
                        <div class="mb-3">
                            <i class="bi bi-graph-up text-success" style="font-size: 2rem;"></i>
                        </div>
                        <h3 class="display-6 fw-800 mb-1"><%= String.format("%.1f", overallAverage) %></h3>
                        <p class="text-muted small mb-0">Ümumi Ortalama</p>
                    </div>
                </div>

                <div class="col-6 col-md-3 mb-3">
                    <div class="edu-stat-card bg-white rounded-4 p-4 text-center">
                        <div class="mb-3">
                            <i class="bi bi-star-fill text-info" style="font-size: 2rem;"></i>
                        </div>
                        <h3 class="display-6 fw-800 mb-1"><%= String.format("%.1f", maxAverage) %></h3>
                        <p class="text-muted small mb-0">Ən Yüksək</p>
                    </div>
                </div>

                <div class="col-6 col-md-3 mb-3">
                    <div class="edu-stat-card bg-white rounded-4 p-4 text-center">
                        <div class="mb-3">
                            <i class="bi bi-arrow-down-circle text-warning" style="font-size: 2rem;"></i>
                        </div>
                        <h3 class="display-6 fw-800 mb-1"><%= String.format("%.1f", minAverage) %></h3>
                        <p class="text-muted small mb-0">Ən Aşağı</p>
                    </div>
                </div>

                <div class="col-6 col-md-3 mb-3">
                    <div class="edu-stat-card bg-white rounded-4 p-4 text-center">
                        <div class="mb-3">
                            <i class="bi bi-award-fill text-danger" style="font-size: 2rem;"></i>
                        </div>
                        <h3 class="display-6 fw-800 mb-1"><%= passingGrade %></h3>
                        <p class="text-muted small mb-0">Keçmə</p>
                    </div>
                </div>
            </div>

            <!-- Grades Table Card -->
            <div class="edu-card rounded-4 p-4 mb-5">
                <h2 class="h4 fw-800 mb-4">Kurs Üzrə Qiymətlər</h2>
                <div class="table-responsive">
                    <table class="table table-striped table-hover mb-0">
                        <thead class="table-light">
                            <tr>
                                <th class="fw-700">Kurs</th>
                                <th class="fw-700">Müəllim</th>
                                <th class="fw-700 text-center">Quiz 1</th>
                                <th class="fw-700 text-center">Quiz 2</th>
                                <th class="fw-700 text-center">Tapşırıq 1</th>
                                <th class="fw-700 text-center">Tapşırıq 2</th>
                                <th class="fw-700 text-center">Orta</th>
                                <th class="fw-700 text-center">Hərf</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (int i = 0; i < gradeData.length; i++) { %>
                            <tr class="grade-row">
                                <td class="fw-600"><%= gradeData[i][0] %></td>
                                <td><%= gradeData[i][1] %></td>
                                <td class="text-center">
                                    <span class="badge <%= getScoreBadgeClass((Integer)gradeData[i][2]) %>">
                                        <%= gradeData[i][2] %>
                                    </span>
                                </td>
                                <td class="text-center">
                                    <span class="badge <%= getScoreBadgeClass((Integer)gradeData[i][3]) %>">
                                        <%= gradeData[i][3] %>
                                    </span>
                                </td>
                                <td class="text-center">
                                    <span class="badge <%= getScoreBadgeClass((Integer)gradeData[i][4]) %>">
                                        <%= gradeData[i][4] %>
                                    </span>
                                </td>
                                <td class="text-center">
                                    <span class="badge <%= getScoreBadgeClass((Integer)gradeData[i][5]) %>">
                                        <%= gradeData[i][5] %>
                                    </span>
                                </td>
                                <td class="text-center fw-700"><%= String.format("%.0f", courseAverages[i]) %></td>
                                <td class="text-center">
                                    <span class="grade-letter <%= getGradeColorClass((int)courseAverages[i]) %>">
                                        <%= getLetterGrade((int)courseAverages[i]) %>
                                    </span>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Course Progress Card -->
            <div class="edu-card rounded-4 p-4 mb-5">
                <h2 class="h4 fw-800 mb-4">Kurs Tərəqqisi</h2>
                <% for (int i = 0; i < gradeData.length; i++) { %>
                <div class="mb-4">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <label class="fw-600"><%= gradeData[i][0] %></label>
                        <span class="fw-700"><%= String.format("%.0f", courseAverages[i]) %>%</span>
                    </div>
                    <div class="edu-progress-wrap">
                        <div class="edu-progress-bar" style="width: <%= String.format("%.0f", courseAverages[i]) %>%; background: linear-gradient(90deg, <%= i % 2 == 0 ? "#4f46e5" : "#0891b2" %>, <%= i % 2 == 0 ? "#6366f1" : "#06b6d4" %>);"></div>
                    </div>
                </div>
                <% } %>
            </div>

            <!-- Recent Results Card -->
            <div class="edu-card rounded-4 p-4">
                <h2 class="h4 fw-800 mb-4">Ən Son Nəticələr</h2>
                <div class="list-unstyled">
                    <div class="d-flex align-items-start mb-3 pb-3 border-bottom">
                        <div class="me-3">
                            <div class="bg-success bg-opacity-10 rounded-3 p-2">
                                <i class="bi bi-file-earmark-check text-success"></i>
                            </div>
                        </div>
                        <div class="flex-grow-1">
                            <h6 class="fw-700 mb-1">Spring Framework Quiz</h6>
                            <p class="text-muted small mb-0">11 Aprel 2026, 14:30 - Skor: 92/100</p>
                        </div>
                    </div>

                    <div class="d-flex align-items-start mb-3 pb-3 border-bottom">
                        <div class="me-3">
                            <div class="bg-info bg-opacity-10 rounded-3 p-2">
                                <i class="bi bi-pencil-square text-info"></i>
                            </div>
                        </div>
                        <div class="flex-grow-1">
                            <h6 class="fw-700 mb-1">HTML & CSS Tapşırığı</h6>
                            <p class="text-muted small mb-0">10 Aprel 2026, 10:15 - Skor: 98/100</p>
                        </div>
                    </div>

                    <div class="d-flex align-items-start mb-3 pb-3 border-bottom">
                        <div class="me-3">
                            <div class="bg-warning bg-opacity-10 rounded-3 p-2">
                                <i class="bi bi-question-circle text-warning"></i>
                            </div>
                        </div>
                        <div class="flex-grow-1">
                            <h6 class="fw-700 mb-1">Java Əsasları Quiz</h6>
                            <p class="text-muted small mb-0">9 Aprel 2026, 09:00 - Skor: 90/100</p>
                        </div>
                    </div>

                    <div class="d-flex align-items-start mb-3 pb-3 border-bottom">
                        <div class="me-3">
                            <div class="bg-danger bg-opacity-10 rounded-3 p-2">
                                <i class="bi bi-clipboard-data text-danger"></i>
                            </div>
                        </div>
                        <div class="flex-grow-1">
                            <h6 class="fw-700 mb-1">OOP Konseptləri Orta Imtahanı</h6>
                            <p class="text-muted small mb-0">8 Aprel 2026, 14:00 - Skor: 82/100</p>
                        </div>
                    </div>

                    <div class="d-flex align-items-start">
                        <div class="me-3">
                            <div class="bg-purple bg-opacity-10 rounded-3 p-2">
                                <i class="bi bi-code-square" style="color: #8b5cf6;"></i>
                            </div>
                        </div>
                        <div class="flex-grow-1">
                            <h6 class="fw-700 mb-1">Python Layihə Müdafiəsi</h6>
                            <p class="text-muted small mb-0">7 Aprel 2026, 16:30 - Skor: 90/100</p>
                        </div>
                    </div>
                </div>
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
