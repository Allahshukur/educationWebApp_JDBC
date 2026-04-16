/* ═══════════════════════════════════════════════
   ANNOUNCEMENTS.JS  —  Elanlar Səhifəsi
═══════════════════════════════════════════════ */

function filterAnnouncements() {
    const categoryFilter = document.getElementById('categoryFilter').value;
    const readFilter = document.getElementById('readFilter').value;

    document.querySelectorAll('.ann-card').forEach(function(card) {
        const category = card.getAttribute('data-category');
        const isUnread = card.getAttribute('data-unread') === 'true';
        let show = true;
        if (categoryFilter && category !== categoryFilter) show = false;
        if (readFilter === 'unread' && !isUnread) show = false;
        card.style.display = show ? 'block' : 'none';
    });
}

function markAsRead(button) {
    const card = button.closest('.ann-card');
    card.classList.remove('unread');
    card.setAttribute('data-unread', 'false');
    button.remove();
    updateUnreadCount();
}

function markAllAsRead() {
    document.querySelectorAll('.ann-card.unread').forEach(function(card) {
        card.classList.remove('unread');
        card.setAttribute('data-unread', 'false');
        const btn = card.querySelector('button.btn-link');
        if (btn) btn.remove();
    });
    updateUnreadCount();
}

function updateUnreadCount() {
    const count = document.querySelectorAll('.ann-card.unread').length;
    const badge = document.querySelector('.badge.bg-danger');
    if (count === 0) {
        if (badge) badge.remove();
    } else if (badge) {
        badge.textContent = count + ' yeni';
    }
}

document.addEventListener('DOMContentLoaded', function() {
    const catFilter = document.getElementById('categoryFilter');
    const readFilter = document.getElementById('readFilter');
    if (catFilter) catFilter.addEventListener('change', filterAnnouncements);
    if (readFilter) readFilter.addEventListener('change', filterAnnouncements);
});
