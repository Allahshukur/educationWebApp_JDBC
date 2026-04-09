/* ============================================================
   STUDENT-PAGE.JS  —  student-page.jsp üçün bütün JS kodlar
   ============================================================ */

/* ── overflow-hidden-init sil (script.js ilə yanaşı əlavə təminat) ── */
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
    var fills = document.querySelectorAll('.sp-progress-fill');
    fills.forEach(function (el) {
        var w = el.style.width;
        el.style.width = '0';
        setTimeout(function () { el.style.width = w; }, 300);
    });
});
