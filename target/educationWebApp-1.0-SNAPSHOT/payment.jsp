<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setAttribute("pageLabel", "Ödəniş");
    request.setAttribute("isHome", false);

    // Enrolled courses with payment status
    Object[][] enrolled = {
        // {course, teacher, price, paid, dueDate, status, color}
        {"Java Əsasları",     "Əli Əliyev",       "150 ₼", "150 ₼", "Ödənilib",   "paid",    "#4f46e5"},
        {"OOP Konseptləri",   "Əli Əliyev",       "120 ₼", "120 ₼", "Ödənilib",   "paid",    "#0d9488"},
        {"Spring Framework",  "Rauf Məmmədov",    "200 ₼",  "50 ₼", "15 May 2026","debt",    "#8b5cf6"},
        {"HTML & CSS",        "Nigar Hüseynova",   "80 ₼",  "80 ₼", "Ödənilib",   "paid",    "#f43f5e"},
        {"JavaScript",        "Nigar Hüseynova",  "100 ₼", "100 ₼", "Ödənilib",   "paid",    "#f59e0b"},
    };

    // Available courses not yet enrolled (for purchase)
    Object[][] available = {
        // {course, teacher, price, oldPrice, duration, level, color, icon}
        {"Python",              "Sevinc Quliyeva", "120 ₼", "180 ₼", "36 saat", "Başlanğıc", "#0ea5e9",  "bi-code-slash"},
        {"React.js",            "Nigar Hüseynova", "180 ₼", "250 ₼", "48 saat", "Orta",      "#8b5cf6",  "bi-layout-text-window"},
        {"Verilənlər Bazası",   "Rauf Məmmədov",   "160 ₼", "220 ₼", "40 saat", "Orta",      "#0d9488",  "bi-database-fill"},
        {"Kibertəhlükəsizlik",  "Əli Əliyev",      "250 ₼", "350 ₼", "60 saat", "İrəliləmiş","#f43f5e",  "bi-shield-fill-check"},
        {"DevOps & Docker",     "Rauf Məmmədov",   "220 ₼", "300 ₼", "52 saat", "Orta",      "#f59e0b",  "bi-gear-wide-connected"},
    };

    // Payment history
    Object[][] history = {
        // {date, course, amount, method, status}
        {"10 Aprel 2026",    "Java Əsasları",    "150 ₼", "Kart",   "Uğurlu"},
        {"05 Mart 2026",     "JavaScript",       "100 ₼", "Kart",   "Uğurlu"},
        {"28 Fevral 2026",   "HTML & CSS",        "80 ₼", "Nağd",   "Uğurlu"},
        {"15 Fevral 2026",   "OOP Konseptləri",  "120 ₼", "Kart",   "Uğurlu"},
        {"01 Yanvar 2026",   "Spring Framework",  "50 ₼", "Kart",   "Uğurlu"},
    };
%>
<!DOCTYPE html>
<html lang="az">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ödəniş & Qeydiyyat - Education App</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="css/style.css?v=3.5">
    <link rel="stylesheet" href="css/dark-mode.css?v=1.0">
    <link rel="stylesheet" href="css/edu-features.css?v=1.0">

    <style>
        .pay-course-card {
            border-radius: 20px;
            overflow: hidden;
            border: 1px solid rgba(0,0,0,.07);
            background: #fff;
            transition: all .25s;
        }
        .pay-course-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 40px rgba(0,0,0,.12);
        }
        .pay-course-price {
            font-size: 1.6rem;
            font-weight: 900;
        }
        .pay-course-old {
            font-size: .9rem;
            text-decoration: line-through;
            color: #94a3b8;
        }
        .pay-badge-enrolled {
            position: absolute;
            top: 14px;
            right: 14px;
        }
        .pay-history-row:hover {
            background: rgba(79,70,229,.03);
        }
        .debt-alert {
            background: linear-gradient(135deg,#fef3c7,#fde68a);
            border: 1px solid #f59e0b;
            border-radius: 16px;
            padding: 16px 20px;
        }
        .dark-mode .pay-course-card {
            background: #1e293b;
            border-color: rgba(255,255,255,.07);
        }
        .dark-mode .debt-alert {
            background: rgba(245,158,11,.12);
            border-color: rgba(245,158,11,.3);
        }
    </style>
</head>
<body>
    <!-- Header -->
    <jsp:include page="header.jsp"/>

    <!-- Hero Section -->
    <section class="edu-hero edu-hero-grades">
        <div class="container">
            <div class="text-white">
                <h1 class="display-4 fw-900 mb-2">
                    <i class="bi bi-credit-card-fill me-2"></i>Ödəniş və Qeydiyyat
                </h1>
                <p class="fs-5 opacity-85">Kurs ödənişlərini izlə, yeni kurslara qeydiyyatdan keç</p>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <section class="edu-main">
        <div class="container">

            <!-- DEBT ALERT (show only if any course has status "debt") -->
            <div class="row mb-4">
                <div class="col-12">
                    <div class="debt-alert d-flex align-items-center justify-content-between">
                        <div>
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>
                            <strong>Spring Framework</strong> kursu üçün <strong>150 ₼</strong> borcunuz var. Son ödəniş tarixi: <strong>15 May 2026</strong>
                        </div>
                        <button type="button" class="btn btn-warning btn-sm" onclick="openPurchaseModal('Spring Framework', '150 ₼')">
                            <i class="bi bi-credit-card me-1"></i>İndi Ödə
                        </button>
                    </div>
                </div>
            </div>

            <!-- STAT CARDS -->
            <div class="row g-3 mb-5">
                <div class="col-sm-6 col-md-3">
                    <div class="edu-stat-card bg-success-subtle">
                        <div class="edu-stat-icon text-success"><i class="bi bi-graph-up"></i></div>
                        <div class="edu-stat-label">Cəmi Ödəniş</div>
                        <div class="edu-stat-value text-success">500 ₼</div>
                    </div>
                </div>
                <div class="col-sm-6 col-md-3">
                    <div class="edu-stat-card bg-primary-subtle">
                        <div class="edu-stat-icon text-primary"><i class="bi bi-journal-bookmark"></i></div>
                        <div class="edu-stat-label">Aktiv Kurslar</div>
                        <div class="edu-stat-value text-primary">5</div>
                    </div>
                </div>
                <div class="col-sm-6 col-md-3">
                    <div class="edu-stat-card bg-danger-subtle">
                        <div class="edu-stat-icon text-danger"><i class="bi bi-exclamation-triangle"></i></div>
                        <div class="edu-stat-label">Borc</div>
                        <div class="edu-stat-value text-danger">150 ₼</div>
                    </div>
                </div>
                <div class="col-sm-6 col-md-3">
                    <div class="edu-stat-card bg-warning-subtle">
                        <div class="edu-stat-icon text-warning"><i class="bi bi-calendar"></i></div>
                        <div class="edu-stat-label">Növbəti Ödəniş</div>
                        <div class="edu-stat-value text-warning">15 May</div>
                    </div>
                </div>
            </div>

            <!-- TAB NAVIGATION -->
            <ul class="nav nav-tabs mb-4" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active fw-600" id="enrolledTab" data-bs-toggle="tab" data-bs-target="#enrolledContent" type="button" role="tab">
                        <i class="bi bi-check-circle me-2"></i>Qeydiyyatlı Kurslar
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link fw-600" id="availableTab" data-bs-toggle="tab" data-bs-target="#availableContent" type="button" role="tab">
                        <i class="bi bi-plus-circle me-2"></i>Yeni Kurslar
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link fw-600" id="historyTab" data-bs-toggle="tab" data-bs-target="#historyContent" type="button" role="tab">
                        <i class="bi bi-clock-history me-2"></i>Ödəniş Tarixi
                    </button>
                </li>
            </ul>

            <!-- TAB CONTENTS -->
            <div class="tab-content">

                <!-- TAB 1: Enrolled Courses -->
                <div class="tab-pane fade show active" id="enrolledContent" role="tabpanel">
                    <div class="row g-4">
                        <% for (int i = 0; i < enrolled.length; i++) {
                            String course = (String) enrolled[i][0];
                            String teacher = (String) enrolled[i][1];
                            String price = (String) enrolled[i][2];
                            String paid = (String) enrolled[i][3];
                            String dueDate = (String) enrolled[i][4];
                            String status = (String) enrolled[i][5];
                            String color = (String) enrolled[i][6];
                            int paidAmount = Integer.parseInt(paid.replaceAll("[^0-9]", ""));
                            int totalAmount = Integer.parseInt(price.replaceAll("[^0-9]", ""));
                            int percentage = (int) ((paidAmount * 100) / totalAmount);
                        %>
                        <div class="col-12 col-md-6">
                            <div class="pay-course-card p-4" style="border-left: 4px solid <%= color %>;">
                                <h5 class="fw-700 mb-2"><%= course %></h5>
                                <p class="text-muted small mb-3"><i class="bi bi-person"></i> <%= teacher %></p>

                                <div class="mb-3">
                                    <div class="d-flex justify-content-between small fw-600 mb-2">
                                        <span>Toplam: <%= price %></span>
                                        <span>Ödəniş: <%= paid %></span>
                                    </div>
                                    <div class="progress" style="height: 6px;">
                                        <div class="progress-bar" style="width: <%= percentage %>%; background: <%= color %>;" role="progressbar"></div>
                                    </div>
                                </div>

                                <% if ("debt".equals(status)) { %>
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="badge bg-danger">Borclu: <%= price %></span>
                                    <button class="btn btn-sm btn-danger" onclick="openPurchaseModal('<%= course %>', '<%= price %>')">
                                        <i class="bi bi-credit-card me-1"></i>Ödə
                                    </button>
                                </div>
                                <% } else { %>
                                <div>
                                    <span class="badge bg-success"><i class="bi bi-check-circle me-1"></i>Ödənilib</span>
                                </div>
                                <% } %>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>

                <!-- TAB 2: Available Courses -->
                <div class="tab-pane fade" id="availableContent" role="tabpanel">
                    <div class="row g-4">
                        <% for (int i = 0; i < available.length; i++) {
                            String course = (String) available[i][0];
                            String teacher = (String) available[i][1];
                            String price = (String) available[i][2];
                            String oldPrice = (String) available[i][3];
                            String duration = (String) available[i][4];
                            String level = (String) available[i][5];
                            String color = (String) available[i][6];
                            String icon = (String) available[i][7];
                        %>
                        <div class="col-12 col-md-6 col-lg-4">
                            <div class="pay-course-card overflow-hidden">
                                <div style="background: linear-gradient(135deg, <%= color %>22, <%= color %>08); padding: 30px 20px; text-align: center;">
                                    <i class="bi <%= icon %>" style="font-size: 2.5rem; color: <%= color %>;"></i>
                                </div>
                                <div class="p-4">
                                    <h5 class="fw-700 mb-2"><%= course %></h5>
                                    <p class="text-muted small mb-3"><i class="bi bi-person"></i> <%= teacher %></p>

                                    <div class="mb-3">
                                        <div class="small mb-1"><i class="bi bi-clock"></i> <%= duration %></div>
                                        <span class="badge" style="background: <%= color %>20; color: <%= color %>;">
                                            <i class="bi bi-bar-chart me-1"></i><%= level %>
                                        </span>
                                    </div>

                                    <div class="mb-3">
                                        <div class="pay-course-price" style="color: <%= color %>;"><%= price %></div>
                                        <div class="pay-course-old"><%= oldPrice %></div>
                                    </div>

                                    <button class="btn btn-primary w-100" onclick="openPurchaseModal('<%= course %>', '<%= price %>','<%= teacher %>')">
                                        <i class="bi bi-plus-circle me-1"></i>Qeydiyyat
                                    </button>
                                </div>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>

                <!-- TAB 3: Payment History -->
                <div class="tab-pane fade" id="historyContent" role="tabpanel">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>Tarix</th>
                                    <th>Kurs</th>
                                    <th>Məbləğ</th>
                                    <th>Ödəniş üsulu</th>
                                    <th>Status</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (int i = 0; i < history.length; i++) {
                                    String date = (String) history[i][0];
                                    String histCourse = (String) history[i][1];
                                    String amount = (String) history[i][2];
                                    String method = (String) history[i][3];
                                    String histStatus = (String) history[i][4];
                                %>
                                <tr class="pay-history-row">
                                    <td><small><%= date %></small></td>
                                    <td class="fw-600"><%= histCourse %></td>
                                    <td class="fw-700"><%= amount %></td>
                                    <td><small><%= method %></small></td>
                                    <td><span class="badge bg-success"><%= histStatus %></span></td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-secondary" title="Qəbzni yüklə">
                                            <i class="bi bi-download"></i>
                                        </button>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>

        </div>
    </section>

    <!-- Purchase Modal -->
    <div class="modal fade" id="purchaseModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content rounded-4 border-0">
                <div class="modal-header border-0 pb-0">
                    <h5 class="modal-title fw-700">Kursa Qeydiyyat</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-4">
                        <label class="text-muted small fw-600 d-block mb-2">Kurs Adı</label>
                        <h6 class="fw-700" id="modalCourseName">—</h6>
                    </div>

                    <div class="mb-4">
                        <label class="text-muted small fw-600 d-block mb-2">Qiymət</label>
                        <h4 class="fw-900 text-primary" id="modalPrice">—</h4>
                    </div>

                    <div class="mb-4">
                        <label class="text-muted small fw-600 d-block mb-3">Ödəniş Üsulu</label>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="paymentMethod" id="methodCard" value="card" checked onchange="togglePaymentFields()">
                            <label class="form-check-label" for="methodCard">Kart</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="paymentMethod" id="methodCash" value="cash" onchange="togglePaymentFields()">
                            <label class="form-check-label" for="methodCash">Nağd</label>
                        </div>
                    </div>

                    <div id="cardFields" style="display: none;" class="mb-4">
                        <div class="alert alert-info small">
                            <i class="bi bi-info-circle me-2"></i>Bu forma yalnız demo məqsədlidir. Həqiqi ödəniş emal edilmir.
                        </div>
                        <div class="mb-3">
                            <label class="form-label small fw-600">Kart Nömrəsi</label>
                            <input type="text" class="form-control" placeholder="•••• •••• •••• ••••" readonly>
                        </div>
                        <div class="row g-2">
                            <div class="col-6">
                                <label class="form-label small fw-600">Sona Çatma Tarixi</label>
                                <input type="text" class="form-control" placeholder="MM/YY" readonly>
                            </div>
                            <div class="col-6">
                                <label class="form-label small fw-600">CVV</label>
                                <input type="text" class="form-control" placeholder="•••" readonly>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0 pt-0">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Ləğv Et</button>
                    <button type="button" class="btn btn-primary" onclick="confirmPurchase()">
                        <i class="bi bi-check-circle me-2"></i>Qeydiyyat
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="footer.jsp"/>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@next/dist/aos.js"></script>
    <script>
        AOS.init({ duration: 800, once: true });

        let purchaseModal = new bootstrap.Modal(document.getElementById('purchaseModal'));

        // Open purchase modal
        function openPurchaseModal(courseName, price, teacher = '') {
            document.getElementById('modalCourseName').textContent = courseName;
            document.getElementById('modalPrice').textContent = price;
            document.getElementById('cardFields').style.display = 'none';
            document.getElementById('methodCard').checked = true;
            purchaseModal.show();
        }

        // Toggle payment method fields
        function togglePaymentFields() {
            const cardFields = document.getElementById('cardFields');
            const isCard = document.getElementById('methodCard').checked;
            cardFields.style.display = isCard ? 'block' : 'none';
        }

        // Confirm purchase
        function confirmPurchase() {
            const courseName = document.getElementById('modalCourseName').textContent;
            purchaseModal.hide();

            // Show success toast
            const toastHtml = `
                <div class="toast align-items-center text-white border-0 bg-success" role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="d-flex">
                        <div class="toast-body">
                            <strong>Uğurlu!</strong><br>Qeydiyyat tamamlandı!
                        </div>
                        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
                    </div>
                </div>
            `;

            const toastContainer = document.createElement('div');
            toastContainer.className = 'toast-container position-fixed bottom-0 end-0 p-3';
            toastContainer.innerHTML = toastHtml;
            document.body.appendChild(toastContainer);

            const toast = new bootstrap.Toast(toastContainer.querySelector('.toast'));
            toast.show();

            setTimeout(() => toastContainer.remove(), 5000);
        }
    </script>
</body>
</html>
