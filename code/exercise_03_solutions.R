# WDDA FS 2026: Lösungen für Aufgabenserie 3
# Dieses Skript enthält die R-Code-Lösungen für die Aufgabenserie 3

# Pakete laden
library(readxl)
library(e1071)

# Daten importieren
data <- read_excel("data/WDDA_03.xlsx", sheet = "BFH")



# ============================================================================
# Aufgabe 1: Mittelwerte und Vergleich der Geschlechtsgruppen
# ============================================================================

male_height <- data$height[data$gender == "Male"]
female_height <- data$height[data$gender == "Female"]

mean_male <- mean(male_height, na.rm = TRUE)
mean_female <- mean(female_height, na.rm = TRUE)

cat("Mittlere Körpergrösse Männer:", mean_male, "cm\n")
cat("Mittlere Körpergrösse Frauen:", mean_female, "cm\n")
# Erwartet: Männer 181.1 cm, Frauen 167.2 cm

# (a) Wie viele Frauen sind grösser als der Mittelwert der Männer?
count_female_above_male_mean <- sum(female_height > mean_male, na.rm = TRUE)
count_female_above_male_mean  # Erwartet: 1

# (b) Wie viele Männer sind kleiner als der Mittelwert der Frauen?
count_male_below_female_mean <- sum(male_height < mean_female, na.rm = TRUE)
count_male_below_female_mean  # Erwartet: 3












# ============================================================================
# Aufgabe 2: Schwarmintelligenz – Analyse der Variable jar
# ============================================================================
# Tatsächliche Anzahl M&Ms im Glas: 405

# (a) Mittelwert von jar
mean_jar <- mean(data$jar, na.rm = TRUE)
mean_jar  # Erwartet: 299.7

# (b) Geburtsdatum der Person, die am besten geraten hat
diff_to_actual <- abs(data$jar - 405)
best_index <- which.min(diff_to_actual)
best_birthdate <- data$dob[best_index]
format(best_birthdate)  # Erwartet: 1997-04-10

# (c) Wie viele Individuen sind näher an 405 als am Mittelwert?
closer_than_mean <- sum(abs(data$jar - 405) < abs(data$jar - mean_jar), na.rm = TRUE)
closer_than_mean  # Erwartet: 61




# ============================================================================
# Aufgabe 3: Vergleich von Mittelwert und Median
# ============================================================================

# (a) jar
mean(data$jar, na.rm = TRUE)    # Erwartet: 299.7
median(data$jar, na.rm = TRUE)  # Erwartet: 287

# (b) siblings
mean(data$siblings, na.rm = TRUE)    # Erwartet: 1.5
median(data$siblings, na.rm = TRUE)  # Erwartet: 1

# (c) distance
mean(data$distance, na.rm = TRUE)    # Erwartet: 25.2
median(data$distance, na.rm = TRUE)  # Erwartet: 24




# ============================================================================
# Aufgabe 4: Schätzung des zentralen Trends von cash
# ============================================================================

# Bei rechtsschiefen Daten ist der Mittelwert höher als der Median,
# weil Ausreisser den Mittelwert nach oben ziehen.
mean(data$cash, na.rm = TRUE)
median(data$cash, na.rm = TRUE)




# ============================================================================
# Aufgabe 5: Durchschnittsausgabe für Geschwister-Geschenk
# ============================================================================

# Gewichteter Mittelwert: Personen mit mehr Geschwistern tragen
# mehr zum Durchschnitt bei
mean_gift <- weighted.mean(data$present, data$siblings)
mean_gift  # Erwartet: 85.1 CHF




# ============================================================================
# Aufgabe 6: Bestimmung der Spannweite (Range)
# ============================================================================

# (a) height
diff(range(data$height, na.rm = TRUE))  # Erwartet: 43 cm

# (b) maths
diff(range(data$maths, na.rm = TRUE))  # Erwartet: 5

# (c) cash
diff(range(data$cash, na.rm = TRUE))  # Erwartet: 749.85 CHF




# ============================================================================
# Aufgabe 7: Interquartilsabstand (IQR)
# ============================================================================

# (a) height
IQR(data$height, na.rm = TRUE)  # Erwartet: 14 cm

# (b) maths
IQR(data$maths, na.rm = TRUE)  # Erwartet: 1.5

# (c) cash
IQR(data$cash, na.rm = TRUE)  # Erwartet: 60 CHF




# ============================================================================
# Aufgabe 8: Nebeneinander liegende Boxplots
# ============================================================================

# (a) hair nach gender
boxplot(data$hair ~ data$gender,
        main = "Boxplot: Haarlänge nach Geschlecht",
        xlab = "Geschlecht", ylab = "Haarlänge",
        col = c("lightpink", "lightblue"))

# (b) distance nach transport
boxplot(data$distance ~ data$transport,
        main = "Boxplot: Entfernung nach Transportmittel",
        xlab = "Transportmittel", ylab = "Entfernung (km)",
        col = "lightgreen")

# (c) foot nach eye
boxplot(data$foot ~ data$eye,
        main = "Boxplot: Fusslänge nach Augenfarbe",
        xlab = "Augenfarbe", ylab = "Fusslänge",
        col = "lightyellow")




# ============================================================================
# Aufgabe 9: Standardabweichung (als Stichprobe)
# ============================================================================

# (a) height
sd(data$height, na.rm = TRUE)  # Erwartet: 9.3 cm

# (b) maths
sd(data$maths, na.rm = TRUE)  # Erwartet: 0.9

# (c) cash
sd(data$cash, na.rm = TRUE)  # Erwartet: 83.8 CHF




# ============================================================================
# Aufgabe 10: Überprüfung der empirischen Regel
# ============================================================================

# Funktion zur Überprüfung der empirischen Regel
check_empirical_rule <- function(x) {
  x <- x[!is.na(x)]
  m <- mean(x)
  s <- sd(x)
  p1 <- mean(x >= m - s & x <= m + s)
  p2 <- mean(x >= m - 2 * s & x <= m + 2 * s)
  p3 <- mean(x >= m - 3 * s & x <= m + 3 * s)
  c("1 SD" = round(p1, 2), "2 SD" = round(p2, 2), "3 SD" = round(p3, 2))
}

# (a) height
check_empirical_rule(data$height)

# (b) foot
check_empirical_rule(data$foot)

# (c) distance
check_empirical_rule(data$distance)

# (d) reaction1
check_empirical_rule(data$reaction1)




# ============================================================================
# Aufgabe 11: Analyse der IHG Kundenbewertungen
# ============================================================================

data_ihg <- read_excel("data/WDDA_03.xlsx", sheet = "IHG")

# (a) Mittelwert und Median
mean(data_ihg$`Customer ratings`, na.rm = TRUE)    # Erwartet: 4.16
median(data_ihg$`Customer ratings`, na.rm = TRUE)  # Erwartet: 4.2

# (b) Mittelwert ist geeignet, da keine offensichtlichen Ausreisser

# (c) Q1, Q3, IQR
quantile(data_ihg$`Customer ratings`, probs = c(0.25, 0.75), na.rm = TRUE)
# Erwartet: Q1 = 3.95, Q3 = 4.3
IQR(data_ihg$`Customer ratings`, na.rm = TRUE)  # Erwartet: 0.35

# (d) 85. Perzentil
quantile(data_ihg$`Customer ratings`, probs = 0.85, na.rm = TRUE)  # Erwartet: 4.4




# ============================================================================
# Aufgabe 12: Polizeiaufzeichnungen – Winter vs. Sommer
# ============================================================================

winter <- c(18, 20, 15, 16, 21, 20, 12, 16, 19, 20)
sommer <- c(28, 18, 24, 32, 18, 29, 23, 38, 28, 18)

# (a) Spannweite und IQR
diff(range(winter))  # = 9
IQR(winter)          # = 4
diff(range(sommer))  # = 20
IQR(sommer)          # = 12

# (b) Varianz und Standardabweichung
var(winter)  # Erwartet: 8.23
sd(winter)   # Erwartet: 2.87
var(sommer)  # Erwartet: 44.49
sd(sommer)   # Erwartet: 6.67

# (c) Variationskoeffizient
sd(winter) / mean(winter) * 100  # Erwartet: 16.21%
sd(sommer) / mean(sommer) * 100  # Erwartet: 26.05%

# (d) Die Sommerperiode weist eine grössere Variabilität auf




# ============================================================================
# Aufgabe 13: Standardisierung – z-Werte
# ============================================================================

z_height <- scale(data$height)
z_foot <- scale(data$foot)
z_house <- scale(data$house)

# Alle standardisierten Listen haben Mittelwert 0 und SD 1
mean(z_height, na.rm = TRUE)  # ~ 0
sd(z_height, na.rm = TRUE)    # ~ 1
mean(z_foot, na.rm = TRUE)    # ~ 0
sd(z_foot, na.rm = TRUE)      # ~ 1
mean(z_house, na.rm = TRUE)   # ~ 0
sd(z_house, na.rm = TRUE)     # ~ 1




# ============================================================================
# Aufgabe 14: Schiefe berechnen
# ============================================================================

# (a) height
skewness(data$height, na.rm = TRUE)  # Erwartet: -0.2

# (b) distance
skewness(data$distance, na.rm = TRUE)  # Erwartet: 1.7

# (c) cash
skewness(data$cash, na.rm = TRUE)  # Erwartet: 5.5

# (d) hair – getrennt nach Geschlecht
skewness(data$hair[data$gender == "Male"], na.rm = TRUE)    # Erwartet: 1.74
skewness(data$hair[data$gender == "Female"], na.rm = TRUE)  # Erwartet: 0.31




# ============================================================================
# Aufgabe 15: Analyse der Ebola-Symptomentwicklung
# ============================================================================
# Keine Berechnung erforderlich – visuelle Analyse einer Grafik

# (a) Mittlere Anzahl Tage: ca. 11
# (b) Modus: ca. 7 Tage (höchster Punkt der Kurve)
# (c) Rechtsschief: x-Achse gegen Null begrenzt, längere Wartezeiten möglich
# (d) Gesamtzahl der Fälle = Fläche unter der Kurve




# ============================================================================
# Aufgabe 16: Streudiagramme, Regressionsgerade und Korrelation
# ============================================================================

# (a) height und foot
plot(data$height, data$foot,
     main = "Scatterplot: Height vs. Foot",
     xlab = "Height", ylab = "Foot")
lm_a <- lm(foot ~ height, data = data)
abline(lm_a, col = "red")
cor(data$height, data$foot, use = "complete.obs")  # Erwartet: r ~ 0.28

# (b) hair und foot
plot(data$hair, data$foot,
     main = "Scatterplot: Hair vs. Foot",
     xlab = "Hair", ylab = "Foot")
lm_b <- lm(foot ~ hair, data = data)
abline(lm_b, col = "red")
cor(data$hair, data$foot, use = "complete.obs")  # Erwartet: r ~ -0.19

# (c) distance und siblings
plot(data$distance, data$siblings,
     main = "Scatterplot: Distance vs. Siblings",
     xlab = "Distance", ylab = "Siblings")
lm_c <- lm(siblings ~ distance, data = data)
abline(lm_c, col = "red")
cor(data$distance, data$siblings, use = "complete.obs")  # Erwartet: r ~ -0.07




# ============================================================================
# Aufgabe 17: Zusammenhang zwischen Höhe und Haar – Geschlechtervergleich
# ============================================================================

# (a) Gesamtkorrelation
cor(data$height, data$hair, use = "complete.obs")  # Erwartet: -0.62

# (b) Korrelation nur für Frauen
cor(data$height[data$gender == "Female"],
    data$hair[data$gender == "Female"], use = "complete.obs")  # Erwartet: 0.01

# (c) Korrelation nur für Männer
cor(data$height[data$gender == "Male"],
    data$hair[data$gender == "Male"], use = "complete.obs")  # Erwartet: 0.12

# Simpson's Paradoxon: Gesamtkorrelation ist negativ,
# aber innerhalb jeder Geschlechtsgruppe nahe null oder leicht positiv.




# ============================================================================
# Aufgabe 18: Kovarianz bei identischen Datensätzen
# ============================================================================
# Keine Berechnung erforderlich

# Cov(x, x) = Var(x)
# Die Kovarianz eines Datensatzes mit sich selbst ist die Varianz.




# ============================================================================
# Aufgabe 19: Schätzung der Korrelation aus Streudiagrammen
# ============================================================================
# Keine Berechnung erforderlich – visuelle Schätzung

# (a) r ~ 0.9    (b) r ~ -0.6   (c) r ~ 0.3
# (d) r ~ 0      (e) r ~ 0.2    (f) r ~ 0.5
# (g) r ~ -0.3   (h) r ~ -0.8   (i) r ~ 0




# ============================================================================
# Aufgabe 20: Vergleich von Streudiagrammen und Stichprobenumfang
# ============================================================================
# Keine Berechnung erforderlich

# Alle vier Streudiagramme haben r = 0.7.
# Die optischen Unterschiede entstehen durch variierenden Stichprobenumfang.




# ============================================================================
# Aufgabe 21: Schätzung der Korrelation bei nicht-linearem Zusammenhang
# ============================================================================
# Keine Berechnung erforderlich

# r ~ -0.17 (schwach, da quadratischer/nicht-linearer Zusammenhang,
# den der lineare Korrelationskoeffizient nicht erfasst)




# ============================================================================
# Aufgabe 22: Analyse der Aktienmärkte 2008
# ============================================================================

data_stock <- read_excel("data/WDDA_03.xlsx", sheet = "Stock_2008")

# (a) Mittelwert und Median
mean(data_stock$Fall, na.rm = TRUE)
median(data_stock$Fall, na.rm = TRUE)

# (b) Q1 und Q3
quantile(data_stock$Fall, probs = c(0.25, 0.75), na.rm = TRUE)

# (c) Boxplot
boxplot(data_stock$Fall,
        main = "Boxplot: Stock 2008",
        ylab = "Prozentuale Änderung")
# Keine Ausreisser

# (d) Perzentil für Belgien
belgium_value <- data_stock$Fall[data_stock$Country == "Belgium"]
mean(data_stock$Fall < belgium_value, na.rm = TRUE) * 100  # Erwartet: 71. Perzentil




# ============================================================================
# Aufgabe 23: Korrelation der Aktienindizes
# ============================================================================

data_dax <- read_excel("data/WDDA_03.xlsx", sheet = "DAX_CAC")

cor(data_dax$DAX, data_dax$CAC, use = "complete.obs")  # Erwartet: r ~ 0.923
# Sehr starker positiver linearer Zusammenhang




# ============================================================================
# Aufgabe 24: Zusammenhang zwischen Factual Reporting und Bias
# ============================================================================
# Keine Berechnung erforderlich

# Extremer Bias (in beide Richtungen) geht mit niedrigerem
# Niveau sachlicher Berichterstattung einher.
# -> Negativer Zusammenhang zwischen |Bias| und Factual Reporting.




# ============================================================================
# Aufgabe 25: Analyse der ideologischen Verteilungen
# ============================================================================
# Keine Berechnung erforderlich

# (a) Demokraten: Mittelwert bleibt relativ konstant, Streuung verringert sich
# (b) Republikaner: Mittelwert driftet nach rechts, Variation nimmt zu
# (c) Republikaner haben extremere Positionen bezogen
# (d) Auseinanderdriften der Mittelwerte und abnehmende Überlappung
#     zeigen zunehmende Polarisierung
# (e) Negative Assoziation zwischen den Standardabweichungen beider Parteien
