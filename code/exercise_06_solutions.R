# WDDA FS 2025: Lösungen für Aufgabenserie 6
# Dieses Skript enthält die R-Code-Lösungen für die Aufgabenserie 6

# Benötigte Pakete laden
library(readxl)
library(dplyr)
library(ggplot2)
library(corrplot)
library(car)
library(scatterplot3d)





# ============================================================================
# Aufgabe 1: Gold Chains (Multiple Regression)
# ============================================================================
# Daten einlesen
gold <- read_excel("data/WDDA_06.xlsx", sheet = "Gold Chains") %>%
  rename(price = `Price ($)`,
         length = `Length (inches)`,
         width = `Width (mm)`)
head(gold)

# (a) Streudiagramme untersuchen
pairs(gold, main = "Streudiagramme Gold Chains")

# (b) Korrelationen berechnen
cor_matrix <- cor(gold)
print(cor_matrix)
corrplot(cor_matrix, method = "number")

# Größte Korrelation: Preis und Breite (0.95)
# Erklärung: Breitere Ketten benötigen mehr Gold, daher höherer Preis

# (c) Marginale Steigung der Breite (einfache Regression)
mod_width_simple <- lm(price ~ width, data = gold)
summary(mod_width_simple)
cat("Marginale Steigung der Breite:", round(coef(mod_width_simple)["width"], 2), "\n")

# (d) Erwartung für partielle Steigung
# Da Länge und Breite unkorreliert sind (r ≈ 0.04), erwarten wir ähnliche Werte

# (e) Multiple Regression anpassen
mod_gold <- lm(price ~ length + width, data = gold)
summary(mod_gold)
cat("Partielle Steigung der Breite:", round(coef(mod_gold)["width"], 2), "\n")

# (f) Interpretation von Intercept, R² und Standardfehler
r2_gold <- summary(mod_gold)$r.squared
rse_gold <- summary(mod_gold)$sigma
cat("R² =", round(r2_gold, 4), "\n")
cat("RSE =", round(rse_gold, 2), "$\n")

# (g) Residuen glockenförmig?
resid_gold <- resid(mod_gold)
par(mfrow = c(1,2))
hist(resid_gold, main = "Histogramm der Residuen", xlab = "Residuen")
qqnorm(resid_gold)
qqline(resid_gold)
par(mfrow = c(1,1))

mean_resid_gold <- mean(resid_gold)
sd_resid_gold <- sd(resid_gold)
cat("Residuen-Mittelwert:", round(mean_resid_gold, 2), "\n")
cat("Residuen-SD:", round(sd_resid_gold, 2), "$\n")

# (h) Scatterplot der Residuen auf erklärenden Variablen
par(mfrow = c(1,2))
plot(gold$length, resid_gold, main = "Residuen vs. Länge", 
     xlab = "Länge (inches)", ylab = "Residuen")
abline(h = 0, lty = 2)
plot(gold$width, resid_gold, main = "Residuen vs. Breite", 
     xlab = "Breite (mm)", ylab = "Residuen")
abline(h = 0, lty = 2)
par(mfrow = c(1,1))

# (i) MRM-Bedingungen erfüllt?
# Linearität: OK aus Streudiagrammen
# Konstante Varianz: Problematisch bei Breite (U-Form)
# Normalität: Ungefähr erfüllt
# Unabhängigkeit: Angenommen

# (j) Länge und Breite kombinieren (Volumen/Gewicht)
gold$volume <- gold$length * gold$width
mod_gold_vol <- lm(price ~ length + width + volume, data = gold)
summary(mod_gold_vol)

# Vergleich der Modelle
anova(mod_gold, mod_gold_vol)

# (k) Residuum der 1. Beobachtung
pred_1 <- predict(mod_gold)[1]
resid_1 <- gold$price[1] - pred_1
cat("Residuum 1. Beobachtung:", round(resid_1, 2), "$\n")

# (l) 25. Beobachtung extrem hoch?
pred_25 <- predict(mod_gold)[25]
resid_25 <- gold$price[25] - pred_25
ci_25 <- predict(mod_gold, interval = "prediction")[25,]
cat("25. Beobachtung - Preis:", gold$price[25], "$\n")
cat("Vorhersage:", round(pred_25, 2), "$\n")
cat("95% Prognose-Intervall: [", round(ci_25["lwr"], 2), ",", round(ci_25["upr"], 2), "] $\n")

# (m) Kalibrierungsdiagramm
plot(fitted(mod_gold), gold$price, 
     main = "Kalibrierungsdiagramm", 
     xlab = "Geschätzte Werte", ylab = "Beobachtete Werte")
abline(0, 1, col = "red")

# (n) Residuen vs. angepasste Werte
plot(fitted(mod_gold), resid_gold,
     main = "Residuen vs. Angepasste Werte",
     xlab = "Angepasste Werte", ylab = "Residuen")
abline(h = 0, lty = 2)

# (o) Pfaddiagramm (konzeptuell)
cat("Pfaddiagramm:\n")
cat("Länge -> Preis:", round(coef(mod_gold)["length"], 2), "\n")
cat("Breite -> Preis:", round(coef(mod_gold)["width"], 2), "\n")
cat("Länge <-> Breite:", round(cor(gold$length, gold$width), 3), "\n")

# (p) 3D-Visualisierung
scatterplot3d(gold$length, gold$width, gold$price,
              xlab = "Länge", ylab = "Breite", zlab = "Preis",
              main = "3D-Visualisierung Gold Chains")





# ============================================================================
# Aufgabe 2: HR Regression (Pfaddiagramm-Interpretation)
# ============================================================================

# Aus dem Pfaddiagramm:
# Age -> Salary: 5 $000/year
# Test Score -> Salary: 2 $000/point  
# Age <-> Test Score: 5 points/year (Korrelation)

# (a) Gleichungen notieren
cat("MRM: Salary = b0 + b1*Age + b2*TestScore\n")
cat("Angepasstes MRM: Salary = b0 + 5*Age + 2*TestScore\n")
cat("Interpretation:\n")
cat("- Pro Jahr Alter: +5000$ (bei konstantem Testscore)\n")
cat("- Pro Testpunkt: +2000$ (bei konstantem Alter)\n")

# (b) Nötige Informationen für Schätzung?
cat("Nein, das Intercept (b0) fehlt im Pfaddiagramm!\n")

# (c) Direkter vs. indirekter Effekt des Testscores
direct_effect <- 2  # $000/point
indirect_effect <- 5 * 2  # 5 points/year * 2 $000/point = 10 $000/year
cat("Direkter Effekt:", direct_effect, "$000/point\n")
cat("Indirekter Effekt:", indirect_effect, "$000/year\n")
cat("Indirekter Effekt ist größer\n")

# (d) Marginale Steigung des Gehalts anhand Testergebnisse
marginal_slope <- direct_effect + (5 * 2)  # Vereinfacht für Demonstration
cat("Marginale Steigung:", marginal_slope, "$000/point\n")

# (e) Kurs für 25.000 USD wert?
# Partielle Steigung ist relevant: 2 $000/point
# 5 Punkte Verbesserung = 5 * 2000 = 10.000 USD
# Wenn man länger als 2 Jahre bleibt, lohnt es sich
cat("Nutzen: 5 * 2000 = 10.000 USD\n")
cat("Kosten: 25.000 USD\n")
cat("Partielle Steigung ist relevant\n")
cat("Lohnt sich nur bei längerer Beschäftigung\n")





# ============================================================================
# Aufgabe 3: Download (Netzwerk-Performance mit mehreren Variablen)
# ============================================================================
# Daten einlesen
download <- read_excel("data/WDDA_06.xlsx", sheet = "Download") %>%
  rename(time_sec = `Transfer Time (sec)`,
         size_mb = `File Size (MB)`,
         hours_after_8 = `Hours after 8AM`)
head(download)

# (a) Korrelationen finden
cor_download <- cor(download)
print(cor_download)

# (b) Streudiagramme untersuchen
pairs(download, main = "Streudiagramme Download")

# (c) Marginale Steigung der Dateigröße
mod_size_simple <- lm(time_sec ~ size_mb, data = download)
summary(mod_size_simple)
cat("Marginale Steigung Dateigröße:", round(coef(mod_size_simple)["size_mb"], 3), "s/MB\n")

# (d) Erwartung für partielle Steigung
# Da Dateigröße und Stunden stark korreliert sind (r ≈ 0.99), 
# erwarten wir deutliche Unterschiede

# (e) Multiple Regression anpassen
mod_download <- lm(time_sec ~ size_mb + hours_after_8, data = download)
summary(mod_download)
cat("Partielle Steigung Dateigröße:", round(coef(mod_download)["size_mb"], 3), "s/MB\n")

# (f) Interpretation von Intercept, R² und Standardfehler
r2_download <- summary(mod_download)$r.squared
rse_download <- summary(mod_download)$sigma
cat("Intercept:", round(coef(mod_download)["(Intercept)"], 2), "s\n")
cat("R² =", round(r2_download, 4), "\n")
cat("RSE =", round(rse_download, 2), "s\n")

# (g) Residuen glockenförmig?
resid_download <- resid(mod_download)
par(mfrow = c(1,2))
hist(resid_download, main = "Histogramm der Residuen", xlab = "Residuen")
qqnorm(resid_download)
qqline(resid_download)
par(mfrow = c(1,1))

mean_resid_download <- mean(resid_download)
sd_resid_download <- sd(resid_download)
cat("Residuen-Mittelwert:", round(mean_resid_download, 2), "\n")
cat("Residuen-SD:", round(sd_resid_download, 2), "s\n")

# (h) Scatterplot der Residuen auf erklärenden Variablen
par(mfrow = c(1,2))
plot(download$size_mb, resid_download, main = "Residuen vs. Dateigröße", 
     xlab = "Dateigröße (MB)", ylab = "Residuen")
abline(h = 0, lty = 2)
plot(download$hours_after_8, resid_download, main = "Residuen vs. Stunden", 
     xlab = "Stunden nach 8AM", ylab = "Residuen")
abline(h = 0, lty = 2)
par(mfrow = c(1,1))

# (i) MRM-Bedingungen erfüllt?
cat("MRM-Bedingungen:\n")
cat("- Linearität: OK\n")
cat("- Konstante Varianz: OK\n") 
cat("- Normalität: OK\n")
cat("- Unabhängigkeit: Angenommen\n")
cat("- Multikollinearität: Problematisch (r = 0.99)\n")

# (j) Kalibrierungsdiagramm
plot(fitted(mod_download), download$time_sec, 
     main = "Kalibrierungsdiagramm", 
     xlab = "Geschätzte Werte", ylab = "Beobachtete Werte")
abline(0, 1, col = "red")

# (k) Residuen vs. angepasste Werte
plot(fitted(mod_download), resid_download,
     main = "Residuen vs. Angepasste Werte",
     xlab = "Angepasste Werte", ylab = "Residuen")
abline(h = 0, lty = 2)

# (l) Pfaddiagramm
cat("Pfaddiagramm:\n")
cat("Dateigröße -> Zeit:", round(coef(mod_download)["size_mb"], 3), "\n")
cat("Stunden -> Zeit:", round(coef(mod_download)["hours_after_8"], 3), "\n")
cat("Dateigröße <-> Stunden:", round(cor(download$size_mb, download$hours_after_8), 3), "\n")

# (m) 3D-Visualisierung
scatterplot3d(download$size_mb, download$hours_after_8, download$time_sec,
              xlab = "Dateigröße", ylab = "Stunden", zlab = "Zeit",
              main = "3D-Visualisierung Download")

# (n) Vergleich SRM vs MRM
mod_download_srm <- lm(time_sec ~ size_mb, data = download)
r2_srm <- summary(mod_download_srm)$r.squared
r2_adj_srm <- summary(mod_download_srm)$adj.r.squared
r2_mrm <- summary(mod_download)$r.squared
r2_adj_mrm <- summary(mod_download)$adj.r.squared

cat("SRM R²:", round(r2_srm, 4), ", Adj-R²:", round(r2_adj_srm, 4), "\n")
cat("MRM R²:", round(r2_mrm, 4), ", Adj-R²:", round(r2_adj_mrm, 4), "\n")

# (o) Zufrieden mit MRM?
cat("Nein, SRM bevorzugen wegen Multikollinearität\n")

# (p) Residuum der 41. Beobachtung
pred_41 <- predict(mod_download)[41]
resid_41 <- download$time_sec[41] - pred_41
cat("Residuum 41. Beobachtung:", round(resid_41, 2), "s\n")

# (q) Übertragungszeit 16. und 80. Beobachtung schätzen
ci_16 <- predict(mod_download, interval = "prediction")[16,]
ci_80 <- predict(mod_download, interval = "prediction")[80,]
cat("16. Beobachtung: [", round(ci_16["lwr"], 2), ",", round(ci_16["upr"], 2), "] s\n")
cat("80. Beobachtung: [", round(ci_80["lwr"], 2), ",", round(ci_80["upr"], 2), "] s\n")





# ============================================================================
# Aufgabe 4: BFH (Körpergröße-Modellierung)
# ============================================================================
# Daten einlesen
bfh <- read_excel("data/WDDA_06.xlsx", sheet = "BFH")
head(bfh)

# (a) Mögliche erklärende Variablen für Körpergröße
cat("Mögliche erklärende Variablen:\n")
cat("- gender: Geschlecht beeinflusst Körpergröße\n")
cat("- foot: Fußgröße korreliert mit Körpergröße\n") 
cat("- dob: Alter könnte relevant sein\n")
cat("- siblings: Genetische Faktoren\n")
cat("- sleep: Weniger wahrscheinlich relevant\n")

# (b) Eine Variable auswählen
cat("Beste Wahl: foot (Fußgröße) - starke biologische Korrelation\n")

# (c) MRM mit mehreren Variablen anpassen
# Erst Daten bereinigen
bfh_clean <- bfh %>%
  filter(!is.na(height), !is.na(foot), !is.na(gender)) %>%
  mutate(age = as.numeric(Sys.Date() - as.Date(dob)) / 365.25)

mod_bfh <- lm(height ~ foot + gender + age, data = bfh_clean)
summary(mod_bfh)

# (d) Linearität beurteilen - Kalibrierungsplot
plot(fitted(mod_bfh), bfh_clean$height, 
     main = "Kalibrierungsdiagramm BFH", 
     xlab = "Geschätzte Körpergröße", ylab = "Beobachtete Körpergröße")
abline(0, 1, col = "red")

# (e) Konstante Streuung - Residuen vs. fitted values
resid_bfh <- resid(mod_bfh)
plot(fitted(mod_bfh), resid_bfh,
     main = "Residuen vs. Angepasste Werte",
     xlab = "Angepasste Werte", ylab = "Residuen")
abline(h = 0, lty = 2)

# (f) Glockenförmige Residuen - Histogramm
hist(resid_bfh, main = "Histogramm der Residuen BFH", xlab = "Residuen")

# (g) Zufriedenheit mit Modell
r2_bfh <- summary(mod_bfh)$r.squared
cat("R² =", round(r2_bfh, 4), "\n")
cat("Modell-Interpretation:\n")
for(i in 1:length(coef(mod_bfh))) {
  cat(names(coef(mod_bfh))[i], ":", round(coef(mod_bfh)[i], 3), "\n")
}

# (h) Variablen entfernen?
# Prüfe Signifikanz der Koeffizienten
summary(mod_bfh)

# (i) Optimale Variablenkombination finden
# Schrittweise Regression
mod_step <- step(mod_bfh, direction = "both")
summary(mod_step)
