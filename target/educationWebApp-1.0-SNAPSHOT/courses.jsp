<%@ page import="com.sukur.educationwebapp.course.service.CourseService" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sukur.educationwebapp.course.entity.Course" %>
<%@ page import="com.sukur.educationwebapp.teacher.service.TeacherService" %>
<%@ page import="com.sukur.educationwebapp.teacher.entity.Teacher" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    CourseService courseService = new CourseService();
    TeacherService teacherService = new TeacherService();
    String searchWord = request.getParameter("search");
    List<Course> courses;
    if (searchWord != null && !searchWord.trim().isEmpty()) {
        courses = courseService.search(searchWord.trim());
    } else {
        courses = courseService.findAll();
    }
    List<Teacher> teachers = teacherService.findAll();
    int totalCourses = courses.size();
%>
<!DOCTYPE html>
<html lang="az">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kurslar - Education App</title>
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
        <div class="loader-subtext">Kurs paneli yüklənir...</div>
    </div>
</div>


<jsp:include page="header.jsp"/>

<section class="py-5 courses-section min-vh-100">
    <div class="container py-4">

        <!-- ===== BAŞLIQ ===== -->
        <div class="row mb-5 align-items-center" data-aos="fade-down">
            <div class="col-lg-8">
                <div class="d-flex align-items-center gap-3 mb-2">
                    <div class="page-icon-box bg-success text-white">
                        <i class="bi bi-journal-bookmark-fill"></i>
                    </div>
                    <div>
                        <h1 class="fw-bold mb-0 page-title">Kurs Paneli</h1>
                        <p class="text-muted mb-0 mt-1">Kursların idarə edilməsi və təşkili</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 text-lg-end mt-4 mt-lg-0">
                <button class="btn btn-success btn-add-new px-4 py-2 shadow text-white"
                        data-bs-toggle="modal" data-bs-target="#addCourseModal">
                    <i class="bi bi-plus-circle-fill me-2"></i>Yeni Kurs
                </button>
            </div>
        </div>

        <!-- ===== STATİSTİKA KARTLARI ===== -->
        <div class="row g-4 mb-5">
            <div class="col-sm-6 col-xl-3" data-aos="fade-up" data-aos-delay="0">
                <div class="stat-card-modern success-card">
                    <div class="stat-icon-wrap">
                        <i class="bi bi-journal-bookmark-fill"></i>
                    </div>
                    <div class="stat-info">
                        <span class="stat-label">Cəmi Kurs</span>
                        <span class="stat-value"><%= totalCourses %></span>
                    </div>
                    <div class="stat-bg-icon"><i class="bi bi-journal-bookmark-fill"></i></div>
                </div>
            </div>
            <div class="col-sm-6 col-xl-3" data-aos="fade-up" data-aos-delay="100">
                <div class="stat-card-modern primary-card">
                    <div class="stat-icon-wrap">
                        <i class="bi bi-people-fill"></i>
                    </div>
                    <div class="stat-info">
                        <span class="stat-label">Aktiv Tələbə</span>
                        <span class="stat-value"><%= totalCourses * 50 %></span>
                    </div>
                    <div class="stat-bg-icon"><i class="bi bi-people-fill"></i></div>
                </div>
            </div>
            <div class="col-sm-6 col-xl-3" data-aos="fade-up" data-aos-delay="200">
                <div class="stat-card-modern warning-card">
                    <div class="stat-icon-wrap">
                        <i class="bi bi-star-fill"></i>
                    </div>
                    <div class="stat-info">
                        <span class="stat-label">Ortalama Reytinq</span>
                        <span class="stat-value">4.8 / 5</span>
                    </div>
                    <div class="stat-bg-icon"><i class="bi bi-star-fill"></i></div>
                </div>
            </div>
            <div class="col-sm-6 col-xl-3" data-aos="fade-up" data-aos-delay="300">
                <div class="stat-card-modern info-card">
                    <div class="stat-icon-wrap">
                        <i class="bi bi-person-workspace"></i>
                    </div>
                    <div class="stat-info">
                        <span class="stat-label">Aktiv Müəllim</span>
                        <span class="stat-value"><%= teachers.size() %></span>
                    </div>
                    <div class="stat-bg-icon"><i class="bi bi-person-workspace"></i></div>
                </div>
            </div>
        </div>

        <!-- ===== CƏDVƏL KARTI ===== -->
        <div class="card custom-table-card border-0" data-aos="fade-up" data-aos-delay="100">

            <!-- Kart Başlığı -->
            <div class="card-header border-0 p-4 bg-white">
                <div class="row align-items-center g-3">
                    <div class="col-md-5">
                        <h5 class="fw-bold mb-0 text-dark d-flex align-items-center gap-2">
                            <i class="bi bi-table text-success"></i> Kurs Siyahısı
                            <span class="badge bg-success-subtle text-success ms-1 rounded-pill" style="font-size:0.75rem;">
                                <%= totalCourses %> kurs
                            </span>
                        </h5>
                    </div>
                    <div class="col-md-7">
                        <div class="d-flex gap-2 flex-wrap">
                            <form action="courses.jsp" method="get" class="d-flex gap-2 flex-grow-1">
                                <div class="input-group search-group flex-grow-1">
                                    <span class="input-group-text bg-white border-end-0 rounded-start-pill ps-3">
                                        <i class="bi bi-search text-muted"></i>
                                    </span>
                                    <input type="text" name="search"
                                           value="<%= searchWord != null ? searchWord : "" %>"
                                           class="form-control border-start-0 border-end-0 py-2"
                                           placeholder="Kurs adı ilə axtar...">
                                    <button type="submit" class="btn btn-success rounded-end-pill px-4 text-white">Axtar</button>
                                </div>
                                <% if (searchWord != null && !searchWord.trim().isEmpty()) { %>
                                <a href="courses.jsp" class="btn btn-outline-secondary rounded-pill px-3" title="Sıfırla">
                                    <i class="bi bi-x-lg"></i>
                                </a>
                                <% } %>
                            </form>
                            <div class="table-toolbar d-none d-md-flex">
                                <button class="btn-toolbar-action" onclick="exportTableCSV('#courseTable','kurslar.csv')"><i class="bi bi-download"></i> CSV</button>
                                <button class="btn-toolbar-action" onclick="printTable('#courseTable','Kurs Siyahısı')"><i class="bi bi-printer"></i></button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Cədvəl -->
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0" id="courseTable">
                    <thead>
                    <tr>
                        <th class="ps-4" style="width:70px;">ID</th>
                        <th>Kurs Adı</th>
                        <th>Təsvir</th>
                        <th class="text-center">Müəllim</th>
                        <th class="text-center">Status</th>
                        <th class="text-center" style="width:140px;">İdarə Et</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        if (courses.isEmpty()) {
                    %>
                    <tr>
                        <td colspan="6" class="text-center py-5">
                            <div class="empty-state">
                                <i class="bi bi-journal-x display-4 text-muted d-block mb-3"></i>
                                <p class="text-muted mb-0">
                                    <% if (searchWord != null && !searchWord.trim().isEmpty()) { %>
                                    "<strong><%= searchWord %></strong>" üzrə kurs tapılmadı.
                                    <% } else { %>
                                    Hələ heç bir kurs əlavə edilməyib.
                                    <% } %>
                                </p>
                            </div>
                        </td>
                    </tr>
                    <%
                        } else {
                            for (Course course : courses) {
                                // Müəllim adını tap
                                String teacherName = "Naməlum";
                                for (Teacher t : teachers) {
                                    if (t.getId() == course.getTeacherId()) {
                                        teacherName = t.getName() + " " + t.getSurname();
                                        break;
                                    }
                                }
                                // Kurs adının baş hərfini al (avatar üçün)
                                String courseInitial = course.getName().substring(0, 1).toUpperCase();
                    %>
                    <tr class="stagger-item">
                        <td class="ps-4">
                            <span class="id-badge"><%= course.getId() %></span>
                        </td>
                        <td>
                            <div class="d-flex align-items-center gap-3">
                                <div class="course-avatar-circle flex-shrink-0"><%= courseInitial %></div>
                                <div>
                                    <div class="fw-semibold text-dark lh-sm"><%= course.getName() %></div>
                                    <small class="text-muted d-none d-md-block">
                                        <i class="bi bi-tag me-1"></i>Proqramlaşdırma
                                    </small>
                                </div>
                            </div>
                        </td>
                        <td>
                            <span class="course-desc-text text-muted">
                                <%= course.getDescription() != null && course.getDescription().length() > 50
                                    ? course.getDescription().substring(0, 50) + "..."
                                    : course.getDescription() %>
                            </span>
                        </td>
                        <td class="text-center">
                            <span class="badge rounded-pill px-3 py-2 teacher-badge">
                                <i class="bi bi-person-fill me-1"></i><%= teacherName %>
                            </span>
                        </td>
                        <td class="text-center">
                            <span class="badge badge-soft-success rounded-pill px-3 py-2">
                                <i class="bi bi-circle-fill me-1" style="font-size:6px;"></i>Aktiv
                            </span>
                        </td>
                        <td class="text-center">
                            <div class="d-flex justify-content-center gap-2">
                                <button class="btn btn-action btn-view shadow-sm" title="Görüntülə">
                                    <i class="bi bi-eye"></i>
                                </button>
                                <button class="btn btn-action btn-edit shadow-sm"
                                        title="Redaktə et"
                                        data-bs-toggle="modal"
                                        data-bs-target="#editCourseModal"
                                        data-id="<%= course.getId() %>"
                                        data-name="<%= course.getName() %>"
                                        data-description="<%= course.getDescription() %>"
                                        data-teacherid="<%= course.getTeacherId() %>">
                                    <i class="bi bi-pencil-square"></i>
                                </button>
                                <button class="btn btn-action btn-delete shadow-sm"
                                        title="Sil"
                                        data-bs-toggle="modal"
                                        data-bs-target="#deleteCourseModal"
                                        data-id="<%= course.getId() %>"
                                        data-name="<%= course.getName() %>">
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
                <nav aria-label="Kurs səhifələməsi">
                    <ul class="pagination pagination-sm justify-content-center mb-0" id="pagination-course">
                        <li class="page-item">
                            <a class="page-link rounded-circle me-1 border-0 bg-light" href="#" id="prev-course">
                                <i class="bi bi-chevron-left"></i>
                            </a>
                        </li>
                        <li class="page-item">
                            <a class="page-link rounded-circle border-0 bg-light" href="#" id="next-course">
                                <i class="bi bi-chevron-right"></i>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</section>

<!-- ===== MODAL: Yeni Kurs ===== -->
<div class="modal fade" id="addCourseModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-4">
            <div class="modal-header border-0 px-4 pt-4 pb-2">
                <div class="d-flex align-items-center gap-2">
                    <div class="modal-icon-box bg-success text-white">
                        <i class="bi bi-journal-plus"></i>
                    </div>
                    <h5 class="modal-title fw-bold mb-0">Yeni Kurs Əlavə Et</h5>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body px-4 pb-4">
                <form action="course" method="POST">
                    <input type="hidden" name="action" value="create">
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-muted">Kurs Adı</label>
                        <input type="text" name="name" class="form-control rounded-3 px-3"
                               placeholder="Məs: Java Proqramlaşdırma" required>
                        <div class="invalid-feedback"></div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-muted">Təsvir</label>
                        <textarea name="description" class="form-control rounded-3 px-3" rows="3"
                                  placeholder="Kurs haqqında qısa məlumat..." required></textarea>
                        <div class="invalid-feedback"></div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-muted">Müəllim</label>
                        <select name="teacherId" class="form-select rounded-3 px-3" required>
                            <option value="">— Müəllim seçin —</option>
                            <% for (Teacher t : teachers) { %>
                            <option value="<%= t.getId() %>"><%= t.getName() %> <%= t.getSurname() %></option>
                            <% } %>
                        </select>
                        <div class="invalid-feedback"></div>
                    </div>
                    <button type="submit" class="btn btn-success w-100 rounded-3 py-2 mt-2 fw-semibold text-white">
                        <i class="bi bi-check2-circle me-2"></i>Yadda Saxla
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- ===== MODAL: Kurs Redaktə ===== -->
<div class="modal fade" id="editCourseModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-4">
            <div class="modal-header border-0 px-4 pt-4 pb-2">
                <div class="d-flex align-items-center gap-2">
                    <div class="modal-icon-box bg-warning text-white">
                        <i class="bi bi-pencil-square"></i>
                    </div>
                    <h5 class="modal-title fw-bold mb-0">Kursu Redaktə Et</h5>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body px-4 pb-4">
                <form action="course" method="POST">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" id="edit-course-id-hidden">
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-muted">ID (dəyişdirilmir)</label>
                        <input type="text" id="edit-course-id-display"
                               class="form-control rounded-3 px-3 bg-light text-muted" disabled>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-muted">Kurs Adı</label>
                        <input type="text" name="name" id="edit-course-name"
                               class="form-control rounded-3 px-3" required>
                        <div class="invalid-feedback"></div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-muted">Təsvir</label>
                        <textarea name="description" id="edit-course-description"
                                  class="form-control rounded-3 px-3" rows="3" required></textarea>
                        <div class="invalid-feedback"></div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-muted">Müəllim</label>
                        <select name="teacherId" id="edit-course-teacherId" class="form-select rounded-3 px-3" required>
                            <% for (Teacher t : teachers) { %>
                            <option value="<%= t.getId() %>"><%= t.getName() %> <%= t.getSurname() %></option>
                            <% } %>
                        </select>
                        <div class="invalid-feedback"></div>
                    </div>
                    <button type="submit" class="btn btn-warning w-100 rounded-3 py-2 mt-2 fw-semibold text-white">
                        <i class="bi bi-arrow-repeat me-2"></i>Yenilə
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- ===== MODAL: Kurs Sil ===== -->
<div class="modal fade" id="deleteCourseModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-sm">
        <div class="modal-content border-0 shadow-lg rounded-4">
            <div class="modal-body p-4 text-center">
                <div class="delete-icon-wrap mb-3">
                    <i class="bi bi-trash3-fill text-danger"></i>
                </div>
                <h5 class="fw-bold mb-2">Kursu Sil</h5>
                <p class="text-muted mb-4">
                    <span class="fw-semibold text-dark" id="delete-course-name"></span>
                    kursunu silmək istədiyinizə əminsiniz?
                </p>
                <form action="course" method="POST">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" id="delete-course-id">
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script src="js/script.js?v=3.0"></script>
<script>
    AOS.init({ duration: 800, once: true, offset: 80 });
    setupPagination('#courseTable', 'pagination-course', 8);

    // Kurs redaktə modalı üçün məlumat doldurma
    const editCourseModal = document.getElementById('editCourseModal');
    if (editCourseModal) {
        editCourseModal.addEventListener('show.bs.modal', function(event) {
            const btn = event.relatedTarget;
            document.getElementById('edit-course-id-hidden').value  = btn.dataset.id;
            document.getElementById('edit-course-id-display').value = btn.dataset.id;
            document.getElementById('edit-course-name').value        = btn.dataset.name;
            document.getElementById('edit-course-description').value = btn.dataset.description;
            document.getElementById('edit-course-teacherId').value   = btn.dataset.teacherid;
        });
    }

    // Kurs silmə modalı üçün məlumat doldurma
    const deleteCourseModal = document.getElementById('deleteCourseModal');
    if (deleteCourseModal) {
        deleteCourseModal.addEventListener('show.bs.modal', function(event) {
            const btn = event.relatedTarget;
            document.getElementById('delete-course-id').value           = btn.dataset.id;
            document.getElementById('delete-course-name').textContent   = btn.dataset.name;
        });
    }
</script>
</body>
</html>
