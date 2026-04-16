/* ═══════════════════════════════════════════════
   QUIZ.JS  —  Quiz Module Logic
═══════════════════════════════════════════════ */

document.addEventListener('DOMContentLoaded', function() {
    if (typeof AOS !== 'undefined') AOS.init({ duration: 800, easing: 'ease-in-out' });
});

const QUIZ_DATA = {
    java: {
        title: "Java Əsasları",
        questions: [
            { q: "Java-da 'public static void main(String[] args)' nə edir?", opts: ["Sinif yaradır", "Proqramın giriş nöqtəsi", "Dəyişən yaradır", "Metod çağırır"], ans: 1 },
            { q: "Java-da 'int' nə deməkdir?", opts: ["Tam ədəd tipi", "Onluq ədəd tipi", "Mətn tipi", "Boolean tipi"], ans: 0 },
            { q: "Java-da hansı açar söz miras almağı ifadə edir?", opts: ["implements", "extends", "inherits", "super"], ans: 1 },
            { q: "Java-da String sinifinin hansı metodu iki sətri birləşdirir?", opts: ["combine()", "merge()", "concat()", "join()"], ans: 2 },
            { q: "Java-da 'final' açar sözü nə edir?", opts: ["Metodu sürətləndirir", "Dəyişənin dəyişdirilməsini qadağan edir", "Sinifi böyüdür", "Loop yaradır"], ans: 1 },
            { q: "Java-da ArrayList-in add() metodu nə edir?", opts: ["Elementi silir", "Elementi əlavə edir", "Elementi dəyişir", "Axtarır"], ans: 1 },
            { q: "Java-da try-catch nə üçün istifadə edilir?", opts: ["Loop üçün", "İstisnaları idarə etmək üçün", "Sinif yaratmaq üçün", "Çap etmək üçün"], ans: 1 },
            { q: "Java-da interface nə edir?", opts: ["Konkret sinif", "Yalnız imzaları olan müqavilə", "Dəyişən", "Loop növü"], ans: 1 },
            { q: "Java-da 'this' açar sözü nəyə istinad edir?", opts: ["Supersinifə", "Cari sinif nüsxəsinə", "Statik metoda", "Başqa sinifə"], ans: 1 },
            { q: "Java-da HashMap nədir?", opts: ["Siyahı", "Açar-qiymət cütlərini saxlayan kolleksiya", "Növbə", "İki ölçülü massiv"], ans: 1 }
        ]
    },
    oop: {
        title: "OOP Konseptləri",
        questions: [
            { q: "OOP-da 'encapsulation' nə deməkdir?", opts: ["Miras alma", "Məlumatı gizlətmək", "Çoxbiçimlilik", "Abstraksiya"], ans: 1 },
            { q: "OOP-da 'inheritance' nə deməkdir?", opts: ["Abstraksiya", "Miras alma", "Polimorfizm", "Kapsullaşdırma"], ans: 1 },
            { q: "OOP-da 'polymorphism' nədir?", opts: ["Miras", "Eyni metodun müxtəlif davranışları", "Gizlətmə", "Sinif yaratma"], ans: 1 },
            { q: "'abstract class' ilə 'interface' arasındakı fərq?", opts: ["Heç fərq yox", "Abstract class konstruktor bilir", "Interface daha güclü", "Abstract class yalnız statik"], ans: 1 },
            { q: "Constructor nə edir?", opts: ["Sinifi silir", "Sinif nüsxəsini yaradır", "Metodu çağırır", "Dəyişən saxlayır"], ans: 1 },
            { q: "Method overriding nədir?", opts: ["Metodu silmək", "Üst sinifdən metodun yenidən yazılması", "Yeni metod yaratmaq", "Metodun kopyalanması"], ans: 1 },
            { q: "Method overloading nədir?", opts: ["Eyni adlı, müxtəlif parametrli metodlar", "Metodu silmək", "Miras alma", "Metodu kilidləmək"], ans: 0 },
            { q: "'super' açar sözü nə edir?", opts: ["Alt sinifə istinad", "Üst sinifə istinad", "Statik metoda çağırış", "Global dəyişən"], ans: 1 },
            { q: "Design Pattern nə deməkdir?", opts: ["Sinif adı", "Yenidən istifadə olunan dizayn həlləri", "Metod növü", "Loop patterni"], ans: 1 },
            { q: "Singleton pattern nədir?", opts: ["Birdən çox nüsxə", "Yalnız bir nüsxəyə icazə", "Miras alma pattern", "Fabrika pattern"], ans: 1 }
        ]
    },
    spring: {
        title: "Spring Framework",
        questions: [
            { q: "Spring IoC nə deməkdir?", opts: ["Inversion of Code", "Inversion of Control", "Input of Control", "Interface of Control"], ans: 1 },
            { q: "@RestController annotasiyası nə edir?", opts: ["HTML qaytarır", "REST endpoint yaradır", "Bean yaradır", "Konfiqurasiya edir"], ans: 1 },
            { q: "@Autowired nə edir?", opts: ["Konfiqurasiya faylı", "Asılılıqların avtomatik yeridirilməsi", "Metod çağırır", "Bean silir"], ans: 1 },
            { q: "Spring Boot nə üçündür?", opts: ["Yalnız test", "Sürətli Spring applikasiya qurma", "Verilənlər bazası", "Frontend"], ans: 1 },
            { q: "@GetMapping nə edir?", opts: ["POST sorğu", "GET HTTP sorğusunu idarə edir", "PUT sorğu", "DELETE sorğu"], ans: 1 },
            { q: "JPA nə deməkdir?", opts: ["Java Program API", "Java Persistence API", "Java Process API", "Java Protocol API"], ans: 1 },
            { q: "@Entity annotasiyası nə edir?", opts: ["Kontroler", "JPA verilənlər bazası cədvəlini təmsil edir", "Servis", "Test annotasiya"], ans: 1 },
            { q: "application.properties nədir?", opts: ["Java faylı", "Spring konfiqurasiya faylı", "HTML şablonu", "Test faylı"], ans: 1 },
            { q: "@Service annotasiyası nə deməkdir?", opts: ["Kontroler", "Repository", "Biznes məntiq sinifi", "Test sinifi"], ans: 2 },
            { q: "Spring Security nə edir?", opts: ["Yalnız şifrələr", "İcazə və autentifikasiya framework", "Verilənlər bazası", "Frontend framework"], ans: 1 }
        ]
    },
    html: {
        title: "HTML & CSS",
        questions: [
            { q: "HTML nə edir?", opts: ["Stil təyin edir", "Məzmun quruşunun əsasını yaradır", "JavaScript kodu əlavə edir", "Şəkilləri sıxır"], ans: 1 },
            { q: "<header> etiketi nə üçün istifadə olunur?", opts: ["Səhifənin əsas məzmunu", "Səhifənin üst qısmı", "Səhifənin alt qısmı", "Yan sütun"], ans: 1 },
            { q: "<meta charset='UTF-8'> nə edir?", opts: ["Stil əlavə edir", "Xarakter kodlaşdırması təyin edir", "Başlığı əlavə edir", "Şəkili əlavə edir"], ans: 1 },
            { q: "CSS nə edir?", opts: ["Məzmun yaradır", "Dizayn və stil əlavə edir", "JavaScript kodu", "Verilənləri saxlayır"], ans: 1 },
            { q: "Flexbox nə edir?", opts: ["Sadəcə sütunlar", "Bir ölçülü tərtib sistemi", "Şəkil yüklənməsi", "Animasiya sistemi"], ans: 1 },
            { q: "CSS Grid nə edir?", opts: ["Sətirlər üçün", "İki ölçülü tərtib sistemi", "Yalnız sütunlar", "Sadəcə sətir"], ans: 1 },
            { q: "<div> etiketi nə edir?", opts: ["Görüntü əlavə edir", "Bölmə yaradır", "Mətni göstərir", "Linkləri yaradır"], ans: 1 },
            { q: "Box Model-də hansı sıra doğrudur?", opts: ["Margin, Padding, Content, Border", "Content, Padding, Border, Margin", "Border, Margin, Content, Padding", "Padding, Content, Margin, Border"], ans: 1 },
            { q: "Semantic etiketlər nədir?", opts: ["Qruplaşdırıcı etiketlər", "Məzmun mənasını açıqlayan etiketlər", "Sadəcə rəng etiketləri", "Səs etiketləri"], ans: 1 },
            { q: "Responsive Dizayn nədir?", opts: ["Sadəcə böyük ekran", "Müxtəlif ekran ölçülərinə uyum", "Yalnız mobil", "Qara-ağ rəngləri"], ans: 1 }
        ]
    },
    js: {
        title: "JavaScript",
        questions: [
            { q: "JavaScript nə edir?", opts: ["Stil yaradır", "İnteraktiv davranış əlavə edir", "Verilənləri saxlayır", "Şəkilləri işləyir"], ans: 1 },
            { q: "'var' və 'let' arasındakı fərq nədir?", opts: ["Heç fərq", "let sahəsi bloka məhdudlaşır", "var daha yenidir", "Onlar eynidir"], ans: 1 },
            { q: "Arrow function nədir?", opts: ["Normal funksiya", "Qısa yazılmış funksiya", "Cəmləyici metod", "Diskdən oxuma"], ans: 1 },
            { q: "Promise nə edir?", opts: ["Bəlkə nəticə", "Gələcəkdə nəticəni təmin edir", "Heç nəticə deyil", "Heç zaman nəticə"], ans: 1 },
            { q: "async/await nə edir?", opts: ["Asinxron kodunu sadələşdir", "Spagetli kod", "Heç bir faidə", "Yalnız sadə kod"], ans: 0 },
            { q: "DOM nə deməkdir?", opts: ["Document Order Model", "Document Object Model", "Dynamic Operating Memory", "Data Operator Management"], ans: 1 },
            { q: "document.querySelector() nə edir?", opts: ["Səhifəni sorğulamaq", "CSS seçicisinə görə element tapmaq", "Hər şeyi seçmək", "Heç nə etməmək"], ans: 1 },
            { q: "event.preventDefault() nə edir?", opts: ["Hadisəni göstərir", "Standart hadisə davranışını dayandırır", "Heç nə etmir", "Hadisəni tekrarla"], ans: 1 },
            { q: "JSON nə deməkdir?", opts: ["Java Serial Object Notation", "JavaScript Object Notation", "Just Ordinary Numbers", "JavaScript Overall Network"], ans: 1 },
            { q: "'this' açar sözü nə əvəzinə istifadə olunur?", opts: ["Global obyek", "Cari kontekst/obyek", "Digər funksiya", "Sablon"], ans: 1 }
        ]
    },
    python: {
        title: "Python",
        questions: [
            { q: "Python hansı tərəfindən yaradılmışdır?", opts: ["Guido van Rossum", "Denis Ritchie", "Bjarne Stroustrup", "Mark Zuckerberg"], ans: 0 },
            { q: "Python-da print() nə edir?", opts: ["Fayl yaradır", "Konsolda çıxarır", "Dəyişən yaradır", "Çıxarır"], ans: 1 },
            { q: "Python-da list nədir?", opts: ["Bir elementli", "Müxtəlif tipli elementləri saxlayan", "Sadəcə sətir", "Sadəcə rəqəm"], ans: 1 },
            { q: "Dictionary (lüğət) nə edir?", opts: ["Açar-qiymət cütləri", "Sadəcə sətri saxlayır", "Sadəcə rəqəmlər", "Heç nə saxlamır"], ans: 0 },
            { q: "Python-da for döngüsü necə yazılır?", opts: ["for(i=0; i<10; i++)", "for i in range(10):", "repeat i 10", "cycle i to 10"], ans: 1 },
            { q: "lambda funksiyası nədir?", opts: ["Böyük funksiya", "Anonim qısa funksiya", "Sınıf yoxdur", "Sadəcə dəyişən"], ans: 1 },
            { q: "Python-da '__init__' nə edir?", opts: ["Konstruktor metod", "Silinən metod", "Boş funksiya", "Sadəcə ad"], ans: 0 },
            { q: "'self' parametri nə edir?", opts: ["Sinif nəticəsi", "Cari sinif nüsxəsinə istinad", "Çıxarma", "Heç nə"], ans: 1 },
            { q: "Python-da try/except nə edir?", opts: ["Cəsarətli kod", "Xəta işləməsi", "Sadəcə etiket", "Boş blok"], ans: 1 },
            { q: "Python-da '__name__' nədir?", opts: ["Sınıf adı", "Modul adı", "Əgər scriptdirəm '=>__main__'", "Heç nədir"], ans: 2 }
        ]
    }
};

// State Variables
let currentQuiz = null;
let currentQuestion = 0;
let answers = [];
let quizTimer = 300;
let timerInterval = null;

function startQuiz(key) {
    currentQuiz = key;
    currentQuestion = 0;
    answers = new Array(QUIZ_DATA[key].questions.length).fill(null);
    quizTimer = 300;

    document.getElementById('quizStart').classList.add('d-none');
    document.getElementById('quizActive').classList.remove('d-none');
    document.getElementById('quizResult').classList.add('d-none');

    renderQuestion(0);
    startTimer();
}

function renderQuestion(idx) {
    currentQuestion = idx;
    const questions = QUIZ_DATA[currentQuiz].questions;
    const q = questions[idx];

    document.getElementById('courseTitle').textContent = QUIZ_DATA[currentQuiz].title;
    document.getElementById('questionProgress').textContent = 'Sual ' + (idx + 1) + ' / ' + questions.length;
    document.getElementById('qText').textContent = q.q;

    const letters = ['A', 'B', 'C', 'D'];
    const optionsHtml = q.opts.map(function(opt, i) {
        const selected = answers[idx] === i ? 'selected' : '';
        return '<div class="quiz-option ' + selected + '" onclick="selectAnswer(' + i + ')">' +
               '<div class="quiz-option-letter">' + letters[i] + '</div>' +
               '<span>' + opt + '</span></div>';
    }).join('');

    document.getElementById('qOptions').innerHTML = optionsHtml;
    updateNavigation();

    const isLast = idx === questions.length - 1;
    document.getElementById('nextBtn').innerHTML = isLast
        ? 'Nəticələr<i class="bi bi-check-circle ms-1"></i>'
        : 'Sonrakı<i class="bi bi-chevron-right ms-1"></i>';
}

function selectAnswer(optIdx) {
    answers[currentQuestion] = optIdx;
    const options = document.querySelectorAll('.quiz-option');
    options.forEach(function(opt, i) {
        opt.classList.remove('selected');
        if (i === optIdx) opt.classList.add('selected');
    });
    updateNavigation();
}

function updateNavigation() {
    const questions = QUIZ_DATA[currentQuiz].questions;
    const navHtml = questions.map(function(_, i) {
        const answered = answers[i] !== null ? 'answered' : '';
        const current = i === currentQuestion ? 'current' : '';
        return '<button class="quiz-nav-btn ' + answered + ' ' + current + '" onclick="renderQuestion(' + i + ')">' + (i + 1) + '</button>';
    }).join('');
    // Desktop sidebar nav
    var navEl = document.getElementById('qNav');
    if (navEl) navEl.innerHTML = navHtml;
    // Mobile nav (below questions)
    var navMobileEl = document.getElementById('qNavMobile');
    if (navMobileEl) navMobileEl.innerHTML = navHtml;
}

function nextQuestion() {
    const questions = QUIZ_DATA[currentQuiz].questions;
    if (currentQuestion === questions.length - 1) {
        showResult();
    } else {
        renderQuestion(currentQuestion + 1);
    }
}

function prevQuestion() {
    if (currentQuestion > 0) renderQuestion(currentQuestion - 1);
}

function startTimer() {
    timerInterval = setInterval(function() {
        quizTimer--;
        updateTimerDisplay();
        if (quizTimer <= 0) {
            clearInterval(timerInterval);
            showResult();
        }
    }, 1000);
}

function updateTimerDisplay() {
    const mins = Math.floor(quizTimer / 60);
    const secs = quizTimer % 60;
    const display = mins.toString().padStart(2, '0') + ':' + secs.toString().padStart(2, '0');
    const timerEl = document.getElementById('quizTimer');
    timerEl.textContent = display;
    timerEl.classList.toggle('danger', quizTimer <= 30);
    const percent = (quizTimer / 300) * 100;
    document.getElementById('timerBar').style.width = percent + '%';
}

function showResult() {
    clearInterval(timerInterval);
    const questions = QUIZ_DATA[currentQuiz].questions;
    let correct = 0, wrong = 0, skipped = 0;

    questions.forEach(function(q, i) {
        if (answers[i] === null) skipped++;
        else if (answers[i] === q.ans) correct++;
        else wrong++;
    });

    const percentage = Math.round((correct / questions.length) * 100);
    const passed = percentage >= 70;

    const circle = document.getElementById('resultCircle');
    circle.textContent = percentage + '%';
    circle.className = 'result-circle ' + (passed ? 'pass' : 'fail');

    document.getElementById('resultStatus').textContent = passed ? 'Təbriklər! Keçdiniz!' : 'Bir daha cəhd edin';
    document.getElementById('resultMessage').textContent = passed
        ? 'Siz bu kursu tamamlamaq üçün əlverişli hazırsınız!'
        : 'Daha çox çalışın və yenidən quizi təkrarlamağı cəhd edin.';

    document.getElementById('statCorrect').textContent = correct;
    document.getElementById('statWrong').textContent = wrong;
    document.getElementById('statSkipped').textContent = skipped;
    document.getElementById('statTotal').textContent = questions.length;

    const reviewHtml = questions.map(function(q, i) {
        const status = answers[i] === null ? 'unanswered' : (answers[i] === q.ans ? 'correct' : 'wrong');
        const badgeCls = status === 'correct' ? 'bg-success' : (status === 'wrong' ? 'bg-danger' : 'bg-secondary');
        const statusText = status === 'correct' ? '✓ Doğru' : (status === 'wrong' ? '✗ Yanlış' : '○ Cavabsız');
        const userAnswer = answers[i] !== null ? q.opts[answers[i]] : 'Cavab verilmədi';
        return '<div class="question-review ' + status + '">' +
               '<p class="fw-700 mb-2">Sual ' + (i + 1) + ': ' + q.q + '</p>' +
               '<p class="text-muted small mb-2">Sizin cavabınız: <strong>' + userAnswer + '</strong></p>' +
               '<p class="text-muted small mb-2">Doğru cavab: <strong>' + q.opts[q.ans] + '</strong></p>' +
               '<p class="small"><span class="badge ' + badgeCls + '">' + statusText + '</span></p>' +
               '</div>';
    }).join('');

    document.getElementById('reviewSection').innerHTML = reviewHtml;

    document.getElementById('quizStart').classList.add('d-none');
    document.getElementById('quizActive').classList.add('d-none');
    document.getElementById('quizResult').classList.remove('d-none');
}

function resetQuiz() {
    currentQuiz = null;
    currentQuestion = 0;
    answers = [];
    quizTimer = 300;
    clearInterval(timerInterval);

    document.getElementById('quizStart').classList.remove('d-none');
    document.getElementById('quizActive').classList.add('d-none');
    document.getElementById('quizResult').classList.add('d-none');
}
