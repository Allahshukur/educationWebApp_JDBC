<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    /* Dərs cədvəli — statik məlumat
       Day indeksi: 1=Bazar E.(Mon), 2=Çərş.A.(Tue), 3=Çərşənbə(Wed),
                   4=Cümə A.(Thu), 5=Cümə(Fri), 6=Şənbə(Sat)  — Bazar(Sun) boş
    */
    Object[][] lessons = {
        {1,0,"Java Əsasları",      "Əli Əliyev",       "A-101","sc-l-indigo"},
        {1,1,"HTML & CSS",         "Nigar Hüseynova",  "B-203","sc-l-rose"},
        {1,3,"Python",             "Sevinc Quliyeva",  "C-105","sc-l-amber"},
        {2,0,"OOP Konseptləri",    "Əli Əliyev",       "A-101","sc-l-teal"},
        {2,2,"Verilənlər Bazası",  "Rauf Məmmədov",    "D-301","sc-l-violet"},
        {2,4,"DevOps & Docker",    "Rauf Məmmədov",    "D-301","sc-l-sky"},
        {3,0,"Spring Framework",   "Rauf Məmmədov",    "A-202","sc-l-indigo"},
        {3,1,"JavaScript",         "Nigar Hüseynova",  "B-101","sc-l-amber"},
        {3,3,"Kibertəhlükəsizlik", "Əli Əliyev",       "C-201","sc-l-rose"},
        {4,0,"React.js",           "Nigar Hüseynova",  "B-101","sc-l-violet"},
        {4,2,"Java Əsasları",      "Əli Əliyev",       "A-101","sc-l-indigo"},
        {4,4,"OOP Konseptləri",    "Əli Əliyev",       "A-202","sc-l-teal"},
        {5,1,"HTML & CSS",         "Nigar Hüseynova",  "B-203","sc-l-rose"},
        {5,2,"Python",             "Sevinc Quliyeva",  "C-105","sc-l-amber"},
        {5,3,"Spring Framework",   "Rauf Məmmədov",    "A-202","sc-l-green"},
        {6,0,"JavaScript",         "Nigar Hüseynova",  "B-101","sc-l-amber"},
        {6,1,"React.js",           "Nigar Hüseynova",  "B-101","sc-l-violet"},
        {6,3,"Verilənlər Bazası",  "Rauf Məmmədov",    "D-301","sc-l-teal"},
    };

    String[] timeSlots = {"09:00–10:30","10:45–12:15","13:00–14:30","14:45–16:15","16:30–18:00"};
    /* 7 gün: Bazar E.(Mon)→0 ... Şənbə(Sat)→5 ... Bazar(Sun)→6 */
    String[] days    = {"Bazar E.","Çərş. A.","Çərşənbə","Cümə A.","Cümə","Şənbə","Bazar"};
    String[] dayKeys = {"mon","tue","wed","thu","fri","sat","sun"};

    /* 7×5 grid */
    int[][] grid = new int[7][5];
    for (int[] row : grid) java.util.Arrays.fill(row, -1);
    for (int li = 0; li < lessons.length; li++) {
        int d = (int)lessons[li][0] - 1;   // 0-5 = Mon-Sat
        int t = (int)lessons[li][1];
        if (d >= 0 && d < 7 && t >= 0 && t < 5) grid[d][t] = li;
    }
%>
<!DOCTYPE html>
<html lang="az">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dərs Cədvəli — Education App</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link href="css/style.css?v=3.5" rel="stylesheet">
    <link href="css/dark-mode.css?v=1.0" rel="stylesheet">
    <link href="css/ads.css?v=4.0" rel="stylesheet">
    <link href="css/schedule.css?v=2.0" rel="stylesheet">
    <style>.page-breadcrumb-bar{display:none!important}</style>
</head>
<body class="overflow-hidden-init sc-page">

<div id="loader">
    <div class="loader-content">
        <div class="loader-circle"></div><div class="loader-circle"></div><div class="loader-circle"></div>
        <div class="loader-subtext">Cədvəl yüklənir...</div>
    </div>
</div>

<% request.setAttribute("pageLabel","Dərs Cədvəli"); request.setAttribute("isHome",false); %>
<jsp:include page="header.jsp"/>

<!-- HERO -->
<div class="sc-hero">
    <div class="container position-relative" style="z-index:2;">
        <div class="d-flex align-items-start justify-content-between flex-wrap gap-3">

            <!-- Sol: başlıq -->
            <div>
                <nav class="d-flex align-items-center gap-2 mb-2"
                     style="font-size:.80rem;font-weight:600;color:rgba(255,255,255,.65);">
                    <a href="index.jsp" style="color:rgba(255,255,255,.65);text-decoration:none;">
                        <i class="bi bi-house-fill me-1"></i>Anasəhfə
                    </a>
                    <i class="bi bi-chevron-right" style="font-size:.65rem;"></i>
                    <span style="color:#fff;">Dərs Cədvəli</span>
                </nav>
                <h1 class="sc-hero-title">
                    <i class="bi bi-calendar3-week-fill me-2"></i>Dərs Cədvəli
                </h1>
                <p class="sc-hero-sub">Həftəlik dərs proqramını izlə, müəllim və otaq məlumatlarına bax.</p>
            </div>

            <!-- Sağ: saat + düymələr -->
            <div class="d-flex flex-column align-items-end gap-3">

                <!-- Bakı saatı -->
                <div class="sc-clock">
                    <div class="sc-clock-day"  id="scDay">—</div>
                    <div class="sc-clock-time" id="scTime">--:--:--</div>
                    <div class="sc-clock-date" id="scDate">— — —</div>
                    <div class="sc-clock-tz">
                        <i class="bi bi-geo-alt-fill"></i> Bakı vaxtı (UTC+4)
                    </div>
                </div>

                <div class="d-flex gap-2 flex-wrap">
                    <a href="courses.jsp" class="btn btn-sm btn-light fw-700 rounded-3">
                        <i class="bi bi-journal-bookmark-fill me-1"></i>Kurslar
                    </a>
                    <a href="dashboard.jsp" class="btn btn-sm btn-light fw-700 rounded-3">
                        <i class="bi bi-speedometer2 me-1"></i>Dashboard
                    </a>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- ƏSAS -->
<div class="sc-main">
<div class="container">

    <!-- Filter paneli -->
    <div class="sc-filter-bar" data-aos="fade-down">
        <label><i class="bi bi-funnel-fill me-1"></i>Müəllim:</label>
        <select id="filterTeacher" onchange="applyFilter()">
            <option value="all">Hamısı</option>
            <option value="Əli Əliyev">Əli Əliyev</option>
            <option value="Nigar Hüseynova">Nigar Hüseynova</option>
            <option value="Rauf Məmmədov">Rauf Məmmədov</option>
            <option value="Sevinc Quliyeva">Sevinc Quliyeva</option>
        </select>
        <label class="ms-2"><i class="bi bi-book-fill me-1"></i>Kurs:</label>
        <select id="filterCourse" onchange="applyFilter()">
            <option value="all">Hamısı</option>
            <option>Java Əsasları</option>
            <option>OOP Konseptləri</option>
            <option>Spring Framework</option>
            <option>Verilənlər Bazası</option>
            <option>HTML & CSS</option>
            <option>JavaScript</option>
            <option>React.js</option>
            <option>Python</option>
            <option>Kibertəhlükəsizlik</option>
            <option>DevOps & Docker</option>
        </select>
        <button class="btn btn-sm btn-outline-secondary ms-auto rounded-3 fw-600" onclick="resetFilter()">
            <i class="bi bi-x-circle me-1"></i>Sıfırla
        </button>
    </div>

    <!-- Cədvəl -->
    <div class="sc-card" data-aos="fade-up">
        <div class="sc-table-wrap" id="scTableWrap">
            <table class="sc-table">
                <thead>
                    <tr>
                        <th class="sc-time-col"><i class="bi bi-clock"></i></th>
                        <% for (int d = 0; d < days.length; d++) { %>
                        <th class="sc-day <%= dayKeys[d] %>" data-day-col="<%= d %>">
                            <%= days[d] %>
                        </th>
                        <% } %>
                    </tr>
                </thead>
                <tbody>
                    <% for (int t = 0; t < timeSlots.length; t++) { %>
                    <tr>
                        <td class="sc-time"><%= timeSlots[t].replace("–","<br>") %></td>
                        <% for (int d = 0; d < 7; d++) {
                            int li = grid[d][t];
                            if (li >= 0) {
                                String lName    = (String)lessons[li][2];
                                String lTeacher = (String)lessons[li][3];
                                String lRoom    = (String)lessons[li][4];
                                String lColor   = (String)lessons[li][5];
                        %>
                        <td data-day-col="<%= d %>" data-time-slot="<%= t %>">
                            <div class="sc-lesson <%= lColor %>"
                                 data-teacher="<%= lTeacher %>"
                                 data-course="<%= lName %>">
                                <div class="sc-lesson-name"><%= lName %></div>
                                <div class="sc-lesson-teacher">
                                    <i class="bi bi-person-fill"></i> <%= lTeacher %>
                                </div>
                                <div class="sc-lesson-room">
                                    <i class="bi bi-door-open-fill"></i> <%= lRoom %>
                                </div>
                            </div>
                        </td>
                        <% } else { %>
                        <td data-day-col="<%= d %>" data-time-slot="<%= t %>">
                            <div class="sc-empty">·</div>
                        </td>
                        <% } } %>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- Legenda -->
        <div class="sc-legend">
            <div class="sc-legend-item"><div class="sc-legend-dot" style="background:#4f46e5;"></div>Proqramlaşdırma</div>
            <div class="sc-legend-item"><div class="sc-legend-dot" style="background:#0d9488;"></div>Veb</div>
            <div class="sc-legend-item"><div class="sc-legend-dot" style="background:#f59e0b;"></div>Data</div>
            <div class="sc-legend-item"><div class="sc-legend-dot" style="background:#f43f5e;"></div>Dizayn</div>
            <div class="sc-legend-item"><div class="sc-legend-dot" style="background:#8b5cf6;"></div>Layihə</div>
            <div class="sc-legend-item"><div class="sc-legend-dot" style="background:#0ea5e9;"></div>DevOps</div>
            <div class="sc-legend-item sc-legend-live">
                <span class="sc-live-dot"></span>Canlı dərs
            </div>
            <div class="sc-legend-item">
                <div class="sc-legend-dot" style="background:#94a3b8;opacity:.4;"></div>Keçmiş dərs
            </div>
        </div>
    </div>

    <div class="mt-4">
        <jsp:include page="ads-infeed.jsp"/>
    </div>

</div>
</div>

<jsp:include page="footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script src="js/script.js?v=3.0"></script>
<script src="js/ads.js?v=4.0"></script>
<script>
AOS.init({duration:700,once:true,offset:50});

function applyFilter(){
    var teacher = document.getElementById('filterTeacher').value;
    var course  = document.getElementById('filterCourse').value;
    document.querySelectorAll('.sc-lesson').forEach(function(el){
        var t = el.getAttribute('data-teacher') || '';
        var c = el.getAttribute('data-course')  || '';
        var show = (teacher==='all'||t===teacher) && (course==='all'||c.includes(course));
        el.style.opacity   = show ? '' : '0.12';
        el.style.transform = show ? '' : 'scale(.94)';
    });
}
function resetFilter(){
    document.getElementById('filterTeacher').value='all';
    document.getElementById('filterCourse').value='all';
    applyFilter();
}

/* ════════════════════════════════════════════
   BAKÜ SAATI + CƏDVƏL VURĞULAMA
════════════════════════════════════════════ */

/* Saat slotları (dəqiqə ilə) */
var SC_SLOTS = [
    {s:9*60,      e:10*60+30},
    {s:10*60+45,  e:12*60+15},
    {s:13*60,     e:14*60+30},
    {s:14*60+45,  e:16*60+15},
    {s:16*60+30,  e:18*60}
];

/* JS getDay() (0=Bazar/Sun..6=Şənbə/Sat) → cədvəl sütun indeksi */
/* Cədvəl: 0=Mon,1=Tue,2=Wed,3=Thu,4=Fri,5=Sat,6=Sun               */
var SC_DAY_TO_COL = [6, 0, 1, 2, 3, 4, 5];

var AZ_MONTHS = ['Yanvar','Fevral','Mart','Aprel','May','İyun',
                 'İyul','Avqust','Sentyabr','Oktyabr','Noyabr','Dekabr'];
var AZ_WDAYS  = ['Bazar','Bazar E.','Çərş. A.','Çərşənbə','Cümə A.','Cümə','Şənbə'];

function getBakuNow() {
    try {
        return new Date(new Date().toLocaleString('en-US', {timeZone:'Asia/Baku'}));
    } catch(e) {
        var n = new Date();
        return new Date(n.getTime() + (4*60 + n.getTimezoneOffset()) * 60000);
    }
}

var _prevCol = -1;

function pad2(x){ return ('0'+x).slice(-2); }

function scTick() {
    var now = getBakuNow();
    var h = now.getHours(), mi = now.getMinutes(), ss = now.getSeconds();

    /* ── Saatı güncəllə ── */
    document.getElementById('scTime').textContent = pad2(h)+':'+pad2(mi)+':'+pad2(ss);
    document.getElementById('scDay').textContent  = AZ_WDAYS[now.getDay()];
    document.getElementById('scDate').textContent =
        now.getDate()+' '+AZ_MONTHS[now.getMonth()]+' '+now.getFullYear();

    var col     = SC_DAY_TO_COL[now.getDay()];
    var minutes = h * 60 + mi;

    /* ── Sütun dəyişibsə highlight yenilə ── */
    if (col !== _prevCol) {
        _prevCol = col;
        document.querySelectorAll('.sc-col-current').forEach(function(el){
            el.classList.remove('sc-col-current');
        });
        document.querySelectorAll('[data-day-col="'+col+'"]').forEach(function(el){
            el.classList.add('sc-col-current');
        });
    }

    /* ── Dərs vəziyyətlərini yenilə (yalnız bugünkü sütun) ── */
    document.querySelectorAll('[data-day-col][data-time-slot]').forEach(function(cell){
        var cellCol = parseInt(cell.dataset.dayCol);
        var slot    = parseInt(cell.dataset.timeSlot);
        var lesson  = cell.querySelector('.sc-lesson');
        if (!lesson) return;

        lesson.classList.remove('sc-lesson-current','sc-lesson-past');

        if (cellCol !== col) return; /* Bu günün sütunu deyil */

        var slotStart = SC_SLOTS[slot].s;
        var slotEnd   = SC_SLOTS[slot].e;

        if (minutes >= slotStart && minutes <= slotEnd) {
            lesson.classList.add('sc-lesson-current');
        } else if (minutes > slotEnd) {
            lesson.classList.add('sc-lesson-past');
        }
    });
}

/* İlk yüklənmədə çalışdır, sonra hər saniyə */
scTick();
setInterval(scTick, 1000);

/* ── Cari gün + saata uyğun hücrəyə scroll et ── */
setTimeout(function(){
    var now = getBakuNow();
    var col = SC_DAY_TO_COL[now.getDay()];
    var min = now.getHours()*60 + now.getMinutes();

    /* Ən yaxın (cari və ya növbəti) slotu tap */
    var targetSlot = SC_SLOTS.length - 1;
    for (var i = 0; i < SC_SLOTS.length; i++) {
        if (min <= SC_SLOTS[i].e) { targetSlot = i; break; }
    }

    /* Hücrəni tap — dərs olan hücrəyə üstünlük ver */
    var target = document.querySelector(
        '[data-day-col="'+col+'"][data-time-slot="'+targetSlot+'"] .sc-lesson'
    );
    if (!target) {
        target = document.querySelector('[data-day-col="'+col+'"]');
    }
    if (target) {
        target.scrollIntoView({behavior:'smooth', block:'center', inline:'center'});
    }
}, 900);
</script>
</body>
</html>
