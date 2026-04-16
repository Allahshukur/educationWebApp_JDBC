<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sukur.educationwebapp.teacher.service.TeacherService" %>
<%@ page import="com.sukur.educationwebapp.teacher.entity.Teacher" %>
<%@ page import="java.util.List" %>
<%
    TeacherService teacherService = new TeacherService();
    String action = request.getParameter("action");
    String msg = "", msgType = "";

    if ("POST".equals(request.getMethod())) {
        if ("delete".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                teacherService.delete(id);
                msg = "Müəllim uğurla silindi.";
                msgType = "success";
                response.sendRedirect("teachers.jsp");
            } catch (Exception e) {
                msg = "Xəta: " + e.getMessage();
                msgType = "danger";
            }
        } else if ("update".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                teacherService.update(id, request.getParameter("name"), request.getParameter("surname"),
                        request.getParameter("email"), Integer.parseInt(request.getParameter("age")));
                msg = "Müəllim məlumatları yeniləndi.";
                msgType = "success";
                response.sendRedirect("teachers.jsp");
            } catch (Exception e) {
                msg = "Xəta: " + e.getMessage();
                msgType = "danger";
            }
        } else if ("create".equals(action)) {
            try {
                teacherService.create(request.getParameter("name"), request.getParameter("surname"),
                        request.getParameter("email"), Integer.parseInt(request.getParameter("age")));
                msg = "Yeni müəllim əlavə edildi.";
                msgType = "success";
                response.sendRedirect("teachers.jsp");
            } catch (Exception e) {
                msg = "Xəta: " + e.getMessage();
                msgType = "danger";
            }
        }
    }

    String q = request.getParameter("q");
    List<Teacher> teachers = (q != null && !q.trim().isEmpty()) ? teacherService.search(q.trim()) : teacherService.findAll();
    int total = teachers != null ? teachers.size() : 0;
%>
<!DOCTYPE html>
<html lang="az">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Müəllimlər — Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="css/admin.css" rel="stylesheet">
</head>
<body class="adm-body">

<jsp:include page="admin-sidebar.jsp"/>

<!-- DELETE MODAL -->
<div class="adm-modal" id="modalDelete">
    <div class="adm-modal-box" style="max-width:430px;">
        <div class="adm-modal-header" style="color:#ef4444;">
            <i class="bi bi-exclamation-triangle-fill"></i> Silmə Təsdiqi
        </div>
        <div class="adm-modal-body">
            <p class="mb-1">Aşağıdakı müəllimi silmək istəyirsiniz?</p>
            <p class="fw-700" id="delName" style="font-size:1rem;color:var(--text);"></p>
            <p class="adm-text-muted" style="font-size:.82rem;">Bu əməliyyat geri qaytarıla bilməz.</p>
        </div>
        <div class="adm-modal-footer">
            <form method="post">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="id" id="delId">
                <button type="submit" class="adm-btn adm-btn-danger"><i class="bi bi-trash3-fill"></i> Bəli, sil
                </button>
                <button type="button" class="adm-btn adm-btn-outline" onclick="admModal.closeAll()">Ləğv et</button>
            </form>
        </div>
    </div>
</div>

<!-- EDIT MODAL -->
<div class="adm-modal" id="modalEdit">
    <div class="adm-modal-box" style="max-width:500px;">
        <div class="adm-modal-header"><i class="bi bi-pencil-square"></i> Müəllimi Düzəlt</div>
        <form method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" id="editId">
            <div class="adm-modal-body">
                <div class="row g-3">
                    <div class="col-6"><label class="adm-form-label">Ad</label><input type="text" name="name"
                                                                                      id="editName"
                                                                                      class="adm-form-control" required>
                    </div>
                    <div class="col-6"><label class="adm-form-label">Soyad</label><input type="text" name="surname"
                                                                                         id="editSurname"
                                                                                         class="adm-form-control"
                                                                                         required></div>
                    <div class="col-8"><label class="adm-form-label">Email</label><input type="email" name="email"
                                                                                         id="editEmail"
                                                                                         class="adm-form-control"
                                                                                         required></div>
                    <div class="col-4"><label class="adm-form-label">Yaş</label><input type="number" name="age"
                                                                                       id="editAge"
                                                                                       class="adm-form-control" min="22"
                                                                                       max="80" required></div>
                </div>
            </div>
            <div class="adm-modal-footer">
                <button type="submit" class="adm-btn adm-btn-primary"><i class="bi bi-check-lg"></i> Yadda saxla
                </button>
                <button type="button" class="adm-btn adm-btn-outline" onclick="admModal.closeAll()">Ləğv et</button>
            </div>
        </form>
    </div>
</div>

<!-- ADD MODAL -->
<div class="adm-modal" id="modalAdd">
    <div class="adm-modal-box" style="max-width:500px;">
        <div class="adm-modal-header"><i class="bi bi-person-plus-fill"></i> Yeni Müəllim Əlavə Et</div>
        <form method="post">
            <input type="hidden" name="action" value="create">
            <div class="adm-modal-body">
                <div class="row g-3">
                    <div class="col-6"><label class="adm-form-label">Ad</label><input type="text" name="name"
                                                                                      class="adm-form-control" required
                                                                                      placeholder="Ad"></div>
                    <div class="col-6"><label class="adm-form-label">Soyad</label><input type="text" name="surname"
                                                                                         class="adm-form-control"
                                                                                         required placeholder="Soyad">
                    </div>
                    <div class="col-8"><label class="adm-form-label">Email</label><input type="email" name="email"
                                                                                         class="adm-form-control"
                                                                                         required
                                                                                         placeholder="email@example.com">
                    </div>
                    <div class="col-4"><label class="adm-form-label">Yaş</label><input type="number" name="age"
                                                                                       class="adm-form-control" required
                                                                                       placeholder="30" min="22"
                                                                                       max="80"></div>
                </div>
            </div>
            <div class="adm-modal-footer">
                <button type="submit" class="adm-btn adm-btn-primary"><i class="bi bi-plus-circle-fill"></i> Əlavə et
                </button>
                <button type="button" class="adm-btn adm-btn-outline" onclick="admModal.closeAll()">Ləğv et</button>
            </div>
        </form>
    </div>
</div>

<!-- VIEW MODAL -->
<div class="adm-modal" id="modalView">
    <div class="adm-modal-box" style="max-width:420px;">
        <div class="adm-modal-header"><i class="bi bi-person-workspace"></i> Müəllim Məlumatları</div>
        <div class="adm-modal-body" id="viewBody"></div>
        <div class="adm-modal-footer">
            <button class="adm-btn adm-btn-outline" onclick="admModal.closeAll()">Bağla</button>
        </div>
    </div>
</div>

<!-- MAIN -->
<div class="adm-main" id="admMain">
    <header class="adm-topbar">
        <div class="adm-topbar-left">
            <button class="adm-hamburger" id="admSidebarToggle"><i class="bi bi-list"></i></button>
            <div class="adm-breadcrumb">
                <a href="index.jsp"><i class="bi bi-house-fill"></i></a>
                <i class="bi bi-chevron-right adm-text-muted" style="font-size:.6rem;"></i>
                <span class="adm-breadcrumb-cur">Müəllimlər</span>
            </div>
        </div>
        <div class="adm-topbar-right">
            <div class="adm-search-wrap">
                <i class="bi bi-search"></i>
                <input id="admSearchInput" type="text" placeholder="Cədvəldə axtar...">
            </div>
            <button class="adm-icon-btn" data-adm-dark-toggle title="Dark/Light"><i class="bi bi-moon-stars-fill"></i>
            </button>
            <div class="adm-top-avatar"><i class="bi bi-person-fill"></i></div>
        </div>
    </header>

    <div class="adm-content">

        <!-- Alert -->
        <% if (!msg.isEmpty()) { %>
        <div class="alert alert-<%= msgType %> alert-dismissible fade show rounded-3 d-flex align-items-center gap-2 mb-3">
            <i class="bi bi-<%= "success".equals(msgType) ? "check-circle-fill" : "exclamation-circle-fill" %>"></i>
            <span><%= msg %></span>
            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
        </div>
        <% } %>

        <div class="adm-page-header">
            <div>
                <h1 class="adm-page-title"><i class="bi bi-person-workspace me-2 adm-text-accent"></i>Müəllimlər</h1>
                <p class="adm-page-sub">Cəmi <strong><%= total %>
                </strong> müəllim tapıldı</p>
            </div>
            <div class="d-flex gap-2 flex-wrap">
                <form method="get" class="d-flex gap-2">
                    <div class="adm-search-wrap">
                        <i class="bi bi-search"></i>
                        <input type="text" name="q" placeholder="Müəllim axtar..." value="<%= q != null ? q : "" %>"
                               style="width:150px;">
                    </div>
                    <button type="submit" class="adm-btn adm-btn-outline"><i class="bi bi-search"></i></button>
                    <% if (q != null && !q.isEmpty()) { %><a href="teachers.jsp" class="adm-btn adm-btn-outline"><i
                        class="bi bi-x-lg"></i></a><% } %>
                </form>
            </div>
        </div>

        <div class="adm-card">
            <div class="adm-card-header">
                <span class="adm-card-title"><i class="bi bi-table"></i>Müəllim Siyahısı</span>
                <span class="adm-badge adm-badge-violet ms-2"><%= total %> nəfər</span>
                <button class="adm-btn adm-btn-primary ms-auto" onclick="admModal.open('modalAdd')"
                        style="font-size:.82rem;padding:6px 14px;">
                    <i class="bi bi-person-plus-fill"></i> Yeni Müəllim
                </button>
            </div>
            <div class="adm-table-wrap">
                <table class="adm-table" id="tblTeachers">
                    <thead>
                    <tr>
                        <th data-sort>#</th>
                        <th data-sort>Ad Soyad</th>
                        <th data-sort>Email</th>
                        <th data-sort>Yaş</th>
                        <th>Tələbələr</th>
                        <th>Status</th>
                        <th style="text-align:center;">Əməliyyat</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% if (teachers == null || teachers.isEmpty()) { %>
                    <tr>
                        <td colspan="7" class="text-center adm-text-muted py-5">
                            <i class="bi bi-inbox display-5 d-block mb-2 opacity-25"></i>Müəllim tapılmadı
                        </td>
                    </tr>
                    <% } else {
                        for (Teacher t : teachers) {
                            boolean del = t.getDeleted() != null && t.getDeleted();
                            String ini = (t.getName() != null && !t.getName().isEmpty()) ? String.valueOf(t.getName().charAt(0)).toUpperCase() : "?";
                            String email = t.getEmail() != null ? t.getEmail() : "—";
                            String studs = t.getStudent() != null ? t.getStudent() : "—";
                    %>
                    <tr>
                        <td class="adm-text-muted fw-700" style="font-size:.80rem;"><%= t.getId() %>
                        </td>
                        <td>
                            <div class="d-flex align-items-center gap-2">
                                <div class="adm-mini-avatar"
                                     style="background:linear-gradient(135deg,#7c3aed,#4f46e5);"><%= ini %>
                                </div>
                                <a href="../teacher-page.jsp?id=<%= t.getId() %>"
                                   class="fw-700 text-decoration-none"
                                   style="color:var(--text);"
                                   onmouseover="this.style.color='var(--accent)'"
                                   onmouseout="this.style.color='var(--text)'"
                                   target="_blank">
                                    <%= t.getName() %> <%= t.getSurname() %>
                                </a>
                            </div>
                        </td>
                        <td class="adm-text-muted" style="font-size:.82rem;"><%= email %>
                        </td>
                        <td class="fw-600"><%= t.getAge() %>
                        </td>
                        <td class="adm-text-muted"
                            style="font-size:.82rem;max-width:110px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;"><%= studs %>
                        </td>
                        <td>
                            <% if (del) { %><span class="adm-badge adm-badge-red"><i class="bi bi-x-circle-fill"></i>Silindi</span>
                            <% } else { %><span class="adm-badge adm-badge-green"><i
                                class="bi bi-check-circle-fill"></i>Aktiv</span><% } %>
                        </td>
                        <td>
                            <div class="d-flex gap-1 justify-content-center">
                                <button class="adm-act-btn adm-act-view" title="Ətraflı bax"
                                        onclick="openView(<%= t.getId() %>,'<%= t.getName() %> <%= t.getSurname() %>','<%= email.replace("'","") %>',<%= t.getAge() %>,'<%= studs.replace("'","") %>','<%= del ? "Silindi" : "Aktiv" %>')">
                                    <i class="bi bi-eye-fill"></i>
                                </button>
                                <button class="adm-act-btn adm-act-edit" title="Düzəlt"
                                        onclick="openEdit(<%= t.getId() %>,'<%= t.getName() %>','<%= t.getSurname() %>','<%= email.replace("'","") %>',<%= t.getAge() %>)">
                                    <i class="bi bi-pencil-fill"></i>
                                </button>
                                <button class="adm-act-btn adm-act-del" title="Sil"
                                        onclick="openDelete(<%= t.getId() %>,'<%= t.getName() %> <%= t.getSurname() %>')">
                                    <i class="bi bi-trash3-fill"></i>
                                </button>
                            </div>
                        </td>
                    </tr>
                    <% }
                    } %>
                    </tbody>
                </table>
            </div>
            <div class="adm-pagination" id="pgTeachers"></div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/admin.js"></script>
<script>
    function openDelete(id, name) {
        document.getElementById('delId').value = id;
        document.getElementById('delName').textContent = name;
        admModal.open('modalDelete');
    }

    function openEdit(id, name, sn, email, age) {
        document.getElementById('editId').value = id;
        document.getElementById('editName').value = name;
        document.getElementById('editSurname').value = sn;
        document.getElementById('editEmail').value = email;
        document.getElementById('editAge').value = age;
        admModal.open('modalEdit');
    }

    function openView(id, name, email, age, students, status) {
        document.getElementById('viewBody').innerHTML =
            '<div class="d-flex align-items-center gap-3 mb-4">' +
            '<div style="width:56px;height:56px;border-radius:16px;background:linear-gradient(135deg,#7c3aed,#4f46e5);display:flex;align-items:center;justify-content:center;font-size:1.4rem;font-weight:800;color:#fff;">' + name.charAt(0) + '</div>' +
            '<div><div style="font-size:1.05rem;font-weight:800;color:var(--text);">' + name + '</div><div class="adm-text-muted" style="font-size:.82rem;">ID: ' + id + '</div></div></div>' +
            '<div class="row g-3">' +
            '<div class="col-6"><div class="adm-form-label">Email</div><div class="fw-700">' + email + '</div></div>' +
            '<div class="col-6"><div class="adm-form-label">Yaş</div><div class="fw-700">' + age + '</div></div>' +
            '<div class="col-12"><div class="adm-form-label">Tələbələr</div><div class="fw-700" style="word-break:break-word;">' + students + '</div></div>' +
            '<div class="col-6"><div class="adm-form-label">Status</div>' +
            (status === 'Aktiv' ? '<span class="adm-badge adm-badge-green">Aktiv</span>' : '<span class="adm-badge adm-badge-red">Silindi</span>') +
            '</div></div>';
        admModal.open('modalView');
    }

    document.addEventListener('DOMContentLoaded', function () {
        admPaginate('tblTeachers', 10);
    });
</script>
</body>
</html>
