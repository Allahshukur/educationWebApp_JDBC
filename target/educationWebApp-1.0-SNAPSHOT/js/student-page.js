/* ============================================================
   STUDENT-PAGE.JS  v2.0
   3D Tilt + Particles + Flip Cards + SVG Circular Progress
   + Stagger Reveal + Confetti Burst + Neon Glow
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
                p.style.width  = size + 'px';
                p.style.height = size + 'px';
                p.style.left   = Math.random() * 100 + '%';
                p.style.bottom = (Math.random() * 50) + 'px';
                p.style.animationDuration = (Math.random() * 5 + 3) + 's';
                p.style.animationDelay    = (Math.random() * 4) + 's';
                p.style.opacity           = (Math.random() * 0.4 + 0.1);
                hero.appendChild(p);
            })();
        }
    }

    /* ── 2. CONFETTI BURST ── */
    var canvas = document.getElementById('sp-confetti');
    if (canvas) {
        var ctx = canvas.getContext('2d');
        canvas.width  = window.innerWidth;
        canvas.height = window.innerHeight;
        var pieces = [];
        var colors = ['#4f46e5','#818cf8','#7c3aed','#a78bfa','#c4b5fd','#38bdf8','#34d399'];
        for (var ci = 0; ci < 100; ci++) {
            pieces.push({
                x:  Math.random() * canvas.width,
                y:  Math.random() * canvas.height - canvas.height,
                w:  Math.random() * 10 + 5,
                h:  Math.random() * 6 + 3,
                color: colors[Math.floor(Math.random() * colors.length)],
                rot:  Math.random() * 360,
                vx:  (Math.random() - 0.5) * 3,
                vy:  Math.random() * 4 + 2,
                vr:  Math.random() * 6 - 3,
                alpha: 1
            });
        }
        var frame = 0;
        function drawConfetti() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            var alive = false;
            pieces.forEach(function (p) {
                p.x  += p.vx;
                p.y  += p.vy;
                p.rot += p.vr;
                if (p.y > canvas.height * 0.6) p.alpha -= 0.018;
                if (p.alpha <= 0) return;
                alive = true;
                ctx.save();
                ctx.globalAlpha = Math.max(0, p.alpha);
                ctx.translate(p.x + p.w / 2, p.y + p.h / 2);
                ctx.rotate(p.rot * Math.PI / 180);
                ctx.fillStyle = p.color;
                ctx.fillRect(-p.w / 2, -p.h / 2, p.w, p.h);
                ctx.restore();
            });
            frame++;
            if (alive && frame < 250) requestAnimationFrame(drawConfetti);
            else { canvas.style.display = 'none'; }
        }
        setTimeout(drawConfetti, 300);
    }

    /* ── 3. SVG CIRCULAR PROGRESS ANİMASİYA ── */
    var CIRCUMFERENCE = 251.2; /* 2 * π * 40 */
    document.querySelectorAll('.sp-circle-fill').forEach(function (circle) {
        var pct = parseFloat(circle.dataset.pct || 0);
        circle.style.strokeDashoffset = CIRCUMFERENCE;
        setTimeout(function () {
            circle.style.strokeDashoffset = CIRCUMFERENCE * (1 - pct / 100);
        }, 400);
    });

    /* ── 4. 3D TİLT — info kartlar ── */
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
            card.style.transition = 'transform 0.08s ease, box-shadow 0.3s';
        });
        card.addEventListener('mouseleave', function () {
            card.style.transform  = '';
            card.style.transition = 'transform 0.55s ease, box-shadow 0.3s, border-color 0.3s';
        });
    });

    /* ── 5. SCROLL REVEAL — kartlar ── */
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
        el.style.transform  = 'translateY(30px)';
        el.style.transition = 'opacity 0.55s ease ' + (idx * 0.07) + 's, transform 0.55s ease ' + (idx * 0.07) + 's, box-shadow 0.3s, border-color 0.3s';
        observer.observe(el);
    });

    /* ── 6. TİMELİNE STAGGER ── */
    document.querySelectorAll('.sp-timeline-item').forEach(function (el, idx) {
        el.style.opacity    = '0';
        el.style.transform  = 'translateX(-18px)';
        el.style.transition = 'opacity 0.45s ease, transform 0.45s ease';
        setTimeout(function () {
            el.style.opacity   = '1';
            el.style.transform = 'translateX(0)';
        }, 500 + idx * 130);
    });

    /* ── 7. TEACHER CHIP STAGGER ── */
    document.querySelectorAll('.sp-teacher-chip').forEach(function (el, idx) {
        el.style.opacity    = '0';
        el.style.transform  = 'scale(0.8)';
        el.style.transition = 'opacity 0.35s ease, transform 0.35s ease, background 0.2s, box-shadow 0.2s';
        setTimeout(function () {
            el.style.opacity   = '1';
            el.style.transform = 'scale(1)';
        }, 350 + idx * 80);
    });

    /* ── 8. STAT CARD HOVER TİP ── */
    document.querySelectorAll('.sp-stat-flip').forEach(function (card) {
        var tip = card.querySelector('.sp-stat-flip-back');
        if (!tip) return;
        card.setAttribute('title', '');
    });

});
