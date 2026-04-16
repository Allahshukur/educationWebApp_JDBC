/* =============================================
   ADMIN PANEL — admin.js  v2.0
   ============================================= */
'use strict';

/* ─────────── 1. SIDEBAR TOGGLE ─────────── */
(function initSidebar() {
    var sidebar = document.getElementById('admSidebar');
    var overlay = document.getElementById('admOverlay');
    var toggler = document.getElementById('admSidebarToggle');

    function openSidebar() {
        if (!sidebar) return;
        sidebar.classList.add('adm-sidebar-open');
        if (overlay) overlay.classList.add('active');
        document.body.style.overflow = 'hidden';
    }
    function closeSidebar() {
        if (!sidebar) return;
        sidebar.classList.remove('adm-sidebar-open');
        if (overlay) overlay.classList.remove('active');
        document.body.style.overflow = '';
    }

    if (toggler) toggler.addEventListener('click', function () {
        sidebar.classList.contains('adm-sidebar-open') ? closeSidebar() : openSidebar();
    });
    if (overlay) overlay.addEventListener('click', closeSidebar);
    document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape') closeSidebar();
    });

    // Expose globally
    window.admSidebarClose = closeSidebar;
    window.admSidebarOpen  = openSidebar;
})();


/* ─────────── 2. DARK MODE ─────────── */
(function initDarkMode() {
    var KEY = 'adm_dark_v2';
    var body = document.body;

    function applyDark(on) {
        body.classList.toggle('adm-dark', on);
        localStorage.setItem(KEY, on ? '1' : '0');
        document.querySelectorAll('[data-adm-dark-toggle]').forEach(function (btn) {
            var icon = btn.querySelector('i');
            if (icon) icon.className = on ? 'bi bi-sun-fill' : 'bi bi-moon-stars-fill';
        });
    }

    // Load saved preference
    var saved = localStorage.getItem(KEY);
    applyDark(saved === '1');

    document.addEventListener('click', function (e) {
        var btn = e.target.closest('[data-adm-dark-toggle]');
        if (btn) applyDark(!body.classList.contains('adm-dark'));
    });

    window.admToggleDark = function () { applyDark(!body.classList.contains('adm-dark')); };
})();


/* ─────────── 3. ANIMATED COUNTERS ─────────── */
(function initCounters() {
    var counters = document.querySelectorAll('[data-counter]');
    if (!counters.length) return;
    var done = false;

    function run() {
        if (done) return;
        done = true;
        counters.forEach(function (el) {
            var target   = parseInt(el.getAttribute('data-counter'), 10) || 0;
            var duration = parseInt(el.getAttribute('data-duration') || '1500', 10);
            var start = null;
            function step(ts) {
                if (!start) start = ts;
                var p = Math.min((ts - start) / duration, 1);
                var ease = 1 - Math.pow(1 - p, 3);
                el.textContent = Math.round(ease * target).toLocaleString();
                if (p < 1) requestAnimationFrame(step);
                else el.textContent = target.toLocaleString();
            }
            requestAnimationFrame(step);
        });
    }

    if ('IntersectionObserver' in window) {
        var io = new IntersectionObserver(function (entries) {
            if (entries.some(function (e) { return e.isIntersecting; })) { run(); io.disconnect(); }
        }, { threshold: 0.2 });
        counters.forEach(function (el) { io.observe(el); });
    } else { run(); }
})();


/* ─────────── 4. PROGRESS BARS ─────────── */
(function initProgressBars() {
    var fills = document.querySelectorAll('.adm-prog-fill[data-width]');
    if (!fills.length) return;

    function animate() {
        fills.forEach(function (el) {
            el.style.width = el.getAttribute('data-width') + '%';
        });
    }

    if ('IntersectionObserver' in window) {
        var io = new IntersectionObserver(function (entries) {
            if (entries.some(function (e) { return e.isIntersecting; })) { animate(); io.disconnect(); }
        }, { threshold: 0.1 });
        fills.forEach(function (el) { io.observe(el); });
    } else {
        setTimeout(animate, 300);
    }
})();


/* ─────────── 5. MODALS ─────────── */
window.admModal = {
    open: function (id) {
        var m = document.getElementById(id);
        if (!m) return;
        m.classList.add('active');
        document.body.style.overflow = 'hidden';
    },
    close: function (id) {
        var m = document.getElementById(id);
        if (!m) return;
        m.classList.remove('active');
        document.body.style.overflow = '';
    },
    closeAll: function () {
        document.querySelectorAll('.adm-modal.active').forEach(function (m) {
            m.classList.remove('active');
        });
        document.body.style.overflow = '';
    }
};

document.addEventListener('click', function (e) {
    if (e.target.classList.contains('adm-modal')) window.admModal.closeAll();
});
document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape') window.admModal.closeAll();
});


/* ─────────── 6. TABLE SORT ─────────── */
(function initSort() {
    document.querySelectorAll('.adm-table th[data-sort]').forEach(function (th) {
        th.addEventListener('click', function () {
            var table = th.closest('table');
            var tbody = table && table.querySelector('tbody');
            if (!tbody) return;
            var col = Array.from(th.parentElement.children).indexOf(th);
            var dir = th.getAttribute('data-dir') === 'asc' ? 'desc' : 'asc';
            th.setAttribute('data-dir', dir);

            table.querySelectorAll('th[data-sort]').forEach(function (h) {
                if (h !== th) { h.removeAttribute('data-dir'); var si = h.querySelector('.si'); if (si) si.remove(); }
            });
            var si = th.querySelector('.si');
            if (!si) { si = document.createElement('span'); si.className = 'si'; th.appendChild(si); }
            si.textContent = dir === 'asc' ? ' ▲' : ' ▼';

            Array.from(tbody.querySelectorAll('tr')).sort(function (a, b) {
                var at = (a.cells[col] && a.cells[col].textContent.trim()) || '';
                var bt = (b.cells[col] && b.cells[col].textContent.trim()) || '';
                var an = parseFloat(at.replace(/[^\d.]/g, ''));
                var bn = parseFloat(bt.replace(/[^\d.]/g, ''));
                if (!isNaN(an) && !isNaN(bn)) return dir === 'asc' ? an - bn : bn - an;
                return dir === 'asc' ? at.localeCompare(bt, 'az') : bt.localeCompare(at, 'az');
            }).forEach(function (r) { tbody.appendChild(r); });
        });
    });
})();


/* ─────────── 7. PAGINATION ─────────── */
window.admPaginate = function (tableId, rowsPerPage) {
    rowsPerPage = rowsPerPage || 10;
    var table = document.getElementById(tableId);
    if (!table) return;
    var tbody = table.querySelector('tbody');
    if (!tbody) return;
    var rows = Array.from(tbody.querySelectorAll('tr'));
    var totalPages = Math.ceil(rows.length / rowsPerPage);
    if (totalPages <= 1) return;
    var cur = 1;

    function showPage(p) {
        cur = p;
        var s = (p - 1) * rowsPerPage;
        rows.forEach(function (r, i) { r.style.display = (i >= s && i < s + rowsPerPage) ? '' : 'none'; });
        renderPager();
    }

    function renderPager() {
        var pager = document.querySelector('#' + tableId).closest('.adm-card').querySelector('.adm-pagination');
        if (!pager) return;
        pager.innerHTML = '';

        // Prev
        var prev = makePagerBtn('‹');
        if (cur === 1) { prev.disabled = true; prev.style.opacity = '.4'; }
        prev.addEventListener('click', function () { if (cur > 1) showPage(cur - 1); });
        pager.appendChild(prev);

        // Pages
        for (var i = 1; i <= totalPages; i++) {
            var btn = makePagerBtn(i);
            if (i === cur) btn.classList.add('active');
            (function (pg) { btn.addEventListener('click', function () { showPage(pg); }); })(i);
            pager.appendChild(btn);
        }

        // Next
        var next = makePagerBtn('›');
        if (cur === totalPages) { next.disabled = true; next.style.opacity = '.4'; }
        next.addEventListener('click', function () { if (cur < totalPages) showPage(cur + 1); });
        pager.appendChild(next);

        // Info
        var info = document.createElement('span');
        info.style.cssText = 'margin-left:auto;font-size:.75rem;color:var(--text-sub);font-weight:600;';
        info.textContent = cur + ' / ' + totalPages + ' səhifə';
        pager.appendChild(info);
    }

    function makePagerBtn(label) {
        var b = document.createElement('button');
        b.className = 'adm-page-btn';
        b.textContent = label;
        return b;
    }

    showPage(1);
};


/* ─────────── 8. TOAST ─────────── */
window.admToast = function (msg, type) {
    type = type || 'success';
    var icons  = { success: 'bi-check-circle-fill', error: 'bi-x-circle-fill', warning: 'bi-exclamation-triangle-fill', info: 'bi-info-circle-fill' };
    var colors = { success: '#10b981', error: '#ef4444', warning: '#f59e0b', info: '#3b82f6' };

    var c = document.getElementById('_admToasts');
    if (!c) {
        c = document.createElement('div');
        c.id = '_admToasts';
        c.style.cssText = 'position:fixed;bottom:22px;right:22px;z-index:99999;display:flex;flex-direction:column;gap:9px;pointer-events:none;';
        document.body.appendChild(c);
    }
    var t = document.createElement('div');
    t.style.cssText = 'display:flex;align-items:center;gap:10px;background:var(--card-bg);border:1px solid var(--border);border-radius:12px;padding:13px 17px;' +
        'box-shadow:0 8px 32px rgba(0,0,0,.18);min-width:260px;max-width:340px;border-left:4px solid ' + colors[type] + ';' +
        'font-size:.87rem;font-weight:600;color:var(--text);pointer-events:all;animation:_admToastIn .3s ease;';
    t.innerHTML = '<i class="bi ' + icons[type] + '" style="color:' + colors[type] + ';font-size:1rem;flex-shrink:0;"></i>' +
        '<span style="flex:1;">' + msg + '</span>' +
        '<button onclick="this.parentElement.remove()" style="background:none;border:none;color:var(--text-sub);cursor:pointer;font-size:1rem;padding:0;">&times;</button>';
    c.appendChild(t);
    setTimeout(function () { t && t.remove(); }, 4000);
};

(function () {
    if (!document.getElementById('_admToastStyle')) {
        var s = document.createElement('style');
        s.id = '_admToastStyle';
        s.textContent = '@keyframes _admToastIn{from{opacity:0;transform:translateX(20px)}to{opacity:1;transform:translateX(0)}}';
        document.head.appendChild(s);
    }
})();


/* ─────────── 9. CHART DEFAULTS ─────────── */
window.admChart = {
    setup: function () {
        if (typeof Chart === 'undefined') return;
        Chart.defaults.font.family = "'Outfit', sans-serif";
        Chart.defaults.font.size   = 12;
        Chart.defaults.plugins.legend.labels.boxRadius = 5;
        Chart.defaults.animation.duration = 1000;
    },
    bar: function (id, labels, datasets, opts) {
        if (typeof Chart === 'undefined') return;
        var ctx = document.getElementById(id);
        if (!ctx) return;
        return new Chart(ctx, {
            type: 'bar',
            data: { labels: labels, datasets: datasets },
            options: Object.assign({ responsive: true, maintainAspectRatio: false }, opts || {})
        });
    },
    donut: function (id, labels, data, colors, opts) {
        if (typeof Chart === 'undefined') return;
        var ctx = document.getElementById(id);
        if (!ctx) return;
        return new Chart(ctx, {
            type: 'doughnut',
            data: { labels: labels, datasets: [{ data: data, backgroundColor: colors, borderWidth: 0, hoverOffset: 10 }] },
            options: Object.assign({ responsive: true, maintainAspectRatio: false, cutout: '68%', plugins: { legend: { position: 'bottom', labels: { padding: 14 } } } }, opts || {})
        });
    },
    line: function (id, labels, datasets, opts) {
        if (typeof Chart === 'undefined') return;
        var ctx = document.getElementById(id);
        if (!ctx) return;
        return new Chart(ctx, {
            type: 'line',
            data: { labels: labels, datasets: datasets },
            options: Object.assign({ responsive: true, maintainAspectRatio: false, tension: 0.4 }, opts || {})
        });
    }
};
document.addEventListener('DOMContentLoaded', function () { window.admChart.setup(); });


/* ─────────── 10. TABS ─────────── */
window.admTab = function (tabId, panelId) {
    document.querySelectorAll('.adm-tab-btn').forEach(function (b) { b.classList.remove('active'); });
    document.querySelectorAll('.adm-tab-panel').forEach(function (p) { p.classList.remove('active'); });
    var tab = document.getElementById(tabId);
    var panel = document.getElementById(panelId);
    if (tab)   tab.classList.add('active');
    if (panel) panel.classList.add('active');
};


/* ─────────── 11. TABLE SEARCH ─────────── */
document.addEventListener('DOMContentLoaded', function () {
    var globalSearch = document.getElementById('admSearchInput');
    if (!globalSearch) return;

    var debounce;
    globalSearch.addEventListener('input', function () {
        clearTimeout(debounce);
        debounce = setTimeout(function () {
            var q = globalSearch.value.toLowerCase().trim();
            document.querySelectorAll('.adm-table tbody tr').forEach(function (row) {
                row.style.display = (!q || row.textContent.toLowerCase().includes(q)) ? '' : 'none';
            });
        }, 200);
    });

    globalSearch.addEventListener('keydown', function (e) {
        if (e.key === 'Escape') { globalSearch.value = ''; globalSearch.dispatchEvent(new Event('input')); }
    });

    // Ctrl+K shortcut
    document.addEventListener('keydown', function (e) {
        if ((e.ctrlKey || e.metaKey) && e.key === 'k') {
            e.preventDefault();
            globalSearch.focus();
            globalSearch.select();
        }
    });
});

console.log('%c✅ Admin Panel v2.0 hazır', 'color:#4f46e5;font-weight:800;font-size:13px;');
