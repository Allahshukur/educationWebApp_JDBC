/* ============================================================
   CONFETTI.JS  v2.0
   Bütün səhifələrdə eyni konfetti — üstdən aşağı rəngli zərələr
   header.jsp vasitəsilə avtomatik yüklənir
   ============================================================ */
(function () {
    'use strict';

    function runConfetti() {
        /* Canvas yarat və body-ə əlavə et */
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

        /* Student-page.js ilə eyni rənglər və davranış */
        var colors = ['#4f46e5','#818cf8','#7c3aed','#a78bfa','#c4b5fd','#38bdf8','#34d399'];

        var pieces = [];
        for (var ci = 0; ci < 100; ci++) {
            pieces.push({
                x:     Math.random() * canvas.width,
                y:     Math.random() * canvas.height - canvas.height,
                w:     Math.random() * 10 + 5,
                h:     Math.random() * 6 + 3,
                color: colors[Math.floor(Math.random() * colors.length)],
                rot:   Math.random() * 360,
                vx:    (Math.random() - 0.5) * 3,
                vy:    Math.random() * 4 + 2,
                vr:    Math.random() * 6 - 3,
                alpha: 1
            });
        }

        var frame = 0;

        function drawConfetti() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            var alive = false;

            pieces.forEach(function (p) {
                p.x   += p.vx;
                p.y   += p.vy;
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
            if (alive && frame < 250) {
                requestAnimationFrame(drawConfetti);
            } else {
                canvas.style.display = 'none';
            }
        }

        /* 300ms gözlə — loader çəkilsin, sonra başla */
        setTimeout(drawConfetti, 300);
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', runConfetti);
    } else {
        runConfetti();
    }
})();
