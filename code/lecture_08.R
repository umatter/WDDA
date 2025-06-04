##############################################################
# WDDA Lecture 08 – Nichtlineare Zusammenhänge
# Themen:
# - Konfidenzintervalle (CI) und Bootstrap
# - Inferenz in einfacher und multipler Regression
# - Signifikanztests (p-Werte), t-Tests, F-Statistik
# - Prognose mit CI und PI
##############################################################

# Pakete laden
library(mosaic)    # für do(), resample()
library(ggplot2)   # für Visualisierungen
library(readxl)    # zum Einlesen von Excel-Dateien


# Daten laden
Advertising <- read_excel("data/WDDA_08.xlsx", sheet = "Advertising")
attach(Advertising)  # Variablen direkt verfügbar machen


# 1. Modelle zur erklärten Variation

# Einfache lineare Regression
md1 <- lm(sales ~ TV)

# Quadratisches Modell (Polynom 2. Grades)
md2 <- lm(sales ~ poly(TV, degree = 2, raw = TRUE))

# Modell mit Wurzeltransformation
md3 <- lm(sales ~ sqrt(TV))

# Modell mit Log-Transformation der erklärenden Variable
md4 <- lm(sales ~ log(TV))

# Modell mit Log-Transformation beider Variablen
md5 <- lm(log(sales) ~ log(TV))

# Modell mit Log-Transformation nur der Response
md6 <- lm(log(sales) ~ TV)

# Ausgabe der R²-Werte (Beispiel: Übersicht über erklärten Anteil)
summary(md1)$r.squared   # linear
summary(md2)$r.squared   # quadratisch
summary(md3)$r.squared   # Wurzel
summary(md4)$r.squared   # log(x)
summary(md5)$r.squared   # log-log
summary(md6)$r.squared   # log(y) ~ x

# Detaillierte Analyse des besten Modells
cat("=== Vergleich der Modellgüte ===\n")
cat("Lineares Modell R²:", round(summary(md1)$r.squared, 4), "\n")
cat("Quadratisches Modell R²:", round(summary(md2)$r.squared, 4), "\n")
cat("Wurzel-Modell R²:", round(summary(md3)$r.squared, 4), "\n")
cat("Log(x)-Modell R²:", round(summary(md4)$r.squared, 4), "\n")
cat("Log-Log-Modell R²:", round(summary(md5)$r.squared, 4), "\n")
cat("Log(y)-Modell R²:", round(summary(md6)$r.squared, 4), "\n")

# Detaillierte Ausgabe für das lineare Modell
cat("\n=== Lineares Modell (md1): sales ~ TV ===\n")
summary(md1)
# Interpretation: 
# - Intercept: Erwartete Sales bei TV = 0
# - TV-Koeffizient: Erwartete Änderung in Sales pro Einheit TV-Ausgaben
# - R²: Anteil der durch TV erklärten Varianz in Sales
# - p-Werte: Signifikanz der Koeffizienten (< 0.05 = signifikant)

# Konfidenzintervalle für die Koeffizienten
cat("\n=== Konfidenzintervalle für Koeffizienten (md1) ===\n")
confint(md1)
# Interpretation: 95%-Konfidenzintervalle für die wahren Parameterwerte









# 2. Funktionen zur Darstellung der Modelle im Originaldaten-Raum

# Lineares Modell (md1)
f1 <- function(x) {
  coef(md1)[1] + coef(md1)[2] * x
}

# Wurzel-Modell (md3)
f3 <- function(x) {
  coef(md3)[1] + coef(md3)[2] * sqrt(x)
}

# Log-Log-Modell (md5) – Rücktransformation ins Originalmaß
f5 <- function(x) {
  exp(coef(md5)[1] + coef(md5)[2] * log(x))
}

# Visualisierung der verschiedenen Modelle
plot(TV, sales, main = "Vergleich verschiedener Regressionsmodelle", 
     xlab = "TV Advertising", ylab = "Sales", pch = 16, col = "gray60")

# Hinzufügen der Modellkurven
curve(f1, add = TRUE, col = "red", lwd = 2)      # Linear
curve(f3, add = TRUE, col = "blue", lwd = 2)     # Wurzel
curve(f5, add = TRUE, col = "green", lwd = 2)    # Log-Log

legend("bottomright", 
       legend = c("Linear", "Wurzel", "Log-Log"),
       col = c("red", "blue", "green"), 
       lwd = 2)






# 3. Kreditkarten-Saldo (ISLR::Credit)

# Package laden und Datensatz einlesen
library(ISLR)
data(Credit)

# 3.1 Vergleich der Salden nach Geschlecht mithilfe von Bootstrap

# Salden nach Geschlecht extrahieren
Balance.m <- Balance[Gender != "Female"]
Balance.f <- Balance[Gender == "Female"]

# Bootstrap-Differenz der Mittelwerte (10.000 Wiederholungen)
# Hinweis: Mit dem Paket 'mosaic' oder Basis-Funktionen
if (!require(mosaic)) {
  install.packages("mosaic")
  library(mosaic)
}
boot.diff <- do(10000) * (mean(resample(Balance.f)) - mean(resample(Balance.m)))

# 95%-Konfidenzintervall der Differenz
ci_diff <- quantile(boot.diff$result, c(0.025, 0.975))
cat("=== Bootstrap-Konfidenzintervall für Mittelwertsdifferenz ===\n")
print(ci_diff)
# Interpretation: 
# - Wenn das Intervall die 0 nicht enthält, ist der Unterschied signifikant
# - Positive Werte bedeuten höhere Salden bei Frauen
# - Negative Werte bedeuten höhere Salden bei Männern

# Deskriptive Statistiken
cat("\n=== Deskriptive Statistiken ===\n")
cat("Mittlerer Saldo Männer:", round(mean(Balance.m), 2), "\n")
cat("Mittlerer Saldo Frauen:", round(mean(Balance.f), 2), "\n")
cat("Differenz (F - M):", round(mean(Balance.f) - mean(Balance.m), 2), "\n")

# 3.2 Lineares Modell für Saldo ~ Geschlecht
md.BG <- lm(Balance ~ Gender)

cat("\n=== Lineares Modell: Balance ~ Gender ===\n")
summary(md.BG)
# Interpretation:
# - Intercept: Mittlerer Saldo für die Referenzkategorie (Female)
# - GenderMale: Unterschied zwischen Male und Female
# - p-Wert für GenderMale: Signifikanz des Geschlechtsunterschieds

cat("\n=== Konfidenzintervalle für Gender-Modell ===\n")
confint(md.BG)
# Vergleich mit Bootstrap-Ergebnis: Sollten ähnliche Werte liefern






# 4. Zweiewertige Prädiktoren (Dummy-Variablen)

# Dummy-Variable für Gender: 1 = Female, 0 = Male
FM10 <- ifelse(Gender == "Female", 1, 0)

# Regressionsmodell mit Dummy-Variable
md.BGdummy <- lm(Balance ~ FM10)

cat("\n=== Dummy-Variable Modell: Balance ~ FM10 ===\n")
summary(md.BGdummy)
# Interpretation:
# - Intercept: Mittlerer Saldo für FM10 = 0 (Männer)
# - FM10-Koeffizient: Unterschied zwischen Frauen (FM10=1) und Männern (FM10=0)
# - Dieses Modell ist äquivalent zu md.BG, nur anders kodiert

# Vergleich der Koeffizienten
cat("\n=== Vergleich: Faktor vs. Dummy-Kodierung ===\n")
cat("Gender-Modell Koeffizienten:\n")
print(coef(md.BG))
cat("Dummy-Modell Koeffizienten:\n")
print(coef(md.BGdummy))








# 5. Qualitative Prädiktoren mit 3 oder mehr Ausprägungen

# Regressionsmodell für Balance ~ Ethnicity (3 Kategorien: 
# "African American" (Baseline), "Asian", "Caucasian")
md.BE <- lm(Balance ~ Ethnicity)

cat("\n=== Modell mit kategorialer Variable: Balance ~ Ethnicity ===\n")
summary(md.BE)
# Interpretation:
# - Intercept: Mittlerer Saldo für African American (Referenzkategorie)
# - EthnicityAsian: Unterschied zwischen Asian und African American
# - EthnicityCaucasian: Unterschied zwischen Caucasian und African American
# - F-Statistik: Gesamtsignifikanz des Ethnicity-Effekts

# Mittlere Salden nach Ethnicity
cat("\n=== Mittlere Salden nach Ethnicity ===\n")
aggregate(Balance, by = list(Ethnicity), FUN = mean)






# 6. Balance aus Einkommen und Studentenstatus (Haupt- und Nebeneffekte)

# Einfaches Modell mit Income und Student (Dummy: "Yes"/"No")
md.BIS <- lm(Balance ~ Income + Student)

cat("\n=== Multiples Regressionsmodell: Balance ~ Income + Student ===\n")
summary(md.BIS)
# Interpretation:
# - Intercept: Erwarteter Saldo bei Income = 0 und Student = "No"
# - Income: Erwartete Änderung in Balance pro Einheit Income (ceteris paribus)
# - StudentYes: Unterschied zwischen Studenten und Nicht-Studenten (ceteris paribus)
# - Adjusted R²: Anteil erklärter Varianz, adjustiert für Anzahl Prädiktoren

# Konfidenzintervalle
cat("\n=== Konfidenzintervalle für Koeffizienten ===\n")
confint(md.BIS)





# 7. Balance aus Einkommen und Studentenstatus mit Interaktion

# Modell erweitert um Interaktion Income:Student
md.BIS2 <- lm(Balance ~ Income + Student + Income:Student)

cat("\n=== Modell mit Interaktion: Balance ~ Income + Student + Income:Student ===\n")
summary(md.BIS2)
# Interpretation:
# - Income: Effekt von Income für Nicht-Studenten (Student = "No")
# - StudentYes: Unterschied im Intercept zwischen Studenten und Nicht-Studenten
# - Income:StudentYes: Unterschied im Income-Effekt zwischen Studenten und Nicht-Studenten
# - Interaktion bedeutet: Der Effekt von Income hängt vom Studentenstatus ab


# Separate Regressionsgeraden für Studenten und Nicht-Studenten
cat("\n=== Separate Effekte von Income ===\n")
cat("Income-Effekt für Nicht-Studenten:", coef(md.BIS2)["Income"], "\n")
cat("Income-Effekt für Studenten:", 
    coef(md.BIS2)["Income"] + coef(md.BIS2)["Income:StudentYes"], "\n")

# Visualisierung der Interaktion
plot(Income, Balance, col = ifelse(Student == "Yes", "red", "blue"), 
     pch = 16, main = "Interaktion zwischen Income und Student",
     xlab = "Income", ylab = "Balance")

# Regressionsgeraden hinzufügen
abline(a = coef(md.BIS2)[1], b = coef(md.BIS2)[2], col = "blue", lwd = 2)  # Nicht-Studenten
abline(a = coef(md.BIS2)[1] + coef(md.BIS2)[3], 
       b = coef(md.BIS2)[2] + coef(md.BIS2)[4], col = "red", lwd = 2)      # Studenten

legend("topleft", legend = c("Nicht-Studenten", "Studenten"), 
       col = c("blue", "red"), pch = 16, lwd = 2)

