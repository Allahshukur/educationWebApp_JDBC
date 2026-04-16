/**
 * Azerbaijani Education App Chatbot
 * Floating AI assistant widget with FAQ knowledge base
 */

(function() {
    'use strict';

    // Configuration
    const TYPING_DELAY = 1000; // ms before bot replies
    const INITIAL_CHIPS = ['Kurslar 📚', 'Quiz 🧠', 'Tapşırıqlar 📋', 'Cədvəl 🗓️', 'Ödəniş 💳'];

    // Knowledge base
    const knowledgeBase = {
        'salam': "Salam! Mən Education App-ın köməkçisiyəm 🎓 Sizə necə kömək edə bilərəm?",
        'hello': "Salam! Mən Education App-ın köməkçisiyəm 🎓 Sizə necə kömək edə bilərəm?",
        'hi': "Salam! Mən Education App-ın köməkçisiyəm 🎓 Sizə necə kömək edə bilərəm?",
        'hey': "Salam! Mən Education App-ın köməkçisiyəm 🎓 Sizə necə kömək edə bilərəm?",

        'kurs': "Platformamızda 10 kurs var: Java, OOP, Spring, HTML & CSS, JavaScript, React.js, Python, Verilənlər Bazası, Kibertəhlükəsizlik və DevOps. Hansı kurs barədə məlumat istəyirsiniz?",
        'course': "Platformamızda 10 kurs var: Java, OOP, Spring, HTML & CSS, JavaScript, React.js, Python, Verilənlər Bazası, Kibertəhlükəsizlik və DevOps. Hansı kurs barədə məlumat istəyirsiniz?",

        'qiymət': "Qiymətlərinizi grades.jsp səhifəsindən görə bilərsiniz. Ortalama bal, hərf qiyməti və kurs üzrə tərəqqi orada göstərilir.",
        'qiymətlər': "Qiymətlərinizi grades.jsp səhifəsindən görə bilərsiniz. Ortalama bal, hərf qiyməti və kurs üzrə tərəqqi orada göstərilir.",
        'grades': "Qiymətlərinizi grades.jsp səhifəsindən görə bilərsiniz. Ortalama bal, hərf qiyməti və kurs üzrə tərəqqi orada göstərilir.",

        'tapşırıq': "Tapşırıqlarınızı assignments.jsp səhifəsindən izləyə bilərsiniz. Gözləyir, Təqdim edildi və Qiymətləndirildi statusları var.",
        'assignment': "Tapşırıqlarınızı assignments.jsp səhifəsindən izləyə bilərsiniz. Gözləyir, Təqdim edildi və Qiymətləndirildi statusları var.",
        'ödev': "Tapşırıqlarınızı assignments.jsp səhifəsindən izləyə bilərsiniz. Gözləyir, Təqdim edildi və Qiymətləndirildi statusları var.",

        'quiz': "Quiz modulu quiz.jsp-dədir. 6 kurs üçün 10 sual, 5 dəqiqəlik vaxt. Nəticə dərhal göstərilir.",
        'test': "Quiz modulu quiz.jsp-dədir. 6 kurs üçün 10 sual, 5 dəqiqəlik vaxt. Nəticə dərhal göstərilir.",
        'imtahan': "Quiz modulu quiz.jsp-dədir. 6 kurs üçün 10 sual, 5 dəqiqəlik vaxt. Nəticə dərhal göstərilir.",

        'sertifikat': "Sertifikatı certificate.jsp-dən ala bilərsiniz. PDF ixrac və çap funksiyaları mövcuddur.",
        'certificate': "Sertifikatı certificate.jsp-dən ala bilərsiniz. PDF ixrac və çap funksiyaları mövcuddur.",

        'cədvəl': "Dərs cədvəlini schedule.jsp-dən görə bilərsiniz. Bakı vaxtı ilə canlı saat, bu günün dərsləri vurğulanır.",
        'schedule': "Dərs cədvəlini schedule.jsp-dən görə bilərsiniz. Bakı vaxtı ilə canlı saat, bu günün dərsləri vurğulanır.",
        'vaxt': "Dərs cədvəlini schedule.jsp-dən görə bilərsiniz. Bakı vaxtı ilə canlı saat, bu günün dərsləri vurğulanır.",

        'ödəniş': "Kurs qiymətləri 199₼-dən 399₼-ə qədərdir. Ödəniş tarixçənizi payment.jsp-dən yoxlaya bilərsiniz.",
        'payment': "Kurs qiymətləri 199₼-dən 399₼-ə qədərdir. Ödəniş tarixçənizi payment.jsp-dən yoxlaya bilərsiniz.",
        'pul': "Kurs qiymətləri 199₼-dən 399₼-ə qədərdir. Ödəniş tarixçənizi payment.jsp-dən yoxlaya bilərsiniz.",

        'davamiyyət': "Davamiyyət faizinizi attendance.jsp-dən görə bilərsiniz. Kurs üzrə həftəlik statistika mövcuddur.",
        'attendance': "Davamiyyət faizinizi attendance.jsp-dən görə bilərsiniz. Kurs üzrə həftəlik statistika mövcuddur.",

        'elan': "Müəllim elanlarını announcements.jsp-dən oxuya bilərsiniz. Bildiriş zənginə klikləyin.",
        'bildiriş': "Müəllim elanlarını announcements.jsp-dən oxuya bilərsiniz. Bildiriş zənginə klikləyin.",
        'announce': "Müəllim elanlarını announcements.jsp-dən oxuya bilərsiniz. Bildiriş zənginə klikləyin.",

        'müəllim': "Müəllimlərimiz: Əli Əliyev (Java, OOP, Kiber), Nigar Hüseynova (HTML, JS, React), Rauf Məmmədov (Spring, VB, DevOps), Sevinc Quliyeva (Python).",
        'teacher': "Müəllimlərimiz: Əli Əliyev (Java, OOP, Kiber), Nigar Hüseynova (HTML, JS, React), Rauf Məmmədov (Spring, VB, DevOps), Sevinc Quliyeva (Python).",

        'dashboard': "Dashboard-da ümumi statistika, son fəaliyyətlər və kurs tərəqqinizi görə bilərsiniz.",

        'sağ ol': "Xahiş edirəm! Başqa sualınız varsa həmişə buradayam 😊",
        'teşekkür': "Xahiş edirəm! Başqa sualınız varsa həmişə buradayam 😊",
        'thanks': "Xahiş edirəm! Başqa sualınız varsa həmişə buradayam 😊",
        'sagol': "Xahiş edirəm! Başqa sualınız varsa həmişə buradayam 😊",
    };

    const defaultReply = "Bağışlayın, bu barədə məlumatım yoxdur. Kurs, quiz, tapşırıq, qiymət, davamiyyət haqqında soruşa bilərsiniz.";

    // Inject chatbot HTML
    function injectChatbot() {
        const chatbotHtml = `
            <button id="chatbotBtn" type="button" title="Köməkçi">
                <i class="bi bi-chat-dots-fill"></i>
                <span class="cb-badge">1</span>
            </button>

            <div id="chatbotWin">
                <div id="cbHeader">
                    <div class="cb-avatar">🤖</div>
                    <div>
                        <div class="cb-title">Education AI</div>
                        <div class="cb-sub">Canlı yardım</div>
                    </div>
                    <button id="cbClose" type="button">
                        <i class="bi bi-x"></i>
                    </button>
                </div>

                <div id="cbMessages"></div>

                <div id="cbChips"></div>

                <div id="cbInputRow">
                    <input type="text" id="cbInput" placeholder="Sualınızı yazın...">
                    <button id="cbSend" type="button">
                        <i class="bi bi-send-fill"></i>
                    </button>
                </div>
            </div>
        `;

        document.body.insertAdjacentHTML('beforeend', chatbotHtml);

        // Load chatbot CSS if not already loaded
        if (!document.getElementById('chatbot-css')) {
            const link = document.createElement('link');
            link.id = 'chatbot-css';
            link.rel = 'stylesheet';
            link.href = 'css/chatbot.css';
            document.head.appendChild(link);
        }
    }

    // Initialize chatbot
    function initChatbot() {
        const btn = document.getElementById('chatbotBtn');
        const win = document.getElementById('chatbotWin');
        const closeBtn = document.getElementById('cbClose');
        const input = document.getElementById('cbInput');
        const sendBtn = document.getElementById('cbSend');
        const chipsContainer = document.getElementById('cbChips');

        // Render chips
        renderChips(INITIAL_CHIPS);

        // Toggle chat window
        btn.addEventListener('click', () => {
            win.classList.toggle('open');
            if (win.classList.contains('open')) {
                input.focus();
                // Show greeting on first open
                if (!win.dataset.initialized) {
                    setTimeout(() => {
                        addBotMessage("Salam! Mən Education App-ın köməkçisiyəm 🎓 Sizə necə kömək edə bilərəm?");
                    }, 300);
                    win.dataset.initialized = 'true';
                }
            }
        });

        closeBtn.addEventListener('click', () => {
            win.classList.remove('open');
        });

        // Send message on Enter key
        input.addEventListener('keypress', (e) => {
            if (e.key === 'Enter' && input.value.trim()) {
                sendMessage(input.value.trim());
                input.value = '';
            }
        });

        // Send button click
        sendBtn.addEventListener('click', () => {
            if (input.value.trim()) {
                sendMessage(input.value.trim());
                input.value = '';
            }
        });
    }

    // Render quick chips
    function renderChips(chips) {
        const chipsContainer = document.getElementById('cbChips');
        chipsContainer.innerHTML = '';

        chips.forEach(chip => {
            const chipBtn = document.createElement('button');
            chipBtn.className = 'cb-chip';
            chipBtn.type = 'button';
            chipBtn.textContent = chip;
            chipBtn.addEventListener('click', () => {
                sendMessage(chip);
            });
            chipsContainer.appendChild(chipBtn);
        });
    }

    // Add user message
    function addUserMessage(text) {
        const messagesContainer = document.getElementById('cbMessages');
        const msgDiv = document.createElement('div');
        msgDiv.className = 'cb-msg user';
        msgDiv.textContent = text;
        messagesContainer.appendChild(msgDiv);
        messagesContainer.scrollTop = messagesContainer.scrollHeight;
    }

    // Add bot message
    function addBotMessage(text) {
        const messagesContainer = document.getElementById('cbMessages');
        const msgDiv = document.createElement('div');
        msgDiv.className = 'cb-msg bot';
        msgDiv.textContent = text;
        messagesContainer.appendChild(msgDiv);
        messagesContainer.scrollTop = messagesContainer.scrollHeight;
    }

    // Show typing indicator
    function showTypingIndicator() {
        const messagesContainer = document.getElementById('cbMessages');
        const typingDiv = document.createElement('div');
        typingDiv.className = 'cb-typing';
        typingDiv.id = 'cb-typing-indicator';
        typingDiv.innerHTML = '<span></span><span></span><span></span>';
        messagesContainer.appendChild(typingDiv);
        messagesContainer.scrollTop = messagesContainer.scrollHeight;
    }

    // Remove typing indicator
    function removeTypingIndicator() {
        const indicator = document.getElementById('cb-typing-indicator');
        if (indicator) {
            indicator.remove();
        }
    }

    // Get bot reply based on keyword matching
    function getBotReply(input) {
        const lowerInput = input.toLowerCase().trim();

        // Direct match
        if (knowledgeBase[lowerInput]) {
            return knowledgeBase[lowerInput];
        }

        // Partial keyword match
        for (const keyword in knowledgeBase) {
            if (lowerInput.includes(keyword)) {
                return knowledgeBase[keyword];
            }
        }

        return defaultReply;
    }

    // Send message and get bot reply
    function sendMessage(text) {
        addUserMessage(text);
        showTypingIndicator();

        setTimeout(() => {
            removeTypingIndicator();
            const reply = getBotReply(text);
            addBotMessage(reply);
        }, TYPING_DELAY);
    }

    // Initialize on DOM ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', () => {
            injectChatbot();
            initChatbot();
        });
    } else {
        injectChatbot();
        initChatbot();
    }
})();
