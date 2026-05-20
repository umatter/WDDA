# WDDA FS 2026: Lösungen für Aufgabenserie 7
# Dieses Skript enthält die R-Code-Lösungen für die Aufgabenserie 7
# Thema: Inferenz in Regressionsmodellen
#  - klassische und Bootstrap-Konfidenzintervalle
#  - t-Tests und F-Tests
#  - Modellvergleich
#  - Prognose mit Konfidenz- und Prognoseintervall

# Benötigte Pakete laden
library(readxl)
library(dplyr)
library(mosaic)
library(ggplot2)




# ============================================================================
# Aufgabe 1: Advertising – Konfidenzintervalle und Bootstrap
# ============================================================================

# Daten einlesen
Advertising <- read_excel("data/WDDA_07.xlsx", sheet = "Advertising")
head(Advertising)

# (a) Einfaches Regressionsmodell schätzen
mod_tv <- lm(sales ~ TV, data = Advertising)
summary(mod_tv)

# (b) Klassisches Konfidenzintervall
confint(mod_tv)

# (c) Bootstrap-Konfidenzintervall für TV-Koeffizient
set.seed(123)
simcoef <- do(5000) * coef(lm(sales ~ TV, data = resample(Advertising)))

CI_intercept <- quantile(simcoef$Intercept, c(0.025, 0.975))
CI_tv        <- quantile(simcoef$TV,        c(0.025, 0.975))

cat("Bootstrap 95%-CI für Intercept:", round(CI_intercept, 3), "\n")
cat("Bootstrap 95%-CI für TV:       ", round(CI_tv, 3), "\n")

# (d) Visualisierung der Bootstrap-Verteilungen
par(mfrow = c(1, 2))
hist(simcoef$TV, main = "Bootstrap-Verteilung TV", xlab = "TV-Koeffizient",
     col = "lightgray", border = "white", breaks = 25)
abline(v = quantile(simcoef$TV, c(0.025, 0.975)), col = "red", lty = 2, lwd = 2)

hist(simcoef$Intercept, main = "Bootstrap-Verteilung Intercept", xlab = "Intercept",
     col = "lightgray", border = "white", breaks = 25)
abline(v = quantile(simcoef$Intercept, c(0.025, 0.975)), col = "red", lty = 2, lwd = 2)
par(mfrow = c(1, 1))

# (e) Multiple Regression (TV + radio + newspaper)
mod_full <- lm(sales ~ TV + radio + newspaper, data = Advertising)
summary(mod_full)
# Interpretation:
#  - TV und radio sind hoch signifikant
#  - newspaper ist nicht signifikant (p ≈ 0.86)

# (f) Modellvergleich (ANOVA F-Test)
mod_red <- lm(sales ~ TV + radio, data = Advertising)
anova(mod_red, mod_full)
# Interpretation:
#  - p > 0.05 -> newspaper liefert keinen signifikanten Beitrag
#  - reduziertes Modell wird bevorzugt

# (g) Prognose: Konfidenz- vs. Prognoseintervall
neue_werte <- data.frame(TV = 200, radio = 30)
ci_mean <- predict(mod_red, newdata = neue_werte, interval = "confidence")
pi_obs  <- predict(mod_red, newdata = neue_werte, interval = "prediction")

cat("\nKonfidenzintervall für mittlere Sales:\n")
print(ci_mean)
cat("\nPrognoseintervall für einzelne Beobachtung:\n")
print(pi_obs)
# Hinweis: PI ist breiter als CI, weil zusätzlich die individuelle
# Variation um die Regressionsfläche berücksichtigt wird.




# ============================================================================
# Aufgabe 2: Diamond Rings – Inferenz und Prognose
# ============================================================================

# Daten einlesen
diamonds <- read_excel("data/WDDA_07.xlsx", sheet = "Diamonds Rings")
names(diamonds) <- c("weight", "price")
head(diamonds)

# (a) Lineares Modell
mod_dr <- lm(price ~ weight, data = diamonds)
summary(mod_dr)
# Steigung ≈ 3721 SGD/Karat, hoch signifikant

# (b) Klassisches Konfidenzintervall
confint(mod_dr)

# (c) Bootstrap-Konfidenzintervall für die Steigung
set.seed(42)
simcoef_dr <- do(5000) * coef(lm(price ~ weight, data = resample(diamonds)))
CI_weight  <- quantile(simcoef_dr$weight, c(0.025, 0.975))
cat("Bootstrap 95%-CI für Steigung (weight):", round(CI_weight, 1), "\n")

# (d) Prognose für 0.25 Karat
neu     <- data.frame(weight = 0.25)
ci_mean <- predict(mod_dr, newdata = neu, interval = "confidence")
pi_obs  <- predict(mod_dr, newdata = neu, interval = "prediction")

cat("\nMittlerer erwarteter Preis (95%-CI):\n")
print(ci_mean)
cat("\nPrognose-Intervall für einzelnen Ring (95%-PI):\n")
print(pi_obs)

# (e) Visualisierung mit CI- und PI-Bändern
grid <- data.frame(weight = seq(min(diamonds$weight),
                                 max(diamonds$weight),
                                 length.out = 100))
ci <- predict(mod_dr, newdata = grid, interval = "confidence")
pi <- predict(mod_dr, newdata = grid, interval = "prediction")

plot(diamonds$weight, diamonds$price, pch = 16, col = "gray50",
     xlab = "Weight (carats)", ylab = "Price (SGD)",
     main = "Regression mit 95%-CI und PI")
lines(grid$weight, ci[, "fit"], col = "blue", lwd = 2)
lines(grid$weight, ci[, "lwr"], col = "blue", lty = 2)
lines(grid$weight, ci[, "upr"], col = "blue", lty = 2)
lines(grid$weight, pi[, "lwr"], col = "red",  lty = 3)
lines(grid$weight, pi[, "upr"], col = "red",  lty = 3)
legend("topleft", legend = c("Fit", "95%-CI", "95%-PI"),
       col = c("blue", "blue", "red"), lty = c(1, 2, 3), lwd = c(2, 1, 1))




# ============================================================================
# Aufgabe 3: SAT – Multiple Regression und F-Test
# ============================================================================

# Daten einlesen
sat <- read_excel("data/WDDA_07.xlsx", sheet = "SAT")
head(sat)
summary(sat[, c("expend", "ratio", "salary", "frac", "sat")])

# (a) Einfaches Modell: SAT ~ expend
mod1 <- lm(sat ~ expend, data = sat)
summary(mod1)
# Überraschung: negative Steigung – Hinweis auf Confounding

# (b) Multiple Regression
mod2 <- lm(sat ~ expend + ratio + salary + frac, data = sat)
summary(mod2)
# Nach Kontrolle für frac kehrt sich das Vorzeichen vieler Koeffizienten um
# -> Selbstselektion über den Anteil teilnehmender Schüler (frac)

# (c) F-Statistik des Gesamtmodells
f <- summary(mod2)$fstatistic
cat("F-Statistik:", round(f["value"], 2),
    "  (df1 =", f["numdf"], ", df2 =", f["dendf"], ")\n")

# (d) ANOVA-Vergleich geschachtelter Modelle
mod_klein <- lm(sat ~ frac, data = sat)
mod_gross <- lm(sat ~ expend + ratio + salary + frac, data = sat)
anova(mod_klein, mod_gross)

# (e) Prognose für einen hypothetischen Bundesstaat
hypothetisch <- data.frame(expend = 6, ratio = 16, salary = 35, frac = 30)
pred <- predict(mod_gross, newdata = hypothetisch, interval = "prediction")
print(pred)
