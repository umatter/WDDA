##############################################################
# WDDA Lecture 04 – Von Stichproben zur Population
# Schließende Statistik, Bootstrap und Konfidenzintervalle
#
# Dieses Script fasst sämtliche Inhalte aus den vier Folien-Batches zusammen.
# Themen:
#   1. Notation: Population vs. Stichprobe (Parameter vs. Schätzung)
#   2. Simulation der Stichprobenvariation und Berechnung des Standardfehlers
#   3. Einfluss der Stichprobengröße
#   4. Bereich plausibler Werte (Punktschätzung ± Fehlerbereich)
#   5. Simulation von Konfidenzintervallen für Proportionen
#   6. Bootstrap-Stichproben: Ermittlung von Standardfehlern und
#      Konfidenzintervallen (klassisch via se, alternativ mittels Quantilen)
#   7. Konfidenzintervalle für Differenzen
#   8. Konfidenzintervalle für Korrelationen
#
# Benötigte Pakete: mosaic, plotrix, readxl
##############################################################

# Pakete laden
library(mosaic)    # z.B. für do(), resample(), dotPlot()
library(plotrix)   # für plotCI()
library(readxl)    # zum Einlesen von Excel-Dateien



##############################################################
# 1. Notation: Stichprobe vs. Population
##############################################################
# Parameter (Population): z.B. Mittelwert µ, Standardabweichung σ, Varianz σ², Proportion p, etc.
# Schätzung (Stichprobe): z.B. x̄, s, s², p̂, etc.
#
# Daten importieren
Footballer <- read_excel("data/WDDA_04.xlsx", sheet = "Footballer")
WeeklySalary <- Footballer$WeeklySalary
# Beispiel: Dataframe Footballer mit den wöchentlichen Gehältern der Premier League
mu <- mean(WeeklySalary)
stichp1 <- sample(WeeklySalary, size = 30)
xbar <- mean(stichp1)
cat("Populationsmittelwert (µ):", round(mu, 2), "\n")
cat("Stichprobenmittelwert (x̄) (n = 30):", round(xbar, 2), "\n\n")







##############################################################
# 2. Simulation der Stichprobenvariation
##############################################################
# Ziehe 3000 Stichproben (n = 30) und berechne jeweils den Mittelwert.
m.stichps <- do(3000) * mean(sample(WeeklySalary, size = 30))
dotPlot(m.stichps$mean, nint = 200, cex = 2, pch = 1, ylim = c(0, 100))
cat("Verteilung der Stichprobenmittelwerte wurde dargestellt.\n\n")








##############################################################
# 3. Standardfehler der Stichprobenmittelwerte
##############################################################
se_simuliert <- sd(m.stichps$mean)
cat("Simulierter Standardfehler (se):", round(se_simuliert, 2), "\n")
cat("Hinweis: Stichprobenmittelwerte variieren deutlich weniger als einzelne Werte.\n\n")










##############################################################
# 4. Einfluss der Stichprobengröße ("Size does matter!")
##############################################################
# Mit zunehmender Stichprobengröße wird die Variation der Mittelwerte kleiner.
m.30  <- do(3000) * mean(sample(WeeklySalary, size = 30))
m.100 <- do(3000) * mean(sample(WeeklySalary, size = 100))
m.500 <- do(3000) * mean(sample(WeeklySalary, size = 500))
hist(m.30$mean, xlim = c(10000, 100000), main = "Stichprobenmittelwerte (n = 30)", xlab = "Mittelwert")
hist(m.100$mean, xlim = c(10000, 100000), main = "Stichprobenmittelwerte (n = 100)", xlab = "Mittelwert")
hist(m.500$mean, xlim = c(10000, 100000), main = "Stichprobenmittelwerte (n = 500)", xlab = "Mittelwert")
cat("Mit zunehmendem n wird die Verteilung schmaler (geringerer Standardfehler).\n\n")








##############################################################
# 5. Bereich plausibler Werte (Punktschätzung ± Fehlerbereich)
##############################################################
# Beispiel: SRF-Umfrage am 9. März 2021
# p̂ = 42% ± 2.8% → plausible Werte: [0.392, 0.448]
p_hat <- 0.42
error <- 0.028
plausible_interval <- c(p_hat - error, p_hat + error)
cat("Bereich der plausiblen Werte (SRF-Umfrage):", round(plausible_interval[1], 3),
    "bis", round(plausible_interval[2], 3), "\n\n")













##############################################################
# 6. Konfidenzintervalle – Simulation für Proportionen
##############################################################
# Beispiel: Anteil Hochschulabschluss bei Schweizerinnen (p = 0.296, d.h. 29.6%)
stich_m <- do(100) * mean(sample(0:1, prob = c(0.704, 0.296), size = 30, replace = TRUE))
hist(stich_m$mean, main = "Stichprobenanteil Hochschulabschluss", xlab = "Anteil Hochschulabschluss")
se_hat <- sd(stich_m$mean)
cat("Simulierter Standardfehler (SE) für den Anteil:", round(se_hat, 4), "\n\n")










##############################################################
# 7. Darstellung von Konfidenzintervallen aus der Simulation
##############################################################
# Berechne für jede der 100 Stichproben ein 95%-Konfidenzintervall (x̄ ± 2·SE)
untere <- stich_m - 2 * se_hat
obere <- stich_m + 2 * se_hat
plotCI(x = 1:100, y = stich_m$mean, li = untere$mean, ui = obere$mean,
       main = "Konfidenzintervalle aus der Simulation",
       xlab = "Stichprobe", ylab = "Anteil Hochschulabschluss")
cat("Konfidenzintervalle (95%-Niveau) aus der Simulation wurden geplottet.\n\n")











##############################################################
# 8. Bootstrap-Stichproben und Standardfehler für 'distance'
##############################################################
# Beispiel: BFH-Datensatz, Variable distance (Arbeitsweg)
BFH <- read_excel("data/WDDA_04.xlsx", sheet = "BFH")
hist(BFH$distance, main = "Histogramm der Arbeitswege", xlab = "Entfernung (km)")
boot1000.dist <- do(1000) * resample(BFH$distance)
boot1000.m <- apply(boot1000.dist, 1, mean)
hist(boot1000.m, main = "Bootstrap-Verteilung der Mittelwerte (distance)", xlab = "Mittelwert")
dist.se.hat <- sd(boot1000.m)
cat("Bootstrap-Standardfehler (distance):", round(dist.se.hat, 2), "\n\n")











##############################################################
# 9. Bootstrap: Beispiel – Nussmischung
##############################################################
# Beispiel: Eine Packung Nussmischung enthält 100 Nüsse, davon 52 Cashew-Nüsse.
phat <- 0.52
nuts <- sample(c(rep(1, phat * 100), rep(0, (1 - phat) * 100)))
nuts.re100 <- do(100) * resample(nuts)
nuts.m100 <- apply(nuts.re100, 1, mean)
hist(nuts.m100, main = "Bootstrap-Verteilung des Anteils (Nussmischung)", xlab = "Anteil Cashew-Nüsse")
nuts.se.hat <- sd(nuts.m100)
cat("Bootstrap-Standardfehler (Nussanteil):", round(nuts.se.hat, 3), "\n\n")






##############################################################
# 10. Konfidenzintervalle mit der Bootstrap-Methode (se-Methode) für 'distance'
##############################################################
xbar_distance <- mean(BFH$distance)
dist.konf <- xbar_distance + c(-1, 1) * 2 * dist.se.hat
cat("95%-Konfidenzintervall (mit se-Methode) für distance:", round(dist.konf[1], 2),
    "bis", round(dist.konf[2], 2), "\n\n")











##############################################################
# 11. Alternative Konfidenzintervalle – Bootstrap-Konfidenzintervalle (Quantile) für 'distance'
##############################################################
dist.q25 <- quantile(boot1000.m, probs = 0.025, type = 1)
dist.q975 <- quantile(boot1000.m, probs = 0.975, type = 1)
cat("95%-Konfidenzintervall (Quantile) für distance:", round(dist.q25, 2),
    "bis", round(dist.q975, 2), "\n\n")









##############################################################
# 12. Konfidenzintervalle mit Perzentilen für unterschiedliche Konfidenzniveaus (distance)
##############################################################
# 90%-Konfidenzintervall:
dist.q05 <- quantile(boot1000.m, probs = 0.05, type = 1)
dist.q90 <- quantile(boot1000.m, probs = 0.90, type = 1)
cat("90%-Konfidenzintervall für distance:", round(dist.q05, 2), "bis", round(dist.q90, 2), "\n")
# 99%-Konfidenzintervall:
dist.q005 <- quantile(boot1000.m, probs = 0.005, type = 1)
dist.q995 <- quantile(boot1000.m, probs = 0.995, type = 1)
cat("99%-Konfidenzintervall für distance:", round(dist.q005, 2), "bis", round(dist.q995, 2), "\n\n")











##############################################################
# 13. Konfidenzintervalle für Differenzen (Trainingszeiten)
##############################################################

# Daten Laden
ExerciseHours <- read_excel("data/WDDA_04.xlsx", sheet = "ExerciseHours")

# Beispiel: Differenz der durchschnittlichen Exercise-Stunden zwischen Männern und Frauen.
men   <- ExerciseHours[ExerciseHours$Sex == "M", ]
women <- ExerciseHours[ExerciseHours$Sex == "F", ]
mw.m  <- mean(men$Exercise)
mw.f  <- mean(women$Exercise)
diff.hat <- mw.m - mw.f
cat("Differenz der durchschnittlichen Exercise-Stunden (Männer - Frauen):", round(diff.hat, 2), "\n")
# Bootstrap für Differenzen: Ziehe 3000 Bootstrap-Stichproben
boot3000.diff <- do(3000) * (mean(resample(men$Exercise)) - mean(resample(women$Exercise)))
diff.q005 <- quantile(boot3000.diff$result, probs = 0.025, type = 1)
diff.q995 <- quantile(boot3000.diff$result, probs = 0.975, type = 1)
cat("95%-Konfidenzintervall für Differenzen:", round(diff.q005, 2), "bis", round(diff.q995, 2), "\n\n")













##############################################################
# 14. Konfidenzintervalle für Korrelationen (Mustangs-Datensatz)
##############################################################

# Daten laden
Mustangs <- read_excel("data/WDDA_04.xlsx", sheet = "Mustangs")

# Beispiel: Bestimme die Korrelation zwischen Price und Miles.
mustangs.cor.boot <- do(5000) * cor(Price ~ Miles, data = resample(Mustangs))
quantiles <- qdata(~ cor, c(0.01, 0.99), data = mustangs.cor.boot)
cat("98%-Konfidenzintervall für die Korrelation (Price ~ Miles):\n")
print(quantiles)
cat("\n")

