# WDDA FS 2025: Lösungen für Aufgabenserie 5
# Dieses Skript enthält die R-Code-Lösungen für die Aufgabenserie 5

# Benötigte Pakete laden
library(readxl)
library(dplyr)
# library(ggplot2) # Nicht benötigt, wir verwenden native R-Plotting-Funktionen





# ============================================================================
# Aufgabe 1: Advertising–Datensatz (TV → Sales)
# ============================================================================
# Daten einlesen
adv <- read_excel("data/WDDA_05.xlsx", sheet = "Advertising")
head(adv)

# RSS für jede Gerade berechnen
tv    <- adv$TV
sales <- adv$sales

# Mögliche Geraden (aus Aufgabenstellung)
kandidaten <- list(
  a = c(intercept = 7.1, slope = 0.049),
  b = c(intercept = 6.8, slope = 0.048),
  c = c(intercept = 7.0, slope = 0.045),
  d = c(intercept = 7.3, slope = 0.041)
)

# RSS für eine einzelne Gerade berechnen
pred <- 7.1 + 0.049 * tv
rss_a <- sum((sales - pred)^2)

pred <- 6.8 + 0.048 * tv
rss_b <- sum((sales - pred)^2)


# RSS für jede Gerade
rss <- sapply(kandidaten, function(par) {
  pred  <- par["intercept"] + par["slope"] * tv
  sum((sales - pred)^2)
})
print(rss)

# Beste Gerade: (b) mit Intercept = 6.8, Steigung = 0.048





# ============================================================================
# Aufgabe 2: Diamond Rings (Price ~ Weight)
# ============================================================================
# Daten einlesen
diamonds <- read_excel("data/WDDA_05.xlsx", sheet = "Diamonds Rings") %>%
  rename(weight = `Weight (carats)`,
         price  = `Price (Singapore dollars)`)
head(diamonds)

# Streudiagramm
plot(diamonds$weight, diamonds$price, 
     main = "Price vs. Weight", 
     xlab = "Gewicht (ct)", ylab = "Preis (SGD)",
     pch = 16)

# Lineares Modell schätzen
mod_dr <- lm(price ~ weight, data = diamonds)
summary(mod_dr)
# Intercept ≈ -259.63: theoretischer Preis bei 0 ct (nicht sinnvoll)
# Steigung ≈ 3721.02: Mehrpreis von SGD 3721.02 pro zusätzlichem Karat

# R², RSE, RSS, TSS berechnen
resid_dr <- resid(mod_dr)
rss_dr   <- sum(resid_dr^2)
tss_dr   <- sum((diamonds$price - mean(diamonds$price))^2)
rse_dr   <- sqrt(rss_dr / df.residual(mod_dr))
r2_dr    <- summary(mod_dr)$r.squared

cat("R^2 =", round(r2_dr, 4), "\n")
cat("RSE =", round(rse_dr, 2), "SGD\n")
cat("RSS =", round(rss_dr, 0), "SGD^2\n")
cat("TSS =", round(tss_dr, 0), "SGD^2\n")

# Preisunterschied für 0.25 → 0.35 ct
preisdiff <- coef(mod_dr)["weight"] * (0.35 - 0.25)
cat("Geschätzter Unterschied:", round(preisdiff, 1), "SGD\n")

# Modell in CHF umrechnen (1 SGD = 0.68 CHF)
b0_chf <- coef(mod_dr)["(Intercept)"] * 0.68
b1_chf <- coef(mod_dr)["weight"] * 0.68
cat("Preismodell (CHF): ŷ =", round(b0_chf,1), "+", round(b1_chf,1), "× weight\n")

# Schnäppchen-Check für 0.18 ct und SGD 325
pred_018 <- predict(mod_dr, newdata = data.frame(weight = 0.18))
ci <- predict(mod_dr, newdata = data.frame(weight = 0.18),
              interval = "prediction", level = 0.95)
cat("Prognose für 0.18 ct:", round(pred_018,1), "SGD\n")
cat("95% Prognose-Intervall: [", round(ci[,"lwr"],1), ",", round(ci[,"upr"],1), "] SGD\n")

# Residuen analysieren
resid_dr <- resid(mod_dr)
mean_resid <- mean(resid_dr)
sd_resid   <- sd(resid_dr)

# Residuen-Plots
par(mfrow = c(1,2))
plot(diamonds$weight, resid_dr,
     main = "Residuen vs. Gewicht", xlab = "Weight (ct)", ylab = "Residuen")
abline(h = 0, lty = 2)
hist(resid_dr, main = "Histogramm der Residuen",
     xlab = "Residuen")

par(mfrow = c(1,1))
cat("Residuen-Mittelwert:", round(mean_resid,2), "\n")
cat("Residuen-SD:", round(sd_resid,2), "SGD\n")





# ============================================================================
# Aufgabe 3: Netzwerk-Performance (Download)
# ============================================================================
# Daten einlesen
dl <- read_excel("data/WDDA_05.xlsx", sheet = "Download") %>%
  rename(time_sec = `Transfer Time (sec)`,
         size_mb  = `File Size (MB)`)
head(dl)

# Streudiagramm
plot(dl$size_mb, dl$time_sec, 
     main = "Transferzeit vs. Dateigrösse",
     xlab = "Dateigrösse (MB)", ylab = "Zeit (s)",
     pch = 16)

# Lineares Modell
mod_dl <- lm(time_sec ~ size_mb, data = dl)
summary(mod_dl)
# Intercept ≈ 7.27 s: Startlatenz im Netzwerk
# Steigung ≈ 0.3133 s/MB: zusätzliche Zeit pro MB

# Kennzahlen berechnen
resid_dl <- resid(mod_dl)
rss_dl   <- sum(resid_dl^2)
tss_dl   <- sum((dl$time_sec - mean(dl$time_sec))^2)
rse_dl   <- sqrt(rss_dl / df.residual(mod_dl))
r2_dl    <- summary(mod_dl)$r.squared

cat("R^2 =", round(r2_dl,4), "\n")
cat("RSE =", round(rse_dl,2), "s\n")
cat("RSS =", round(rss_dl,0), "s²\n")
cat("TSS =", round(tss_dl,0), "s²\n")

# Zeitdifferenz 50 → 60 MB
time_diff <- coef(mod_dl)["size_mb"] * 10
cat("Geschätzter Unterschied:", round(time_diff,2), "s\n")

# Modell in Minuten & Kilobyte
# Zeit in Minuten: time_min = 7.2747/60 + 0.3133/60 × size_MB = 0.1212 + 0.005222 × size_MB
# In Kilobyte: time_min = 0.1212 + 5.22×10^-6 × size_KB

# Residuen vs. Grösse
plot(dl$size_mb, resid_dl,
     main = "Residuen vs. Dateigrösse",
     xlab = "Dateigrösse (MB)", ylab = "Residuen (s)")
abline(h = 0, lty = 2)

# Residuen vs. geschätzte Werte
plot(fitted(mod_dl), resid_dl,
     main = "Residuen vs. Geschätzte Werte",
     xlab = "Geschätzte Werte (s)", ylab = "Residuen (s)")
abline(h = 0, lty = 2)

# Datenmenge in 15 Sekunden
pred_size_15 <- (15 - coef(mod_dl)["(Intercept)"]) / coef(mod_dl)["size_mb"]
cat("In 15 s übertragbar:", round(pred_size_15,2), "MB\n")





# ============================================================================
# Aufgabe 4: Cars – Displacement vs. Horsepower
# ============================================================================
# Daten einlesen
cars <- read_excel("data/WDDA_05.xlsx", sheet = "Cars") %>%
  rename(displacement = `Displacement (liters)`,
         horsepower   = Horsepower)
head(cars)

# Streudiagramm
plot(cars$displacement, cars$horsepower, 
     main = "Horsepower vs. Displacement",
     xlab = "Hubraum (L)", ylab = "Leistung (PS)",
     pch = 16, col = rgb(0,0,0,0.5))

# Lineares Modell
mod_cars <- lm(horsepower ~ displacement, data = cars)
summary(mod_cars)
# Intercept ≈ 34.19 PS: Grundleistung bei 0 L (nicht realistisch)
# Steigung ≈ 69.20 PS/L: zusätzliche Leistung pro Liter

# R² & RSE
resid_c <- resid(mod_cars)
rss_c   <- sum(resid_c^2)
tss_c   <- sum((cars$horsepower - mean(cars$horsepower))^2)
rse_c   <- sqrt(rss_c / df.residual(mod_cars))
r2_c    <- summary(mod_cars)$r.squared

cat("R^2 =", round(r2_c,4), "\n")
cat("RSE =", round(rse_c,2), "PS\n")

# Mehrleistung für +0.5 L
delta_hp <- coef(mod_cars)["displacement"] * 0.5
cat("Geschätzte Mehrleistung:", round(delta_hp,1), "PS\n")

# Residuum für 3 L/333 PS
pred_3L <- predict(mod_cars, newdata = data.frame(displacement = 3))
resid_3L <- 333 - pred_3L
cat("Residual (333 PS bei 3 L):", round(resid_3L,2), "PS\n")

# Konfidenzintervall für mittlere Leistung bei 3 L
cars3 <- filter(cars, displacement == 3)
t.test(cars3$horsepower)$conf.int

# Wiederholung für 2 L und 6.2 L
for(d in c(2, 6.2)) {
  subset <- filter(cars, displacement == d)
  ci     <- t.test(subset$horsepower)$conf.int
  cat("\nDisplacement =", d, "L:\n")
  cat("  95% CI:", round(ci[1],1), "–", round(ci[2],1), "PS\n")
  pred   <- predict(mod_cars, newdata = data.frame(displacement = d))
  cat("  Modell-Prediction:", round(pred,1), "PS\n")
}
