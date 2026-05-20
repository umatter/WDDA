# WDDA FS 2026: Lösungen für Aufgabenserie 8
# Dieses Skript enthält die R-Code-Lösungen für die Aufgabenserie 8
# Thema: Nichtlineare Zusammenhänge & kategoriale Prädiktoren
#  - Variablentransformationen (Polynom, Wurzel, Log)
#  - Modellvergleich über R^2 und F-Test
#  - Dummy-Variablen für kategoriale Prädiktoren
#  - Interaktionseffekte

# Benötigte Pakete laden
library(readxl)
library(dplyr)
library(mosaic)
library(ggplot2)




# ============================================================================
# Aufgabe 1: Advertising – Nichtlineare Modelle für TV und Sales
# ============================================================================

# Daten einlesen
adv <- read_excel("data/WDDA_08.xlsx", sheet = "Advertising")
head(adv)

# (a) Streudiagramm
plot(adv$TV, adv$sales, pch = 16, col = "gray50",
     xlab = "TV-Ausgaben", ylab = "Sales",
     main = "Sales vs. TV")

# (b) Sechs Modelle anpassen
attach(adv)

md1 <- lm(sales ~ TV)                                     # Linear
md2 <- lm(sales ~ poly(TV, 2, raw = TRUE))                # Quadratisch
md3 <- lm(sales ~ sqrt(TV))                               # Wurzel
md4 <- lm(sales ~ log(TV))                                # Log(x)
md5 <- lm(log(sales) ~ log(TV))                           # Log-Log
md6 <- lm(log(sales) ~ TV)                                # Log(y)

cat("R^2-Werte:\n")
cat("Linear:       ", round(summary(md1)$r.squared, 4), "\n")
cat("Quadratisch:  ", round(summary(md2)$r.squared, 4), "\n")
cat("Wurzel:       ", round(summary(md3)$r.squared, 4), "\n")
cat("Log(x):       ", round(summary(md4)$r.squared, 4), "\n")
cat("Log-Log:      ", round(summary(md5)$r.squared, 4), "\n")
cat("Log(y):       ", round(summary(md6)$r.squared, 4), "\n")
# Achtung: R^2 nur direkt vergleichbar bei identischer Response.

# (c) Visualisierung der Modellkurven
f1 <- function(x) coef(md1)[1] + coef(md1)[2] * x
f3 <- function(x) coef(md3)[1] + coef(md3)[2] * sqrt(x)
f5 <- function(x) exp(coef(md5)[1] + coef(md5)[2] * log(x))

plot(TV, sales, pch = 16, col = "gray60",
     xlab = "TV-Ausgaben", ylab = "Sales",
     main = "Vergleich der Regressionsmodelle")
curve(f1, add = TRUE, col = "red",   lwd = 2)
curve(f3, add = TRUE, col = "blue",  lwd = 2)
curve(f5, add = TRUE, col = "green", lwd = 2)
legend("bottomright", legend = c("Linear", "Wurzel", "Log-Log"),
       col = c("red", "blue", "green"), lwd = 2)

# (d) Residuenanalyse
par(mfrow = c(1, 2))
plot(fitted(md1), resid(md1), pch = 16, col = "gray50",
     main = "Lineares Modell", xlab = "Fitted", ylab = "Residuen")
abline(h = 0, lty = 2, col = "red")

plot(fitted(md3), resid(md3), pch = 16, col = "gray50",
     main = "Wurzel-Modell", xlab = "Fitted", ylab = "Residuen")
abline(h = 0, lty = 2, col = "red")
par(mfrow = c(1, 1))

# (e) Interpretation Log-Log-Modell
summary(md5)
# Steigung von log(TV) ist eine Elastizität:
# 1% mehr TV-Ausgaben -> ca. beta1 % mehr Sales

detach(adv)




# ============================================================================
# Aufgabe 2: Default – Kategoriale Prädiktoren
# ============================================================================

# (a) Daten einlesen
default <- read_excel("data/WDDA_08.xlsx", sheet = "Default")
default$student <- factor(default$student, levels = c("No", "Yes"))
head(default)
table(default$student)

# (b) Einfaches Modell mit kategorialem Prädiktor
mod_s <- lm(balance ~ student, data = default)
summary(mod_s)
# Intercept: mittlerer Saldo der Baseline (Nicht-Studenten)
# studentYes: Differenz Studenten vs. Nicht-Studenten

# (c) Manuelle Dummy-Kodierung
default$st10 <- ifelse(default$student == "Yes", 1, 0)
mod_s_dummy  <- lm(balance ~ st10, data = default)

cat("\nKoeffizienten Faktor-Modell:\n")
print(coef(mod_s))
cat("\nKoeffizienten Dummy-Modell:\n")
print(coef(mod_s_dummy))
# Beide Modelle sind identisch (nur andere Kodierung)

# (d) Multiple Regression: balance ~ income + student
mod_si <- lm(balance ~ income + student, data = default)
summary(mod_si)
# Geometrisch: zwei parallele Regressionsgeraden

# (e) Modell mit Interaktion
mod_si_int <- lm(balance ~ income * student, data = default)
summary(mod_si_int)
# income:studentYes -> Differenz im Steigungskoeffizienten zwischen den Gruppen

# (f) Visualisierung der Interaktion
plot(default$income, default$balance,
     col = ifelse(default$student == "Yes", "red", "blue"),
     pch = 16, cex = 0.6,
     xlab = "Income", ylab = "Balance",
     main = "Income vs. Balance nach Studentenstatus")

abline(a = coef(mod_si_int)[1],
       b = coef(mod_si_int)[2],
       col = "blue", lwd = 2)
abline(a = coef(mod_si_int)[1] + coef(mod_si_int)[3],
       b = coef(mod_si_int)[2] + coef(mod_si_int)[4],
       col = "red", lwd = 2)

legend("topright", legend = c("Nicht-Studenten", "Studenten"),
       col = c("blue", "red"), pch = 16, lwd = 2)

# (g) Modellvergleich: mit vs. ohne Interaktion
anova(mod_si, mod_si_int)
# p > 0.05 -> Modell ohne Interaktion ausreichend




# ============================================================================
# Aufgabe 3: Polynomial – Polynomanpassung
# ============================================================================

# (a) Daten einlesen und visualisieren
poly_dat <- read_excel("data/WDDA_08.xlsx", sheet = "Polynomial")
plot(poly_dat$x, poly_dat$y, pch = 16, col = "gray50",
     xlab = "x", ylab = "y",
     main = "Streudiagramm Polynomial")

# (b) Polynome verschiedener Grade
m1 <- lm(y ~ x,                              data = poly_dat)  # Linear
m2 <- lm(y ~ poly(x, 2, raw = TRUE),         data = poly_dat)  # Quadratisch
m3 <- lm(y ~ poly(x, 3, raw = TRUE),         data = poly_dat)  # Kubisch
m4 <- lm(y ~ poly(x, 4, raw = TRUE),         data = poly_dat)  # Grad 4

cat("R^2-Werte:\n")
cat("Grad 1: ", round(summary(m1)$r.squared, 4), "\n")
cat("Grad 2: ", round(summary(m2)$r.squared, 4), "\n")
cat("Grad 3: ", round(summary(m3)$r.squared, 4), "\n")
cat("Grad 4: ", round(summary(m4)$r.squared, 4), "\n")

# (c) Modellvergleich mit F-Tests
anova(m1, m2, m3, m4)
# Wo p > 0.05 -> zusätzliche Komplexität lohnt nicht

# (d) Visualisierung der angepassten Kurven
x_grid <- seq(min(poly_dat$x), max(poly_dat$x), length.out = 200)

plot(poly_dat$x, poly_dat$y, pch = 16, col = "gray60",
     xlab = "x", ylab = "y",
     main = "Polynomanpassungen verschiedener Grade")
lines(x_grid, predict(m1, newdata = data.frame(x = x_grid)),
      col = "red", lwd = 2)
lines(x_grid, predict(m2, newdata = data.frame(x = x_grid)),
      col = "blue", lwd = 2)
lines(x_grid, predict(m3, newdata = data.frame(x = x_grid)),
      col = "green", lwd = 2)
lines(x_grid, predict(m4, newdata = data.frame(x = x_grid)),
      col = "purple", lwd = 2)
legend("topright", legend = c("Grad 1", "Grad 2", "Grad 3", "Grad 4"),
       col = c("red", "blue", "green", "purple"), lwd = 2)
