/* ============================================================
   TEACHER-PAGE.JS  —  teacher-page.jsp üçün JS kodlar
   ============================================================ */

/* ── overflow-hidden-init sil ── */
window.addEventListener('load', function () {
    document.body.classList.remove('overflow-hidden-init');
    document.body.style.overflow = '';
});

/* ── Dark mode ilkin yükləmə ── */
(function () {
    var saved = localStorage.getItem('darkMode');
    if (saved === 'true') document.body.classList.add('dark-mode');
})();

/* ── Progress bar animasiyası ── */
document.addEventListener('DOMContentLoaded', function () {
    var fills = document.querySelectorAll('.tp-progress-fill');
    fills.forEach(function (el) {
        var target = el.style.width;
        el.style.width = '0';
        setTimeout(function () { el.style.width = target; }, 350);
    });

    /* ── Stat sayaç animasiyası ── */
    document.querySelectorAll('.tp-count-up').forEach(function (el) {
        var target = parseInt(el.dataset.target || el.textContent, 10);
        var start  = 0;
        var dur    = 1200;
        var step   = dur / target;
        var timer  = setInterval(function () {
            start += Math.ceil(target / 60);
            if (start >= target) { start = target; clearInterval(timer); }
            el.textContent = start;
        }, step);
    });
});
