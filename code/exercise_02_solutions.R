# WDDA FS 2026: Lösungen für Aufgabenserie 2
# Dieses Skript enthält die R-Code-Lösungen für die Aufgabenserie 2

# Pakete laden
library(readxl)

# Daten importieren
data <- read_excel("data/WDDA_02.xlsx", sheet = "BFH")




# ============================================================================
# Aufgabe 1: Häufigkeitsverteilung von transport
# ============================================================================

data$transport |> table()
# Erwartete Ergebnisse:
# Bicycle: 7, Bus: 35, Car: 22, Other: 2, Train: 149, Walk: 2




# ============================================================================
# Aufgabe 2: Balkendiagramme für gender, transport und maths
# ============================================================================

# (a) Balkendiagramm für gender
gender_freq <- data$gender |> table()
barplot(gender_freq,
        main = "Verteilung von Gender",
        col = "lightblue",
        ylab = "Häufigkeit")

# (b) Balkendiagramm für transport
transport_freq <- data$transport |> table()
barplot(transport_freq,
        main = "Verteilung von Transport",
        col = "lightgreen",
        ylab = "Häufigkeit")

# (c) Balkendiagramm für maths
maths_freq <- data$maths |> table()
barplot(maths_freq,
        main = "Verteilung von Maths",
        col = "lightcoral",
        ylab = "Häufigkeit")




# ============================================================================
# Aufgabe 3: Analyse der Diagrammdarstellung der Semester-Noten
# ============================================================================
# Keine Berechnung erforderlich
# (a) Das Diagramm ist schlecht, weil es eine für ordinale Daten ungeeignete
#     Darstellungsform verwendet (z.B. Linien- oder Punktdiagramm).
# (b) Besser: Balkendiagramm mit Noten auf der x-Achse und
#     Häufigkeit auf der y-Achse.




# ============================================================================
# Aufgabe 4: Kreisdiagramme für eye und eyetext
# ============================================================================

# Relative Häufigkeiten und Kreisdiagramm für eye
eye_rel <- data$eye |> table() |> prop.table()
pie(eye_rel, main = "Relative Verteilung von Eye")

# Relative Häufigkeiten und Kreisdiagramm für eyetext
eyetext_rel <- data$eyetext |> table() |> prop.table()
pie(eyetext_rel, main = "Relative Verteilung von Eyetext")




# ============================================================================
# Aufgabe 5: Problematische Darstellung bei Steve Jobs
# ============================================================================
# Keine Berechnung erforderlich
# Problem: Perspektivische Verzerrung im 3D-Kreisdiagramm lässt
# einige Segmente grösser/kleiner erscheinen als sie sind.
# Korrektur: Einfaches 2D-Kreisdiagramm oder Balkendiagramm verwenden.




# ============================================================================
# Aufgabe 6: Häufigkeitsverteilung von height in Bins
# ============================================================================

bins <- seq(155, 185, by = 5)
height_bins <- data$height |> cut(breaks = bins, right = TRUE)
height_freq <- table(height_bins)
print(height_freq)




# ============================================================================
# Aufgabe 7: Kumulative Häufigkeit für height
# ============================================================================

height_cum <- height_freq |> cumsum()
print(height_cum)




# ============================================================================
# Aufgabe 8: Histogramme für foot und reaction1
# ============================================================================

# Histogramm für foot
hist(as.numeric(data$foot),
     main = "Histogramm von Foot",
     xlab = "Foot",
     col = "lightblue")

# Histogramm für reaction1
hist(as.numeric(data$reaction1),
     main = "Histogramm von Reaction1",
     xlab = "Reaction1",
     col = "lightgreen")




# ============================================================================
# Aufgabe 9: Histogramm für height und Geschlechtervergleich
# ============================================================================

# (a) Gesamthistogramm
hist(data$height,
     main = "Histogramm von Height",
     xlab = "Height",
     col = "lightgrey")

# (b) Aufteilen nach Geschlecht und vergleichen
height_m <- data$height[data$gender == "Male"]
height_f <- data$height[data$gender == "Female"]

x_range <- range(data$height)
y_max <- max(hist(height_m, plot = FALSE)$counts,
             hist(height_f, plot = FALSE)$counts)

hist(height_m,
     main = "Histogramm von Height (Männer)",
     xlab = "Height",
     xlim = x_range, ylim = c(0, y_max),
     col = "lightblue")

hist(height_f,
     main = "Histogramm von Height (Frauen)",
     xlab = "Height",
     xlim = x_range, ylim = c(0, y_max),
     col = "lightpink")




# ============================================================================
# Aufgabe 10: Histogramme für hair und Geschlechtervergleich
# ============================================================================

# (a) Gesamthistogramm für hair
hair_numeric <- as.numeric(data$hair)
hist(hair_numeric,
     main = "Histogramm von Hair",
     xlab = "Hair",
     col = "lightgrey")

# (b) Aufteilen nach Geschlecht
hair_m <- as.numeric(data$hair[data$gender == "Male"])
hair_f <- as.numeric(data$hair[data$gender == "Female"])

x_range_hair <- range(c(hair_m, hair_f), na.rm = TRUE)
hist_m <- hist(hair_m, plot = FALSE)
hist_f <- hist(hair_f, plot = FALSE)
y_max_hair <- max(hist_m$counts, hist_f$counts)

hist(hair_m,
     main = "Histogramm von Hair (Männer)",
     xlab = "Hair",
     ylim = c(0, y_max_hair),
     col = "lightblue")

hist(hair_f,
     main = "Histogramm von Hair (Frauen)",
     xlab = "Hair",
     ylim = c(0, y_max_hair),
     col = "lightpink")




# ============================================================================
# Aufgabe 11: Histogramm für cash und Beurteilung der Schiefe
# ============================================================================

cash_numeric <- as.numeric(data$cash)
cash_numeric <- cash_numeric[!is.na(cash_numeric)]

hist(cash_numeric,
     main = "Histogramm von Cash",
     xlab = "Cash",
     col = "lightgrey",
     breaks = "Sturges")

# Die Verteilung ist rechtsschief: wenige hohe Ausreisser
# ziehen den rechten Schwanz der Verteilung nach aussen.




# ============================================================================
# Aufgabe 12: Analyse der Körpergrösse: Hoehe.m und Hoehe.f
# ============================================================================

Hoehe.m <- data$height[data$gender == "Male"]
Hoehe.f <- data$height[data$gender == "Female"]

# Kleinster Mann
min_m <- Hoehe.m |> min()

# Frauen, die grösser sind als der kleinste Mann
count_f <- (Hoehe.f > min_m) |> sum()
count_f  # Erwartet: 58




# ============================================================================
# Aufgabe 13: Fusslängenanalyse
# ============================================================================

foot.m <- data$foot[data$gender == "Male"]
foot.f <- data$foot[data$gender == "Female"]

# Hat der grösste Mann die grössten Füsse?
data$height[data$gender == "Male"] |> which.max()
data$foot[data$gender == "Male"] |> which.max()
# Vergleich: Indizes stimmen nicht überein -> Nein

# Wie bei den Frauen?
data$height[data$gender == "Female"] |> which.max()
data$foot[data$gender == "Female"] |> which.max()




# ============================================================================
# Aufgabe 14: Mindestgrösse für britische Polizei
# ============================================================================

# Männer >= 173cm, Frauen >= 163cm
suitable <- data |>
  subset((gender == "Male" & height >= 173) |
         (gender == "Female" & height >= 163))

nrow(suitable)  # Erwartet: 185




# ============================================================================
# Aufgabe 15: Geburtsmonate mit lubridate
# ============================================================================

library(lubridate)

months <- data$dob |> month()

# Personen im April geboren
count_april <- (months == 4) |> sum()
count_april  # Erwartet: 24




# ============================================================================
# Aufgabe 16: Kontingenztabelle für gender und eye
# ============================================================================

data |> with(table(gender, eye))




# ============================================================================
# Aufgabe 17: Streudiagramme
# ============================================================================

# (a) height vs. hair
plot(data$height, data$hair,
     main = "Scatterplot: Height vs. Hair",
     xlab = "Height", ylab = "Hair")

# (b) height vs. foot
plot(data$height, data$foot,
     main = "Scatterplot: Height vs. Foot",
     xlab = "Height", ylab = "Foot")
# Positiver linearer Zusammenhang erwartet

# (c) height vs. reaction1
plot(data$height, data$reaction1,
     main = "Scatterplot: Height vs. Reaction1",
     xlab = "Height", ylab = "Reaction1")
# Kein klarer Zusammenhang erwartet




# ============================================================================
# Aufgabe 18: Analyse der Golfspieler-Umfrage
# ============================================================================

# Daten für Männer (Zeilen: Handicap <15, >=15; Spalten: Zu schnell, Ok)
golfer_maennlich <- matrix(c(10, 40, 25, 25), nrow = 2, byrow = TRUE)
colnames(golfer_maennlich) <- c("Zu schnell", "Ok")
rownames(golfer_maennlich) <- c("Handicap < 15", "Handicap >= 15")

# Daten für Frauen
golfer_weiblich <- matrix(c(1, 9, 39, 51), nrow = 2, byrow = TRUE)
colnames(golfer_weiblich) <- c("Zu schnell", "Ok")
rownames(golfer_weiblich) <- c("Handicap < 15", "Handicap >= 15")

# (a) Kombinierte Kontingenztabelle
total_m <- colSums(golfer_maennlich)  # Männer total: 35 Zu schnell, 65 Ok
total_f <- colSums(golfer_weiblich)   # Frauen total: 40 Zu schnell, 60 Ok

gesamt <- rbind(Männlich = total_m, Weiblich = total_f)
print(gesamt)

# Prozentsätze
round(gesamt / rowSums(gesamt) * 100, 1)
# Frauen: 40% "Zu schnell", Männer: 35% "Zu schnell"

# (b) Niedriges Handicap (< 15)
# Männer: 10/50 = 20% "Zu schnell"
# Frauen: 1/10 = 10% "Zu schnell"
# -> Männer haben höheren Beschwerdeanteil

# (c) Höheres Handicap (>= 15)
# Männer: 25/50 = 50% "Zu schnell"
# Frauen: 39/90 = 43.3% "Zu schnell"
# -> Männer haben höheren Beschwerdeanteil

# (d) Simpson-Paradoxon: Aggregiert beschweren sich Frauen häufiger (40% vs. 35%),
# aber in beiden Handicap-Gruppen einzeln beschweren sich Männer häufiger.
# Der Grund: Die Handicap-Verteilung ist unterschiedlich (Frauen haben mehr
# Spielerinnen mit hohem Handicap, wo generell mehr Beschwerden auftreten).
