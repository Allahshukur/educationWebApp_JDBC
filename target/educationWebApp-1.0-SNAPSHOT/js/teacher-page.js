/* ============================================================
   TEACHER-PAGE.JS  v2.0 — 3D Tilt + Particles + Animations
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

    /* ── 1. PROGRESS BAR ANİMASİYASI ── */
    var fills = document.querySelectorAll('.tp-progress-fill');
    fills.forEach(function (el) {
        var target = el.style.width;
        el.style.width = '0';
        setTimeout(function () { el.style.width = target; }, 400);
    });

    /* ── 2. SAYAÇ ANİMASİYASI (count-up) ── */
    document.querySelectorAll('.tp-count-up').forEach(function (el) {
        var target = parseInt(el.dataset.target || el.textContent, 10);
        if (isNaN(target) || target === 0) return;
        var current = 0;
        var increment = Math.max(1, Math.ceil(target / 50));
        var timer = setInterval(function () {
            current += increment;
            if (current >= target) { current = target; clearInterval(timer); }
            el.textContent = current;
        }, 30);
    });

    /* ── 3. 3D TİLT EFFEKTİ — kartlar ── */
    var tiltCards = document.querySelectorAll('.tp-card, .tp-stat');
    tiltCards.forEach(function (card) {
        card.addEventListener('mousemove', function (e) {
            var rect   = card.getBoundingClientRect();
            var x      = e.clientX - rect.left;
            var y      = e.clientY - rect.top;
            var cx     = rect.width  / 2;
            var cy     = rect.height / 2;
            var rotX   = ((y - cy) / cy) * -7;
            var rotY   = ((x - cx) / cx) *  7;
            card.style.transform = 'perspective(900px) rotateX(' + rotX + 'deg) rotateY(' + rotY + 'deg) translateZ(6px)';
            card.style.transition = 'transform 0.08s ease, box-shadow 0.3s';
        });
        card.addEventListener('mouseleave', function () {
            card.style.transform = '';
            card.style.transition = 'transform 0.55s ease, box-shadow 0.3s, border-color 0.3s';
        });
    });

    /* ── 4. PARTICLES — hero içinə ── */
    var hero = document.querySelector('.tp-hero');
    if (hero) {
        for (var i = 0; i < 14; i++) {
            (function (i) {
                var p = document.createElement('div');
                p.className = 'tp-particle';
                var size = Math.random() * 10 + 4;
                p.style.width  = size + 'px';
                p.style.height = size + 'px';
                p.style.left   = Math.random() * 100 + '%';
                p.style.bottom = (Math.random() * 40) + 'px';
                p.style.animationDuration  = (Math.random() * 4 + 3) + 's';
                p.style.animationDelay     = (Math.random() * 3) + 's';
                p.style.opacity = (Math.random() * 0.4 + 0.1);
                hero.appendChild(p);
            })(i);
        }
    }

    /* ── 5. SCROLL REVEAL — kartlar görünüşə girəndə fade-in ── */
    var observer = new IntersectionObserver(function (entries) {
        entries.forEach(function (entry) {
            if (entry.isIntersecting) {
                entry.target.style.opacity    = '1';
                entry.target.style.transform  = 'translateY(0)';
                observer.unobserve(entry.target);
            }
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.tp-card, .tp-stat').forEach(function (el, idx) {
        el.style.opacity    = '0';
        el.style.transform  = 'translateY(28px)';
        el.style.transition = 'opacity 0.5s ease ' + (idx * 0.06) + 's, transform 0.5s ease ' + (idx * 0.06) + 's, box-shadow 0.3s, border-color 0.3s';
        observer.observe(el);
    });

    /* ── 6. TİMELİNE ITEM STAGGER ── */
    document.querySelectorAll('.tp-timeline-item').forEach(function (el, idx) {
        el.style.opacity    = '0';
        el.style.transform  = 'translateX(-16px)';
        el.style.transition = 'opacity 0.45s ease ' + (0.3 + idx * 0.1) + 's, transform 0.45s ease ' + (0.3 + idx * 0.1) + 's';
        setTimeout(function () {
            el.style.opacity   = '1';
            el.style.transform = 'translateX(0)';
        }, 500 + idx * 120);
    });

    /* ── 7. SKİLL BADGE STAGGER ── */
    document.querySelectorAll('.tp-skill-badge').forEach(function (el, idx) {
        el.style.opacity    = '0';
        el.style.transform  = 'scale(0.85)';
        el.style.transition = 'opacity 0.35s ease ' + (idx * 0.07) + 's, transform 0.35s ease ' + (idx * 0.07) + 's, box-shadow 0.2s, color 0.2s';
        setTimeout(function () {
            el.style.opacity   = '1';
            el.style.transform = 'scale(1)';
        }, 400 + idx * 80);
    });

});
