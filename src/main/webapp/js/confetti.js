/* ============================================================
   CONFETTI.JS  v1.0
   Global confetti rain — səhifə yüklənəndə hər yerdə işləyir
   (student-page öz sp-confetti-ni idarə edir, orada ikinci canvas yaranmır)
   ============================================================ */
(function () {
    'use strict';

    /* sp-confetti artıq varsa (student-page) skip et */
    function spCanvasExists() {
        return !!document.getElementById('sp-confetti');
    }

    function runConfetti() {
        if (spCanvasExists()) return;

        /* Canvas yarat */
        var canvas = document.createElement('canvas');
        canvas.id = 'global-confetti';
        canvas.style.cssText = [
            'position:fixed',
            'top:0',
            'left:0',
            'width:100%',
            'height:100%',
            'pointer-events:none',
            'z-index:9999'
        ].join(';');
        document.body.appendChild(canvas);

        var ctx = canvas.getContext('2d');
        canvas.width  = window.innerWidth;
        canvas.height = window.innerHeight;

        var colors = [
            '#4f46e5','#818cf8','#7c3aed','#a78bfa',
            '#c4b5fd','#38bdf8','#34d399','#f472b6',
            '#fb923c','#facc15','#4ade80','#f87171'
        ];

        /* 120 parça yarat */
        var pieces = [];
        for (var i = 0; i < 120; i++) {
            pieces.push({
                x:     Math.random() * canvas.width,
                y:     Math.random() * canvas.height - canvas.height,   /* yuxarıdan başla */
                w:     Math.random() * 12 + 5,
                h:     Math.random() * 7 + 3,
                color: colors[Math.floor(Math.random() * colors.length)],
                rot:   Math.random() * 360,
                vx:    (Math.random() - 0.5) * 3,
                vy:    Math.random() * 4 + 2,
                vr:    Math.random() * 7 - 3.5,
                alpha: 1,
                shape: Math.random() > 0.5 ? 'rect' : 'circle'
            });
        }

        var frame = 0;

        function draw() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            var alive = false;

            pieces.forEach(function (p) {
                p.x   += p.vx;
                p.y   += p.vy;
                p.rot += p.vr;

                /* Aşağı yarıda solur */
                if (p.y > canvas.height * 0.55) {
                    p.alpha -= 0.016;
                }
                if (p.alpha <= 0) return;
                alive = true;

                ctx.save();
                ctx.globalAlpha = Math.max(0, p.alpha);
                ctx.translate(p.x + p.w / 2, p.y + p.h / 2);
                ctx.rotate(p.rot * Math.PI / 180);
                ctx.fillStyle = p.color;

                if (p.shape === 'circle') {
                    ctx.beginPath();
                    ctx.arc(0, 0, p.w / 2, 0, Math.PI * 2);
                    ctx.fill();
                } else {
                    ctx.fillRect(-p.w / 2, -p.h / 2, p.w, p.h);
                }

                ctx.restore();
            });

            frame++;
            if (alive && frame < 300) {
                requestAnimationFrame(draw);
            } else {
                canvas.style.display = 'none';
            }
        }

        /* 200ms gözlə — loader bitmişdən sonra başla */
        setTimeout(draw, 200);
    }

    /* DOM hazır olanda işlət */
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', runConfetti);
    } else {
        runConfetti();
    }
})();
