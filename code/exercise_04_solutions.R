# WDDA FS 2025: Lösungen für Aufgabenserie 4
# Dieses Skript enthält die R-Code-Lösungen für die Aufgabenserie 4

# Daten laden
library(readxl)
library(mosaic)
data <- read_excel("data/WDDA_04.xlsx", sheet = "BFH")





# ============================================================================
# Aufgabe 1: Parameter vs. Statistik
# ============================================================================
# Keine Berechnung erforderlich
# (a) Parameter: μ
# (b) Statistik: x̄





# ============================================================================
# Aufgabe 2: Smartphone-App-Studie
# ============================================================================
# Keine Berechnung erforderlich, die Werte sind bereits gegeben
# (a) Der Parameter ist μ = mittlere Anzahl heruntergeladener Apps aller Smartphone-Nutzer in den USA
# (b) Die beste Schätzung liefert der Stichprobenmittelwert x̄ = 19.7
# (c) Um den Parameter genau zu berechnen, müsste man die Anzahl der heruntergeladenen Apps 
#     von allen Smartphone-Nutzern in den USA erfassen





# ============================================================================
# Aufgabe 3: Wahrscheinlichkeit von Stichprobenmittelwerten
# ============================================================================
# Hier würde normalerweise eine Analyse der Stichprobenverteilung erfolgen
# Da wir nur das Bild haben, basieren die Antworten auf visueller Inspektion
# (a) x̄ = 70: Mit angemessener Wahrscheinlichkeit (i)
# (b) x̄ = 100: Mit angemessener Wahrscheinlichkeit (i)
# (c) x̄ = 140: Ungewöhnlich, könnte aber gelegentlich auftreten (ii)





# ============================================================================
# Aufgabe 4: Analyse von Umfragedaten
# ============================================================================
# Verhüllungsverbot
ja_verhuellungsverbot <- 49
fehlerbereich <- 2.8

# Berechnung des Konfidenzintervalls
untere_grenze_verhuellungsverbot <- ja_verhuellungsverbot - fehlerbereich
obere_grenze_verhuellungsverbot <- ja_verhuellungsverbot + fehlerbereich


cat("Plausible Werte für Verhüllungsverbot:", 
    untere_grenze_verhuellungsverbot, "% bis", 
    obere_grenze_verhuellungsverbot, "%\n")

# Freihandel mit Indonesien
ja_freihandel <- 52
untere_grenze_freihandel <- ja_freihandel - fehlerbereich
obere_grenze_freihandel <- ja_freihandel + fehlerbereich

cat("Plausible Werte für Freihandel mit Indonesien:", 
    untere_grenze_freihandel, "% bis", 
    obere_grenze_freihandel, "%\n")

# Interpretation:
# (a) Für das Verhüllungsverbot liegt der Bereich der plausiblen Werte bei [46.2%, 51.8%].
#     Da dieser Bereich sowohl Werte unter als auch über 50% enthält, kann nicht mit 
#     Sicherheit gesagt werden, dass die Initiative angenommen wird.
# (b) Für den Freihandel mit Indonesien liegt der Bereich der plausiblen Werte bei [49.2%, 54.8%].
#     Auch hier enthält der Bereich Werte unter 50%, daher ist eine Annahme nicht sicher.

# ============================================================================
# Aufgabe 5: Wahr oder Falsch zu Konfidenzintervallen
# ============================================================================
# Keine Berechnung erforderlich
# (a) FALSCH. Ein Konfidenzintervall macht eine Aussage über den Parameter der Grundgesamtheit,
#     nicht über die einzelnen Datenpunkte.
# (b) FALSCH. Ein Konfidenzintervall bezieht sich auf den Populationsparameter, 
#     nicht auf Stichprobenmittelwerte.
# (c) FALSCH. Nachdem ein Konfidenzintervall berechnet wurde, enthält es entweder den wahren 
#     Parameter oder nicht. Die 95% beziehen sich auf die Methode.

# ============================================================================
# Aufgabe 6: Konstruktion von Konfidenzintervallen
# ============================================================================
# (a) Für den Mittelwert μ
x_bar <- 25
se_mean <- 3
margin_error <- 2 * se_mean  # Für ein 95%-Konfidenzintervall

lower_bound_mean <- x_bar - margin_error
upper_bound_mean <- x_bar + margin_error

cat("95%-Konfidenzintervall für μ:", lower_bound_mean, "bis", upper_bound_mean, "\n")

# (b) Für den Anteil p
p_hat <- 0.37
margin_error_p <- 0.02

lower_bound_p <- p_hat - margin_error_p
upper_bound_p <- p_hat + margin_error_p

cat("Konfidenzintervall für p:", lower_bound_p, "bis", upper_bound_p, "\n")

# ============================================================================
# Aufgabe 7: Angstassoziationen bei Heranwachsenden
# ============================================================================
# Gegebene Werte
mean_adults <- 0.225
mean_teens <- 0.059
se_diff <- 0.091

# Berechnung der Differenz
diff_means <- mean_adults - mean_teens

# Berechnung des 95%-Konfidenzintervalls
margin_error <- 2 * se_diff
lower_bound <- diff_means - margin_error
upper_bound <- diff_means + margin_error

cat("Differenz der Mittelwerte:", diff_means, "\n")
cat("95%-Konfidenzintervall:", lower_bound, "bis", upper_bound, "\n")

# Antworten:
# (a) Die zu schätzende Grösse ist μA - μT (Differenz der mittleren Angstreaktionen)
# (b) Die beste Schätzung ist x̄A - x̄T = 0.166
# (c) Das 95%-Konfidenzintervall ist [-0.016, 0.348]
# (d) Es handelt sich um eine Beobachtungsstudie, da die erklärende Variable (Alter) 
#     nicht manipuliert wurde

# ============================================================================
# Aufgabe 8: Verhaftungsraten bei jungen Menschen
# ============================================================================
# Gegebene Werte
p_hat <- 0.30
margin_error <- 0.01

# Berechnung des Konfidenzintervalls
lower_bound <- p_hat - margin_error
upper_bound <- p_hat + margin_error

cat("Schätzung des Anteils:", p_hat, "\n")
cat("Konfidenzintervall:", lower_bound, "bis", upper_bound, "\n")

# Antworten:
# (a) Der Wert 30% ist eine Statistik, Notation: p̂ = 0.30
# (b) Der zu schätzende Parameter ist p, der Anteil aller jungen Menschen in den USA,
#     die im Alter von 23 Jahren verhaftet wurden
# (c) Der Bereich plausibler Werte für p liegt bei [0.29, 0.31]
# (d) Nein, es ist sehr unwahrscheinlich, dass der tatsächliche Anteil weniger als 20% beträgt,
#     da dieser Wert weit ausserhalb des Konfidenzintervalls liegt

# ============================================================================
# Aufgabe 9: Auto als Notwendigkeit oder Luxus
# ============================================================================
# Keine Berechnung erforderlich
# Das 95%-Konfidenzintervall [0.83, 0.89] bedeutet, dass wir mit 95% Sicherheit davon 
# ausgehen können, dass zwischen 83% und 89% aller Erwachsenen in den USA ein Auto 
# als Notwendigkeit betrachten.

# ============================================================================
# Aufgabe 10: Action-Videospiele und Reaktionszeit
# ============================================================================
# Keine Berechnung erforderlich
# (a) Das 95%-KI [-1.8, -1.2] bedeutet, dass Spieler im Durchschnitt zwischen 
#     1.2 und 1.8 Sekunden schneller reagieren als Nicht-Spieler
# (b) Es ist nicht plausibel, dass die Reaktionszeiten gleich sind, da das KI den Wert 0 
#     nicht enthält. Die Spieler sind schneller.
# (c) Das 95%-KI [-4.2, +5.8] für die Differenz der Genauigkeitswerte bedeutet, dass 
#     der Unterschied zwischen -4.2 und +5.8 Einheiten liegt
# (d) Es ist plausibel, dass Spieler und Nicht-Spieler bei der Genauigkeit gleich sind,
#     da das KI den Wert 0 enthält

# ============================================================================
# Aufgabe 11: Bootstrap-Stichproben
# ============================================================================
# Ursprüngliche Stichprobe
original_sample <- c(85, 72, 79, 97, 88)

# Überprüfung der Stichproben 
# (muss nicht so gemacht werden, Sie können dies auch gut manuell überprüfen!)
check_bootstrap <- function(sample) {
  # Prüfen, ob alle Werte in der ursprünglichen Stichprobe vorkommen
  all_values_valid <- all(sample %in% original_sample)
  
  # Prüfen, ob die Grösse stimmt
  correct_size <- length(sample) == length(original_sample)
  
  return(all_values_valid && correct_size)
}

samples <- list(
  a = c(79, 79, 97, 85, 88),
  b = c(72, 79, 85, 88, 97),
  c = c(85, 88, 97, 72),
  d = c(88, 97, 81, 78, 85),
  e = c(97, 85, 79, 85, 97),
  f = c(72, 72, 79, 72, 79)
)

for (name in names(samples)) {
  cat(name, ": ", check_bootstrap(samples[[name]]), "\n")
}

# Antworten:
# (a) Ja, dies ist eine mögliche Bootstrap-Stichprobe
# (b) Ja, dies ist eine mögliche Bootstrap-Stichprobe
# (c) Nein, diese Stichprobe hat nur 4 Elemente statt 5
# (d) Nein, die Werte 81 und 78 kommen in der ursprünglichen Stichprobe nicht vor
# (e) Ja, dies ist eine mögliche Bootstrap-Stichprobe
# (f) Ja, dies ist eine mögliche Bootstrap-Stichprobe

# ============================================================================
# Aufgabe 12: Bootstrap-Methode für Konfidenzintervalle
# ============================================================================
# Daten erstellen
n <- 250
yes <- 180
no <- n - yes
data_votes <- c(rep(1, yes), rep(0, no))  # 1 für Ja, 0 für Nein

# Anteil berechnen
p_hat <- mean(data_votes)
cat("Geschätzter Anteil:", p_hat, "\n")

# Bootstrap-Stichproben ziehen
set.seed(123)  # Für Reproduzierbarkeit
bootstrap_samples <- do(1000) * mean(resample(data_votes))

# Standardfehler berechnen
se_bootstrap <- sd(bootstrap_samples$mean)
cat("Bootstrap-Standardfehler:", se_bootstrap, "\n")

# 95%-Konfidenzintervall berechnen
ci_lower <- p_hat - 2 * se_bootstrap
ci_upper <- p_hat + 2 * se_bootstrap
cat("95%-Konfidenzintervall:", ci_lower, "bis", ci_upper, "\n")

# Alternative: Perzentil-Methode
ci_percentile <- quantile(bootstrap_samples$mean, c(0.025, 0.975))
cat("95%-Konfidenzintervall (Perzentil-Methode):", 
    ci_percentile[1], "bis", ci_percentile[2], "\n")





# ============================================================================
# Aufgabe 13: Ameisen auf Honigbrot
# ============================================================================
# Daten
ants <- c(43, 59, 22, 25, 36, 47, 19, 21)

# (a) Mittelwert und Standardabweichung
mean_ants <- mean(ants)
sd_ants <- sd(ants)
cat("Mittelwert (x̄):", mean_ants, "\n")
cat("Standardabweichung (s):", sd_ants, "\n")

# (e) Bootstrap-Stichproben ziehen
set.seed(123)
bootstrap_samples_ants <- do(5000) * mean(resample(ants))

# Standardfehler berechnen
se_bootstrap_ants <- sd(bootstrap_samples_ants$mean)
cat("Bootstrap-Standardfehler:", se_bootstrap_ants, "\n")

# (f) 95%-Konfidenzintervall berechnen
ci_lower_ants <- mean_ants - 2 * se_bootstrap_ants
ci_upper_ants <- mean_ants + 2 * se_bootstrap_ants
cat("95%-Konfidenzintervall:", ci_lower_ants, "bis", ci_upper_ants, "\n")

# Histogramm der Bootstrap-Verteilung
hist(bootstrap_samples_ants$mean, 
     main = "Bootstrap-Verteilung des Mittelwerts",
     xlab = "Mittelwert", 
     col = "lightblue")
abline(v = mean_ants, col = "red", lwd = 2)

# Antworten:
# (a) x̄ = 34, s = 14.63
# (b) Wir schreiben die 8 Werte jeweils auf einen Zettel, ziehen zufällig mit Zurücklegen
#     und berechnen den Mittelwert der gezogenen Werte
# (c) Wir erwarten eine annähernd glockenförmige Verteilung mit Zentrum bei etwa 34
# (d) Der Parameter ist μ, die mittlere Anzahl von Ameisen auf allen möglichen Honigbroten
#     Die beste Schätzung ist x̄ = 34
# (e) Der Bootstrap-Standardfehler beträgt etwa 4.85
# (f) Das 95%-Konfidenzintervall liegt bei [24.3, 43.7]





# ============================================================================
# Aufgabe 14: Nussmischung
# ============================================================================
# Daten
n_nuts <- 400
n_cashew <- 208

# Anteil berechnen
p_hat_nuts <- n_cashew / n_nuts
cat("Geschätzter Anteil Cashew-Nüsse:", p_hat_nuts, "\n")

# Standardfehler berechnen
se_nuts <- sqrt(p_hat_nuts * (1 - p_hat_nuts) / n_nuts)
cat("Standardfehler:", se_nuts, "\n")

# 95%-Konfidenzintervall berechnen
ci_lower_nuts <- p_hat_nuts - 2 * se_nuts
ci_upper_nuts <- p_hat_nuts + 2 * se_nuts
cat("95%-Konfidenzintervall:", ci_lower_nuts, "bis", ci_upper_nuts, "\n")

# Vergleich mit einem hypothetischen kleineren Stichprobenumfang (z.B. 100)
n_small <- 100
se_small <- sqrt(p_hat_nuts * (1 - p_hat_nuts) / n_small)
ci_lower_small <- p_hat_nuts - 2 * se_small
ci_upper_small <- p_hat_nuts + 2 * se_small
cat("95%-KI bei n=100:", ci_lower_small, "bis", ci_upper_small, "\n")

# Antworten:
# (g) Das 95%-Konfidenzintervall für den Anteil der Cashew-Nüsse liegt bei [0.466, 0.574]
# (h) Bei einer Erhöhung des Stichprobenumfangs wird das Konfidenzintervall schmaler
#     Der Standardfehler nimmt mit dem Faktor 1/√n ab





# ============================================================================
# Aufgabe 15: Perzentil-Methode für Konfidenzintervalle
# ============================================================================
# Anzahl der Bootstrap-Stichproben
n_bootstrap <- 1000

# (a) 95%-Konfidenzintervall
alpha_95 <- 0.05
cut_each_end_95 <- n_bootstrap * (alpha_95 / 2)
cat("Für 95%-KI: ", cut_each_end_95, "Werte an jedem Ende abschneiden\n")

# (b) 90%-Konfidenzintervall
alpha_90 <- 0.10
cut_each_end_90 <- n_bootstrap * (alpha_90 / 2)
cat("Für 90%-KI: ", cut_each_end_90, "Werte an jedem Ende abschneiden\n")

# (c) 99%-Konfidenzintervall
alpha_99 <- 0.01
cut_each_end_99 <- n_bootstrap * (alpha_99 / 2)
cat("Für 99%-KI: ", cut_each_end_99, "Werte an jedem Ende abschneiden\n")





# ============================================================================
# Aufgabe 16: Änderungen im Bootstrap-Prozess
# ============================================================================
# Keine Berechnung erforderlich
# (a) Für ein 90%-KI erwarten wir ein schmaleres Intervall: C = [67.5, 72.5]
# (b) Bei kleinerem Stichprobenumfang erwarten wir ein breiteres KI: A = [66, 74]
# (c) Die Änderung der Bootstrap-Stichprobenanzahl hat wenig Einfluss: B = [67, 73]







# ============================================================================
# Aufgabe 17: Konfidenzintervall für Umfragedaten
# ============================================================================
# Daten
n <- 1000
n_agree <- 382

# Anteil berechnen
p_hat_survey <- n_agree / n
cat("Geschätzter Anteil Zustimmender:", p_hat_survey, "\n")

# Standardfehler berechnen
se_survey <- sqrt(p_hat_survey * (1 - p_hat_survey) / n)
cat("Standardfehler:", se_survey, "\n")

# 99%-Konfidenzintervall berechnen (z = 2.576 für 99%)
z_99 <- 2.576
margin_error_survey <- z_99 * se_survey
ci_lower_survey <- p_hat_survey - margin_error_survey
ci_upper_survey <- p_hat_survey + margin_error_survey
cat("99%-Konfidenzintervall:", ci_lower_survey, "bis", ci_upper_survey, "\n")





# ============================================================================
# Aufgabe 18: Konfidenzintervall für Bargeldbeträge
# ============================================================================
# Bootstrap-Stichproben ziehen
set.seed(123)
bootstrap_samples_cash <- do(1000) * mean(~cash, data = resample(data))

# 90%-Konfidenzintervall berechnen (Perzentil-Methode)
ci_90_cash <- quantile(bootstrap_samples_cash$mean, c(0.05, 0.95))
cat("90%-Konfidenzintervall für Bargeldbeträge:", 
    ci_90_cash[1], "bis", ci_90_cash[2], "CHF\n")

# Alternativ: Standardfehler-Methode
mean_cash <- mean(data$cash, na.rm = TRUE)
se_bootstrap_cash <- sd(bootstrap_samples_cash$mean)
z_90 <- 1.645  # z-Wert für 90%-KI
ci_lower_cash <- mean_cash - z_90 * se_bootstrap_cash
ci_upper_cash <- mean_cash + z_90 * se_bootstrap_cash
cat("90%-KI (Standardfehler-Methode):", ci_lower_cash, "bis", ci_upper_cash, "CHF\n")

# ============================================================================
# Aufgabe 19: Schlafzeiten nach Geschlecht
# ============================================================================
# Daten nach Geschlecht filtern
female_data <- subset(data, gender == "Female")
male_data <- subset(data, gender == "Male")

# Mittlere Schlafzeiten berechnen
mean_sleep_female <- mean(female_data$sleep, na.rm = TRUE)
mean_sleep_male <- mean(male_data$sleep, na.rm = TRUE)
diff_means_sleep <- mean_sleep_female - mean_sleep_male

cat("Mittlere Schlafzeit Frauen:", mean_sleep_female, "Stunden\n")
cat("Mittlere Schlafzeit Männer:", mean_sleep_male, "Stunden\n")
cat("Differenz (Frauen - Männer):", diff_means_sleep, "Stunden\n")

# Bootstrap für die Differenz der Mittelwerte
set.seed(123)
# Wir erstellen einen Datensatz ohne "Non binary" und ohne NA-Werte
data_binary <- subset(data, gender %in% c("Female", "Male") & !is.na(sleep))
# Prüfen, ob genügend Daten vorhanden sind
if (nrow(data_binary) > 0 && length(unique(data_binary$gender)) > 1) {
  bootstrap_diff <- do(1000) * diff(mean(sleep ~ gender, data = resample(data_binary)))
} else {
  # Fallback, wenn nicht genügend Daten vorhanden sind
  bootstrap_diff <- data.frame(Female = NA)
  cat("Warnung: Nicht genügend Daten für Bootstrap-Analyse vorhanden.\n")
}

# 95%-Konfidenzintervall berechnen
ci_95_sleep <- quantile(bootstrap_diff$Female, c(0.025, 0.975), na.rm = TRUE)
cat("95%-Konfidenzintervall für die Differenz:", ci_95_sleep[1], "bis", ci_95_sleep[2], "Stunden\n")

# Interpretation - mit Fehlerbehandlung
if (!is.na(ci_95_sleep[1]) && !is.na(ci_95_sleep[2])) {
  if (ci_95_sleep[1] > 0) {
    cat("Da das gesamte Konfidenzintervall positiv ist, schlafen Studentinnen signifikant mehr als Studenten.\n")
  } else if (ci_95_sleep[2] < 0) {
    cat("Da das gesamte Konfidenzintervall negativ ist, schlafen Studenten signifikant mehr als Studentinnen.\n")
  } else {
    cat("Da das Konfidenzintervall die Null enthält, gibt es keinen signifikanten Unterschied in den Schlafzeiten.\n")
  }
} else {
  cat("Die Berechnung des Konfidenzintervalls ergab NA-Werte, möglicherweise aufgrund fehlender Daten.\n")
}

# ============================================================================
# Aufgabe 20: Konfidenzintervall für Korrelation
# ============================================================================
# Korrelation berechnen
correlation <- cor(data$height, data$foot, use = "complete.obs")
cat("Korrelation zwischen Körpergrösse und Fusslänge:", correlation, "\n")

# Daten für Bootstrap vorbereiten - nur vollständige Fälle verwenden
complete_data <- data[complete.cases(data[, c("height", "foot")]), ]

# Bootstrap für die Korrelation
set.seed(123)
if (nrow(complete_data) > 0) {
  bootstrap_cor <- do(5000) * cor(height ~ foot, data = resample(complete_data))
  
  # 99%-Konfidenzintervall berechnen
  ci_99_cor <- quantile(bootstrap_cor$cor, c(0.005, 0.995), na.rm = TRUE)
  cat("99%-Konfidenzintervall für die Korrelation:", ci_99_cor[1], "bis", ci_99_cor[2], "\n")
  
  # Histogramm der Bootstrap-Verteilung
  hist(bootstrap_cor$cor, 
       main = "Bootstrap-Verteilung der Korrelation",
       xlab = "Korrelation", 
       col = "lightblue")
  abline(v = correlation, col = "red", lwd = 2)
  abline(v = ci_99_cor, col = "blue", lty = 2, lwd = 2)
} else {
  cat("Nicht genügend vollständige Daten für Bootstrap-Analyse vorhanden.\n")
}
