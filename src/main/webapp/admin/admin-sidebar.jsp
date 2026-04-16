<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String uri = request.getRequestURI();
    if (uri == null) uri = "";
    boolean isIndex    = uri.endsWith("index.jsp") || uri.endsWith("admin/") || uri.endsWith("/admin");
    boolean isStudents = uri.endsWith("students.jsp");
    boolean isTeachers = uri.endsWith("teachers.jsp");
    boolean isCourses  = uri.endsWith("courses.jsp");
    boolean isSettings = uri.endsWith("settings.jsp");
    boolean isReports  = uri.endsWith("reports.jsp");
    boolean isAnalytics = uri.endsWith("analytics.jsp");
%>

<!-- Mobile overlay -->
<div class="adm-overlay" id="admOverlay"></div>

<!-- SIDEBAR -->
<aside class="adm-sidebar" id="admSidebar">

    <!-- Brand -->
    <a class="adm-brand" href="index.jsp">
        <div class="adm-brand-icon"><i class="bi bi-mortarboard-fill"></i></div>
        <div>
            <div class="adm-brand-name">EduAdmin</div>
            <div class="adm-brand-sub">v2.0 Panel</div>
        </div>
    </a>

    <!-- Navigation -->
    <nav class="adm-nav">

        <div class="adm-nav-section">Əsas</div>

        <a href="index.jsp" class="adm-nav-link <%= isIndex ? "active" : "" %>">
            <i class="bi bi-speedometer2"></i>
            <span>Dashboard</span>
        </a>

        <a href="students.jsp" class="adm-nav-link <%= isStudents ? "active" : "" %>">
            <i class="bi bi-people-fill"></i>
            <span>Tələbələr</span>
        </a>

        <a href="teachers.jsp" class="adm-nav-link <%= isTeachers ? "active" : "" %>">
            <i class="bi bi-person-workspace"></i>
            <span>Müəllimlər</span>
        </a>

        <a href="courses.jsp" class="adm-nav-link <%= isCourses ? "active" : "" %>">
            <i class="bi bi-journal-bookmark-fill"></i>
            <span>Kurslar</span>
        </a>

        <div class="adm-nav-section">Analitika</div>

        <a href="analytics.jsp" class="adm-nav-link <%= isAnalytics ? "active" : "" %>">
            <i class="bi bi-graph-up"></i>
            <span>Analitika</span>
        </a>

        <a href="reports.jsp" class="adm-nav-link <%= isReports ? "active" : "" %>">
            <i class="bi bi-bar-chart-fill"></i>
            <span>Hesabatlar</span>
        </a>

        <div class="adm-nav-section">Sistem</div>

        <a href="settings.jsp" class="adm-nav-link <%= isSettings ? "active" : "" %>">
            <i class="bi bi-gear-fill"></i>
            <span>Parametrlər</span>
        </a>

        <a href="../index.jsp" class="adm-nav-link">
            <i class="bi bi-house-door-fill"></i>
            <span>Sayta qayıt</span>
        </a>

    </nav>

    <!-- Sidebar Footer (User) -->
    <div class="adm-sidebar-footer">
        <div class="adm-sidebar-user">
            <div class="adm-user-avatar"><i class="bi bi-person-fill"></i></div>
            <div style="min-width:0;">
                <div class="adm-user-name">Administrator</div>
                <div class="adm-user-role">Super Admin</div>
            </div>
        </div>
        <a href="login.jsp" class="adm-nav-link" style="margin-top:2px;">
            <i class="bi bi-box-arrow-right"></i>
            <span>Çıxış</span>
        </a>
    </div>

</aside>
