/* ================================================================
   ads.js  v4.0  —  3D In-feed Reklam Sistemi
   Her .ad-3d-card ucun: slide rotasiya + 3D tilt + bagla
   ================================================================ */
(function () {
    'use strict';

    var INTERVAL = 10000; /* 10 saniye */

    /* ── Bir kart ucun tam init ─────────────────────────────────── */
    function initCard(card) {
        var slides  = Array.from(card.querySelectorAll('.ad-3d-slide'));
        var dots    = Array.from(card.querySelectorAll('.ad-3d-dot'));
        var progBar = card.querySelector('.ad-3d-prog-bar');
        var closeBtn= card.querySelector('.ad-3d-close');
        var current = 0;
        var timer;

        if (!slides.length) return;

        /* ── Slide keçidi ── */
        function goTo(n) {
            slides[current].classList.remove('active');
            if (dots[current]) dots[current].classList.remove('active');
            current = (n + slides.length) % slides.length;
            slides[current].classList.add('active');
            if (dots[current]) dots[current].classList.add('active');
            startProg();
        }

        /* ── Progress bar sıfırla + başlat ── */
        function startProg() {
            if (!progBar) return;
            progBar.style.transition = 'none';
            progBar.style.width = '0%';
            void progBar.offsetWidth; /* reflow */
            progBar.style.transition = 'width ' + INTERVAL + 'ms linear';
            progBar.style.width = '100%';
        }

        /* ── Dot klikleri ── */
        dots.forEach(function (d, i) {
            d.addEventListener('click', function () {
                clearInterval(timer);
                goTo(i);
                timer = setInterval(next, INTERVAL);
            });
        });

        function next() { goTo(current + 1); }

        /* Baslat */
        goTo(0);
        timer = setInterval(next, INTERVAL);

        /* ── Bagla düyməsi ── */
        if (closeBtn) {
            closeBtn.addEventListener('click', function () {
                var outer = card.closest('.ad-3d-outer');
                if (!outer) return;
                clearInterval(timer);
                var h = outer.offsetHeight;
                outer.style.overflow  = 'hidden';
                outer.style.maxHeight = h + 'px';
                outer.style.transition= 'opacity .38s ease, transform .38s ease, max-height .44s ease, margin .44s ease';
                requestAnimationFrame(function () {
                    outer.style.opacity   = '0';
                    outer.style.transform = 'scale(.96) translateY(-6px)';
                    outer.style.maxHeight = '0';
                    outer.style.marginTop = '0';
                    outer.style.marginBottom = '0';
                    outer.style.paddingTop   = '0';
                    outer.style.paddingBottom= '0';
                });
                setTimeout(function () { outer.style.display = 'none'; }, 460);
            });
        }

        /* ── 3D Mouse Tilt ── */
        card.addEventListener('mousemove', function (e) {
            var r  = card.getBoundingClientRect();
            var rx = -((e.clientY - r.top  - r.height / 2) / (r.height / 2)) * 5;
            var ry =  ((e.clientX - r.left - r.width  / 2) / (r.width  / 2)) * 7;
            card.style.transform = 'rotateX(' + rx.toFixed(2) + 'deg) rotateY(' + ry.toFixed(2) + 'deg)';
        });

        card.addEventListener('mouseleave', function () {
            card.style.transform = 'rotateX(0deg) rotateY(0deg)';
        });
    }

    /* ── Sehifedeki butun kartlari init et ─────────────────────── */
    function init() {
        document.querySelectorAll('.ad-3d-card').forEach(initCard);
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }

})();
