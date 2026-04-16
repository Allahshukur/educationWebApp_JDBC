<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="az">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz — Education App</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css?v=3.5">
    <link rel="stylesheet" href="css/dark-mode.css?v=1.0">
    <link rel="stylesheet" href="css/edu-features.css?v=1.0">
    <link rel="stylesheet" href="css/quiz.css?v=1.2">
</head>
<body>
<%
    request.setAttribute("pageLabel", "Quiz");
    request.setAttribute("isHome", false);
%>

<jsp:include page="header.jsp" />

<!-- Hero Section -->
<div class="edu-hero edu-hero-quiz">
    <div class="container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb breadcrumb-dark">
                <li class="breadcrumb-item"><a href="index.jsp">Anasəhfə</a></li>
                <li class="breadcrumb-item active">Quiz</li>
            </ol>
        </nav>
        <div class="row align-items-center">
            <div class="col-lg-8">
                <h1 class="display-5 fw-900 mb-3">
                    <i class="bi bi-patch-question-fill me-2"></i>Online Quiz
                </h1>
                <p class="lead text-muted">Biliklərinizi yoxlayın, nəticənizi görün</p>
            </div>
        </div>
    </div>
</div>

<!-- Main Content -->
<div class="edu-main">
    <div class="container">

        <!-- Quiz Start Screen -->
        <div id="quizStart">
            <div class="edu-card p-4">
                <h3 class="mb-4 fw-800">Kurs seçin və quizi başladın</h3>
                <div class="row g-4">
                    <!-- Java -->
                    <div class="col-12 col-md-6 col-lg-4">
                        <div class="course-card edu-card p-4 text-center" onclick="startQuiz('java')" role="button">
                            <div class="bg-indigo-light rounded-2 p-3 mb-3 d-inline-block">
                                <i class="bi bi-cup-hot text-indigo" style="font-size: 2rem;"></i>
                            </div>
                            <h5 class="fw-800 mb-2">Java Əsasları</h5>
                            <p class="text-muted small mb-3">
                                <i class="bi bi-question-circle me-1"></i>10 sual
                                <span class="ms-2"><i class="bi bi-clock me-1"></i>5 dəq</span>
                            </p>
                            <span class="badge bg-indigo">Başlıçı</span>
                        </div>
                    </div>

                    <!-- OOP -->
                    <div class="col-12 col-md-6 col-lg-4">
                        <div class="course-card edu-card p-4 text-center" onclick="startQuiz('oop')" role="button">
                            <div class="bg-teal-light rounded-2 p-3 mb-3 d-inline-block">
                                <i class="bi bi-diagram-3-fill text-teal" style="font-size: 2rem;"></i>
                            </div>
                            <h5 class="fw-800 mb-2">OOP Konseptləri</h5>
                            <p class="text-muted small mb-3">
                                <i class="bi bi-question-circle me-1"></i>10 sual
                                <span class="ms-2"><i class="bi bi-clock me-1"></i>5 dəq</span>
                            </p>
                            <span class="badge bg-teal">Başlıçı</span>
                        </div>
                    </div>

                    <!-- Spring -->
                    <div class="col-12 col-md-6 col-lg-4">
                        <div class="course-card edu-card p-4 text-center" onclick="startQuiz('spring')" role="button">
                            <div class="bg-violet-light rounded-2 p-3 mb-3 d-inline-block">
                                <i class="bi bi-layers-fill text-violet" style="font-size: 2rem;"></i>
                            </div>
                            <h5 class="fw-800 mb-2">Spring Framework</h5>
                            <p class="text-muted small mb-3">
                                <i class="bi bi-question-circle me-1"></i>10 sual
                                <span class="ms-2"><i class="bi bi-clock me-1"></i>5 dəq</span>
                            </p>
                            <span class="badge bg-violet">Orta</span>
                        </div>
                    </div>

                    <!-- HTML & CSS -->
                    <div class="col-12 col-md-6 col-lg-4">
                        <div class="course-card edu-card p-4 text-center" onclick="startQuiz('html')" role="button">
                            <div class="bg-rose-light rounded-2 p-3 mb-3 d-inline-block">
                                <i class="bi bi-code-slash text-rose" style="font-size: 2rem;"></i>
                            </div>
                            <h5 class="fw-800 mb-2">HTML & CSS</h5>
                            <p class="text-muted small mb-3">
                                <i class="bi bi-question-circle me-1"></i>10 sual
                                <span class="ms-2"><i class="bi bi-clock me-1"></i>5 dəq</span>
                            </p>
                            <span class="badge bg-rose">Başlıçı</span>
                        </div>
                    </div>

                    <!-- JavaScript -->
                    <div class="col-12 col-md-6 col-lg-4">
                        <div class="course-card edu-card p-4 text-center" onclick="startQuiz('js')" role="button">
                            <div class="bg-amber-light rounded-2 p-3 mb-3 d-inline-block">
                                <i class="bi bi-lightning-fill text-amber" style="font-size: 2rem;"></i>
                            </div>
                            <h5 class="fw-800 mb-2">JavaScript</h5>
                            <p class="text-muted small mb-3">
                                <i class="bi bi-question-circle me-1"></i>10 sual
                                <span class="ms-2"><i class="bi bi-clock me-1"></i>5 dəq</span>
                            </p>
                            <span class="badge bg-amber">Orta</span>
                        </div>
                    </div>

                    <!-- Python -->
                    <div class="col-12 col-md-6 col-lg-4">
                        <div class="course-card edu-card p-4 text-center" onclick="startQuiz('python')" role="button">
                            <div class="bg-sky-light rounded-2 p-3 mb-3 d-inline-block">
                                <i class="bi bi-braces text-sky" style="font-size: 2rem;"></i>
                            </div>
                            <h5 class="fw-800 mb-2">Python</h5>
                            <p class="text-muted small mb-3">
                                <i class="bi bi-question-circle me-1"></i>10 sual
                                <span class="ms-2"><i class="bi bi-clock me-1"></i>5 dəq</span>
                            </p>
                            <span class="badge bg-sky">Başlıçı</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quiz Active Screen -->
        <div id="quizActive" class="d-none">
            <div class="row g-4">

                <!-- Timer (mobilde üstdə, desktopda sağda) -->
                <div class="col-12 col-lg-4 order-1 order-lg-2">
                    <div class="edu-card">
                        <div class="card-body text-center py-4">
                            <p class="quiz-timer-label mb-2">
                                <i class="bi bi-clock-fill me-1"></i>Qalan vaxt
                            </p>
                            <div class="quiz-timer" id="quizTimer">05:00</div>
                            <div class="progress mt-3" style="height:8px;border-radius:8px;">
                                <div class="progress-bar quiz-timer-bar" id="timerBar"
                                     role="progressbar" style="width:100%;border-radius:8px;"></div>
                            </div>
                        </div>
                    </div>

                    <!-- Sual naviqatoru — yalnız desktop -->
                    <div class="edu-card mt-4 d-none d-lg-block">
                        <div class="card-body">
                            <p class="text-muted small fw-600 mb-3 text-center">
                                <i class="bi bi-grid me-1"></i>Suallara keçid
                            </p>
                            <div class="d-flex flex-wrap justify-content-center gap-2" id="qNav"></div>
                        </div>
                    </div>
                </div>

                <!-- Sual sahəsi (mobilde ortada, desktopda solda) -->
                <div class="col-12 col-lg-8 order-2 order-lg-1">
                    <div class="edu-card quiz-question-card">

                        <!-- Card Header — centered course name + progress -->
                        <div class="quiz-card-header">
                            <div class="text-center mb-1">
                                <span class="quiz-course-label fw-700" id="courseTitle"></span>
                            </div>
                            <div class="text-center">
                                <span class="badge quiz-progress-badge" id="questionProgress"></span>
                            </div>
                        </div>

                        <!-- Question Text — centered -->
                        <div class="quiz-card-body">
                            <h5 class="quiz-question-text fw-800 mb-4 text-center" id="qText"></h5>
                            <div id="qOptions"></div>
                        </div>

                        <!-- Footer buttons -->
                        <div class="quiz-card-footer">
                            <button class="btn quiz-btn-prev" onclick="prevQuestion()">
                                <i class="bi bi-chevron-left me-1"></i>Əvvəlki
                            </button>
                            <button class="btn quiz-btn-next" id="nextBtn" onclick="nextQuestion()">
                                Sonrakı<i class="bi bi-chevron-right ms-1"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Sual naviqatoru — yalnız mobil/tablet (sualların altında) -->
                <div class="col-12 order-3 d-lg-none">
                    <div class="edu-card">
                        <div class="card-body">
                            <p class="text-muted small fw-600 mb-3 text-center">
                                <i class="bi bi-grid me-1"></i>Suallara keçid
                            </p>
                            <div class="d-flex flex-wrap justify-content-center gap-2" id="qNavMobile"></div>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <!-- Quiz Result Screen -->
        <div id="quizResult" class="d-none">
            <div class="row justify-content-center">
                <div class="col-12 col-lg-6">
                    <div class="edu-card text-center p-5">
                        <div class="result-circle" id="resultCircle"></div>
                        <h3 class="fw-800 mb-2" id="resultStatus"></h3>
                        <p class="text-muted mb-4" id="resultMessage"></p>

                        <!-- Stats -->
                        <div class="row g-3 mb-4">
                            <div class="col-6">
                                <div class="bg-light p-3 rounded-2">
                                    <p class="text-muted small mb-1">Doğru</p>
                                    <p class="fw-800 h5" id="statCorrect">0</p>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="bg-light p-3 rounded-2">
                                    <p class="text-muted small mb-1">Yanlış</p>
                                    <p class="fw-800 h5" id="statWrong">0</p>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="bg-light p-3 rounded-2">
                                    <p class="text-muted small mb-1">Cavabsız</p>
                                    <p class="fw-800 h5" id="statSkipped">0</p>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="bg-light p-3 rounded-2">
                                    <p class="text-muted small mb-1">Ümumi</p>
                                    <p class="fw-800 h5" id="statTotal">10</p>
                                </div>
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="d-grid gap-2 gap-sm-0 d-sm-flex justify-content-center">
                            <button class="btn quiz-btn-next" onclick="resetQuiz()">
                                <i class="bi bi-arrow-repeat me-1"></i>Yenidən cəhd et
                            </button>
                            <button class="btn btn-outline-secondary" onclick="resetQuiz()">
                                <i class="bi bi-arrow-left me-1"></i>Başqa quiz
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Question Review -->
            <div class="row mt-5">
                <div class="col-12">
                    <div class="edu-card p-4">
                        <h5 class="fw-800 mb-4">Suallara baxış</h5>
                        <div id="reviewSection"></div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<jsp:include page="footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script src="js/script.js?v=2.2"></script>
<script src="js/quiz.js?v=1.2"></script>

</body>
</html>