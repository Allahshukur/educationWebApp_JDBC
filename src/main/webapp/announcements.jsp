<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="az">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Elanlar</title>

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
    <link rel="stylesheet" href="css/announcements.css?v=1.0">

</head>
<%!
    String getCategoryLabel(String cat) {
        if ("exam".equals(cat)) return "İmtahan";
        if ("assign".equals(cat)) return "Tapşırıq";
        if ("event".equals(cat)) return "Tədbir";
        if ("update".equals(cat)) return "Yenilik";
        if ("general".equals(cat)) return "Ümumi";
        return "";
    }

    String getCategoryBadgeClass(String cat) {
        if ("exam".equals(cat)) return "badge-exam";
        if ("assign".equals(cat)) return "badge-assign";
        if ("event".equals(cat)) return "badge-event";
        if ("update".equals(cat)) return "badge-update";
        if ("general".equals(cat)) return "badge-general";
        return "";
    }

    String getAnnCardClass(String cat) {
        if ("exam".equals(cat)) return "cat-exam";
        if ("assign".equals(cat)) return "cat-assign";
        if ("event".equals(cat)) return "cat-event";
        if ("update".equals(cat)) return "cat-update";
        if ("general".equals(cat)) return "cat-general";
        return "";
    }
%>
<body>
    <%
        request.setAttribute("pageLabel", "Elanlar");

        // Announcements data: title, body, teacher, date, category, isUnread, avatarBg
        Object[][] announcements = {
            {"İmtahan Tarixi Dəyişdi",
             "Java Əsasları kursunun yekun imtahanı 20 Aprel 2026 tarixinə keçirilmişdir. Hazırlıq mövzuları: Collections, Generics, Exception Handling.",
             "Əli Əliyev", "11 Aprel 2026, 09:30", "exam", true, "#4f46e5"},
            {"Yeni Tapşırıq: Spring REST API",
             "Spring Framework kursundan yeni tapşırıq əlavə edildi. Son tarix: 25 Aprel 2026. Tapşırıq bölməsindən baxın.",
             "Rauf Məmmədov", "10 Aprel 2026, 14:15", "assign", true, "#0891b2"},
            {"HTML & CSS Workshop",
             "Bu cümə günü saat 15:00-da əlavə praktika sessiyası keçiriləcək. İştirak könüllüdür, lakin tövsiyə olunur.",
             "Nigar Hüseynova", "9 Aprel 2026, 11:00", "event", true, "#db2777"},
            {"Platforma Yeniləməsi",
             "Education App platforması yeniləndi. İndi quiz modulu, tapşırıq sistemi və davamiyyət izləmə mövcuddur.",
             "Admin", "8 Aprel 2026, 10:00", "update", false, "#7c3aed"},
            {"Python Layihə Müdafiəsi",
             "Python Proqramlaşdırma kursunun son layihə müdafiəsi 30 Aprel tarixindədir. Layihə tələbləri fayl bölməsindədir.",
             "Sevinc Quliyeva", "7 Aprel 2026, 16:45", "assign", false, "#059669"},
            {"OOP İmtahan Nəticələri",
             "OOP Konseptləri kursunun ara imtahan nəticələri elan edildi. Ortalama: 79/100. Nəticələrinizi qiymət bölməsindən yoxlaya bilərsiniz.",
             "Əli Əliyev", "5 Aprel 2026, 12:30", "exam", false, "#4f46e5"},
            {"Ümumi Məlumat: Tətil Cədvəli",
             "21-23 Aprel tarixlərində dərslər olmayacaq (Novruz tatili ertəsi). Cədvəl buna uyğun yenilənib.",
             "Admin", "3 Aprel 2026, 09:00", "general", false, "#64748b"},
            {"JavaScript DOM Tapşırığı Uzadıldı",
             "JavaScript DOM tapşırığının son tarixi 28 Aprel-dən 5 May-a uzadılmışdır. Bütün tələbələrə bildiriş göndərildi.",
             "Nigar Hüseynova", "2 Aprel 2026, 15:20", "assign", false, "#db2777"}
        };

        // Count unread
        int unreadCount = 0;
        int examCount = 0, assignCount = 0;
        for (Object[] ann : announcements) {
            if ((Boolean)ann[5]) unreadCount++;
            String cat = (String)ann[4];
            if ("exam".equals(cat)) examCount++;
            if ("assign".equals(cat)) assignCount++;
        }

    %>

    <!-- Header Include -->
    <jsp:include page="header.jsp" />

    <!-- Hero Section -->
    <section class="edu-hero edu-hero-announce py-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-12">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <h1 class="display-4 fw-800 mb-3">
                                <i class="bi bi-megaphone-fill me-2"></i>Elanlar
                            </h1>
                            <p class="lead text-muted mb-0">Müəllimlərdən ən son bildiriş və elanlar</p>
                        </div>
                        <% if (unreadCount > 0) { %>
                        <div class="badge bg-danger fs-5" style="height: fit-content; padding: 10px 16px;">
                            <%= unreadCount %> yeni
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <main class="edu-main py-5">
        <div class="container">

            <!-- Filter Bar -->
            <div class="row mb-5 g-3 align-items-center">
                <div class="col-12 col-md-6">
                    <div class="d-flex gap-2">
                        <select class="form-select form-select-sm" id="categoryFilter">
                            <option value="">Hamısı</option>
                            <option value="exam">İmtahan</option>
                            <option value="assign">Tapşırıq</option>
                            <option value="general">Ümumi</option>
                            <option value="event">Tədbir</option>
                            <option value="update">Yenilik</option>
                        </select>
                        <select class="form-select form-select-sm" id="readFilter">
                            <option value="">Hamısı</option>
                            <option value="unread">Oxunmamış</option>
                        </select>
                    </div>
                </div>
                <div class="col-12 col-md-6 text-md-end">
                    <button class="btn btn-sm btn-outline-primary" onclick="markAllAsRead()">
                        Hamısını oxunmuş et
                    </button>
                </div>
            </div>

            <!-- Stats Cards -->
            <div class="row mb-5">
                <div class="col-6 col-md-3 mb-3">
                    <div class="edu-stat-card bg-white rounded-4 p-4 text-center">
                        <div class="mb-3">
                            <i class="bi bi-megaphone-fill text-info" style="font-size: 2rem;"></i>
                        </div>
                        <h3 class="display-6 fw-800 mb-1"><%= announcements.length %></h3>
                        <p class="text-muted small mb-0">Cəmi</p>
                    </div>
                </div>

                <div class="col-6 col-md-3 mb-3">
                    <div class="edu-stat-card bg-white rounded-4 p-4 text-center">
                        <div class="mb-3">
                            <i class="bi bi-dot text-danger" style="font-size: 2rem;"></i>
                        </div>
                        <h3 class="display-6 fw-800 mb-1"><%= unreadCount %></h3>
                        <p class="text-muted small mb-0">Oxunmamış</p>
                    </div>
                </div>

                <div class="col-6 col-md-3 mb-3">
                    <div class="edu-stat-card bg-white rounded-4 p-4 text-center">
                        <div class="mb-3">
                            <i class="bi bi-book-fill text-danger" style="font-size: 2rem;"></i>
                        </div>
                        <h3 class="display-6 fw-800 mb-1"><%= examCount %></h3>
                        <p class="text-muted small mb-0">İmtahan</p>
                    </div>
                </div>

                <div class="col-6 col-md-3 mb-3">
                    <div class="edu-stat-card bg-white rounded-4 p-4 text-center">
                        <div class="mb-3">
                            <i class="bi bi-pencil-square text-warning" style="font-size: 2rem;"></i>
                        </div>
                        <h3 class="display-6 fw-800 mb-1"><%= assignCount %></h3>
                        <p class="text-muted small mb-0">Tapşırıq</p>
                    </div>
                </div>
            </div>

            <!-- Announcements List -->
            <div class="announcements-container">
                <% for (Object[] ann : announcements) {
                    String title = (String)ann[0];
                    String body = (String)ann[1];
                    String teacher = (String)ann[2];
                    String date = (String)ann[3];
                    String category = (String)ann[4];
                    boolean isUnread = (Boolean)ann[5];
                    String avatarBg = (String)ann[6];
                %>

                <div class="ann-card <%= getAnnCardClass(category) %> <%= isUnread ? "unread" : "" %>" data-category="<%= category %>" data-unread="<%= isUnread %>">
                    <div class="d-flex gap-3">
                        <div class="ann-avatar" style="background: <%= avatarBg %>;">
                            <% if ("Admin".equals(teacher)) { %>
                                <i class="bi bi-gear-fill"></i>
                            <% } else { %>
                                <%= teacher.charAt(0) %>
                            <% } %>
                        </div>

                        <div class="flex-grow-1">
                            <div class="d-flex align-items-start justify-content-between mb-2">
                                <div class="flex-grow-1">
                                    <h5 class="fw-800 mb-1"><%= title %></h5>
                                    <p class="small text-muted mb-0"><%= date %></p>
                                </div>
                                <span class="badge <%= getCategoryBadgeClass(category) %> ms-3">
                                    <%= getCategoryLabel(category) %>
                                </span>
                            </div>

                            <p class="text-muted small ann-body mb-3"><%= body %></p>

                            <div class="d-flex align-items-center justify-content-between">
                                <span class="small text-muted">
                                    <i class="bi bi-person-circle"></i>
                                    <%= teacher %>
                                </span>
                                <% if (isUnread) { %>
                                <button class="btn btn-sm btn-link p-0 text-primary" onclick="markAsRead(this)">
                                    Oxu
                                </button>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>

                <% } %>
            </div>

            <!-- Pagination -->
            <nav class="mt-5" aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <li class="page-item disabled">
                        <a class="page-link" href="#" tabindex="-1">Öncəki</a>
                    </li>
                    <li class="page-item active">
                        <a class="page-link" href="#">1</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="#">2</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" href="#">Sonrakı</a>
                    </li>
                </ul>
            </nav>

        </div>
    </main>

    <!-- Footer Include -->
    <jsp:include page="footer.jsp" />

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- AOS JS -->
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>

<script src="js/script.js?v=2.2"></script>
    <script src="js/announcements.js?v=1.0"></script>
</body>
</html>
