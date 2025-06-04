##############################################################
# WDDA Lecture 08 – Inferenz in Regressionsmodellen 
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
quantile(boot.diff$result, c(0.025, 0.975))

# 3.2 Lineares Modell für Saldo ~ Geschlecht
md.BG <- lm(Balance ~ Gender)
confint(md.BG)






# 4. Zweiewertige Prädiktoren (Dummy-Variablen)

# Dummy-Variable für Gender: 1 = Female, 0 = Male
FM10 <- ifelse(Gender == "Female", 1, 0)

# Regressionsmodell mit Dummy-Variable
md.BGdummy <- lm(Balance ~ FM10)








# 5. Qualitative Prädiktoren mit 3 oder mehr Ausprägungen

# Regressionsmodell für Balance ~ Ethnicity (3 Kategorien: 
# "African American" (Baseline), "Asian", "Caucasian")
md.BE <- lm(Balance ~ Ethnicity)






# 6. Balance aus Einkommen und Studentenstatus (Haupt- und Nebeneffekte)

# Einfaches Modell mit Income und Student (Dummy: "Yes"/"No")
md.BIS <- lm(Balance ~ Income + Student)





# 7. Balance aus Einkommen und Studentenstatus mit Interaktion

# Modell erweitert um Interaktion Income:Student
md.BIS2 <- lm(Balance ~ Income + Student + Income:Student)

