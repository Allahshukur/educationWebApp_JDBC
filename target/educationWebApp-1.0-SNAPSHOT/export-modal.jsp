<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- ═══════════════════════════════════════════════════════
     EXPORT MODAL  —  2 addımlı: Format → Sətir seçimi
     students.jsp və teachers.jsp tərəfindən include edilir
═══════════════════════════════════════════════════════ -->
<div class="modal fade" id="exportModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" style="max-width:400px;">
        <div class="modal-content border-0 shadow-lg rounded-4 overflow-hidden">

            <!-- Header -->
            <div class="modal-header border-0 px-4 pt-4 pb-2"
                 style="background:linear-gradient(135deg,#4f46e5,#7c3aed);">
                <div class="d-flex align-items-center gap-2">
                    <i class="bi bi-box-arrow-up fs-5 text-white"></i>
                    <h5 class="modal-title fw-bold mb-0 text-white">Cədvəli İxrac Et</h5>
                </div>
                <button type="button" class="btn-close btn-close-white"
                        data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body p-4">

                <!-- ── ADDIM 1: Format seçimi ── -->
                <div id="exportStep1">
                    <p class="text-muted small fw-semibold mb-3 text-uppercase"
                       style="letter-spacing:.05em;">
                        <i class="bi bi-1-circle-fill text-primary me-1"></i>
                        Format seçin
                    </p>
                    <div class="d-grid gap-2">

                        <!-- Excel -->
                        <button id="fmtExcelBtn" class="export-fmt-btn">
                            <span class="export-fmt-icon" style="background:#e8f5e9;">
                                <i class="bi bi-file-earmark-excel-fill text-success fs-4"></i>
                            </span>
                            <span class="export-fmt-info">
                                <span class="fw-bold">Excel</span>
                                <small class="text-muted d-block">.xlsx — rəngli cədvəl</small>
                            </span>
                            <i class="bi bi-chevron-right text-muted ms-auto"></i>
                        </button>

                        <!-- Word -->
                        <button id="fmtWordBtn" class="export-fmt-btn">
                            <span class="export-fmt-icon" style="background:#e3f2fd;">
                                <i class="bi bi-file-earmark-word-fill text-primary fs-4"></i>
                            </span>
                            <span class="export-fmt-info">
                                <span class="fw-bold">Word</span>
                                <small class="text-muted d-block">.doc — sənəd formatı</small>
                            </span>
                            <i class="bi bi-chevron-right text-muted ms-auto"></i>
                        </button>

                        <!-- PDF -->
                        <button id="fmtPdfBtn" class="export-fmt-btn">
                            <span class="export-fmt-icon" style="background:#fce4ec;">
                                <i class="bi bi-file-earmark-pdf-fill text-danger fs-4"></i>
                            </span>
                            <span class="export-fmt-info">
                                <span class="fw-bold">PDF</span>
                                <small class="text-muted d-block">.pdf — çap üçün ideal</small>
                            </span>
                            <i class="bi bi-chevron-right text-muted ms-auto"></i>
                        </button>

                    </div>
                </div>

                <!-- ── ADDIM 2: Sətir seçimi ── -->
                <div id="exportStep2" style="display:none;">
                    <div class="d-flex align-items-center gap-2 mb-3">
                        <button id="exportBackBtn" class="btn btn-sm btn-light rounded-circle p-1 lh-1"
                                style="width:28px;height:28px;">
                            <i class="bi bi-arrow-left" style="font-size:.75rem;"></i>
                        </button>
                        <p class="text-muted small fw-semibold mb-0 text-uppercase"
                           style="letter-spacing:.05em;">
                            <i class="bi bi-2-circle-fill text-primary me-1"></i>
                            Hansı sətirlər?
                        </p>
                        <span class="ms-auto badge rounded-pill"
                              style="background:#eef2ff;color:#4f46e5;font-size:.7rem;">
                            <i id="exportFmtIcon" class="bi bi-file-earmark me-1"></i>
                            <span id="exportFmtLabel"></span>
                        </span>
                    </div>

                    <div class="d-grid gap-2">

                        <!-- Görünənlər -->
                        <button id="exportVisibleBtn"
                                class="export-row-btn border-success">
                            <span class="export-row-icon bg-success bg-opacity-10">
                                <i class="bi bi-funnel-fill text-success fs-5"></i>
                            </span>
                            <span>
                                <span class="fw-bold d-block">Cədvəldə Görünənlər</span>
                                <small class="text-muted">
                                    Filtr / axtarış nəticəsi —
                                    <strong id="exportVisibleCount">0</strong> sətir
                                </small>
                            </span>
                        </button>

                        <!-- Hamısı -->
                        <button id="exportAllBtn"
                                class="export-row-btn border-primary">
                            <span class="export-row-icon bg-primary bg-opacity-10">
                                <i class="bi bi-database-fill text-primary fs-5"></i>
                            </span>
                            <span>
                                <span class="fw-bold d-block">Bütün Qeydlər</span>
                                <small class="text-muted">
                                    Cəmi —
                                    <strong id="exportAllCount">0</strong> sətir
                                </small>
                            </span>
                        </button>

                    </div>
                </div>

            </div><!-- /modal-body -->
        </div>
    </div>
</div>

<!-- Export modal stilləri -->
<style>
.export-fmt-btn {
    display: flex;
    align-items: center;
    gap: 14px;
    padding: 12px 14px;
    border: 1.5px solid #e5e7eb;
    border-radius: 12px;
    background: #fff;
    cursor: pointer;
    transition: border-color .2s, box-shadow .2s, transform .15s;
    text-align: left;
    width: 100%;
}
.export-fmt-btn:hover {
    border-color: #4f46e5;
    box-shadow: 0 4px 16px rgba(79,70,229,.12);
    transform: translateY(-1px);
}
.export-fmt-icon {
    width: 46px; height: 46px;
    border-radius: 10px;
    display: flex; align-items: center; justify-content: center;
    flex-shrink: 0;
}
.export-fmt-info { flex: 1; }

.export-row-btn {
    display: flex;
    align-items: center;
    gap: 14px;
    padding: 14px 16px;
    border: 1.5px solid #e5e7eb;
    border-radius: 12px;
    background: #fff;
    cursor: pointer;
    transition: box-shadow .2s, transform .15s;
    text-align: left;
    width: 100%;
}
.export-row-btn:hover {
    box-shadow: 0 4px 16px rgba(0,0,0,.1);
    transform: translateY(-1px);
}
.export-row-icon {
    width: 44px; height: 44px;
    border-radius: 10px;
    display: flex; align-items: center; justify-content: center;
    flex-shrink: 0;
}

body.dark-mode .export-fmt-btn,
body.dark-mode .export-row-btn  { background:#1e293b; border-color:#334155; color:#e2e8f0; }
body.dark-mode .export-fmt-btn:hover,
body.dark-mode .export-row-btn:hover { border-color:#818cf8; }
</style>

<!-- Font yolu: context path dəyişsə belə düzgün işləyir -->
<script>
    window.FONT_BASE_PATH = '${pageContext.request.contextPath}/fonts/';
</script>
