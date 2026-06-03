# ============================================================
# Figuren für das Beamer-Deck "Deskriptive Statistik: Fragen 16 & 17"
# Erzeugt alle PDF-Abbildungen aus den echten Exam-Datensätzen und
# druckt die zentralen Kennzahlen für die Foliennarrative.
# Ausführen aus dem Repo-Root:
#   Rscript slides/musterpruefung_aufgaben/make_figures.R
# ============================================================

suppressMessages({
  library(readxl)
  library(e1071)
  library(mosaic)
})

data_dir <- "_resources/exam_questions"
fig_dir  <- "slides/musterpruefung_aufgaben/figures"
dir.create(fig_dir, showWarnings = FALSE, recursive = TRUE)

# --- BFH-Farbpalette ---------------------------------------
col_primary   <- "#697D91"
col_secondary <- "#FAC300"
col_accent    <- "#699673"
col_incorrect <- "#B41428"
col_alert     <- "#F7931E"

set_par <- function() par(mar = c(4.2, 4.4, 2.4, 1), cex = 1.15,
                          col.axis = "#3A4750", col.lab = "#3A4750",
                          col.main = "#3A4750", font.main = 1, las = 1)
line <- function() cat(strrep("=", 60), "\n")

# cairo_pdf rendert UTF-8 (Umlaute, Gedankenstrich, ×) korrekt
cpdf <- function(file, ...) cairo_pdf(file.path(fig_dir, file), ...)

# ============================================================
# FRAGE 15 — Boxplots zuordnen (Konzept, keine Musterlösung)
# ============================================================
line(); cat("FRAGE 15  Boxplots lesen (Illustration)\n"); line()

## Zwei generische Verteilungen: symmetrisch vs. rechtsschief.
## Zeigt, wie man Median (Boxlinie) und Mean (Marker) ableitet.
set.seed(15)
box_sym   <- rnorm(300, mean = 50, sd = 13)              # symmetrisch
box_right <- 6 + rgamma(300, shape = 2.0, scale = 11)    # rechtsschief
cat(sprintf("symmetrisch : Median %.1f | Mean %.1f | SD %.1f\n",
            median(box_sym), mean(box_sym), sd(box_sym)))
cat(sprintf("rechtsschief: Median %.1f | Mean %.1f | SD %.1f\n",
            median(box_right), mean(box_right), sd(box_right)))

draw_box <- function(z, farbe, titel) {
  boxplot(z, horizontal = TRUE, col = adjustcolor(farbe, 0.30),
          border = farbe, lwd = 2.5, outpch = 19, outcol = col_incorrect,
          ylim = c(0, 100), axes = FALSE, main = titel)
  axis(1, at = seq(0, 100, 20))
  points(mean(z), 1, pch = 18, col = col_alert, cex = 2.4)   # Mittelwert
}

cpdf("ex15_boxplots.pdf", width = 9.4, height = 2.7)
par(mfrow = c(2, 1), mar = c(2.4, 1.0, 1.8, 1.0), cex = 1.05,
    col.axis = "#3A4750", col.main = "#3A4750", font.main = 1, las = 1)
draw_box(box_sym,   col_primary, "symmetrisch:  Median ≈ Mittelwert")
legend("topleft", bty = "n", horiz = FALSE,
       pch = c(NA, 18), lty = c(1, NA), lwd = c(2.5, NA),
       col = c("#3A4750", col_alert),
       legend = c("Median (Boxlinie)", "Mittelwert"), cex = 0.9)
draw_box(box_right, col_alert,   "rechtsschief:  Median unten, Mittelwert grösser")
par(mfrow = c(1, 1))
dev.off()

# ============================================================
# FRAGE 16 — Umfragedaten: Skalenniveau & Lagemass
# ============================================================
line(); cat("FRAGE 16  Umfragedaten (n = 100)\n"); line()

u <- read_excel(file.path(data_dir, "Umfragedaten.xlsx"))
cat("Variablen:", paste(names(u), collapse = ", "), "\n\n")

## Geschlecht — nominal -> Modus
tab_g <- sort(table(u$Geschlecht), decreasing = TRUE)
cat("Geschlecht (nominal):\n"); print(tab_g)
cat("  Modus =", names(tab_g)[1], "\n\n")

## Bildung — ordinal -> Median
ord <- c("Gymnasium", "Bachelor", "Master", "Doktorat")
bf  <- factor(u$Bildung, levels = ord, ordered = TRUE)
cat("Bildung (ordinal, aufsteigend):\n"); print(table(bf))
cat("  kumuliert:\n"); print(cumsum(table(bf)))
cat("  Median (50./51. Wert) =", as.character(sort(bf)[50]), "\n\n")

## Einkommen — verhältnisskaliert -> Mittelwert
cat("Einkommen (metrisch):\n")
cat("  Mittelwert =", round(mean(u$Einkommen)), "CHF",
    " | Median =", median(u$Einkommen), "CHF\n\n")

## Bewertung — ordinal (Rating 1-10)
cat("Bewertung (Rating 1-10, ordinal):\n")
cat("  Median =", median(u$Bewertung), " | Modus =",
    names(which.max(table(u$Bewertung))), "\n")

## Abb. 16a: Geschlecht (nominal)
cpdf("ex16_geschlecht.pdf", width = 5.4, height = 3.7)
set_par()
cols <- ifelse(names(tab_g) == names(tab_g)[1], col_secondary, col_primary)
bp <- barplot(tab_g, col = cols, border = "white",
              ylim = c(0, max(tab_g) * 1.18),
              ylab = "Anzahl", main = "Geschlecht (nominal)")
text(bp, tab_g, labels = tab_g, pos = 3, col = "#3A4750", font = 2)
dev.off()

## Abb. 16b: Bildung (ordinal, in Reihenfolge) + Median-Markierung
cpdf("ex16_bildung.pdf", width = 5.8, height = 3.7)
set_par()
tab_b <- table(bf)
cols_b <- ifelse(names(tab_b) == "Bachelor", col_accent, col_primary)
bp <- barplot(tab_b, col = cols_b, border = "white",
              ylim = c(0, max(tab_b) * 1.18),
              ylab = "Anzahl", main = "Bildung (ordinal) — Median: Bachelor")
text(bp, tab_b, labels = tab_b, pos = 3, col = "#3A4750", font = 2)
dev.off()

## Abb. 16c: Einkommen (metrisch) Histogramm + Mittelwert/Median
cpdf("ex16_einkommen.pdf", width = 5.8, height = 3.7)
set_par()
hist(u$Einkommen / 1000, breaks = 15, col = col_primary, border = "white",
     xlab = "Einkommen (1000 CHF)", ylab = "Anzahl",
     main = "Einkommen (verhältnisskaliert)")
abline(v = mean(u$Einkommen) / 1000, col = col_alert, lwd = 3)
abline(v = median(u$Einkommen) / 1000, col = col_incorrect, lwd = 3, lty = 2)
legend("topright", bty = "n", lwd = 3, lty = c(1, 2),
       col = c(col_alert, col_incorrect),
       legend = c(paste0("Mittelwert = ", round(mean(u$Einkommen) / 1000)),
                  paste0("Median = ", round(median(u$Einkommen) / 1000))))
dev.off()

# ============================================================
# FRAGE 17 — Studentenleben: Streuung, Form & Ausreisser
# ============================================================
line(); cat("FRAGE 17  Studentenleben (n = 80)\n"); line()

s <- read_excel(file.path(data_dir, "Studentenleben.xlsx"))
x <- s$Lernstunden
n <- length(x)
q <- quantile(x, c(.25, .75), type = 7)
IQR1 <- as.numeric(q[2] - q[1])
lo <- q[1] - 1.5 * IQR1
hi <- q[2] + 1.5 * IQR1
out <- sort(x[x < lo | x > hi])

cat("Lernstunden:\n")
cat(sprintf("  Mittelwert = %.1f | Median = %.1f | SD = %.1f\n",
            mean(x), median(x), sd(x)))
cat(sprintf("  Q1 = %.3f | Q3 = %.3f | IQR = %.1f\n", q[1], q[2], IQR1))
cat(sprintf("  Schiefe (e1071 default/typ3) = %.2f | Excel SKEW = %.2f\n",
            skewness(x), n / ((n - 1) * (n - 2)) * sum(((x - mean(x)) / sd(x))^3)))
cat(sprintf("  Tukey-Zaun: [%.1f, %.1f] | Ausreisser: %d -> %s\n",
            lo, hi, length(out), paste(out, collapse = ", ")))
cat("\nVerkehrsmittel (nominal):\n"); print(sort(table(s$Verkehrsmittel), decreasing = TRUE))
cat("  Modus =", names(which.max(table(s$Verkehrsmittel))), "\n")

## Abb. 17-Konzept: Drei Verteilungsformen (simulierte Dichten) ----------
## Zeigt links-/symmetrisch/rechtsschief mit Mittelwert- und Median-Linien.
set.seed(7)
sim_left  <- 12 - rgamma(20000, shape = 2.2, scale = 1)   # Schiefe < 0
sim_sym   <- rnorm(20000, mean = 6, sd = 1.6)             # Schiefe ~ 0
sim_right <- rgamma(20000, shape = 2.2, scale = 1)        # Schiefe > 0
cat(sprintf("\nKonzept-Dichten Schiefe: links %.2f | sym %.2f | rechts %.2f\n",
            skewness(sim_left), skewness(sim_sym), skewness(sim_right)))

panel_dichte <- function(z, farbe, titel, untertitel) {
  d <- density(z)
  plot(d, main = "", xlab = "", ylab = "", axes = FALSE,
       col = farbe, lwd = 3)
  polygon(d, col = adjustcolor(farbe, 0.12), border = farbe, lwd = 3)
  mw <- mean(z); md <- median(z)
  # Vertikale Linien nur von der Basislinie (y=0) bis zur Dichtekurve,
  # damit sie die horizontale Achse nicht überschreiten.
  h_mw <- approx(d$x, d$y, xout = mw)$y
  h_md <- approx(d$x, d$y, xout = md)$y
  segments(mw, 0, mw, h_mw, col = col_alert,     lwd = 2.5)
  segments(md, 0, md, h_md, col = col_incorrect, lwd = 2.5, lty = 2)
  mtext(titel, side = 1, line = 0.6, font = 2, col = "#3A4750", cex = 0.95)
  mtext(untertitel, side = 1, line = 1.7, col = "#3A4750", cex = 0.85)
}

cpdf("ex17_schiefe.pdf", width = 8.4, height = 3.0)
par(mfrow = c(1, 3), mar = c(3.2, 0.6, 0.6, 0.6), xpd = NA)
panel_dichte(sim_left,  col_primary, "Schiefe < 0", "linksschief")
panel_dichte(sim_sym,   col_accent,  "Schiefe ≈ 0", "symmetrisch")
panel_dichte(sim_right, col_alert,   "Schiefe > 0", "rechtsschief")
# gemeinsame Legende oben
legend("topright", inset = c(0, -0.02), bty = "n", lwd = c(2.5, 2.5),
       lty = c(1, 2), col = c(col_alert, col_incorrect),
       legend = c("Mittelwert", "Median"), cex = 0.9)
par(mfrow = c(1, 1))
dev.off()

## Abb. 17a: Histogramm Lernstunden + Mittelwert/Median (Form)
cpdf("ex17_hist.pdf", width = 6.0, height = 3.8)
set_par()
hist(x, breaks = 14, col = col_primary, border = "white",
     xlab = "Lernstunden pro Woche", ylab = "Anzahl",
     main = "Lernstunden — rechtsschiefe Verteilung")
abline(v = mean(x), col = col_alert, lwd = 3)
abline(v = median(x), col = col_incorrect, lwd = 3, lty = 2)
legend("topright", bty = "n", lwd = 3, lty = c(1, 2),
       col = c(col_alert, col_incorrect),
       legend = c(sprintf("Mittelwert = %.1f", mean(x)),
                  sprintf("Median = %.1f", median(x))))
dev.off()

## Abb. 17b: Boxplot mit Tukey-Zaun und Ausreissern
cpdf("ex17_box.pdf", width = 6.0, height = 3.8)
set_par()
boxplot(x, horizontal = TRUE, col = col_primary, border = "#3A4750",
        outpch = 19, outcol = col_incorrect, ylim = range(c(x, lo)),
        xlab = "Lernstunden pro Woche",
        main = "Boxplot — Tukey-Ausreisserregel (1.5 × IQR)")
abline(v = hi, col = col_alert, lwd = 2.5, lty = 2)
text(hi, 1.35, labels = sprintf("oberer Zaun = %.1f", hi),
     col = col_alert, pos = 2, font = 2, cex = 0.9)
points(out, rep(1, length(out)), pch = 19, col = col_incorrect, cex = 1.4)
text(max(out), 0.72, labels = sprintf("%d Ausreisser", length(out)),
     col = col_incorrect, pos = 2, font = 2, cex = 0.9)
dev.off()

## Abb. 17c: Verkehrsmittel (Modus)
cpdf("ex17_verkehr.pdf", width = 5.6, height = 3.7)
set_par()
tab_v <- sort(table(s$Verkehrsmittel), decreasing = TRUE)
cols_v <- ifelse(names(tab_v) == names(tab_v)[1], col_secondary, col_primary)
bp <- barplot(tab_v, col = cols_v, border = "white",
              ylim = c(0, max(tab_v) * 1.18),
              ylab = "Anzahl", main = "Verkehrsmittel (nominal) — Modus: ÖV")
text(bp, tab_v, labels = tab_v, pos = 3, col = "#3A4750", font = 2)
dev.off()

# ============================================================
# FRAGE 18 — Impfabsicht: Bootstrap-CI für Differenz zweier Anteile
# ============================================================
line(); cat("FRAGE 18  ImpfabsichtUmfrage (n = 250)\n"); line()

imp <- read_excel(file.path(data_dir, "ImpfabsichtUmfrage.xlsx"))
p_beh <- mean(imp$Impfabsicht[imp$Gruppe == "Behandlung"])
p_kon <- mean(imp$Impfabsicht[imp$Gruppe == "Kontrolle"])
cat(sprintf("p_Behandlung = %.3f | p_Kontrolle = %.3f | Diff = %.3f\n",
            p_beh, p_kon, p_beh - p_kon))

pdiff <- function(data)
  mean(data$Impfabsicht[data$Gruppe == "Behandlung"]) -
  mean(data$Impfabsicht[data$Gruppe == "Kontrolle"])
set.seed(2024)
boot <- do(5000) * pdiff(resample(imp))
ci18 <- quantile(boot$pdiff, c(.025, .975))
cat(sprintf("Bootstrap 95%%-CI: [%.2f, %.2f] | enthält 0: %s\n",
            ci18[1], ci18[2], ci18[1] <= 0 & ci18[2] >= 0))

## Abb. 18a: Anteile je Gruppe
cpdf("ex18_anteile.pdf", width = 5.2, height = 3.7)
set_par()
ps <- c(Kontrolle = p_kon, Behandlung = p_beh)
bp <- barplot(ps, col = c(col_primary, col_accent), border = "white",
              ylim = c(0, 0.85), ylab = "Anteil Impfabsicht",
              main = "Impfabsicht je Gruppe")
text(bp, ps, labels = sprintf("%.0f%%", ps * 100), pos = 3,
     col = "#3A4750", font = 2)
dev.off()

## Abb. 18b: Bootstrap-Verteilung von p_diff
## x-Achse bis 0 erweitern, damit die Null-Linie sichtbar ist und man
## sieht, dass die ganze Verteilung rechts von 0 liegt (-> signifikant).
cpdf("ex18_boot.pdf", width = 6.0, height = 3.8)
set_par()
hist(boot$pdiff, breaks = 30, col = col_primary, border = "white",
     xlim = c(0, max(boot$pdiff) + 0.02),
     xlab = expression(hat(p)[diff] == hat(p)[Behandlung] - hat(p)[Kontrolle]),
     ylab = "Häufigkeit",
     main = "Bootstrap-Verteilung (5000 Stichproben)")
abline(v = ci18, col = col_incorrect, lwd = 2.5, lty = 2)
abline(v = 0, col = col_alert, lwd = 3)
legend("topright", bty = "n", lwd = 2.5, lty = c(2, 1),
       col = c(col_incorrect, col_alert),
       legend = c(sprintf("95%%-CI [%.2f, %.2f]", ci18[1], ci18[2]),
                  "Null (kein Effekt)"))
dev.off()

# ============================================================
# FRAGE 20 — Immobilienpreise: einfache lineare Regression
# ============================================================
line(); cat("FRAGE 20  Immobilienpreise (n = 120)\n"); line()

h <- read_excel(file.path(data_dir, "Immobilienpreise.xlsx"))
m20 <- lm(Preis_kCHF ~ Quadratmeter, data = h)
ci20 <- confint(m20, "Quadratmeter")
cat(sprintf("Steigung = %.2f | R^2 = %.3f | 95%%-CI [%.2f, %.2f] | p = %.2g\n",
            coef(m20)[2], summary(m20)$r.squared, ci20[1], ci20[2],
            summary(m20)$coef["Quadratmeter", 4]))

## Abb. 20: Streudiagramm + Regressionsgerade
cpdf("ex20_scatter.pdf", width = 6.2, height = 3.9)
set_par()
plot(h$Quadratmeter, h$Preis_kCHF, pch = 19, col = col_primary,
     xlab = expression("Wohnfläche (m"^2*")"), ylab = "Preis (1000 CHF)",
     main = "Immobilienpreise: Preis vs. Wohnfläche")
abline(m20, col = col_alert, lwd = 3)
legend("topleft", bty = "n",
       legend = c(sprintf("Steigung = %.2f", coef(m20)[2]),
                  sprintf("R² = %.3f", summary(m20)$r.squared)),
       text.col = "#3A4750")
dev.off()

line(); cat("Alle Figuren geschrieben nach:", fig_dir, "\n"); line()
