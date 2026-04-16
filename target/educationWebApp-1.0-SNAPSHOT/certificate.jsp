<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    /* URL: certificate.jsp?student=Əli+Əliyev&course=2&date=10+Aprel+2025 */
    String studentName = request.getParameter("student");
    if (studentName == null || studentName.trim().isEmpty()) studentName = "Tələbə Adı";

    int courseIdx = 1;
    try { courseIdx = Math.max(1, Math.min(10, Integer.parseInt(request.getParameter("course")))); }
    catch (Exception ignored) {}
    courseIdx--;

    String[] courseNames = {"Java Əsasları","OOP Konseptləri","Spring Framework","Verilənlər Bazası","HTML & CSS",
                            "JavaScript Əsasları","React.js","Python Proqramlaşdırma","Kibertəhlükəsizlik","DevOps & Docker"};
    String[] courseHours = {"36","28","42","32","24","30","38","35","40","26"};
    String[] courseLvl   = {"Başlanğıc","Başlanğıc","Orta","Orta","Başlanğıc","Başlanğıc","Orta","Orta","İrəliləmiş","İrəliləmiş"};
    String[] gFrom = {"#4338ca","#059669","#d97706","#db2777","#0891b2","#7c3aed","#ea580c","#2563eb","#0f172a","#065f46"};
    String[] gTo   = {"#7c3aed","#0d9488","#dc2626","#7c3aed","#0f766e","#db2777","#d97706","#4f46e5","#334155","#047857"};

    String courseName = courseNames[courseIdx];
    String courseHour = courseHours[courseIdx];
    String courseLev  = courseLvl[courseIdx];
    String g1 = gFrom[courseIdx], g2 = gTo[courseIdx];

    String certDate = request.getParameter("date");
    if (certDate == null || certDate.trim().isEmpty()) {
        java.time.LocalDate now = java.time.LocalDate.now();
        String[] MONTHS = {"Yanvar","Fevral","Mart","Aprel","May","İyun","İyul","Avqust","Sentyabr","Oktyabr","Noyabr","Dekabr"};
        certDate = now.getDayOfMonth() + " " + MONTHS[now.getMonthValue()-1] + " " + now.getYear();
    }

    /* Sertifikat ID — hər dəfə unikal */
    String certId = "EDU-" + java.util.UUID.randomUUID().toString().toUpperCase().substring(0,8);
%>
<!DOCTYPE html>
<html lang="az">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sertifikat — <%= studentName %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800;900&family=Playfair+Display:wght@700;900&display=swap" rel="stylesheet">
    <link href="css/style.css?v=3.5" rel="stylesheet">
    <link href="css/dark-mode.css?v=1.0" rel="stylesheet">
    <link href="css/certificate.css?v=1.0" rel="stylesheet">
    <style>.page-breadcrumb-bar{display:none!important}</style>
</head>
<body class="cert-page">

<div id="loader">
    <div class="loader-content">
        <div class="loader-circle"></div><div class="loader-circle"></div><div class="loader-circle"></div>
        <div class="loader-subtext">Sertifikat hazırlanır...</div>
    </div>
</div>

<% request.setAttribute("pageLabel","Sertifikat"); request.setAttribute("isHome",false); %>
<jsp:include page="header.jsp"/>

<!-- Nəzarət paneli -->
<div class="cert-controls">
    <div class="container d-flex align-items-center justify-content-between flex-wrap gap-2">

        <nav class="d-flex align-items-center gap-2 text-muted" style="font-size:.82rem;font-weight:600;">
            <a href="index.jsp" class="text-decoration-none text-muted">
                <i class="bi bi-house-fill me-1"></i>Anasəhfə
            </a>
            <i class="bi bi-chevron-right" style="font-size:.7rem;"></i>
            <a href="courses.jsp" class="text-decoration-none text-muted">Kurslar</a>
            <i class="bi bi-chevron-right" style="font-size:.7rem;"></i>
            <span style="color:#4f46e5;">Sertifikat</span>
        </nav>

        <div class="d-flex gap-2">
            <button class="btn-share" onclick="navigator.clipboard&&navigator.clipboard.writeText(location.href);this.innerHTML='<i class=\'bi bi-check2\'></i> Kopyalandı!';">
                <i class="bi bi-share-fill"></i> Paylaş
            </button>
            <button class="btn-print" onclick="printCert()">
                <i class="bi bi-printer-fill"></i> Çap Et
            </button>
            <button class="btn-export-pdf" id="btnExportPDF" onclick="exportPDF()">
                <i class="bi bi-file-earmark-pdf-fill"></i> PDF İxrac
            </button>
        </div>

    </div>
</div>

<!-- Sertifikat -->
<div class="cert-wrapper">
<div class="cert" id="certCard" data-aos="zoom-in" data-aos-duration="600">

    <!-- Üst rəngli şerit -->
    <div class="cert-top-bar"></div>

    <!-- Əsas məzmun -->
    <div class="cert-body">

        <!-- Qurum -->
        <div class="cert-org">
            <div class="cert-org-icon"><i class="bi bi-mortarboard-fill"></i></div>
            <div>
                <div class="cert-org-name">Education App</div>
                <div class="cert-org-sub">Azərbaycan Online Təhsil Platforması</div>
            </div>
        </div>

        <hr class="cert-hr">

        <!-- Başlıq -->
        <div class="cert-heading">Tamamlama Sertifikatı</div>
        <h1 class="cert-title" style="font-family:'Playfair Display',serif;">
            Certificate of Completion
        </h1>

        <!-- Mətn -->
        <p class="cert-desc">
            Bu sertifikat aşağıda adı qeyd olunan şəxsin müvəffəqiyyətlə kursu
            tamamladığını rəsmi olaraq təsdiqləyir.
        </p>

        <!-- Tələbə adı -->
        <div class="cert-recipient-label">Bu sertifikat verilir</div>
        <div class="cert-recipient-name"><%= studentName %></div>

        <!-- Kurs qutusu -->
        <div class="cert-course-box">
            <div class="cert-course-label">Tamamlanan Kurs</div>
            <div class="cert-course-name"><%= courseName %></div>
        </div>

        <!-- Chiplar -->
        <div class="cert-chips">
            <span class="cert-chip"><i class="bi bi-clock-fill"></i><%= courseHour %> Saat</span>
            <span class="cert-chip"><i class="bi bi-bar-chart-fill"></i><%= courseLev %></span>
            <span class="cert-chip"><i class="bi bi-calendar3"></i><%= certDate %></span>
            <span class="cert-chip"><i class="bi bi-patch-check-fill" style="color:#10b981;"></i>Doğrulandı</span>
        </div>

        <hr class="cert-hr">

        <!-- İmzalar -->
        <div class="cert-signatures">
            <div class="cert-sign">
                <div class="cert-sign-line"></div>
                <div class="cert-sign-name">Əli Əliyev</div>
                <div class="cert-sign-title">Baş Müəllim</div>
            </div>
            <div class="cert-sign">
                <div class="cert-sign-line"></div>
                <div class="cert-sign-name">Nigar Hüseynova</div>
                <div class="cert-sign-title">Proqram Direktoru</div>
            </div>
            <div class="cert-sign">
                <div class="cert-sign-line"></div>
                <div class="cert-sign-name">Rauf Məmmədov</div>
                <div class="cert-sign-title">Platforma Rəhbəri</div>
            </div>
        </div>

        <!-- Möhür -->
        <div class="cert-seal"><i class="bi bi-patch-check-fill"></i></div>

    </div>

    <!-- Footer -->
    <div class="cert-footer-bar">
        <div class="cert-id">Sertifikat ID: <strong><%= certId %></strong></div>
        <div class="cert-verify">
            <i class="bi bi-shield-check-fill"></i>
            education-app.az/verify/<%= certId %>
        </div>
    </div>

</div>
</div>

<!-- Əməliyyat düymələri -->
<div class="d-flex justify-content-center gap-3 mb-5" id="certPrintBtn">
    <button onclick="printCert()"
        style="display:inline-flex;align-items:center;gap:10px;
               background:linear-gradient(135deg,#4f46e5,#7c3aed);
               color:#fff;border:none;border-radius:16px;
               padding:14px 36px;font-size:1rem;font-weight:700;
               cursor:pointer;box-shadow:0 6px 24px rgba(79,70,229,.40);
               transition:all .2s;">
        <i class="bi bi-printer-fill" style="font-size:1.2rem;"></i>
        Çap Et
    </button>
    <button onclick="exportPDF()" id="btnExportPDF2"
        style="display:inline-flex;align-items:center;gap:10px;
               background:linear-gradient(135deg,#dc2626,#ea580c);
               color:#fff;border:none;border-radius:16px;
               padding:14px 36px;font-size:1rem;font-weight:700;
               cursor:pointer;box-shadow:0 6px 24px rgba(220,38,38,.40);
               transition:all .2s;">
        <i class="bi bi-file-earmark-pdf-fill" style="font-size:1.2rem;"></i>
        PDF İxrac
    </button>
</div>

<!-- Fərqli tələbə / kurs seçmək üçün form -->
<div class="container pb-5" id="certCreateForm">
    <div class="card border-0 shadow-sm rounded-4 p-4 mx-auto" style="max-width:600px;">
        <h5 class="fw-800 mb-1" style="color:#1e293b;">Sertifikat Yarat</h5>
        <p class="text-muted small mb-3">Tələbə adını və kursu seçib sertifikat yarada bilərsən.</p>
        <form method="get" action="certificate.jsp" class="row g-2">
            <div class="col-12">
                <input type="text" name="student" class="form-control rounded-3"
                       placeholder="Tələbənin adı soyadı"
                       value="<%= studentName.equals("Tələbə Adı") ? "" : studentName %>">
            </div>
            <div class="col-12">
                <select name="course" class="form-select rounded-3">
                    <% String[] cn={"Java Əsasları","OOP Konseptləri","Spring Framework","Verilənlər Bazası","HTML & CSS",
                                    "JavaScript Əsasları","React.js","Python Proqramlaşdırma","Kibertəhlükəsizlik","DevOps & Docker"};
                       for(int i=0;i<cn.length;i++){ %>
                    <option value="<%= (i+1) %>" <%= (i==courseIdx?"selected":"") %>><%= cn[i] %></option>
                    <% } %>
                </select>
            </div>
            <div class="col-12">
                <button type="submit"
                        class="btn w-100 py-2 fw-700 rounded-3 text-white"
                        style="background:linear-gradient(135deg,#4f46e5,#7c3aed);border:none;">
                    <i class="bi bi-patch-check-fill me-2"></i>Sertifikat Yarat
                </button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script src="js/script.js?v=3.0"></script>
<script>
AOS.init({duration:700,once:true});

/* ── ÇAPETMƏ — exportPDF ilə eyni html2canvas yanaşması ── */
function printCert() {
    var isDark  = document.body.classList.contains('dark-mode');
    var pageBg  = isDark ? '#0f172a' : '#f1f5f9';
    var cert    = document.getElementById('certCard');

    /* Düyməni "Hazırlanır..." vəziyyətinə gətir */
    var printBtns = document.querySelectorAll('[onclick="printCert()"]');
    printBtns.forEach(function(b){ b.disabled=true; b.style.opacity='.6'; });

    html2canvas(cert, {
        scale: 2, useCORS: true, allowTaint: true,
        backgroundColor: pageBg, logging: false,
        onclone: function(clonedDoc) {
            var el = clonedDoc.getElementById('certCard');
            if (!el) return;
            el.style.boxShadow = 'none';
            if (isDark) {
                var nameEl = el.querySelector('.cert-recipient-name');
                if (nameEl) {
                    nameEl.style.background = 'none';
                    nameEl.style.webkitBackgroundClip = 'unset';
                    nameEl.style.backgroundClip = 'unset';
                    nameEl.style.webkitTextFillColor = '#a78bfa';
                    nameEl.style.color = '#a78bfa';
                }
            }
        }
    }).then(function(canvas) {
        var imgData = canvas.toDataURL('image/png');

        /* Yeni pəncərədə yalnız şəkil — A4 landscape, tam dolu */
        var pw = window.open('', '_blank', 'width=1240,height=870');
        pw.document.write(
            '<!DOCTYPE html><html><head>' +
            '<meta charset="UTF-8">' +
            '<style>' +
            '@page{size:A4 landscape;margin:0}' +
            '*{-webkit-print-color-adjust:exact!important;print-color-adjust:exact!important;' +
               'margin:0;padding:0;box-sizing:border-box}' +
            'html,body{width:297mm;height:210mm;overflow:hidden;background:' + pageBg + '}' +
            'body{display:flex;justify-content:center;align-items:center}' +
            'img{max-width:100%;max-height:100%;object-fit:contain;display:block}' +
            '</style></head>' +
            '<body><img src="' + imgData + '"></body></html>'
        );
        pw.document.close();

        /* Şəkil yüklənən kimi çap et */
        var printed = false;
        function doPrint() {
            if (printed) return; printed = true;
            pw.focus(); pw.print();
            setTimeout(function(){ if(pw && !pw.closed) pw.close(); }, 1500);
        }
        pw.onload = function(){ setTimeout(doPrint, 300); };
        setTimeout(doPrint, 2000);

        /* Düymələri bərpa et */
        printBtns.forEach(function(b){ b.disabled=false; b.style.opacity=''; });
    });
}

/* ── PDF İXRAC — dark/light mode qorunur, tək A4 landscape ── */
function exportPDF() {
    var btns = [document.getElementById('btnExportPDF'), document.getElementById('btnExportPDF2')];
    btns.forEach(function(b){
        if(b){ b.innerHTML='<i class="bi bi-hourglass-split"></i> Hazırlanır...'; b.disabled=true; }
    });

    var isDark  = document.body.classList.contains('dark-mode');
    /* Səhifənin arxa fonu — sertifikatın kənar küncləri bu rənglə örtülür */
    var pageBg  = isDark ? '#0f172a' : '#f1f5f9';
    var cert    = document.getElementById('certCard');

    html2canvas(cert, {
        scale: 2,
        useCORS: true,
        allowTaint: true,
        backgroundColor: pageBg,   /* JPEG küncləri pageBg rəngi alır → border-radius görünür */
        logging: false,
        onclone: function(clonedDoc) {
            var el = clonedDoc.getElementById('certCard');
            if (!el) return;

            /* Box-shadow-u sıfırla — PDF-də kölgə lazım deyil */
            el.style.boxShadow = 'none';

            /* Dark mode-da ad-soyadın arxasındakı gradient fon html2canvas-da
               qara/rəngli blok kimi çıxır — düz rənglə əvəz et */
            if (isDark) {
                var nameEl = el.querySelector('.cert-recipient-name');
                if (nameEl) {
                    nameEl.style.background           = 'none';
                    nameEl.style.webkitBackgroundClip = 'unset';
                    nameEl.style.backgroundClip       = 'unset';
                    nameEl.style.webkitTextFillColor  = '#a78bfa';
                    nameEl.style.color                = '#a78bfa';
                }
            }
        }
    }).then(function(canvas) {
        var jsPDFLib = window.jspdf && window.jspdf.jsPDF;
        if (!jsPDFLib) { alert('jsPDF yüklənmədi, bir daha cəhd edin.'); return; }

        /* A4 landscape: 297 × 210 mm */
        var pdf    = new jsPDFLib({ orientation: 'landscape', unit: 'mm', format: 'a4' });
        var pageW  = pdf.internal.pageSize.getWidth();
        var pageH  = pdf.internal.pageSize.getHeight();
        var margin = 5;
        var availW = pageW - margin * 2;
        var availH = pageH - margin * 2;

        /* Proporsiya qorunaraq A4-ə sığışdır */
        var ratio  = canvas.width / canvas.height;
        var finalW, finalH;
        if (availW / ratio <= availH) {
            finalW = availW; finalH = availW / ratio;
        } else {
            finalH = availH; finalW = availH * ratio;
        }
        var x = (pageW - finalW) / 2;
        var y = (pageH - finalH) / 2;

        /* PDF səhifəsini page fonuyla doldur — border-radius künclər blendlənsin */
        var bg = isDark ? [15, 23, 42] : [241, 245, 249];
        pdf.setFillColor(bg[0], bg[1], bg[2]);
        pdf.rect(0, 0, pageW, pageH, 'F');

        var imgData = canvas.toDataURL('image/jpeg', 1.0);
        pdf.addImage(imgData, 'JPEG', x, y, finalW, finalH);
        pdf.save('Sertifikat-<%= studentName.replace(" ","-") %>.pdf');

        btns.forEach(function(b){
            if(b){
                b.innerHTML='<i class="bi bi-file-earmark-pdf-fill" style="font-size:1.2rem;"></i> PDF İxrac';
                b.disabled=false;
            }
        });
    });
}
</script>
</body>
</html>
