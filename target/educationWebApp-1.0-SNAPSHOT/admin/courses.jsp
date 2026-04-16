<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String[] cNames    = {"Java Əsasları","OOP Konseptləri","Spring Framework","Verilənlər Bazası","HTML & CSS",
                          "JavaScript Əsasları","React.js","Python Proqramlaşdırma","Kibertəhlükəsizlik","DevOps & Docker"};
    String[] cTeachers = {"Əli Əliyev","Əli Əliyev","Rauf Məmmədov","Rauf Məmmədov","Nigar Hüseynova",
                          "Nigar Hüseynova","Nigar Hüseynova","Sevinc Quliyeva","Əli Əliyev","Rauf Məmmədov"};
    int[]    cStudents = {32,28,21,17,45,40,38,25,14,19};
    String[] cHours    = {"36","28","42","32","24","30","38","35","40","26"};
    String[] cLevels   = {"Başlanğıc","Başlanğıc","Orta","Orta","Başlanğıc","Başlanğıc","Orta","Orta","İrəliləmiş","İrəliləmiş"};
    String[] cStatus   = {"Aktiv","Aktiv","Aktiv","Aktiv","Aktiv","Aktiv","Aktiv","Aktiv","Planlaşdırılır","Aktiv"};
    String[] icons     = {"bi-cup-hot-fill","bi-diagram-3-fill","bi-layers-fill","bi-database-fill","bi-code-slash",
                          "bi-braces","bi-rocket-fill","bi-robot","bi-shield-lock-fill","bi-cloud-arrow-up-fill"};
    String[] iconBgs   = {"#3b82f6","#7c3aed","#0d9488","#f59e0b","#f43f5e","#f59e0b","#0ea5e9","#10b981","#dc2626","#64748b"};
    int N = cNames.length;

    int totalEnroll = 0;
    int totalHrsSum = 0;
    for (int n : cStudents) totalEnroll += n;
    for (String h : cHours) try { totalHrsSum += Integer.parseInt(h); } catch(Exception ex) {}
%>
<!DOCTYPE html>
<html lang="az">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kurslar — Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="css/admin.css" rel="stylesheet">
</head>
<body class="adm-body">

<jsp:include page="admin-sidebar.jsp"/>

<!-- COURSE DETAIL MODAL -->
<div class="adm-modal" id="modalCourse">
    <div class="adm-modal-box" style="max-width:520px;">
        <div class="adm-modal-header" id="mCHead"></div>
        <div class="adm-modal-body" id="mCBody"></div>
        <div class="adm-modal-footer">
            <a id="mCLink" href="#" target="_blank" class="adm-btn adm-btn-primary">
                <i class="bi bi-box-arrow-up-right"></i> Kurs Səhifəsi
            </a>
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
                <span class="adm-breadcrumb-cur">Kurslar</span>
            </div>
        </div>
        <div class="adm-topbar-right">
            <div class="adm-search-wrap">
                <i class="bi bi-search"></i>
                <input id="admSearchInput" type="text" placeholder="Cədvəldə axtar...">
            </div>
            <button class="adm-icon-btn" data-adm-dark-toggle title="Dark/Light"><i class="bi bi-moon-stars-fill"></i></button>
            <div class="adm-top-avatar"><i class="bi bi-person-fill"></i></div>
        </div>
    </header>

    <div class="adm-content">

        <div class="adm-page-header">
            <div>
                <h1 class="adm-page-title"><i class="bi bi-journal-bookmark-fill me-2 adm-text-accent"></i>Kurslar</h1>
                <p class="adm-page-sub">Platforma üzərindəki bütün kurslar</p>
            </div>
            <a href="../courses.jsp" class="adm-btn adm-btn-outline" target="_blank">
                <i class="bi bi-eye"></i> Saytda gör
            </a>
        </div>

        <!-- STATS -->
        <div class="row g-3 mb-4">
            <div class="col-sm-4">
                <div class="adm-stat adm-stat-teal">
                    <div class="adm-stat-icon"><i class="bi bi-journal-bookmark-fill"></i></div>
                    <div>
                        <div class="adm-stat-val" data-counter="<%= N %>">0</div>
                        <div class="adm-stat-label">Cəmi Kurs</div>
                    </div>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="adm-stat adm-stat-blue">
                    <div class="adm-stat-icon"><i class="bi bi-people-fill"></i></div>
                    <div>
                        <div class="adm-stat-val" data-counter="<%= totalEnroll %>">0</div>
                        <div class="adm-stat-label">Toplam Qeydiyyat</div>
                    </div>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="adm-stat adm-stat-amber">
                    <div class="adm-stat-icon"><i class="bi bi-clock-fill"></i></div>
                    <div>
                        <div class="adm-stat-val" data-counter="<%= totalHrsSum %>">0</div>
                        <div class="adm-stat-label">Cəmi Saat</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- TABLE -->
        <div class="adm-card">
            <div class="adm-card-header">
                <span class="adm-card-title"><i class="bi bi-table"></i>Kurs Siyahısı</span>
                <div class="adm-search-wrap ms-auto" style="width:220px;">
                    <i class="bi bi-search"></i>
                    <input type="text" id="localSearch" placeholder="Kurs axtar..."
                           style="width:100%;" oninput="localFilter(this.value)">
                </div>
                <span class="adm-badge adm-badge-teal"><%= N %> kurs</span>
            </div>
            <div class="adm-table-wrap">
                <table class="adm-table" id="tblCourses">
                    <thead><tr>
                        <th>#</th>
                        <th data-sort>Kurs Adı</th>
                        <th data-sort>Müəllim</th>
                        <th data-sort>Tələbə</th>
                        <th data-sort>Saat</th>
                        <th>Səviyyə</th>
                        <th>Status</th>
                        <th style="text-align:center;">Əməliyyat</th>
                    </tr></thead>
                    <tbody id="coursesTbody">
                    <%
                    for (int i = 0; i < N; i++) {
                        String lvlBadge = "İrəliləmiş".equals(cLevels[i]) ? "adm-badge-red" : "Orta".equals(cLevels[i]) ? "adm-badge-amber" : "adm-badge-blue";
                        String stBadge  = "Aktiv".equals(cStatus[i]) ? "adm-badge-green" : "adm-badge-amber";
                        int pct = Math.min(100, cStudents[i] * 2);
                    %>
                    <tr>
                        <td class="adm-text-muted fw-700" style="font-size:.80rem;"><%= (i+1) %></td>
                        <td>
                            <div class="d-flex align-items-center gap-2">
                                <div class="adm-mini-avatar" style="background:<%= iconBgs[i] %>20;color:<%= iconBgs[i] %>;font-size:.8rem;">
                                    <i class="bi <%= icons[i] %>"></i>
                                </div>
                                <span class="fw-700"><%= cNames[i] %></span>
                            </div>
                        </td>
                        <td class="adm-text-muted" style="font-size:.82rem;"><%= cTeachers[i] %></td>
                        <td>
                            <div class="d-flex align-items-center gap-2">
                                <div style="width:50px;height:5px;background:var(--border);border-radius:3px;overflow:hidden;flex-shrink:0;">
                                    <div style="width:<%= pct %>%;height:100%;background:var(--accent);border-radius:3px;"></div>
                                </div>
                                <span class="fw-700"><%= cStudents[i] %></span>
                            </div>
                        </td>
                        <td><span class="adm-badge adm-badge-blue"><i class="bi bi-clock"></i><%= cHours[i] %> s.</span></td>
                        <td><span class="adm-badge <%= lvlBadge %>"><%= cLevels[i] %></span></td>
                        <td><span class="adm-badge <%= stBadge %>"><%= cStatus[i] %></span></td>
                        <td>
                            <div class="d-flex gap-1 justify-content-center">
                                <button class="adm-act-btn adm-act-view" title="Ətraflı"
                                    onclick='openCourse(<%= (i+1) %>,"<%= cNames[i].replace("\"","") %>","<%= cTeachers[i] %>",<%= cStudents[i] %>,"<%= cHours[i] %>","<%= cLevels[i] %>","<%= cStatus[i] %>","<%= iconBgs[i] %>","<%= icons[i] %>")'>
                                    <i class="bi bi-eye-fill"></i>
                                </button>
                                <a href="../course-page.jsp?id=<%= (i+1) %>" class="adm-act-btn adm-act-edit" title="Saytda bax" target="_blank">
                                    <i class="bi bi-box-arrow-up-right"></i>
                                </a>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/admin.js"></script>
<script>
function localFilter(q) {
    var lq = q.toLowerCase();
    document.querySelectorAll('#coursesTbody tr').forEach(function(r) {
        r.style.display = r.textContent.toLowerCase().includes(lq) ? '' : 'none';
    });
}

function openCourse(id, name, teacher, students, hours, level, status, color, icon) {
    document.getElementById('mCHead').innerHTML =
        '<div style="width:36px;height:36px;border-radius:10px;background:' + color + '22;color:' + color + ';display:flex;align-items:center;justify-content:center;font-size:.9rem;flex-shrink:0;"><i class="bi ' + icon + '"></i></div>' +
        '<span>' + name + '</span>';
    document.getElementById('mCBody').innerHTML =
        '<div class="row g-3">' +
        '<div class="col-6"><div class="adm-form-label">Müəllim</div><div class="fw-700">' + teacher + '</div></div>' +
        '<div class="col-6"><div class="adm-form-label">Qeydiyyat</div><div class="fw-700">' + students + ' tələbə</div></div>' +
        '<div class="col-6"><div class="adm-form-label">Müddət</div><div class="fw-700">' + hours + ' saat</div></div>' +
        '<div class="col-6"><div class="adm-form-label">Səviyyə</div><div class="fw-700">' + level + '</div></div>' +
        '<div class="col-12"><div class="adm-form-label">Status</div>' +
        '<span class="adm-badge ' + (status==="Aktiv" ? "adm-badge-green" : "adm-badge-amber") + '">' + status + '</span>' +
        '</div>' +
        '<div class="col-12"><div class="adm-form-label">Doluluk</div>' +
        '<div style="height:8px;background:var(--border);border-radius:50px;overflow:hidden;margin-top:4px;">' +
        '<div style="width:' + Math.min(100, students*2) + '%;height:100%;background:linear-gradient(90deg,' + color + ',' + color + 'aa);border-radius:50px;"></div></div>' +
        '<div class="adm-text-muted" style="font-size:.75rem;margin-top:4px;">' + Math.min(100, students*2) + '% dolu</div>' +
        '</div></div>';
    document.getElementById('mCLink').href = '../course-page.jsp?id=' + id;
    admModal.open('modalCourse');
}
</script>
</body>
</html>
