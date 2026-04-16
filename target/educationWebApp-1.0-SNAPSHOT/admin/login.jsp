<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    /* Simple demo login — real auth would check DB */
    String error = "";
    if ("POST".equals(request.getMethod())) {
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        if ("admin".equals(user) && "admin123".equals(pass)) {
            session.setAttribute("adminUser", user);
            response.sendRedirect("index.jsp");
            return;
        } else {
            error = "İstifadəçi adı və ya şifrə yanlışdır.";
        }
    }
    if (session.getAttribute("adminUser") != null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="az">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Giriş — Education App</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link href="css/admin.css" rel="stylesheet">
    <style>
        *{box-sizing:border-box;margin:0;padding:0;}
        body{font-family:'Outfit',sans-serif;background:#0f172a;min-height:100vh;display:flex;align-items:center;justify-content:center;overflow:hidden;}

        /* BG particles */
        .login-bg{position:fixed;inset:0;z-index:0;overflow:hidden;}
        .login-orb{position:absolute;border-radius:50%;filter:blur(80px);opacity:.25;}
        .login-orb-1{width:500px;height:500px;background:radial-gradient(circle,#4f46e5,transparent);top:-150px;left:-150px;}
        .login-orb-2{width:400px;height:400px;background:radial-gradient(circle,#7c3aed,transparent);bottom:-100px;right:-100px;}
        .login-orb-3{width:300px;height:300px;background:radial-gradient(circle,#0891b2,transparent);top:50%;left:60%;}

        /* Card */
        .login-card{
            position:relative;z-index:1;
            background:rgba(255,255,255,.06);
            border:1px solid rgba(255,255,255,.12);
            border-radius:24px;
            padding:48px 40px;
            width:100%;max-width:420px;
            backdrop-filter:blur(20px);
            box-shadow:0 32px 80px rgba(0,0,0,.4);
        }
        .login-logo{
            width:60px;height:60px;border-radius:16px;
            background:linear-gradient(135deg,#4f46e5,#7c3aed);
            display:flex;align-items:center;justify-content:center;
            font-size:1.6rem;color:white;margin:0 auto 20px;
        }
        .login-title{font-size:1.6rem;font-weight:800;color:white;text-align:center;margin-bottom:4px;}
        .login-sub{font-size:.9rem;color:rgba(255,255,255,.5);text-align:center;margin-bottom:28px;}

        .login-label{font-size:.82rem;font-weight:700;color:rgba(255,255,255,.7);letter-spacing:.05em;text-transform:uppercase;display:block;margin-bottom:6px;}
        .login-input{
            width:100%;background:rgba(255,255,255,.08);border:1.5px solid rgba(255,255,255,.14);
            border-radius:12px;padding:13px 16px;font-family:'Outfit',sans-serif;font-size:.95rem;
            color:white;outline:none;transition:.2s;
        }
        .login-input::placeholder{color:rgba(255,255,255,.35);}
        .login-input:focus{border-color:#4f46e5;background:rgba(79,70,229,.12);box-shadow:0 0 0 3px rgba(79,70,229,.2);}

        .login-input-wrap{position:relative;}
        .login-eye{
            position:absolute;right:14px;top:50%;transform:translateY(-50%);
            background:none;border:none;color:rgba(255,255,255,.4);cursor:pointer;font-size:1rem;padding:0;
        }
        .login-eye:hover{color:rgba(255,255,255,.8);}

        .login-btn{
            width:100%;padding:14px;border:none;border-radius:12px;cursor:pointer;
            background:linear-gradient(135deg,#4f46e5,#7c3aed);color:white;
            font-family:'Outfit',sans-serif;font-size:1rem;font-weight:700;
            letter-spacing:.02em;transition:.2s;margin-top:8px;
        }
        .login-btn:hover{transform:translateY(-1px);box-shadow:0 8px 24px rgba(79,70,229,.5);}
        .login-btn:active{transform:translateY(0);}

        .login-err{
            background:rgba(239,68,68,.15);border:1px solid rgba(239,68,68,.35);
            border-radius:10px;padding:10px 14px;color:#fca5a5;font-size:.87rem;
            font-weight:600;display:flex;align-items:center;gap:8px;margin-bottom:16px;
        }
        .login-hint{
            text-align:center;font-size:.8rem;color:rgba(255,255,255,.3);margin-top:20px;
        }
        .login-hint code{background:rgba(255,255,255,.1);padding:2px 7px;border-radius:5px;color:rgba(255,255,255,.55);}

        .login-back{
            display:flex;align-items:center;justify-content:center;gap:6px;
            color:rgba(255,255,255,.45);font-size:.84rem;font-weight:600;
            text-decoration:none;margin-top:16px;transition:.2s;
        }
        .login-back:hover{color:rgba(255,255,255,.8);}
        .login-back i{font-size:.78rem;}
    </style>
</head>
<body>

<!-- BG -->
<div class="login-bg">
    <div class="login-orb login-orb-1"></div>
    <div class="login-orb login-orb-2"></div>
    <div class="login-orb login-orb-3"></div>
</div>

<!-- Card -->
<div class="login-card">

    <div class="login-logo"><i class="bi bi-shield-lock-fill"></i></div>
    <div class="login-title">Admin Paneli</div>
    <div class="login-sub">Education App idarəetmə sistemi</div>

    <% if (!error.isEmpty()) { %>
    <div class="login-err">
        <i class="bi bi-exclamation-triangle-fill"></i>
        <%= error %>
    </div>
    <% } %>

    <form method="post" action="login.jsp" autocomplete="off">
        <div class="mb-3">
            <label class="login-label">İstifadəçi adı</label>
            <input type="text" name="username" class="login-input"
                   placeholder="admin" autocomplete="username" required>
        </div>
        <div class="mb-4">
            <label class="login-label">Şifrə</label>
            <div class="login-input-wrap">
                <input type="password" name="password" id="passInput" class="login-input"
                       placeholder="••••••••" autocomplete="current-password" required>
                <button type="button" class="login-eye" id="eyeBtn" onclick="togglePass()">
                    <i class="bi bi-eye-fill" id="eyeIcon"></i>
                </button>
            </div>
        </div>

        <button type="submit" class="login-btn">
            <i class="bi bi-box-arrow-in-right me-2"></i>Daxil ol
        </button>
    </form>

    <div class="login-hint">
        Demo: <code>admin</code> / <code>admin123</code>
    </div>

    <a href="../index.jsp" class="login-back">
        <i class="bi bi-arrow-left"></i> Sayta qayıt
    </a>
</div>

<script>
function togglePass() {
    var input = document.getElementById('passInput');
    var icon  = document.getElementById('eyeIcon');
    if (input.type === 'password') {
        input.type = 'text';
        icon.className = 'bi bi-eye-slash-fill';
    } else {
        input.type = 'password';
        icon.className = 'bi bi-eye-fill';
    }
}
// Enter key submit
document.addEventListener('keydown', function(e) {
    if (e.key === 'Enter') {
        var form = document.querySelector('form');
        if (form) form.submit();
    }
});
</script>

</body>
</html>
