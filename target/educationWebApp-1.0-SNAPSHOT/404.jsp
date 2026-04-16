<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="false" %>
<!DOCTYPE html>
<html lang="az">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 — Səhifə Tapılmadı</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;700;800;900&display=swap" rel="stylesheet">
    <link href="css/dark-mode.css?v=1.0" rel="stylesheet">
    <link href="css/error.css?v=1.0" rel="stylesheet">
</head>
<body class="err-page">

<!-- Ulduzlar -->
<div class="err-stars" id="errStars"></div>

<!-- Arxa fon dairələri -->
<div class="err-bg-orb err-bg-orb-1"></div>
<div class="err-bg-orb err-bg-orb-2"></div>
<div class="err-bg-orb err-bg-orb-3"></div>

<!-- Məzmun -->
<div class="err-content">

    <div class="err-num">404</div>

    <span class="err-icon">🚀</span>

    <div class="err-divider"></div>

    <h1 class="err-title">Səhifə Tapılmadı!</h1>
    <p class="err-sub">
        Axtardığın səhifə silinmiş, köçürülmüş<br>
        və ya heç vaxt mövcud olmamışdır.
    </p>

    <div class="d-flex flex-wrap gap-3 justify-content-center mb-4">
        <a href="index.jsp" class="err-btn-home">
            <i class="bi bi-house-fill"></i> Anasəhfəyə Qayıt
        </a>
        <button onclick="history.back()" class="err-btn-back">
            <i class="bi bi-arrow-left"></i> Geri Qayıt
        </button>
    </div>

    <div class="err-links">
        <a href="students.jsp" class="err-link"><i class="bi bi-people-fill me-1"></i>Tələbələr</a>
        <a href="teachers.jsp" class="err-link"><i class="bi bi-person-badge me-1"></i>Müəllimlər</a>
        <a href="courses.jsp"  class="err-link"><i class="bi bi-journal-bookmark me-1"></i>Kurslar</a>
        <a href="dashboard.jsp" class="err-link"><i class="bi bi-speedometer2 me-1"></i>Dashboard</a>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
/* Ulduz generatoru */
(function(){
    var container = document.getElementById('errStars');
    for(var i=0;i<80;i++){
        var s=document.createElement('div');
        s.className='err-star';
        s.style.left=Math.random()*100+'%';
        s.style.top=Math.random()*100+'%';
        var dur=(2+Math.random()*4).toFixed(1)+'s';
        var delay=(Math.random()*4).toFixed(1)+'s';
        s.style.setProperty('--dur',dur);
        s.style.animationDelay=delay;
        container.appendChild(s);
    }
})();
</script>
</body>
</html>
