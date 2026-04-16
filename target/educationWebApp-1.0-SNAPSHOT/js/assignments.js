/* ═══════════════════════════════════════════════
   ASSIGNMENTS.JS  —  Tapşırıqlar Səhifəsi
═══════════════════════════════════════════════ */

document.addEventListener('DOMContentLoaded', function() {
    if (typeof AOS !== 'undefined') AOS.init({ duration: 800, easing: 'ease-in-out' });
});

function openSubmitModal(assignmentTitle) {
    document.getElementById('assignmentName').value = assignmentTitle;
    document.getElementById('assignmentNotes').value = '';
    const modal = new bootstrap.Modal(document.getElementById('submitModal'));
    modal.show();
}

function submitAssignment() {
    const assignmentName = document.getElementById('assignmentName').value;

    document.querySelectorAll('.assignment-item').forEach(function(card) {
        const titleEl = card.querySelector('.assignment-title');
        if (titleEl && titleEl.textContent.trim() === assignmentName) {
            card.dataset.status = 'submitted';

            const badgeEl = card.querySelector('.status-badge');
            if (badgeEl) {
                badgeEl.classList.remove('pending');
                badgeEl.classList.add('submitted');
                badgeEl.innerHTML = '<i class="bi bi-check-circle"></i> Təqdim Edildi';
            }

            const buttonEl = card.querySelector('.d-grid button');
            if (buttonEl) {
                buttonEl.disabled = true;
                buttonEl.classList.remove('btn-primary');
                buttonEl.classList.add('btn-outline-secondary');
                buttonEl.innerHTML = '<i class="bi bi-eye me-1"></i>Baxışda';
            }
        }
    });

    bootstrap.Modal.getInstance(document.getElementById('submitModal')).hide();
    new bootstrap.Toast(document.getElementById('successToast')).show();
}

function applyFilters() {
    const statusFilter = document.getElementById('statusFilter').value;
    const courseFilter = document.getElementById('courseFilter').value;

    document.querySelectorAll('.assignment-item').forEach(function(card) {
        let show = true;
        if (statusFilter && card.dataset.status !== statusFilter) show = false;
        if (courseFilter && card.dataset.course !== courseFilter) show = false;
        card.style.display = show ? '' : 'none';
    });
}

function resetFilters() {
    document.getElementById('statusFilter').value = '';
    document.getElementById('courseFilter').value = '';
    applyFilters();
}
