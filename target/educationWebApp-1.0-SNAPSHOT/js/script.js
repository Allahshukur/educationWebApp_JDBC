// ============================================================
// Education App — Əsas JS faylı
// ============================================================

// ------------------------------------------------------------
// GLOBAL: setupPagination — DOMContentLoaded-dən KƏNARDA
// JSP səhifələrindən birbaşa çağırılır (script.js yüklənəndən sonra)
// ------------------------------------------------------------
function setupPagination(tableId, paginationId, rowsPerPage) {
    const table = document.querySelector(tableId);
    if (!table) return;

    const tbody = table.querySelector('tbody');
    // Boş vəziyyət sətirini (colspan olan) nəzərə alma
    const rows = Array.from(tbody.querySelectorAll('tr')).filter(
        r => !r.querySelector('td[colspan]')
    );
    const paginationUl = document.getElementById(paginationId);
    if (!paginationUl) return;

    // Əgər sətir yoxdursa pagination-ı gizlət, boş mesajı göstər
    if (rows.length === 0) {
        const nav = paginationUl.closest('nav');
        if (nav) nav.style.display = 'none';
        return;
    }

    const pageCount = Math.ceil(rows.length / rowsPerPage);
    let currentPage = 1;

    function showPage(page) {
        currentPage = page;
        const start = (page - 1) * rowsPerPage;
        const end   = start + rowsPerPage;

        rows.forEach((row, index) => {
            if (index >= start && index < end) {
                row.style.display = '';
                row.style.transitionDelay = `${(index - start) * 0.05}s`;
            } else {
                row.style.display = 'none';
                row.style.transitionDelay = '0s';
            }
        });

        updatePaginationButtons();
        document.dispatchEvent(new CustomEvent('table:pageChanged', {
            detail: { tableId, paginationId, currentPage, visibleRows: rows.filter(row => row.style.display !== 'none').length }
        }));
    }

    function updatePaginationButtons() {
        // Köhnə nömrə düymələrini sil
        paginationUl.querySelectorAll('.page-num').forEach(el => el.remove());

        const nextLi = paginationUl.querySelector('li:last-child');

        for (let i = 1; i <= pageCount; i++) {
            const li = document.createElement('li');
            li.className = `page-item page-num${i === currentPage ? ' active' : ''}`;

            const a = document.createElement('a');
            a.className = 'page-link rounded-circle me-1';
            if (i !== currentPage) a.classList.add('border-0', 'bg-light');
            a.href = '#';
            a.textContent = i;
            a.addEventListener('click', e => { e.preventDefault(); showPage(i); });

            li.appendChild(a);
            paginationUl.insertBefore(li, nextLi);
        }

        // Prev / Next vəziyyəti
        const prevLi = paginationUl.querySelector('li:first-child');
        const lastLi = paginationUl.querySelector('li:last-child');
        prevLi.classList.toggle('disabled', currentPage === 1);
        lastLi.classList.toggle('disabled', currentPage === pageCount);
    }

    // Prev / Next klik hadisələri
    paginationUl.querySelector('li:first-child a').addEventListener('click', e => {
        e.preventDefault();
        if (currentPage > 1) showPage(currentPage - 1);
    });
    paginationUl.querySelector('li:last-child a').addEventListener('click', e => {
        e.preventDefault();
        if (currentPage < pageCount) showPage(currentPage + 1);
    });

    // İlk səhifəni göstər
    showPage(1);
}

// ------------------------------------------------------------
// Page Loader
// ------------------------------------------------------------
window.addEventListener('load', function () {
    const loader = document.getElementById('loader');
    if (loader) {
        setTimeout(() => {
            loader.classList.add('loader-hidden');
            document.body.classList.remove('overflow-hidden-init');
        }, 2000);
    }
});

// ------------------------------------------------------------
// DOMContentLoaded — digər bütün UI məntiqi
// ------------------------------------------------------------
document.addEventListener('DOMContentLoaded', function () {
    console.log('Education App işə düşdü.');

    // --- Navbar scroll effekti ---
    const navbar     = document.querySelector('.navbar');
    const backToTop  = document.getElementById('backToTop');

    window.addEventListener('scroll', () => {
        if (navbar) navbar.classList.toggle('shadow-sm', window.scrollY > 50);
        if (backToTop) backToTop.classList.toggle('show', window.scrollY > 300);
    });

    if (backToTop) {
        backToTop.addEventListener('click', () =>
            window.scrollTo({ top: 0, behavior: 'smooth' })
        );
    }

    // --- Aktiv nav link (URL-ə görə) ---
    const currentPage = window.location.pathname.split('/').pop() || 'index.jsp';
    document.querySelectorAll('.navbar-nav .nav-link').forEach(link => {
        const linkPage = (link.getAttribute('href') || '').split(/[?#]/)[0];
        link.classList.toggle(
            'active',
            linkPage === currentPage || (currentPage === '' && linkPage === 'index.jsp')
        );
    });

    // Nav link klik — vizual aktiv
    document.querySelectorAll('.navbar-nav .nav-link').forEach(link => {
        link.addEventListener('click', function () {
            document.querySelectorAll('.navbar-nav .nav-link').forEach(l => l.classList.remove('active'));
            this.classList.add('active');
        });
    });

    // --- Feature card hover ---
    document.querySelectorAll('.feature-card').forEach(card => {
        card.addEventListener('mouseenter', function () { this.style.cursor = 'pointer'; });
    });

    // --- Göz düyməsi: Aktiv ↔ Passiv ---
    document.addEventListener('click', function (e) {
        const btn = e.target.closest('.btn-view');
        if (!btn) return;

        const icon = btn.querySelector('i');
        const row  = btn.closest('tr');
        if (!icon || !row) return;
        const emailInline = row.querySelector('.row-email-inline');
        if (!emailInline) return;

        const expanded = row.classList.toggle('row-email-expanded');
        emailInline.classList.toggle('d-none', expanded);
        btn.classList.toggle('btn-view-passive', expanded);
        btn.setAttribute('title', expanded ? 'Email göstər' : 'Email gizlət');
        icon.className = expanded ? 'bi bi-eye-slash' : 'bi bi-eye';
    });

    // --- Form Validation ---
    function setupFormValidation(formSelector) {
        document.querySelectorAll(formSelector).forEach(form => {
            const inputs = form.querySelectorAll('input[required], select[required], textarea[required]');

            inputs.forEach(input => {
                const validate = () => {
                    const labelEl = input.closest('.mb-3, .col-6')?.querySelector('.form-label');
                    const label   = labelEl ? labelEl.innerText : 'Sahə';
                    const feedback = input.parentElement.querySelector('.invalid-feedback');
                    const empty    = input.value.trim() === '';

                    input.classList.toggle('is-invalid', empty);
                    input.classList.toggle('is-valid',   !empty);
                    if (feedback) {
                        feedback.textContent = empty ? `${label} boş qala bilməz!` : '';
                        feedback.style.display = empty ? 'block' : 'none';
                    }
                };
                input.addEventListener('input', validate);
                input.addEventListener('blur',  validate);
            });

            form.addEventListener('submit', function (e) {
                let valid = true;
                inputs.forEach(input => {
                    if (input.value.trim() === '') {
                        input.classList.add('is-invalid');
                        const feedback = input.parentElement.querySelector('.invalid-feedback');
                        if (feedback) { feedback.textContent = 'Bu sahə mütləq doldurulmalıdır!'; feedback.style.display = 'block'; }
                        valid = false;
                    }
                });
                if (!valid) {
                    e.preventDefault();
                    e.stopPropagation();
                    form.querySelector('.is-invalid')?.focus();
                }
            });
        });
    }

    setupFormValidation('form[action="student"]');
    setupFormValidation('form[action="teacher"]');
    setupFormValidation('form[action="course"]');

    // --- Modal: Student Edit ---
    const editStudentModal = document.getElementById('editStudentModal');
    if (editStudentModal) {
        editStudentModal.addEventListener('show.bs.modal', function (e) {
            const btn = e.relatedTarget;
            document.getElementById('edit-student-id-hidden').value  = btn.dataset.id;
            document.getElementById('edit-student-id-display').value = btn.dataset.id;
            document.getElementById('edit-student-name').value       = btn.dataset.name;
            document.getElementById('edit-student-surname').value    = btn.dataset.surname;
            document.getElementById('edit-student-age').value        = btn.dataset.age;
            document.getElementById('edit-student-email').value      = btn.dataset.email;
        });
    }

    // --- Modal: Student Delete ---
    const deleteStudentModal = document.getElementById('deleteStudentModal');
    if (deleteStudentModal) {
        deleteStudentModal.addEventListener('show.bs.modal', function (e) {
            const btn = e.relatedTarget;
            document.getElementById('delete-student-id').value          = btn.dataset.id;
            document.getElementById('delete-student-name').textContent  = btn.dataset.name;
        });
    }

    // --- Modal: Teacher Edit ---
    const editTeacherModal = document.getElementById('editTeacherModal');
    if (editTeacherModal) {
        editTeacherModal.addEventListener('show.bs.modal', function (e) {
            const btn = e.relatedTarget;
            document.getElementById('edit-teacher-id-hidden').value  = btn.dataset.id;
            document.getElementById('edit-teacher-id-display').value = btn.dataset.id;
            document.getElementById('edit-teacher-name').value       = btn.dataset.name;
            document.getElementById('edit-teacher-surname').value    = btn.dataset.surname;
            document.getElementById('edit-teacher-age').value        = btn.dataset.age;
            document.getElementById('edit-teacher-email').value      = btn.dataset.email;
        });
    }

    // --- Modal: Teacher Delete ---
    const deleteTeacherModal = document.getElementById('deleteTeacherModal');
    if (deleteTeacherModal) {
        deleteTeacherModal.addEventListener('show.bs.modal', function (e) {
            const btn = e.relatedTarget;
            document.getElementById('delete-teacher-id').value         = btn.dataset.id;
            document.getElementById('delete-teacher-name').textContent = btn.dataset.name;
        });
    }

    // --- Hot Reload (Development) ---
    let serverStartTime = null;
    let isReloading     = false;

    function checkServerStatus() {
        if (isReloading) return;
        fetch('system-status')
            .then(r => r.json())
            .then(data => {
                if (serverStartTime !== null && serverStartTime !== data.startTime) {
                    isReloading = true;
                    setTimeout(() => window.location.reload(), 2000);
                }
                serverStartTime = data.startTime;
            })
            .catch(() => {});
    }
    setInterval(checkServerStatus, 2000);

    // --- Counter animasiyası ---
    const counters = document.querySelectorAll('.counter-value');
    const speed    = 200;

    const startCounter = counter => {
        const target = +counter.getAttribute('data-target');
        const count  = +counter.innerText;
        const inc    = target / speed;
        if (count < target) {
            counter.innerText = Math.ceil(count + inc);
            setTimeout(() => startCounter(counter), 1);
        } else {
            counter.innerText = target;
        }
    };

    const counterObserver = new IntersectionObserver((entries, obs) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                startCounter(entry.target);
                obs.unobserve(entry.target);
            }
        });
    }, { threshold: 0.5 });

    counters.forEach(c => counterObserver.observe(c));

    // --- AOS (Animate On Scroll) Initialization ---
    if (typeof AOS !== 'undefined') {
        AOS.init({
            duration: 1000,
            once: true,
            offset: 100
        });
    }

    // ── DARK / LIGHT TOGGLE PILL ──
    const TOGGLES = [
        document.getElementById('darkToggleDesktop'),
        document.getElementById('darkToggleMobile')
    ].filter(Boolean);

    const applyDark = (isDark) => {
        document.body.classList.toggle('dark-mode', isDark);
        TOGGLES.forEach(el => {
            el.classList.toggle('is-light', !isDark);
            const knob = el.querySelector('.dtp-knob');
            if (knob) knob.innerHTML = isDark
                ? '<i class="bi bi-moon-stars-fill"></i>'
                : '<i class="bi bi-sun-fill"></i>';
            const lbl = el.querySelector('.dtp-label');
            if (lbl) lbl.innerHTML = isDark ? 'DARK<br>MODE' : 'LIGHT<br>MODE';
        });
    };

    applyDark(localStorage.getItem('darkMode') === 'true');

    TOGGLES.forEach(el => el.addEventListener('click', () => {
        const next = !document.body.classList.contains('dark-mode');
        applyDark(next);
        localStorage.setItem('darkMode', next);
    }));

    // ── DİL SEÇİCİ ──
    const LANG_LABELS = { az: 'AZ', tr: 'TR', en: 'EN', ru: 'RU' };
    const LANG_OPTS = [
        { code: 'az', flag: '🇦🇿', label: 'Azərbaycan' },
        { code: 'tr', flag: '🇹🇷', label: 'Türkçe'     },
        { code: 'en', flag: '🇬🇧', label: 'English'     },
        { code: 'ru', flag: '🇷🇺', label: 'Русский'    },
    ];

    /* --- Google Translate vasitəsilə dil dəyişdirmə --- */
    const setGoogleLang = (targetCode) => {

        // AZ seçildə — orijinal dilə qayıt
        if (targetCode === 'az') {
            // 1) GT-nin öz "Show original" düyməsini tap və click et
            const tryRestore = () => {
                // iframe içindəki restore button
                const frames = document.querySelectorAll('iframe.goog-te-menu-frame, .goog-te-banner-frame');
                frames.forEach(f => {
                    try {
                        const btn = f.contentDocument.querySelector('.goog-te-button button');
                        if (btn) btn.click();
                    } catch(e) {}
                });
                // Cookie-ni sil
                ['/', location.pathname].forEach(path => {
                    document.cookie = `googtrans=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=${path}`;
                    document.cookie = `googtrans=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=${path}; domain=${location.hostname}`;
                    document.cookie = `googtrans=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=${path}; domain=.${location.hostname}`;
                });
                // Select-i sıfırla
                const sel = document.querySelector('.goog-te-combo');
                if (sel) { sel.value = ''; sel.dispatchEvent(new Event('change')); }
                // Səhifəni yenidən yüklə
                setTimeout(() => location.reload(), 150);
            };
            tryRestore();
            return;
        }

        // Digər dillər — GT select elementini tap və dəyişdir
        const tryTranslate = () => {
            const sel = document.querySelector('.goog-te-combo');
            if (!sel) return false;
            sel.value = targetCode;
            sel.dispatchEvent(new Event('change'));
            return true;
        };

        if (!tryTranslate()) {
            let attempts = 0;
            const wait = setInterval(() => {
                if (tryTranslate() || ++attempts > 25) clearInterval(wait);
            }, 250);
        }
    };

    /* --- Mövcud dili GT cookie-dən oxu --- */
    const getCurrentLang = () => {
        const m = document.cookie.match(/googtrans=\/[a-z-]+\/([a-z-]+)/);
        return (m && LANG_LABELS[m[1]]) ? m[1] : 'az';
    };

    /* --- Portal dropdown (body-yə append, overflow problemi yoxdur) --- */
    const portal = document.createElement('div');
    portal.id = 'langDropdownPortal';
    portal.innerHTML = LANG_OPTS.map(o =>
        `<div class="lang-opt" data-lang="${o.code}">${o.flag} ${o.label}</div>`
    ).join('');
    document.body.appendChild(portal);

    let activePicker = null;

    const closePortal = () => {
        portal.classList.remove('open');
        activePicker = null;
    };

    const openPortal = (picker) => {
        const rect = picker.getBoundingClientRect();
        portal.style.top  = (rect.bottom + 6) + 'px';
        portal.style.left = (rect.left + rect.width / 2 - 77) + 'px'; // 155/2=77
        portal.classList.add('open');
        activePicker = picker;
    };

    /* --- Picker-ləri inisializ et --- */
    const initLangPickers = () => {
        const curLang = getCurrentLang();

        // Bütün picker-lərdə aktiv dili göstər
        document.querySelectorAll('.lang-pill-cur').forEach(el => {
            el.textContent = LANG_LABELS[curLang] || 'AZ';
        });

        // Portal-da aktiv dili işarələ
        portal.querySelectorAll('.lang-opt').forEach(opt => {
            opt.classList.toggle('active-lang', opt.dataset.lang === curLang);
        });

        // Picker click — portal aç/bağla
        document.querySelectorAll('.lang-pill').forEach(picker => {
            picker.addEventListener('click', (e) => {
                e.stopPropagation();
                if (activePicker === picker) { closePortal(); return; }
                openPortal(picker);
            });
        });

        // Portal-da dil seçimi
        portal.addEventListener('click', (e) => {
            e.stopPropagation();
            const opt = e.target.closest('.lang-opt');
            if (!opt) return;
            const lang = opt.dataset.lang;
            // UI-ni dərhal yenilə
            document.querySelectorAll('.lang-pill-cur').forEach(el => {
                el.textContent = LANG_LABELS[lang];
            });
            portal.querySelectorAll('.lang-opt').forEach(o => {
                o.classList.toggle('active-lang', o.dataset.lang === lang);
            });
            closePortal();
            setGoogleLang(lang);
            localStorage.setItem('appLang', lang);
        });

        // Xaricdə click-də bağla
        document.addEventListener('click', closePortal);

        // Scroll-da portal-ı yenidən pozisiyala
        window.addEventListener('scroll', () => {
            if (activePicker) openPortal(activePicker);
        }, { passive: true });
    };

    initLangPickers();

    // ── TOAST BİLDİRİŞ SİSTEMİ ──
    window.showAppToast = function(message, type = 'success', duration = 3500) {
        let container = document.getElementById('appToastContainer');
        if (!container) {
            container = document.createElement('div');
            container.id = 'appToastContainer';
            container.style.cssText = 'position:fixed;bottom:24px;right:24px;z-index:99999;display:flex;flex-direction:column-reverse;gap:10px;';
            document.body.appendChild(container);
        }
        const icons = { success: 'bi-check-circle-fill', danger: 'bi-x-circle-fill', warning: 'bi-exclamation-triangle-fill', info: 'bi-info-circle-fill' };
        const colors = { success: '#10b981', danger: '#ef4444', warning: '#f59e0b', info: '#3b82f6' };
        const toast = document.createElement('div');
        toast.style.cssText = `background:white;border-radius:14px;padding:14px 18px;box-shadow:0 8px 30px rgba(0,0,0,0.12);display:flex;align-items:center;gap:12px;font-size:14px;font-weight:500;min-width:250px;max-width:340px;border-left:4px solid ${colors[type]};animation:toastSlideIn 0.35s ease;`;
        toast.innerHTML = `<i class="bi ${icons[type]}" style="color:${colors[type]};font-size:18px;flex-shrink:0;"></i><span style="flex:1;">${message}</span><button onclick="this.parentElement.remove()" style="background:none;border:none;color:#94a3b8;cursor:pointer;padding:0;font-size:16px;line-height:1;">✕</button>`;
        container.appendChild(toast);
        setTimeout(() => { toast.style.animation = 'toastSlideOut 0.35s ease forwards'; setTimeout(() => toast.remove(), 350); }, duration);
    };
    if (!document.getElementById('toastAnimStyles')) {
        const s = document.createElement('style');
        s.id = 'toastAnimStyles';
        s.textContent = '@keyframes toastSlideIn{from{opacity:0;transform:translateX(60px)}to{opacity:1;transform:translateX(0)}}@keyframes toastSlideOut{from{opacity:1;transform:translateX(0)}to{opacity:0;transform:translateX(60px)}}';
        document.head.appendChild(s);
    }

    // ── CƏDVƏL EXPORT (CSV) ──
    window.exportTableCSV = function(tableId, filename) {
        const table = document.querySelector(tableId);
        if (!table) return;
        const rows = table.querySelectorAll('tr');
        const csv = [];
        rows.forEach(row => {
            const cols = row.querySelectorAll('th, td');
            const rowData = [];
            cols.forEach(col => {
                // data-export atributunu yoxla, yoxsa textContent
                let txt = (col.dataset.export || col.textContent).replace(/\s+/g, ' ').trim();
                txt = '"' + txt.replace(/"/g, '""') + '"';
                rowData.push(txt);
            });
            csv.push(rowData.join(','));
        });
        const blob = new Blob(['\uFEFF' + csv.join('\n')], { type: 'text/csv;charset=utf-8;' });
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url; a.download = filename || 'export.csv';
        a.click(); URL.revokeObjectURL(url);
        showAppToast('CSV faylı yükləndi! 📥', 'success');
    };

    // ── CƏDVƏL ÇAPETMƏ ──
    window.printTable = function(tableId, title) {
        const table = document.querySelector(tableId);
        if (!table) return;
        const w = window.open('', '_blank');
        w.document.write(`<html><head><title>${title||'Çap'}</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <style>body{padding:20px;}h4{margin-bottom:16px;}.table th{background:#4f46e5;color:white;}</style>
            </head><body><h4>${title||'Siyahı'}</h4><p style="color:#888;font-size:12px;">Çap tarixi: ${new Date().toLocaleString('az-AZ')}</p>
            ${table.outerHTML}</body></html>`);
        w.document.close();
        setTimeout(() => { w.print(); w.close(); }, 400);
    };

    // ── SÜTUN ÜZRƏ SIRALAMA ──
    document.querySelectorAll('table.sortable-table thead th[data-sort]').forEach(th => {
        th.style.cursor = 'pointer';
        th.addEventListener('click', function() {
            const table = this.closest('table');
            const tbody = table.querySelector('tbody');
            const col   = Array.from(this.parentElement.children).indexOf(this);
            const asc   = this.dataset.sortDir !== 'asc';
            this.dataset.sortDir = asc ? 'asc' : 'desc';
            table.querySelectorAll('thead th').forEach(h => { h.querySelector('.sort-icon')?.remove(); });
            const icon = document.createElement('i');
            icon.className = `bi bi-chevron-${asc ? 'up' : 'down'} ms-1 sort-icon`;
            icon.style.fontSize = '10px';
            this.appendChild(icon);
            const rows = Array.from(tbody.querySelectorAll('tr:not([style*="display: none"])'));
            rows.sort((a, b) => {
                const av = (a.cells[col]?.dataset.sort || a.cells[col]?.textContent || '').trim();
                const bv = (b.cells[col]?.dataset.sort || b.cells[col]?.textContent || '').trim();
                const an = parseFloat(av), bn = parseFloat(bv);
                if (!isNaN(an) && !isNaN(bn)) return asc ? an - bn : bn - an;
                return asc ? av.localeCompare(bv, 'az') : bv.localeCompare(av, 'az');
            });
            rows.forEach(r => tbody.appendChild(r));
        });
    });

    // ── KLAVIATURA QISAYOLLARI ──
    document.addEventListener('keydown', function(e) {
        // ESC — Modalları bağla
        if (e.key === 'Escape') {
            document.querySelectorAll('.modal.show').forEach(m => {
                const inst = bootstrap.Modal.getInstance(m);
                if (inst) inst.hide();
            });
        }
        // Alt+N — Yeni element əlavə et
        if (e.altKey && e.key === 'n') {
            e.preventDefault();
            const addBtn = document.querySelector('[data-bs-target*="add"]');
            if (addBtn) addBtn.click();
        }
    });

    // ── FORM SUBMIT — Toast Feedback ──
    document.querySelectorAll('form[action="student"], form[action="teacher"], form[action="course"]').forEach(form => {
        form.addEventListener('submit', function(e) {
            const action = this.querySelector('[name="action"]')?.value;
            if (!e.defaultPrevented) {
                const msgs = { create: 'Uğurla əlavə edildi! ✅', update: 'Uğurla yeniləndi! ✏️', delete: 'Uğurla silindi! 🗑️' };
                if (msgs[action]) sessionStorage.setItem('pendingToast', JSON.stringify({ msg: msgs[action], type: action === 'delete' ? 'danger' : 'success' }));
            }
        });
    });
    // Pending toast göstər (form submit-dən sonra)
    const pending = sessionStorage.getItem('pendingToast');
    if (pending) {
        sessionStorage.removeItem('pendingToast');
        setTimeout(() => { const d = JSON.parse(pending); showAppToast(d.msg, d.type); }, 600);
    }

    // ── ROW HOVER - Tooltip ──
    document.querySelectorAll('table tbody tr').forEach(row => {
        row.style.cursor = 'pointer';
    });

}); // DOMContentLoaded sonu

// ============================================================
// INDEX.JSP — Xüsusi funksiyalar
// ============================================================

// ── TYPING ANIMATION ──
function initTypingAnimation() {
    const el = document.getElementById('typingText');
    if (!el) return;
    const words = ['Qurun', 'Dəyişdirin', 'Kəşf Edin', 'İnkişaf Etdirin'];
    let wi = 0, ci = 0, deleting = false;
    function type() {
        const w = words[wi];
        el.textContent = deleting ? w.substring(0, ci--) : w.substring(0, ci++);
        if (!deleting && ci > w.length) { deleting = true; setTimeout(type, 1800); return; }
        if (deleting && ci < 0) { deleting = false; wi = (wi + 1) % words.length; setTimeout(type, 400); return; }
        setTimeout(type, deleting ? 60 : 100);
    }
    setTimeout(type, 800);
}

// ── PARTICLE CANVAS ──
function initParticleCanvas() {
    const canvas = document.getElementById('heroCanvas');
    if (!canvas) return;
    const ctx = canvas.getContext('2d');
    const particles = [];
    function resizeCanvas() {
        canvas.width = canvas.offsetWidth;
        canvas.height = canvas.offsetHeight;
    }
    resizeCanvas();
    window.addEventListener('resize', resizeCanvas);
    for (let i = 0; i < 60; i++) {
        particles.push({
            x: Math.random() * canvas.width, y: Math.random() * canvas.height,
            r: Math.random() * 3 + 1, dx: (Math.random() - 0.5) * 0.6,
            dy: (Math.random() - 0.5) * 0.6, alpha: Math.random() * 0.5 + 0.1
        });
    }
    function animateParticles() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        particles.forEach(p => {
            ctx.beginPath();
            ctx.arc(p.x, p.y, p.r, 0, Math.PI * 2);
            ctx.fillStyle = `rgba(99,102,241,${p.alpha})`;
            ctx.fill();
            p.x += p.dx; p.y += p.dy;
            if (p.x < 0 || p.x > canvas.width) p.dx *= -1;
            if (p.y < 0 || p.y > canvas.height) p.dy *= -1;
        });
        for (let i = 0; i < particles.length; i++) {
            for (let j = i + 1; j < particles.length; j++) {
                const dist = Math.hypot(particles[i].x - particles[j].x, particles[i].y - particles[j].y);
                if (dist < 100) {
                    ctx.beginPath();
                    ctx.moveTo(particles[i].x, particles[i].y);
                    ctx.lineTo(particles[j].x, particles[j].y);
                    ctx.strokeStyle = `rgba(99,102,241,${0.15 * (1 - dist / 100)})`;
                    ctx.lineWidth = 1;
                    ctx.stroke();
                }
            }
        }
        requestAnimationFrame(animateParticles);
    }
    animateParticles();
}

// ── COUNTDOWN TIMER ──
function initCountdown() {
    const section = document.getElementById('countdown-section');
    if (!section) return;
    const end = new Date();
    end.setDate(end.getDate() + 5);
    end.setHours(23, 59, 59);
    const saved = localStorage.getItem('cdEnd');
    const target = saved ? new Date(saved) : end;
    if (!saved) localStorage.setItem('cdEnd', target.toISOString());
    function update() {
        const diff = target - new Date();
        if (diff <= 0) { section.style.display = 'none'; return; }
        const d = Math.floor(diff / 86400000);
        const h = Math.floor((diff % 86400000) / 3600000);
        const m = Math.floor((diff % 3600000) / 60000);
        const s = Math.floor((diff % 60000) / 1000);
        document.getElementById('cd-days').textContent  = String(d).padStart(2, '0');
        document.getElementById('cd-hours').textContent = String(h).padStart(2, '0');
        document.getElementById('cd-mins').textContent  = String(m).padStart(2, '0');
        document.getElementById('cd-secs').textContent  = String(s).padStart(2, '0');
    }
    update();
    setInterval(update, 1000);
}

// ── SKILL PROGRESS BARS ──
function initSkillBars() {
    const skillSection = document.getElementById('skillBars');
    if (!skillSection) return;
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.querySelectorAll('.skill-fill').forEach(bar => {
                    bar.style.width = bar.dataset.width + '%';
                });
                observer.unobserve(entry.target);
            }
        });
    }, { threshold: 0.3 });
    observer.observe(skillSection.closest('section'));
}

// ── TOAST NOTIFICATIONS (index) ──
function initIndexToasts() {
    const container = document.getElementById('toastContainer');
    if (!container) return;
    const toastMessages = [
        { icon: '🎓', text: 'Orxan B. Java Kursuna qoşuldu' },
        { icon: '🌟', text: 'Leyla M. Sertifikat aldı!' },
        { icon: '🔥', text: '5 nəfər bu kursa baxır' },
        { icon: '💡', text: 'Yeni UI/UX Kursu əlavə edildi' },
        { icon: '🏆', text: 'Nicat M. "Ən Yaxşı Müəllim" seçildi' },
    ];
    function showToast(msg) {
        const t = document.createElement('div');
        t.className = 'ea-toast';
        t.innerHTML = `<span style="font-size:20px">${msg.icon}</span><span>${msg.text}</span>`;
        container.appendChild(t);
        setTimeout(() => {
            t.style.animation = 'toastOut 0.4s ease forwards';
            setTimeout(() => t.remove(), 400);
        }, 3500);
    }
    let ti = 0;
    setTimeout(() => {
        showToast(toastMessages[ti++ % toastMessages.length]);
        setInterval(() => showToast(toastMessages[ti++ % toastMessages.length]), 7000);
    }, 3000);
}

// ── CHAT WIDGET ──
function toggleChat() {
    const p = document.getElementById('chatPanel');
    if (p) p.style.display = p.style.display === 'block' ? 'none' : 'block';
}

function sendChat() {
    const inp = document.getElementById('chatInput');
    if (!inp) return;
    const val = inp.value.trim();
    if (!val) return;
    const body = document.querySelector('.chat-body');
    const userMsg = document.createElement('div');
    userMsg.style.cssText = 'text-align:right;margin-bottom:8px;';
    userMsg.innerHTML = `<span style="background:#4f46e5;color:white;padding:8px 14px;border-radius:12px 12px 0 12px;font-size:14px;display:inline-block;">${val}</span>`;
    body.appendChild(userMsg);
    inp.value = '';
    setTimeout(() => {
        const botMsg = document.createElement('div');
        botMsg.innerHTML = '<div class="chat-msg">Təşəkkürlər! Tezliklə sizinlə əlaqə saxlayacağıq. 😊</div>';
        body.appendChild(botMsg);
        body.scrollTop = body.scrollHeight;
    }, 800);
    body.scrollTop = body.scrollHeight;
}

// ── INDEX BACK TO TOP (scroll listener) ──
function initIndexBackToTop() {
    const btn = document.getElementById('backToTop');
    if (!btn) return;
    window.addEventListener('scroll', () => {
        btn.style.display = window.scrollY > 300 ? 'block' : 'none';
    });
    btn.addEventListener('click', () => window.scrollTo({ top: 0, behavior: 'smooth' }));
}

// ── VIDEO MODAL ──
function openVideoModal() {
    const m = document.getElementById('videoModal');
    if (m) m.style.display = 'flex';
}
function closeVideoModal() {
    const m = document.getElementById('videoModal');
    if (m) m.style.display = 'none';
}

// ── INDEX INIT ──
document.addEventListener('DOMContentLoaded', function () {
    initTypingAnimation();
    initParticleCanvas();
    initCountdown();
    initSkillBars();
    initIndexToasts();
    initIndexBackToTop();

    // Chat input Enter key
    document.getElementById('chatInput')?.addEventListener('keypress', e => {
        if (e.key === 'Enter') sendChat();
    });
});

document.addEventListener('DOMContentLoaded', function () {
    const notifBtn = document.getElementById('notifBtn');
    const notifPanel = document.getElementById('notifPanel');
    if (notifBtn && notifPanel) {
        notifBtn.addEventListener('click', function (e) {
            e.stopPropagation();
            notifPanel.style.display = notifPanel.style.display === 'block' ? 'none' : 'block';
        });
        document.addEventListener('click', function () {
            if (notifPanel) notifPanel.style.display = 'none';
        });
        notifPanel.addEventListener('click', function (e) {
            e.stopPropagation();
        });
    }
    document.addEventListener('keydown', function (e) {
        if ((e.ctrlKey || e.metaKey) && e.key === 'k') { // Ctrl + K birlikde click oldugun yoxlayir.
            e.preventDefault();  // Brauzerin default davranışını blokla.
            const gs = document.getElementById('globalSearch');
            if (gs) {
                gs.focus();  // Fokus axtarış inputuna keçir.
                gs.select();
            }
        }
    });
});
