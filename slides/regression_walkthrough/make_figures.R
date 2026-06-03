# ============================================================
# Figuren für das Beamer-Deck "Regression: drei Übungen"
# Erzeugt alle PDF-Abbildungen aus den echten WDDA-Daten und
# druckt die zentralen Kennzahlen für die Foliennarrative.
# Ausführen aus dem Repo-Root:
#   Rscript slides/regression_walkthrough/make_figures.R
# ============================================================

suppressMessages({
  library(readxl)
  library(mosaic)
})

fig_dir <- "slides/regression_walkthrough/figures"
dir.create(fig_dir, showWarnings = FALSE, recursive = TRUE)

# --- BFH-Farbpalette ---------------------------------------
col_primary   <- "#697D91"
col_secondary <- "#FAC300"
col_accent    <- "#699673"
col_incorrect <- "#B41428"
col_alert     <- "#F7931E"

# Einheitliches, schlankes Theme für Base-R-Plots
set_par <- function() par(mar = c(4.2, 4.2, 2.2, 1), cex = 1.15,
                          col.axis = "#3A4750", col.lab = "#3A4750",
                          col.main = "#3A4750", font.main = 1, las = 1)

line <- function() cat(strrep("=", 60), "\n")

# ============================================================
# KAPITEL 5 — Diamond Rings: einfache lineare Regression
# ============================================================
line(); cat("KAPITEL 5  Diamond Rings (price ~ weight)\n"); line()

diamonds <- read_excel("data/WDDA_05.xlsx", sheet = "Diamonds Rings")
names(diamonds) <- c("weight", "price")
cat("n =", nrow(diamonds), " | weight range:",
    round(range(diamonds$weight), 3), "\n")

mod_dr <- lm(price ~ weight, data = diamonds)
b <- coef(mod_dr)
cat(sprintf("b0 (Intercept) = %.2f SGD\n", b[1]))
cat(sprintf("b1 (Steigung)  = %.2f SGD/ct\n", b[2]))
s <- summary(mod_dr)
cat(sprintf("R^2 = %.4f | RSE = %.2f SGD | df = %d\n",
            s$r.squared, s$sigma, df.residual(mod_dr)))
rss <- sum(resid(mod_dr)^2); tss <- sum((diamonds$price - mean(diamonds$price))^2)
cat(sprintf("RSS = %.0f | TSS = %.0f | 1-RSS/TSS = %.4f\n", rss, tss, 1 - rss/tss))
cat(sprintf("Preisdiff 0.25->0.35 ct: %.1f SGD\n", b[2] * 0.10))

# Schnäppchen-Check: Ring mit 0.18 ct für 325 SGD
ci18 <- predict(mod_dr, newdata = data.frame(weight = 0.18),
                interval = "prediction", level = 0.95)
cat(sprintf("Prognose 0.18 ct: %.1f SGD | 95%%-PI [%.1f, %.1f]\n",
            ci18[1], ci18[2], ci18[3]))
cat(sprintf("Angebot 325 SGD liegt %s der Untergrenze -> %s\n",
            ifelse(325 < ci18[2], "UNTER", "ueber"),
            ifelse(325 < ci18[2], "Schnaeppchen", "kein Schnaeppchen")))

## Abb. 1: Streudiagramm + Regressionsgerade
pdf(file.path(fig_dir, "dr_scatter.pdf"), width = 6.4, height = 4.0)
set_par()
plot(diamonds$weight, diamonds$price, pch = 19, col = col_primary,
     xlab = "Gewicht (Karat)", ylab = "Preis (SGD)",
     main = "Diamantringe: Preis vs. Gewicht")
abline(mod_dr, col = col_alert, lwd = 3)
dev.off()

## Abb. 2: Residuen-Idee (vertikale Abstände zur Geraden)
pdf(file.path(fig_dir, "dr_leastsquares.pdf"), width = 6.4, height = 4.0)
set_par()
plot(diamonds$weight, diamonds$price, pch = 19, col = col_primary,
     xlab = "Gewicht (Karat)", ylab = "Preis (SGD)",
     main = "Residuen = vertikale Abstände zur Geraden")
fit <- fitted(mod_dr)
segments(diamonds$weight, diamonds$price, diamonds$weight, fit,
         col = col_incorrect, lwd = 1.5)
abline(mod_dr, col = col_alert, lwd = 3)
points(diamonds$weight, diamonds$price, pch = 19, col = col_primary)
dev.off()

## Abb. 3: Residuendiagnostik
pdf(file.path(fig_dir, "dr_resid.pdf"), width = 7.2, height = 3.6)
par(mfrow = c(1, 2)); set_par()
plot(fitted(mod_dr), resid(mod_dr), pch = 19, col = col_primary,
     xlab = "Geschätzte Werte (SGD)", ylab = "Residuen (SGD)",
     main = "Residuen vs. Fit")
abline(h = 0, lty = 2, col = col_incorrect, lwd = 2)
hist(resid(mod_dr), col = col_primary, border = "white",
     xlab = "Residuen (SGD)", main = "Verteilung der Residuen")
par(mfrow = c(1, 1))
dev.off()

## Abb. 4: Schnäppchen-Check mit Prognose-Intervall
pdf(file.path(fig_dir, "dr_bargain.pdf"), width = 6.6, height = 4.1)
set_par()
grid <- data.frame(weight = seq(min(0.17, min(diamonds$weight)),
                                max(diamonds$weight), length.out = 100))
pi <- predict(mod_dr, newdata = grid, interval = "prediction")
plot(diamonds$weight, diamonds$price, pch = 19, col = col_primary,
     xlim = range(grid$weight), ylim = range(c(diamonds$price, pi, 325, ci18)),
     xlab = "Gewicht (Karat)", ylab = "Preis (SGD)",
     main = "Schnäppchen-Check: 0.18 ct für 325 SGD?")
polygon(c(grid$weight, rev(grid$weight)), c(pi[, "lwr"], rev(pi[, "upr"])),
        col = adjustcolor(col_alert, 0.15), border = NA)
abline(mod_dr, col = col_alert, lwd = 3)
points(0.18, ci18[1], pch = 17, col = col_accent, cex = 1.6)        # Prognose
points(0.18, 325, pch = 19, col = col_incorrect, cex = 1.6)        # Angebot
arrows(0.18, ci18[2], 0.18, 325, length = 0.08, col = col_incorrect, lwd = 2)
legend("topleft", bty = "n", pch = c(17, 19),
       col = c(col_accent, col_incorrect),
       legend = c("Modell-Prognose", "Angebot 325 SGD"))
dev.off()

# ============================================================
# KAPITEL 6 — Download: marginale vs. partielle Steigung
# ============================================================
line(); cat("KAPITEL 6  Download (time ~ size + hours)\n"); line()

download <- read_excel("data/WDDA_06.xlsx", sheet = "Download")
names(download) <- c("time_sec", "size_mb", "hours_after_8", "vendor")
cat("n =", nrow(download), "\n")
cat(sprintf("cor(size, hours)        = %.3f\n",
            cor(download$size_mb, download$hours_after_8)))
cat(sprintf("cor(time, size)         = %.3f\n",
            cor(download$time_sec, download$size_mb)))

mod_simple <- lm(time_sec ~ size_mb, data = download)
mod_multi  <- lm(time_sec ~ size_mb + hours_after_8, data = download)
cat(sprintf("Marginale Steigung size  = %.3f s/MB (SE %.3f)\n",
            coef(mod_simple)["size_mb"], summary(mod_simple)$coef["size_mb", 2]))
cat(sprintf("Partielle Steigung size  = %.3f s/MB (SE %.3f)\n",
            coef(mod_multi)["size_mb"], summary(mod_multi)$coef["size_mb", 2]))
cat(sprintf("Partielle Steigung hours = %.3f s/h  (SE %.3f)\n",
            coef(mod_multi)["hours_after_8"], summary(mod_multi)$coef["hours_after_8", 2]))
cat(sprintf("R^2 simple = %.4f | R^2 multi = %.4f\n",
            summary(mod_simple)$r.squared, summary(mod_multi)$r.squared))
cat(sprintf("Adj-R^2 simple = %.4f | Adj-R^2 multi = %.4f\n",
            summary(mod_simple)$adj.r.squared, summary(mod_multi)$adj.r.squared))
if (requireNamespace("car", quietly = TRUE)) {
  vif <- car::vif(mod_multi)
  cat(sprintf("VIF (size) = %.1f | VIF (hours) = %.1f\n", vif[1], vif[2]))
}

## Abb. 5: Kollinearität der Prädiktoren
pdf(file.path(fig_dir, "dl_collinearity.pdf"), width = 6.4, height = 4.0)
set_par()
plot(download$size_mb, download$hours_after_8, pch = 19, col = col_primary,
     xlab = "Dateigröße (MB)", ylab = "Stunden nach 8:00 Uhr",
     main = sprintf("Prädiktoren fast deckungsgleich (r = %.2f)",
                    cor(download$size_mb, download$hours_after_8)))
abline(lm(hours_after_8 ~ size_mb, data = download), col = col_alert, lwd = 3)
dev.off()

## Abb. 6: time ~ size mit beiden Steigungen veranschaulicht
pdf(file.path(fig_dir, "dl_scatter.pdf"), width = 6.4, height = 4.0)
set_par()
plot(download$size_mb, download$time_sec, pch = 19, col = col_primary,
     xlab = "Dateigröße (MB)", ylab = "Übertragungszeit (s)",
     main = "Übertragungszeit vs. Dateigröße")
abline(mod_simple, col = col_alert, lwd = 3)
dev.off()

# ============================================================
# KAPITEL 7 — Advertising: Inferenz, Bootstrap, CI vs. PI
# ============================================================
line(); cat("KAPITEL 7  Advertising (sales ~ TV ...)\n"); line()

adv <- read_excel("data/WDDA_07.xlsx", sheet = "Advertising")
cat("n =", nrow(adv), " | Spalten:", paste(names(adv), collapse = ", "), "\n")

mod_tv <- lm(sales ~ TV, data = adv)
cat(sprintf("TV: b1 = %.4f (SE %.4f, p = %.2g)\n",
            coef(mod_tv)["TV"], summary(mod_tv)$coef["TV", 2],
            summary(mod_tv)$coef["TV", 4]))
cat("Klassisches 95%-CI:\n"); print(round(confint(mod_tv), 4))

set.seed(123)
simcoef <- do(5000) * coef(lm(sales ~ TV, data = resample(adv)))
ci_boot_tv  <- quantile(simcoef$TV, c(0.025, 0.975))
ci_boot_int <- quantile(simcoef$Intercept, c(0.025, 0.975))
cat(sprintf("Bootstrap 95%%-CI TV       : [%.4f, %.4f]\n", ci_boot_tv[1], ci_boot_tv[2]))
cat(sprintf("Bootstrap 95%%-CI Intercept: [%.3f, %.3f]\n", ci_boot_int[1], ci_boot_int[2]))

mod_full <- lm(sales ~ TV + radio + newspaper, data = adv)
mod_red  <- lm(sales ~ TV + radio, data = adv)
cat("\nVolles Modell (sales ~ TV + radio + newspaper):\n")
print(round(summary(mod_full)$coef, 4))
cat("\nANOVA reduziert (TV+radio) vs. voll:\n")
print(anova(mod_red, mod_full))

nv <- data.frame(TV = 200, radio = 30)
cat("\nKonfidenzintervall (mittlere Sales) bei TV=200, radio=30:\n")
print(round(predict(mod_red, nv, interval = "confidence"), 3))
cat("Prognoseintervall (einzelne Beobachtung):\n")
print(round(predict(mod_red, nv, interval = "prediction"), 3))

## Abb. 7: sales ~ TV mit Fit
pdf(file.path(fig_dir, "adv_scatter.pdf"), width = 6.4, height = 4.0)
set_par()
plot(adv$TV, adv$sales, pch = 19, col = col_primary,
     xlab = "TV-Budget (1000 $)", ylab = "Sales (1000 Stück)",
     main = "Sales vs. TV-Werbebudget")
abline(mod_tv, col = col_alert, lwd = 3)
dev.off()

## Abb. 8: Bootstrap-Verteilungen der Koeffizienten
pdf(file.path(fig_dir, "adv_boot.pdf"), width = 7.2, height = 3.6)
par(mfrow = c(1, 2)); set_par()
hist(simcoef$TV, breaks = 30, col = col_primary, border = "white",
     xlab = "TV-Koeffizient", main = "Bootstrap-Verteilung: TV")
abline(v = ci_boot_tv, col = col_incorrect, lty = 2, lwd = 2)
hist(simcoef$Intercept, breaks = 30, col = col_primary, border = "white",
     xlab = "Intercept", main = "Bootstrap-Verteilung: Intercept")
abline(v = ci_boot_int, col = col_incorrect, lty = 2, lwd = 2)
par(mfrow = c(1, 1))
dev.off()

## Abb. 9: CI- vs. PI-Band (sales ~ TV)
pdf(file.path(fig_dir, "adv_cipi.pdf"), width = 6.6, height = 4.1)
set_par()
g <- data.frame(TV = seq(min(adv$TV), max(adv$TV), length.out = 100))
ci <- predict(mod_tv, g, interval = "confidence")
pi <- predict(mod_tv, g, interval = "prediction")
plot(adv$TV, adv$sales, pch = 19, col = adjustcolor(col_primary, 0.5),
     xlab = "TV-Budget (1000 $)", ylab = "Sales (1000 Stück)",
     main = "Konfidenz- (CI) vs. Prognoseintervall (PI)")
polygon(c(g$TV, rev(g$TV)), c(pi[, "lwr"], rev(pi[, "upr"])),
        col = adjustcolor(col_incorrect, 0.10), border = NA)
polygon(c(g$TV, rev(g$TV)), c(ci[, "lwr"], rev(ci[, "upr"])),
        col = adjustcolor(col_accent, 0.30), border = NA)
lines(g$TV, ci[, "fit"], col = col_alert, lwd = 3)
legend("topleft", bty = "n", fill = c(adjustcolor(col_accent, 0.30),
       adjustcolor(col_incorrect, 0.10)), border = NA,
       legend = c("95%-CI (Mittelwert)", "95%-PI (Einzelwert)"))
dev.off()

line(); cat("Alle Figuren geschrieben nach:", fig_dir, "\n"); line()
