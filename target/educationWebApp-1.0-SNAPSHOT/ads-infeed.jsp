<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%-- ================================================================
     ads-infeed.jsp  —  3D Ucucu Reklam Karti
     Istifade: <jsp:include page="ads-infeed.jsp"/>
     Bir sehifede birdən cox yerlesdirilə bilar.
     ================================================================ --%>

<div class="ad-3d-outer">
    <div class="ad-3d-card">

        <%-- Başlıq sırası --%>
        <div class="ad-3d-head">
            <span class="ad-3d-label">Reklam</span>
            <button class="ad-3d-close" title="Bagla" aria-label="Reklamı bağla">&#x2715;</button>
        </div>

        <%-- Slaydlar --%>
        <div class="ad-3d-slides">

            <%-- Slide 1 — EduTech Pro (image style) --%>
            <div class="ad-3d-slide active">
                <div class="ad-3d-body">
                    <div class="ad-3d-visual ad-vis-a">
                        <div class="ad-vis-blob ad-vis-blob-1"></div>
                        <div class="ad-vis-blob ad-vis-blob-2"></div>
                        <i class="bi bi-mortarboard-fill ad-vis-icon"></i>
                    </div>
                    <div class="ad-3d-text">
                        <span class="ad-3d-badge">Sponsorlu</span>
                        <div class="ad-3d-brand">EduTech Pro &mdash; Online Kurslar</div>
                        <div class="ad-3d-sub">Java, Python, Data Science kurslarini pulsuz sinayin. 50.000+ telebenin secimi.</div>
                        <a href="#" class="ad-3d-cta" style="background:#4f46e5;">
                            Indi Bax &#x2192;
                        </a>
                    </div>
                </div>
            </div>

            <%-- Slide 2 — CodeMaster (video style, animated bg) --%>
            <div class="ad-3d-slide">
                <div class="ad-3d-body">
                    <div class="ad-3d-visual ad-vis-b">
                        <div class="ad-vis-blob ad-vis-blob-1"></div>
                        <div class="ad-vis-blob ad-vis-blob-2"></div>
                        <div class="ad-vis-play">&#x25B6;</div>
                    </div>
                    <div class="ad-3d-text">
                        <span class="ad-3d-badge" style="color:#0891b2;">Video Reklam</span>
                        <div class="ad-3d-brand">CodeMaster AZ &mdash; Canli Dersler</div>
                        <div class="ad-3d-sub">Her gun canli dersler, mentorluq ve real layiheler. Azerbaycan dilinde proqramlasdirma.</div>
                        <a href="#" class="ad-3d-cta" style="background:#0891b2;">
                            Demo Izle &#x25B6;
                        </a>
                    </div>
                </div>
            </div>

            <%-- Slide 3 — CertifyNow (image style) --%>
            <div class="ad-3d-slide">
                <div class="ad-3d-body">
                    <div class="ad-3d-visual ad-vis-c">
                        <div class="ad-vis-blob ad-vis-blob-1"></div>
                        <div class="ad-vis-blob ad-vis-blob-2"></div>
                        <i class="bi bi-patch-check-fill ad-vis-icon"></i>
                    </div>
                    <div class="ad-3d-text">
                        <span class="ad-3d-badge" style="color:#d97706;">Sertifikat</span>
                        <div class="ad-3d-brand">CertifyNow &mdash; Beynelxalq Sertifikatlar</div>
                        <div class="ad-3d-sub">AWS, Google, Microsoft sertifikatlari ucun hazirliq kurslari. Karyeranizi ireli aparin.</div>
                        <a href="#" class="ad-3d-cta" style="background:linear-gradient(90deg,#d97706,#dc2626);">
                            Daha Cox &#x2192;
                        </a>
                    </div>
                </div>
            </div>

            <%-- Slide 4 — Yerinizi Ayin (placeholder) --%>
            <div class="ad-3d-slide">
                <div class="ad-3d-body">
                    <div class="ad-3d-visual ad-vis-d">
                        <i class="bi bi-megaphone-fill ad-vis-icon"></i>
                        <span class="ad-vis-d-text">Reklamınız</span>
                    </div>
                    <div class="ad-3d-text">
                        <span class="ad-3d-badge" style="color:#64748b;">Reklamciliq</span>
                        <div class="ad-3d-brand">Bu yeri siz ala bilersiniz</div>
                        <div class="ad-3d-sub">Heftede 10.000+ aktiv istifadeci. Platformamizda reklaminixi yerlesidirin.</div>
                        <a href="mailto:reklam@educationapp.az" class="ad-3d-cta" style="background:#64748b;">
                            Elaqe &#x2192;
                        </a>
                    </div>
                </div>
            </div>

        </div><%-- /ad-3d-slides --%>

        <%-- Alt sıra: dots + progress bar --%>
        <div class="ad-3d-foot">
            <div class="ad-3d-dots">
                <span class="ad-3d-dot active"></span>
                <span class="ad-3d-dot"></span>
                <span class="ad-3d-dot"></span>
                <span class="ad-3d-dot"></span>
            </div>
            <div class="ad-3d-prog">
                <div class="ad-3d-prog-bar"></div>
            </div>
        </div>

    </div><%-- /ad-3d-card --%>
</div><%-- /ad-3d-outer --%>
