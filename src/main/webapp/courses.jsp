<%@ page import="com.sukur.educationwebapp.teacher.service.TeacherService" %>
<%@ page import="com.sukur.educationwebapp.teacher.entity.Teacher" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sukur.educationwebapp.course.service.CourseService" %>
<%@ page import="com.sukur.educationwebapp.course.entity.Course" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    TeacherService teacherService = new TeacherService();
    List<Teacher> teachers = teacherService.findAll();
    Teacher teacher = teacherService.findById(2);

    CourseService courseService = new CourseService();
    List<Course> courses = courseService.findAll();


    /* ── 10 Default Kurs (JSP massivləri) ──────────────────────── */
    String[] cNames = {
        "Java Əsasları",
        "OOP Konseptləri",
        "Spring Framework",
        "Verilənlər Bazası",
        "HTML & CSS",
        "JavaScript Əsasları",
        "React.js",
        "Python Proqramlaşdırma",
        "Kibertəhlükəsizlik",
        "DevOps & Docker"
    };
    String[] cDescs = {
        "Java proqramlaşdırma dilinin temel konseptləri: dəyişənlər, dövrələr, şərtlər və metodlar.",
        "Obyekt yönümlü proqramlaşdırmanın prinsipləri: inkapsulyasiya, miras, polimorfizm, abstraksiya.",
        "Spring Boot ilə müasir Java veb tətbiqlərinin qurulması. IoC, Dependency Injection, REST API.",
        "MySQL və PostgreSQL ilə işləmə. SQL sorğuları, JOIN əməliyyatları, indeksləmə.",
        "Müasir veb dizaynının əsasları. Flexbox, Grid, animasiyalar və responsive dizayn.",
        "Veb səhifələri interaktiv etmək üçün JavaScript: DOM, Events, Fetch API, ES6+.",
        "Meta-nın populyar UI kitabxanası ilə komponent əsaslı veb tətbiqlər qurmaq.",
        "Data analizi, skript yazma və süni intellekt üçün Python proqramlaşdırma dili.",
        "Şəbəkə təhlükəsizliyi, kriptografiya, zəifliklərin aşkarlanması və etik hacking.",
        "CI/CD prosesləri, konteynerləşdirmə, Docker, Kubernetes ilə müasir deployment."
    };
    String[] cFilters = {
        "active prog", "active prog", "active prog", "active prog",
        "active design", "active prog", "active prog",
        "active prog", "active", "active"
    };
    String[] cTeachers = {
        "Əli Əliyev", "Nigar Hüseynova", "Rauf Məmmədov",
        "Sevinc Quliyeva", "Əli Əliyev", "Nigar Hüseynova",
        "Rauf Məmmədov", "Sevinc Quliyeva", "Əli Əliyev", "Rauf Məmmədov"
    };
    String[] cStudents = {"85","62","74","91","58","103","67","80","45","72"};
    String[] cHours    = {"36","28","42","32","24","30","38","35","40","26"};
    String[] cRatings  = {"4.9","4.7","4.8","4.6","5.0","4.8","4.7","4.9","4.6","4.8"};

    /* Rəng palitrasını */
    String[] gFrom = {"#4338ca","#059669","#d97706","#db2777","#0891b2","#7c3aed","#ea580c","#2563eb","#0f172a","#065f46"};
    String[] gTo   = {"#7c3aed","#0d9488","#dc2626","#7c3aed","#0f766e","#db2777","#d97706","#4f46e5","#334155","#047857"};
    String[] icons = {
        "bi-code-slash","bi-diagram-3-fill","bi-layers-fill","bi-database-fill",
        "bi-brush-fill","bi-braces-asterisk","bi-filetype-js","bi-robot",
        "bi-shield-lock-fill","bi-cloud-upload-fill"
    };

    String searchWord = request.getParameter("search");
    int totalCourses = courses.size();
%>
<!DOCTYPE html>
<html lang="az">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kurslar — Education App</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="css/style.css?v=3.5" rel="stylesheet">
    <link href="css/dark-mode.css?v=1.0" rel="stylesheet">
    <link href="css/ads.css?v=4.0" rel="stylesheet">
    <link href="css/courses.css?v=1.0" rel="stylesheet">
</head>
<body class="overflow-hidden-init cr-page">

<!-- Yükləmə ekranı -->
<div id="loader">
    <div class="loader-content">
        <div class="loader-circle"></div>
        <div class="loader-circle"></div>
        <div class="loader-circle"></div>
        <div class="loader-subtext">Kurslar yüklənir...</div>
    </div>
</div>

<%
    request.setAttribute("pageLabel", "Kurslar");
    request.setAttribute("isHome", false);
%>
<jsp:include page="header.jsp"/>

<!-- ══════════════════════════════════════════════
     HERO BÖLMƏSİ
══════════════════════════════════════════════ -->
<div class="cr-hero">
    <div class="container">
        <div class="row align-items-center g-4">

            <!-- Sol — Başlıq + Axtarış -->
            <div class="col-lg-6" data-aos="fade-right">
                <div class="cr-hero-label">
                    <i class="bi bi-journal-bookmark-fill"></i> Kurs Paneli
                </div>
                <h1 class="cr-hero-title">
                    Kursları <span style="color:#818cf8;">İdarə Et</span> &amp;<br>
                    İzlə
                </h1>
                <p class="cr-hero-sub">
                    Bütün kursları bir yerdən idarə et, müəllim təyin et,<br class="d-none d-md-block">
                    statistikalara bax və yeni kurslar əlavə et.
                </p>

                <!-- Axtarış forması -->
                <form action="courses.jsp" method="get" class="cr-hero-search">
                    <input type="text" name="search"
                           value="<%= searchWord != null ? searchWord : "" %>"
                           class="form-control"
                           placeholder="Kurs adı ilə axtar...">
                    <button type="submit" class="btn-search">
                        <i class="bi bi-search me-1"></i>Axtar
                    </button>
                    <% if (searchWord != null && !searchWord.trim().isEmpty()) { %>
                    <a href="courses.jsp" class="btn-reset">
                        <i class="bi bi-x-lg"></i>
                    </a>
                    <% } %>
                </form>
            </div>

            <!-- Sağ — Stat kartları -->
            <div class="col-lg-6" data-aos="fade-left" data-aos-delay="100">
                <div class="cr-stat-grid">

                    <div class="cr-stat-box">
                        <div class="cr-stat-icon-box" style="background:rgba(79,70,229,.25);">
                            <i class="bi bi-journal-bookmark-fill" style="color:#a5b4fc;"></i>
                        </div>
                        <div>
                            <div class="cr-stat-val"><%= totalCourses %></div>
                            <div class="cr-stat-lbl">Cəmi Kurs</div>
                        </div>
                    </div>

                    <div class="cr-stat-box">
                        <div class="cr-stat-icon-box" style="background:rgba(16,185,129,.20);">
                            <i class="bi bi-people-fill" style="color:#6ee7b7;"></i>
                        </div>
                        <div>
                            <div class="cr-stat-val"><%= totalCourses * 50 %></div>
                            <div class="cr-stat-lbl">Aktiv Tələbə</div>
                        </div>
                    </div>

                    <div class="cr-stat-box">
                        <div class="cr-stat-icon-box" style="background:rgba(245,158,11,.20);">
                            <i class="bi bi-star-fill" style="color:#fcd34d;"></i>
                        </div>
                        <div>
                            <div class="cr-stat-val">4.8</div>
                            <div class="cr-stat-lbl">Ortalama Reytinq</div>
                        </div>
                    </div>

                    <div class="cr-stat-box">
                        <div class="cr-stat-icon-box" style="background:rgba(56,189,248,.20);">
                            <i class="bi bi-person-workspace" style="color:#7dd3fc;"></i>
                        </div>
                        <div>
                            <div class="cr-stat-val"><%= teachers.size() > 0 ? teachers.size() : 4 %></div>
                            <div class="cr-stat-lbl">Aktiv Müəllim</div>
                        </div>
                    </div>

                </div>
            </div>

        </div>
    </div>
</div>

<!-- ══════════════════════════════════════════════
     ANA MƏZMUN
══════════════════════════════════════════════ -->
<div class="cr-main">
    <div class="container">

        <!-- Toolbar -->
        <div class="cr-toolbar" data-aos="fade-down">
            <div class="cr-filter-group">
                <button class="cr-filter-btn active" data-filter="all">
                    <i class="bi bi-grid-3x3-gap-fill me-1"></i>Hamısı
                </button>
                <button class="cr-filter-btn" data-filter="active">
                    <i class="bi bi-circle-fill me-1" style="font-size:7px;color:#10b981;"></i>Aktiv
                </button>
                <button class="cr-filter-btn" data-filter="prog">
                    <i class="bi bi-code-slash me-1"></i>Proqramlaşdırma
                </button>
                <button class="cr-filter-btn" data-filter="design">
                    <i class="bi bi-brush me-1"></i>Dizayn
                </button>
            </div>
            <div class="cr-toolbar-right">
                <span class="cr-count-badge" id="crCountBadge">
                    <i class="bi bi-journal-bookmark-fill"></i>
                    <span id="crCount"><%= totalCourses %></span> kurs
                </span>
                <button class="cr-tool-btn d-none d-md-flex"
                        onclick="exportTableCSV('#crHiddenTable','kurslar.csv')">
                    <i class="bi bi-download"></i> CSV
                </button>
                <button class="cr-tool-btn d-none d-md-flex"
                        onclick="printTable('#crHiddenTable','Kurs Siyahısı')">
                    <i class="bi bi-printer"></i>
                </button>
                <button class="cr-add-btn"
                        data-bs-toggle="modal" data-bs-target="#addCourseModal">
                    <i class="bi bi-plus-circle-fill"></i> Yeni Kurs
                </button>
            </div>
        </div>

        <!-- Reklam -->
        <jsp:include page="ads-infeed.jsp"/>

        <!-- ── KURS KARTLARI GRİD ── -->
        <div class="row g-4" id="crGrid">

            <%
                    for(Course course: courses) {

                    /* Axtarış filteri */
                    if (searchWord != null && !searchWord.trim().isEmpty()) {
                        if (!course.getCourseTitle().toLowerCase().contains(searchWord.toLowerCase()) &&
                            !course.getCourseDescription().toLowerCase().contains(searchWord.toLowerCase())) {
                            continue;
                        }
                    }

                    String shortDesc = course.getCourseDescription().length() > 75
                        ? course.getCourseDescription().substring(0, 75) + "..."
                        : course.getCourseDescription();
            %>
            <div class="col-12 col-sm-6 col-xl-4 cr-col"
                 data-category="<%= course.getStatus() %>"
                 data-name="<%= course.getCourseTitle().toLowerCase() %>">

                <div class="cr-card">

                    <!-- Gradient yuxarı hissə -->
                    <div class="cr-card-top"
                         style="background: linear-gradient(140deg, <%= course.getCardColorFrom() %> 0%, <%= course.getCardColorTo() %> 100%);">
                        <div class="cr-card-deco1"></div>
                        <div class="cr-card-deco2"></div>
                        <div class="cr-card-deco3"></div>
                        <i class="bi <%= course.getCourseIcon() %> cr-card-icon"></i>
                        <span class="cr-card-id-tag">#<%= course.getId() %></span>
                        <span class="cr-card-status-tag">
                            <i class="bi bi-circle-fill me-1" style="font-size:6px;"></i><%= course.getStatus() %>
                        </span>
                    </div>

                    <!-- Kart gövdəsi -->
                    <div class="cr-card-body">

                        <h5 class="cr-card-title"
                            style="cursor:pointer;"
                            onclick="window.location.href='course-page.jsp?id=<%= course.getId() %>'"
                            title="Kursa bax">
                            <%= course.getCourseTitle() %>
                        </h5>
                        <p class="cr-card-desc"><%= course.getCourseDescription() %></p>

                        <!-- Rating -->
                        <div class="cr-rating">
                            <i class="bi bi-star-fill cr-star"></i>
                            <i class="bi bi-star-fill cr-star"></i>
                            <i class="bi bi-star-fill cr-star"></i>
                            <i class="bi bi-star-fill cr-star"></i>
                            <i class="bi bi-star-half cr-star"></i>
                            <span class="cr-rating-val">4.8</span>
                        </div>

                        <!-- Meta chipləri -->
                        <div class="cr-meta">
                            <span class="cr-meta-chip">
                                <i class="bi bi-person-fill"></i>
                                <%= teacher.getName() + teacher.getSurname() %>
                            </span>
                            <span class="cr-meta-chip">
                                <i class="bi bi-people-fill"></i>
<%--                                <%= cStudents[i] %> tələbə--%>
                                85 tələbə
                            </span>
                            <span class="cr-meta-chip">
                                <i class="bi bi-clock-fill"></i>
<%--                                <%= cHours[i] %> saat--%>
                                42 saat
                            </span>
                        </div>

                    </div>

                    <!-- Kart footer -->
                    <div class="cr-card-footer">
                        <button class="cr-btn cr-btn-view" title="Görüntülə"
                                onclick="window.location.href='course-page.jsp?id=<%= course.getId() %>'">
                            <i class="bi bi-eye-fill"></i> Bax
                        </button>
                        <button class="cr-btn cr-btn-edit"
                                title="Redaktə et"
                                data-bs-toggle="modal"
                                data-bs-target="#editCourseModal"
                                data-id="<%= course.getId() %>"
                                data-name="<%= course.getCourseTitle() %>"
                                data-description="<%= course.getCourseDescription() %>"
                                data-teacherid="">
                            <i class="bi bi-pencil-square"></i> Düzəlt
                        </button>
                        <button class="cr-btn cr-btn-del"
                                title="Sil"
                                data-bs-toggle="modal"
                                data-bs-target="#deleteCourseModal"
                                data-id="<%= course.getId() %>"
                                data-name="<%= course.getCourseTitle() %>">
                            <i class="bi bi-trash3-fill"></i>
                        </button>
                    </div>

                </div>
            </div>
            <% } %>

        </div><!-- /crGrid -->

        <!-- Boş vəziyyət (filter nəticəsi boş olarsa) -->
        <div class="cr-empty-state" id="crFilterEmpty">
            <div class="cr-empty-icon"><i class="bi bi-funnel"></i></div>
            <div class="cr-empty-title">Bu filtrdə kurs yoxdur</div>
            <p class="cr-empty-sub">Başqa filtri sınayın.</p>
        </div>

    </div>
</div>

<!-- Gizli cədvəl — CSV/Print üçün -->
<table id="crHiddenTable" style="display:none">
    <thead>
        <tr><th>ID</th><th>Kurs Adı</th><th>Təsvir</th><th>Müəllim</th><th>Tələbə</th><th>Status</th></tr>
    </thead>
    <tbody>
    <% for (Course course : courses) { %>
    <tr>
        <td><%= course.getId() %></td>
        <td><%= course.getCourseTitle() %></td>
        <td><%= course.getCourseDescription() %></td>
        <td><%= teacher.getName() + teacher.getSurname() %></td>
        <td>85</td>
        <td><%= course.getStatus() %></td>
    </tr>
    <% } %>
    </tbody>
</table>

<!-- ══════════════════════════════════════════════
     MODAL: Yeni Kurs
══════════════════════════════════════════════ -->
<div class="modal fade" id="addCourseModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-4">
            <div class="modal-header border-0 px-4 pt-4 pb-2">
                <div class="d-flex align-items-center gap-2">
                    <div class="modal-icon-box"
                         style="background:linear-gradient(135deg,#4f46e5,#7c3aed);color:#fff;border-radius:12px;width:40px;height:40px;display:flex;align-items:center;justify-content:center;font-size:1.1rem;">
                        <i class="bi bi-journal-plus"></i>
                    </div>
                    <h5 class="modal-title fw-bold mb-0">Yeni Kurs Əlavə Et</h5>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body px-4 pb-4">
                <form action="courses.jsp" method="POST">
                    <input type="hidden" name="action" value="create">
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-muted">Kurs Adı</label>
                        <input type="text" name="name" class="form-control rounded-3"
                               placeholder="Məs: Java Proqramlaşdırma" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-muted">Təsvir</label>
                        <textarea name="description" class="form-control rounded-3" rows="3"
                                  placeholder="Kurs haqqında qısa məlumat..." required></textarea>
                    </div>
                    <div class="mb-4">
                        <label class="form-label small fw-semibold text-muted">Müəllim</label>
                        <select name="teacherName" class="form-select rounded-3">
                            <option value="">— Müəllim seçin —</option>
                            <% if (teachers != null && !teachers.isEmpty()) {
                               for (Teacher t : teachers) { %>
                            <option value="<%= t.getId() %>"><%= t.getName() %> <%= t.getSurname() %></option>
                            <% } } else { %>
                            <option value="1">Əli Əliyev</option>
                            <option value="2">Nigar Hüseynova</option>
                            <option value="3">Rauf Məmmədov</option>
                            <option value="4">Sevinc Quliyeva</option>
                            <% } %>
                        </select>
                    </div>
                    <button type="button"
                            class="btn w-100 rounded-3 py-2 fw-semibold text-white"
                            data-bs-dismiss="modal"
                            style="background:linear-gradient(135deg,#4f46e5,#7c3aed);border:none;">
                        <i class="bi bi-check2-circle me-2"></i>Yadda Saxla
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- ══════════════════════════════════════════════
     MODAL: Kurs Redaktə
══════════════════════════════════════════════ -->
<div class="modal fade" id="editCourseModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-4">
            <div class="modal-header border-0 px-4 pt-4 pb-2">
                <div class="d-flex align-items-center gap-2">
                    <div class="modal-icon-box"
                         style="background:linear-gradient(135deg,#d97706,#f59e0b);color:#fff;border-radius:12px;width:40px;height:40px;display:flex;align-items:center;justify-content:center;font-size:1.1rem;">
                        <i class="bi bi-pencil-square"></i>
                    </div>
                    <h5 class="modal-title fw-bold mb-0">Kursu Redaktə Et</h5>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body px-4 pb-4">
                <form>
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-muted">ID (dəyişdirilmir)</label>
                        <input type="text" id="edit-course-id-display"
                               class="form-control rounded-3 bg-light text-muted" disabled>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-muted">Kurs Adı</label>
                        <input type="text" id="edit-course-name" class="form-control rounded-3">
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-muted">Təsvir</label>
                        <textarea id="edit-course-description" class="form-control rounded-3" rows="3"></textarea>
                    </div>
                    <button type="button"
                            class="btn btn-warning w-100 rounded-3 py-2 fw-semibold text-white"
                            data-bs-dismiss="modal">
                        <i class="bi bi-arrow-repeat me-2"></i>Yenilə
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- ══════════════════════════════════════════════
     MODAL: Kurs Sil
══════════════════════════════════════════════ -->
<div class="modal fade" id="deleteCourseModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-sm">
        <div class="modal-content border-0 shadow-lg rounded-4">
            <div class="modal-body p-4 text-center">
                <div style="width:64px;height:64px;border-radius:20px;background:#fee2e2;display:flex;align-items:center;justify-content:center;font-size:1.7rem;color:#dc2626;margin:0 auto 16px;">
                    <i class="bi bi-trash3-fill"></i>
                </div>
                <h5 class="fw-bold mb-2">Kursu Sil</h5>
                <p class="text-muted mb-4 small">
                    <strong class="text-dark" id="delete-course-name"></strong>
                    kursunu silmək istədiyinizə əminsiniz?
                </p>
                <div class="d-flex gap-2">
                    <button type="button" class="btn btn-light w-100 rounded-3 py-2"
                            data-bs-dismiss="modal">Ləğv Et</button>
                    <button type="button" class="btn btn-danger w-100 rounded-3 py-2 fw-semibold"
                            data-bs-dismiss="modal">
                        <i class="bi bi-trash3 me-1"></i>Sil
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script src="js/script.js?v=3.0"></script>
<script src="js/ads.js?v=4.0"></script>
<script>
    /* AOS */
    AOS.init({ duration: 700, once: true, offset: 60 });

    /* ── Kart Filter ──────────────────────────────────────────── */
    (function () {
        var filterBtns = document.querySelectorAll('.cr-filter-btn');
        var cols       = document.querySelectorAll('#crGrid .cr-col');
        var countEl    = document.getElementById('crCount');
        var emptyEl    = document.getElementById('crFilterEmpty');

        filterBtns.forEach(function (btn) {
            btn.addEventListener('click', function () {
                filterBtns.forEach(function (b) { b.classList.remove('active'); });
                btn.classList.add('active');

                var filter  = btn.getAttribute('data-filter');
                var visible = 0;

                cols.forEach(function (col) {
                    var cat  = col.getAttribute('data-category') || '';
                    var show = (filter === 'all') || cat.includes(filter);
                    col.style.display = show ? '' : 'none';
                    if (show) visible++;
                });

                if (countEl) countEl.textContent = visible;
                if (emptyEl) emptyEl.classList.toggle('show', visible === 0);
            });
        });
    })();

    /* ── Redaktə modalı ─────────────────────────────────────── */
    var editModal = document.getElementById('editCourseModal');
    if (editModal) {
        editModal.addEventListener('show.bs.modal', function (e) {
            var btn = e.relatedTarget;
            document.getElementById('edit-course-id-display').value  = btn.dataset.id;
            document.getElementById('edit-course-name').value         = btn.dataset.name;
            document.getElementById('edit-course-description').value  = btn.dataset.description;
        });
    }

    /* ── Silmə modalı ───────────────────────────────────────── */
    var deleteModal = document.getElementById('deleteCourseModal');
    if (deleteModal) {
        deleteModal.addEventListener('show.bs.modal', function (e) {
            var btn = e.relatedTarget;
            document.getElementById('delete-course-name').textContent = btn.dataset.name;
        });
    }
</script>
</body>
</html>
