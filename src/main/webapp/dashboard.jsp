<%@ page import="com.sukur.educationwebapp.student.service.StudentService" %>
<%@ page import="com.sukur.educationwebapp.teacher.service.TeacherService" %>
<%@ page import="com.sukur.educationwebapp.student.entity.Student" %>
<%@ page import="com.sukur.educationwebapp.teacher.entity.Teacher" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    StudentService studentService = new StudentService();
    TeacherService teacherService = new TeacherService();
    List<Student> students = studentService.findAll();
    List<Teacher> teachers = teacherService.findAll();

    int totalStudents = students.size();
    int totalTeachers = teachers.size();
    int totalCourses  = 10;   /* Kurslar hələ hardcode */
    int totalActive   = Math.max(1, (int)(totalStudents * 0.78));

    /* Bugünkü tarix */
    java.time.LocalDate today = java.time.LocalDate.now();
    String[] MONTHS = {"Yanvar","Fevral","Mart","Aprel","May","İyun","İyul","Avqust","Sentyabr","Oktyabr","Noyabr","Dekabr"};
    String todayStr = today.getDayOfMonth() + " " + MONTHS[today.getMonthValue()-1] + " " + today.getYear();

    String[] courseNames = {"Java Əsasları","OOP Konseptləri","Spring Framework","Verilənlər Bazası","HTML & CSS",
                            "JavaScript","React.js","Python","Kibertəhlükəsizlik","DevOps & Docker"};
    int[] courseStudents = {85,62,74,91,58,103,67,80,45,72};
    String[] courseColors = {"indigo","teal","amber","rose","indigo","violet","teal","amber","rose","indigo"};
%>
<!DOCTYPE html>
<html lang="az">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard — Education App</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link href="css/style.css?v=3.5" rel="stylesheet">
    <link href="css/dark-mode.css?v=1.0" rel="stylesheet">
    <link href="css/ads.css?v=4.0" rel="stylesheet">
    <link href="css/dashboard.css?v=1.0" rel="stylesheet">
    <style>.page-breadcrumb-bar{display:none!important}</style>
</head>
<body class="overflow-hidden-init db-page">

<div id="loader">
    <div class="loader-content">
        <div class="loader-circle"></div><div class="loader-circle"></div><div class="loader-circle"></div>
        <div class="loader-subtext">Dashboard yüklənir...</div>
    </div>
</div>

<% request.setAttribute("pageLabel","Dashboard"); request.setAttribute("isHome",false); %>
<jsp:include page="header.jsp"/>

<!-- HERO -->
<div class="db-hero">
    <div class="container">
        <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
            <div>
                <div class="db-hero-date"><i class="bi bi-calendar3"></i><%= todayStr %></div>
                <h1 class="db-hero-title">İdarəetmə Paneli</h1>
                <p class="db-hero-sub">Bütün statistikalara bir yerdən bax, izlə, idarə et.</p>
            </div>
            <div class="d-flex gap-2 flex-wrap">
                <a href="students.jsp" class="btn btn-sm btn-light fw-700 rounded-3">
                    <i class="bi bi-people-fill me-1"></i>Tələbələr
                </a>
                <a href="courses.jsp" class="btn btn-sm btn-light fw-700 rounded-3">
                    <i class="bi bi-journal-bookmark-fill me-1"></i>Kurslar
                </a>
            </div>
        </div>
    </div>
</div>

<!-- ƏSAS MƏZMUN -->
<div class="db-main">
<div class="container">

    <!-- Stat Kartları -->
    <div class="row g-3 mb-4">
        <div class="col-6 col-lg-3" data-aos="fade-up" data-aos-delay="0">
            <div class="db-stat">
                <div class="db-stat-icon" style="background:rgba(79,70,229,.12);">
                    <i class="bi bi-people-fill" style="color:#4f46e5;"></i>
                </div>
                <div>
                    <div class="db-stat-val" data-count="<%= totalStudents %>">0</div>
                    <div class="db-stat-lbl">Tələbə</div>
                    <div class="db-stat-trend up"><i class="bi bi-arrow-up-short"></i>+12%</div>
                </div>
            </div>
        </div>
        <div class="col-6 col-lg-3" data-aos="fade-up" data-aos-delay="60">
            <div class="db-stat">
                <div class="db-stat-icon" style="background:rgba(16,185,129,.12);">
                    <i class="bi bi-person-workspace" style="color:#10b981;"></i>
                </div>
                <div>
                    <div class="db-stat-val" data-count="<%= totalTeachers %>">0</div>
                    <div class="db-stat-lbl">Müəllim</div>
                    <div class="db-stat-trend up"><i class="bi bi-arrow-up-short"></i>+3%</div>
                </div>
            </div>
        </div>
        <div class="col-6 col-lg-3" data-aos="fade-up" data-aos-delay="120">
            <div class="db-stat">
                <div class="db-stat-icon" style="background:rgba(245,158,11,.12);">
                    <i class="bi bi-journal-bookmark-fill" style="color:#f59e0b;"></i>
                </div>
                <div>
                    <div class="db-stat-val" data-count="<%= totalCourses %>">0</div>
                    <div class="db-stat-lbl">Kurs</div>
                    <div class="db-stat-trend up"><i class="bi bi-arrow-up-short"></i>+2</div>
                </div>
            </div>
        </div>
        <div class="col-6 col-lg-3" data-aos="fade-up" data-aos-delay="180">
            <div class="db-stat">
                <div class="db-stat-icon" style="background:rgba(56,189,248,.12);">
                    <i class="bi bi-lightning-charge-fill" style="color:#0ea5e9;"></i>
                </div>
                <div>
                    <div class="db-stat-val" data-count="<%= totalActive %>">0</div>
                    <div class="db-stat-lbl">Aktiv Bu Ay</div>
                    <div class="db-stat-trend down"><i class="bi bi-arrow-down-short"></i>-4%</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Qrafiklər + Cədvəl -->
    <div class="row g-3 mb-4">

        <!-- Bar Chart -->
        <div class="col-lg-8" data-aos="fade-up">
            <div class="db-card h-100">
                <div class="db-card-title">
                    <span style="background:rgba(79,70,229,.12);color:#4f46e5;" class="db-stat-icon">
                        <i class="bi bi-bar-chart-fill"></i>
                    </span>
                    Aylıq Tələbə Qeydiyyatı
                    <span class="ms-auto badge text-bg-light fw-600 fs-7">2024</span>
                </div>
                <div class="db-chart-wrap"><canvas id="barChart"></canvas></div>
            </div>
        </div>

        <!-- Donut Chart -->
        <div class="col-lg-4" data-aos="fade-up" data-aos-delay="60">
            <div class="db-card h-100">
                <div class="db-card-title">
                    <span style="background:rgba(124,58,237,.12);color:#7c3aed;" class="db-stat-icon">
                        <i class="bi bi-pie-chart-fill"></i>
                    </span>
                    Kurs Paylanması
                </div>
                <div class="db-chart-wrap"><canvas id="donutChart"></canvas></div>
            </div>
        </div>

    </div>

    <!-- Kurs İrəliləyişi + Müəllimlər + Sürət keçidləri -->
    <div class="row g-3 mb-4">

        <!-- Kurs progress -->
        <div class="col-lg-5" data-aos="fade-up">
            <div class="db-card h-100">
                <div class="db-card-title">
                    <span style="background:rgba(245,158,11,.12);color:#f59e0b;" class="db-stat-icon">
                        <i class="bi bi-graph-up-arrow"></i>
                    </span>
                    Kurs Doluluk Faizi
                </div>
                <div class="db-progress-row">
                    <% for (int i=0;i<Math.min(courseNames.length,6);i++) {
                        int pct = (courseStudents[i] * 100) / 120; %>
                    <div>
                        <div class="db-prog-label">
                            <span><%= courseNames[i] %></span>
                            <span><%= courseStudents[i] %>/120</span>
                        </div>
                        <div class="db-prog-track">
                            <div class="db-prog-fill"
                                 data-width="<%= pct %>"
                                 style="background:linear-gradient(90deg,
                                 <%= i%3==0?"#4f46e5,#7c3aed":i%3==1?"#10b981,#0d9488":"#f59e0b,#dc2626" %>);">
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>
        </div>

        <!-- Müəllimlər siyahısı -->
        <div class="col-lg-4" data-aos="fade-up" data-aos-delay="60">
            <div class="db-card h-100">
                <div class="db-card-title">
                    <span style="background:rgba(16,185,129,.12);color:#10b981;" class="db-stat-icon">
                        <i class="bi bi-person-badge-fill"></i>
                    </span>
                    Müəllimlər
                </div>
                <% if (teachers.isEmpty()) { %>
                <p class="text-muted small text-center py-3">Müəllim tapılmadı</p>
                <% } else {
                    int shown = 0;
                    for (Teacher t : teachers) {
                        if (shown++ >= 5) break;
                        String initials = t.getName().charAt(0) + "" + (t.getSurname() != null && !t.getSurname().isEmpty() ? t.getSurname().charAt(0) : "");
                %>
                <div class="d-flex align-items-center gap-3 mb-3">
                    <div class="db-avatar"><%= initials.toUpperCase() %></div>
                    <div style="min-width:0;">
                        <div style="font-size:.86rem;font-weight:700;color:#1e293b;" class="text-truncate">
                            <%= t.getName() %> <%= t.getSurname() %>
                        </div>
                        <div style="font-size:.75rem;color:#94a3b8;font-weight:500;"><%= t.getEmail() != null ? t.getEmail() : "—" %></div>
                    </div>
                    <span class="db-badge green ms-auto">Aktiv</span>
                </div>
                <% } } %>
                <a href="teachers.jsp" class="btn btn-sm btn-outline-primary w-100 rounded-3 mt-2 fw-600">
                    Hamısına Bax →
                </a>
            </div>
        </div>

        <!-- Sürət keçidləri -->
        <div class="col-lg-3" data-aos="fade-up" data-aos-delay="120">
            <div class="db-card h-100">
                <div class="db-card-title">
                    <span style="background:rgba(14,165,233,.12);color:#0ea5e9;" class="db-stat-icon">
                        <i class="bi bi-lightning-fill"></i>
                    </span>
                    Sürətli Keçidlər
                </div>
                <div class="row g-2">
                    <div class="col-6">
                        <a href="students.jsp" class="db-quick">
                            <i class="bi bi-people-fill"></i>Tələbələr
                        </a>
                    </div>
                    <div class="col-6">
                        <a href="teachers.jsp" class="db-quick">
                            <i class="bi bi-person-badge-fill"></i>Müəllimlər
                        </a>
                    </div>
                    <div class="col-6">
                        <a href="courses.jsp" class="db-quick">
                            <i class="bi bi-journal-bookmark-fill"></i>Kurslar
                        </a>
                    </div>
                    <div class="col-6">
                        <a href="schedule.jsp" class="db-quick">
                            <i class="bi bi-calendar3-week-fill"></i>Cədvəl
                        </a>
                    </div>
                    <div class="col-6">
                        <a href="about.jsp" class="db-quick">
                            <i class="bi bi-info-circle-fill"></i>Haqqında
                        </a>
                    </div>
                    <div class="col-6">
                        <a href="certificate.jsp" class="db-quick">
                            <i class="bi bi-patch-check-fill"></i>Sertifikat
                        </a>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- Son tələbələr cədvəli -->
    <div class="row g-3 mb-4">
        <div class="col-12" data-aos="fade-up">
            <div class="db-card">
                <div class="db-card-title">
                    <span style="background:rgba(79,70,229,.12);color:#4f46e5;" class="db-stat-icon">
                        <i class="bi bi-clock-history"></i>
                    </span>
                    Son Qeydiyyatlı Tələbələr
                    <a href="students.jsp" class="btn btn-sm btn-outline-primary ms-auto rounded-3 fw-600" style="font-size:.76rem;">
                        Hamısı →
                    </a>
                </div>
                <div class="table-responsive">
                    <table class="db-table">
                        <thead>
                            <tr>
                                <th>Tələbə</th>
                                <th class="d-none d-md-table-cell">E-poçt</th>
                                <th class="d-none d-sm-table-cell">Yaş</th>
                                <th>Müəllim</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                        <% if (students.isEmpty()) { %>
                        <tr><td colspan="5" class="text-center py-4 text-muted">Tələbə tapılmadı</td></tr>
                        <% } else {
                            int shown = 0;
                            for (Student s : students) {
                                if (shown++ >= 8) break;
                                String initials2 = s.getName().charAt(0) + "" + (s.getSurname() != null ? s.getSurname().charAt(0) : "");
                                String[] statuses = {"green","indigo","amber"};
                                String[] statusLabels = {"Aktiv","Yeni","Gözləmə"};
                                int si = s.getId() % 3;
                        %>
                        <tr style="cursor:pointer;" onclick="window.location='student-page.jsp?id=<%= s.getId() %>'">
                            <td>
                                <div class="d-flex align-items-center gap-2">
                                    <div class="db-avatar" style="width:30px;height:30px;font-size:.70rem;">
                                        <%= initials2.toUpperCase() %>
                                    </div>
                                    <span><%= s.getName() %> <%= s.getSurname() %></span>
                                </div>
                            </td>
                            <td class="d-none d-md-table-cell"><%= s.getEmail() != null ? s.getEmail() : "—" %></td>
                            <td class="d-none d-sm-table-cell"><%= s.getAge() %></td>
                            <td style="max-width:120px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
                                <%= s.getTeacher() != null && !s.getTeacher().equals("0") ? s.getTeacher() : "—" %>
                            </td>
                            <td><span class="db-badge <%= statuses[si] %>"><%= statusLabels[si] %></span></td>
                        </tr>
                        <% } } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Xətt qrafiki — ay üzrə aktivlik -->
    <div class="row g-3 mb-4">
        <div class="col-12" data-aos="fade-up">
            <div class="db-card">
                <div class="db-card-title">
                    <span style="background:rgba(56,189,248,.12);color:#0ea5e9;" class="db-stat-icon">
                        <i class="bi bi-activity"></i>
                    </span>
                    Aylıq Aktivlik Trendu
                </div>
                <div class="db-chart-wrap" style="height:200px;">
                    <canvas id="lineChart"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!-- Reklam -->
    <jsp:include page="ads-infeed.jsp"/>

</div>
</div>

<jsp:include page="footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<script src="js/script.js?v=3.0"></script>
<script src="js/ads.js?v=4.0"></script>
<script>
AOS.init({duration:700,once:true,offset:50});

/* ── Sayaç animasiyası ─────────────────────────── */
function animateCounter(el){
    var target=parseFloat(el.getAttribute('data-count')||0);
    var dur=1400; var start=performance.now();
    function step(now){
        var p=Math.min((now-start)/dur,1);
        var e=1-Math.pow(1-p,3);
        el.textContent=Math.floor(target*e);
        if(p<1)requestAnimationFrame(step);
        else el.textContent=target;
    }
    requestAnimationFrame(step);
}
document.querySelectorAll('.db-stat-val[data-count]').forEach(function(el){
    var obs=new IntersectionObserver(function(entries){
        entries.forEach(function(e){if(e.isIntersecting){animateCounter(el);obs.unobserve(el);}});
    },{threshold:.5});
    obs.observe(el);
});

/* ── Progress barları ──────────────────────────── */
setTimeout(function(){
    document.querySelectorAll('.db-prog-fill').forEach(function(b){
        b.style.width=(b.getAttribute('data-width')||0)+'%';
    });
},600);

/* ── Dark mode rəngləri ─────────────────────────── */
var isDark = document.documentElement.getAttribute('data-bs-theme')==='dark'
          || document.body.classList.contains('dark-mode');
var gridColor  = isDark ? 'rgba(255,255,255,.06)' : 'rgba(0,0,0,.06)';
var labelColor = isDark ? '#64748b' : '#94a3b8';
var tooltipBg  = isDark ? '#1e293b' : '#fff';
var tooltipTxt = isDark ? '#f1f5f9' : '#1e293b';

Chart.defaults.font.family = "'Outfit',sans-serif";

/* ── Bar Chart ─────────────────────────────────── */
new Chart(document.getElementById('barChart'),{
    type:'bar',
    data:{
        labels:['Yan','Fev','Mar','Apr','May','İyun','İyul','Avq','Sep','Okt','Noy','Dek'],
        datasets:[{
            label:'Yeni Tələbə',
            data:[18,25,32,28,45,38,52,41,60,48,55,70],
            backgroundColor:'rgba(79,70,229,.75)',
            borderRadius:8, borderSkipped:false,
        },{
            label:'Tərk edən',
            data:[3,5,8,4,6,7,9,5,11,8,10,12],
            backgroundColor:'rgba(244,63,94,.60)',
            borderRadius:8, borderSkipped:false,
        }]
    },
    options:{
        responsive:true, maintainAspectRatio:false,
        plugins:{legend:{labels:{color:labelColor,font:{weight:'600',size:12}}},
                 tooltip:{backgroundColor:tooltipBg,titleColor:tooltipTxt,bodyColor:tooltipTxt,borderColor:'rgba(0,0,0,.08)',borderWidth:1}},
        scales:{
            x:{grid:{color:gridColor},ticks:{color:labelColor,font:{weight:'600'}}},
            y:{grid:{color:gridColor},ticks:{color:labelColor,font:{weight:'600'}}}
        }
    }
});

/* ── Donut Chart ───────────────────────────────── */
new Chart(document.getElementById('donutChart'),{
    type:'doughnut',
    data:{
        labels:['Proqramlaşdırma','Dizayn','Şəbəkə','DevOps'],
        datasets:[{
            data:[65,15,12,8],
            backgroundColor:['#4f46e5','#10b981','#f59e0b','#0ea5e9'],
            borderWidth:0, hoverOffset:6,
        }]
    },
    options:{
        responsive:true, maintainAspectRatio:false,
        cutout:'68%',
        plugins:{
            legend:{position:'bottom',labels:{color:labelColor,font:{weight:'600',size:11},padding:14,usePointStyle:true}},
            tooltip:{backgroundColor:tooltipBg,titleColor:tooltipTxt,bodyColor:tooltipTxt,borderColor:'rgba(0,0,0,.08)',borderWidth:1}
        }
    }
});

/* ── Line Chart ────────────────────────────────── */
new Chart(document.getElementById('lineChart'),{
    type:'line',
    data:{
        labels:['Yan','Fev','Mar','Apr','May','İyun','İyul','Avq','Sep','Okt','Noy','Dek'],
        datasets:[{
            label:'Aktiv Tələbə',
            data:[120,145,160,155,175,190,210,198,225,240,228,260],
            borderColor:'#4f46e5', backgroundColor:'rgba(79,70,229,.10)',
            tension:.4, fill:true, pointBackgroundColor:'#4f46e5',
            pointRadius:4, pointHoverRadius:7,
        },{
            label:'Tamamlanan Kurs',
            data:[8,12,18,15,22,25,30,28,35,38,34,42],
            borderColor:'#10b981', backgroundColor:'rgba(16,185,129,.10)',
            tension:.4, fill:true, pointBackgroundColor:'#10b981',
            pointRadius:4, pointHoverRadius:7,
        }]
    },
    options:{
        responsive:true, maintainAspectRatio:false,
        plugins:{
            legend:{labels:{color:labelColor,font:{weight:'600',size:12},usePointStyle:true}},
            tooltip:{backgroundColor:tooltipBg,titleColor:tooltipTxt,bodyColor:tooltipTxt,borderColor:'rgba(0,0,0,.08)',borderWidth:1}
        },
        scales:{
            x:{grid:{color:gridColor},ticks:{color:labelColor,font:{weight:'600'}}},
            y:{grid:{color:gridColor},ticks:{color:labelColor,font:{weight:'600'}}}
        }
    }
});
</script>
</body>
</html>
