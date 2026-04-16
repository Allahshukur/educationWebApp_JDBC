/* ═══════════════════════════════════════════════════
   COURSE-PAGE.JS  —  Kurs Ətraflı Səhifə Skriptləri
═══════════════════════════════════════════════════ */

(function () {
    'use strict';

    /* ── Tab keçidi ─────────────────────────────── */
    var tabBtns   = document.querySelectorAll('.cp-tab-btn');
    var tabPanels = document.querySelectorAll('.cp-tab-panel');

    tabBtns.forEach(function (btn) {
        btn.addEventListener('click', function () {
            var target = btn.getAttribute('data-tab');

            tabBtns.forEach(function (b) { b.classList.remove('active'); });
            tabPanels.forEach(function (p) { p.classList.remove('active'); });

            btn.classList.add('active');
            var panel = document.getElementById('tab-' + target);
            if (panel) {
                panel.classList.add('active');
                /* Skill barları canvas anima et (Haqqında tabı açıldıqda) */
                if (target === 'about') animateSkillBars();
            }
        });
    });

    /* ── Modul Accordion ────────────────────────── */
    document.querySelectorAll('.cp-module-header').forEach(function (header) {
        header.addEventListener('click', function () {
            var module = header.closest('.cp-module');
            var isOpen = module.classList.contains('open');

            /* Hamısını bağla */
            document.querySelectorAll('.cp-module').forEach(function (m) {
                m.classList.remove('open');
            });

            /* Seçilmişi aç/bağla */
            if (!isOpen) module.classList.add('open');
        });
    });

    /* İlk modulu avtomatik aç */
    var firstModule = document.querySelector('.cp-module');
    if (firstModule) firstModule.classList.add('open');

    /* ── Skill Bar Animasiyası ───────────────────── */
    function animateSkillBars() {
        document.querySelectorAll('.cp-skill-bar-fill').forEach(function (bar) {
            var target = bar.getAttribute('data-width') || '0';
            setTimeout(function () {
                bar.style.width = target + '%';
            }, 100);
        });
    }

    /* İlk yüklemede Haqqında tabı aktiv olduğu üçün barları başlat */
    setTimeout(animateSkillBars, 400);

    /* ── Enroll düyməsi ─────────────────────────── */
    var enrollBtn = document.getElementById('cpEnrollBtn');
    if (enrollBtn) {
        enrollBtn.addEventListener('click', function () {
            enrollBtn.innerHTML = '<i class="bi bi-check2-circle"></i> Qeydiyyat tamamlandı!';
            enrollBtn.style.background = 'linear-gradient(135deg, #10b981, #059669)';
            enrollBtn.disabled = true;
        });
    }

    /* ── "Pulsuz Sına" ──────────────────────────── */
    var tryBtn = document.getElementById('cpTryBtn');
    if (tryBtn) {
        tryBtn.addEventListener('click', function () {
            tryBtn.innerHTML = '<i class="bi bi-play-circle-fill"></i> Başladı!';
            tryBtn.style.color = '#10b981';
            tryBtn.style.borderColor = '#10b981';
        });
    }

    /* ── Geri düyməsi ───────────────────────────── */
    var backBtn = document.getElementById('cpBackBtn');
    if (backBtn) {
        backBtn.addEventListener('click', function () {
            window.history.back();
        });
    }

    /* ── Paylaş düyməsi ─────────────────────────── */
    var shareBtn = document.getElementById('cpShareBtn');
    if (shareBtn) {
        shareBtn.addEventListener('click', function () {
            if (navigator.share) {
                navigator.share({
                    title: document.title,
                    url: window.location.href
                });
            } else {
                navigator.clipboard.writeText(window.location.href).then(function () {
                    shareBtn.innerHTML = '<i class="bi bi-check2"></i>';
                    setTimeout(function () {
                        shareBtn.innerHTML = '<i class="bi bi-share-fill"></i>';
                    }, 2000);
                });
            }
        });
    }

    /* ── Scroll-da sticky sidebar ───────────────── */
    var enrollCard = document.querySelector('.cp-enroll-card');
    if (enrollCard && window.innerWidth > 991) {
        var heroH = (document.querySelector('.cp-hero') || {}).offsetHeight || 0;
        window.addEventListener('scroll', function () {
            var scrolled = window.scrollY;
            if (scrolled > heroH * 0.6) {
                enrollCard.style.boxShadow = '0 8px 40px rgba(79,70,229,.20)';
            } else {
                enrollCard.style.boxShadow = '0 4px 24px rgba(0,0,0,.08)';
            }
        }, { passive: true });
    }

    /* ── Sayaç animasiyası ──────────────────────── */
    function animateCounter(el) {
        var target = parseFloat(el.getAttribute('data-count') || el.textContent);
        var isDecimal = target % 1 !== 0;
        var duration = 1200;
        var start = performance.now();

        function step(now) {
            var elapsed = now - start;
            var progress = Math.min(elapsed / duration, 1);
            var eased = 1 - Math.pow(1 - progress, 3);
            var val = target * eased;
            el.textContent = isDecimal ? val.toFixed(1) : Math.floor(val);
            if (progress < 1) requestAnimationFrame(step);
        }
        requestAnimationFrame(step);
    }

    /* IntersectionObserver ilə stat kartları görünəndə sayaç başlat */
    var counters = document.querySelectorAll('.cp-stat-val[data-count]');
    if (counters.length && 'IntersectionObserver' in window) {
        var obs = new IntersectionObserver(function (entries) {
            entries.forEach(function (entry) {
                if (entry.isIntersecting) {
                    animateCounter(entry.target);
                    obs.unobserve(entry.target);
                }
            });
        }, { threshold: 0.5 });
        counters.forEach(function (c) { obs.observe(c); });
    }

})();
