/* ============================================================
   STUDENT-PAGE.JS  v2.0
   SVG Dairəvi Progress + 3D Tilt + Particles + Flip Cards
   Stagger Reveal + Timeline + Teacher Chip Stagger
   (Konfetti → confetti.js vasitəsilə header.jsp-dən gəlir)
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

document.addEventListener('DOMContentLoaded', function () {

    /* ── 1. PARTICLES — hero içinə ── */
    var hero = document.querySelector('.sp-hero');
    if (hero) {
        for (var i = 0; i < 16; i++) {
            (function () {
                var p = document.createElement('div');
                p.className = 'sp-particle';
                var size = Math.random() * 10 + 4;
                p.style.width             = size + 'px';
                p.style.height            = size + 'px';
                p.style.left              = Math.random() * 100 + '%';
                p.style.bottom            = (Math.random() * 50) + 'px';
                p.style.animationDuration = (Math.random() * 5 + 3) + 's';
                p.style.animationDelay    = (Math.random() * 4) + 's';
                p.style.opacity           = (Math.random() * 0.4 + 0.1);
                hero.appendChild(p);
            })();
        }
    }

    /* ── 2. SVG DAİRƏVİ PROGRESS ANİMASİYA ── */
    var CIRCUMFERENCE = 251.2; /* 2 × π × 40 */
    document.querySelectorAll('.sp-circle-fill').forEach(function (circle) {
        var pct = parseFloat(circle.dataset.pct || 0);
        circle.style.strokeDasharray  = CIRCUMFERENCE;
        circle.style.strokeDashoffset = CIRCUMFERENCE;
        circle.style.transition       = 'stroke-dashoffset 1.1s cubic-bezier(0.4,0,0.2,1)';
        setTimeout(function () {
            circle.style.strokeDashoffset = CIRCUMFERENCE * (1 - pct / 100);
        }, 500);
    });

    /* ── 3. 3D TİLT — info kartlar ── */
    document.querySelectorAll('.sp-info-card').forEach(function (card) {
        card.addEventListener('mousemove', function (e) {
            var rect = card.getBoundingClientRect();
            var x    = e.clientX - rect.left;
            var y    = e.clientY - rect.top;
            var cx   = rect.width  / 2;
            var cy   = rect.height / 2;
            var rotX = ((y - cy) / cy) * -7;
            var rotY = ((x - cx) / cx) *  7;
            card.style.transform  = 'perspective(900px) rotateX(' + rotX + 'deg) rotateY(' + rotY + 'deg) translateZ(6px)';
            card.style.transition = 'transform 0.08s ease';
        });
        card.addEventListener('mouseleave', function () {
            card.style.transform  = '';
            card.style.transition = 'transform 0.55s ease, box-shadow 0.3s, border-color 0.3s';
        });
    });

    /* ── 4. SCROLL REVEAL — kartlar stagger ilə ── */
    var observer = new IntersectionObserver(function (entries) {
        entries.forEach(function (entry) {
            if (entry.isIntersecting) {
                entry.target.style.opacity   = '1';
                entry.target.style.transform = 'translateY(0)';
                observer.unobserve(entry.target);
            }
        });
    }, { threshold: 0.08 });

    document.querySelectorAll('.sp-info-card, .sp-stat-flip').forEach(function (el, idx) {
        el.style.opacity    = '0';
        el.style.transform  = 'translateY(28px)';
        el.style.transition = 'opacity 0.55s ease ' + (idx * 0.07) + 's, transform 0.55s ease ' + (idx * 0.07) + 's';
        observer.observe(el);
    });

    /* ── 5. TİMELİNE STAGGER ── */
    document.querySelectorAll('.sp-timeline-item').forEach(function (el, idx) {
        el.style.opacity    = '0';
        el.style.transform  = 'translateX(-18px)';
        el.style.transition = 'opacity 0.45s ease, transform 0.45s ease';
        setTimeout(function () {
            el.style.opacity   = '1';
            el.style.transform = 'translateX(0)';
        }, 500 + idx * 130);
    });

    /* ── 6. MÜƏLLİM CHİP STAGGER ── */
    document.querySelectorAll('.sp-teacher-chip').forEach(function (el, idx) {
        el.style.opacity    = '0';
        el.style.transform  = 'scale(0.8)';
        el.style.transition = 'opacity 0.35s ease, transform 0.35s ease, background 0.2s, box-shadow 0.2s';
        setTimeout(function () {
            el.style.opacity   = '1';
            el.style.transform = 'scale(1)';
        }, 350 + idx * 80);
    });

});
