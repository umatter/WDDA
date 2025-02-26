# R-Code Beispiele aus WDDA Vorlesung 02
# Deskriptive Statistik: tabellarische und grafische Darstellung
# Dieses Skript enthält Code-Beispiele zu:
# - Häufigkeitsverteilungen
# - Relativen Häufigkeiten
# - Balkendiagrammen und Kuchendiagrammen
# - Zusammenfassen quantitativer Daten (Bins, kumulierte Häufigkeiten, Histogramme)
# - Filterung von Datensätzen
# - Kreuztabellen
# - Recoding und Umgestalten eines Dataframes
# - Aggregation
# - Streudiagrammen und Trendlinien

# -----------------------------------------------------------------------------
# 0. Laden von Paketen und Import von Daten
# -----------------------------------------------------------------------------

# Laden der benötigten Pakete
library(readxl)

# Laden der Datensätze
# (Auto, Variable "Brand")
Brand <- read_excel("data/WDDA_02.xlsx", sheet = "Auto")

# (Audit, Variable "Time")
Time <- read_excel("data/WDDA_02.xlsx", sheet = "Audit")
# Convert Time to numeric vector
Time <- as.numeric(unlist(Time))

# (Restaurant)
Restaurant <- read_excel("data/WDDA_02.xlsx", sheet = "Restaurant")

# (Inventory, Variablen "shirt", "price")  
Inventory <- read_excel("data/WDDA_02.xlsx", sheet = "Inventory")

# (Stereo, Variablen "Week", "Commercials", "Sales")
Stereo <- read_excel("data/WDDA_02.xlsx", sheet = "Stereo")


# -----------------------------------------------------------------------------
# 1. Häufigkeitsverteilung
# Eine Häufigkeitsverteilung fasst die Daten tabellarisch zusammen, indem sie die Anzahl
# der Elemente in nicht-überlappenden Klassen angibt.
# Hier betrachten wir beispielsweise den Datensatz 'Auto' und die Variable 'Brand'.
# -----------------------------------------------------------------------------

# Eindeutige Werte der Variable 'Brand' ermitteln
unique_brands <- Brand |> unique() # unique_brands <- unique(Brand)

# Häufigkeit der Werte in 'Brand' zählen
freq <- Brand |> table()








# -----------------------------------------------------------------------------
# 2. Relative Häufigkeit
# Die relative Häufigkeit einer Kategorie entspricht dem Anteil der
# absoluten Häufigkeit an der Gesamthäufigkeit.
# -----------------------------------------------------------------------------

# Berechnung der relativen Häufigkeiten
relfreq <- freq / sum(freq)









# -----------------------------------------------------------------------------
# 3. Balkendiagramme
# Balkendiagramme visualisieren die absolute Häufigkeit von kategorialen Daten.
# Bei ordinalen Daten sollte die Reihenfolge der Kategorien beachtet werden.
# -----------------------------------------------------------------------------

# Erstellen eines Balkendiagramms der Häufigkeiten
barplot(freq,
        main = "Balkendiagramm der Häufigkeiten",
        col = "lightblue",
        xlab = "Kategorien",
        ylab = "Häufigkeit")

# -----------------------------------------------------------------------------
# 4. Kuchendiagramme (Kreisdiagramme)
# Kreisdiagramme visualisieren die relative Häufigkeit von nominalen Daten.
# -----------------------------------------------------------------------------

# Erstellen eines Kreisdiagramms der relativen Häufigkeiten
pie(freq,
    main = "Kuchendiagramm der relativen Häufigkeiten")













# -----------------------------------------------------------------------------
# 5. Zusammenfassen von quantitativen Daten
# Bei quantitativen Daten, bei denen viele Werte nur einmal vorkommen, ist eine
# einfache Häufigkeitstabelle wenig sinnvoll. Stattdessen werden Klassen (Bins) erstellt.
# -----------------------------------------------------------------------------

# Erstellen einer Häufigkeitstabelle für die Variable 'Time'
table(Time)

# Definieren von Klassen (Bins). Beispiel: Beginn bei 0, Schrittweite 5, obere Grenze abhängig von den Daten.
# Stellen Sie sicher, dass die Bins alle Werte abdecken
bins <- c(0, 14 + 5 * (0:5))  # Erweitert auf 0, 14, 19, 24, 29, 34, 39

# Zuweisen der Werte in 'Time' zu den entsprechenden Bins
Time_binned <- Time |> cut(bins)
table(Time_binned)











# -----------------------------------------------------------------------------
# 6. Kumulierte Häufigkeiten
# Die kumulierte Häufigkeit gibt an, wie viele Datenwerte kleiner oder gleich der oberen Grenze
# der jeweiligen Klasse sind.
# -----------------------------------------------------------------------------

# Gesamtsumme der Werte in 'Time' (nur als Beispiel, nicht immer sinnvoll)
sum(Time)

# Erstellen der kumulierten Häufigkeitstabelle aus den gruppierten Daten
cum_freq <- Time_binned |> 
  table() |> 
  cumsum()











# -----------------------------------------------------------------------------
# 7. Histogramme
# Histogramme stellen quantitative Daten grafisch dar.
# Mit dem Parameter 'breaks' kann die Anzahl der Klassen eingestellt werden.
# Achte darauf, das Signal (Muster) zu modellieren und nicht das Rauschen.
# -----------------------------------------------------------------------------

# Standard-Histogramm für 'Time'
hist(Time,
     main = "Histogramm von Time",
     xlab = "Time",
     col = "lightgreen")

# Histogramm mit festgelegter Anzahl von Klassen (breaks = 10)
hist(Time,
     breaks = 10,
     main = "Histogramm von Time (10 Klassen)",
     xlab = "Time",
     col = "lightgreen")










# -----------------------------------------------------------------------------
# 8. Schiefe
# Histogramme können Hinweise auf die Schiefe (Asymmetrie) der Verteilung geben.
# Eine positive Schiefe bedeutet, dass der rechte Schwanz länger ist, 
# eine negative Schiefe einen längeren linken Schwanz.
# -----------------------------------------------------------------------------

# Hinweis: Für die Berechnung der Schiefe kann z.B. das Paket 'e1071' genutzt werden.
# library(e1071)
# skewness_value <- skewness(Time)
# print(skewness_value)














# -----------------------------------------------------------------------------
# 9. Filter
# Filter ermöglichen die Auswahl einer Teilmenge eines Datensatzes anhand von Bedingungen.
# Hier betrachten wir den Datensatz 'Restaurant'.
# -----------------------------------------------------------------------------

# Annahme: Das Paket dplyr wird verwendet
library(dplyr)

# Auswahl der 'Price'-Spalte für Restaurants mit guter Qualität
good_price <- 
  Restaurant |> 
  filter(Quality == 'Good') |>
  select(Price)

print(good_price)

# Anzahl der Restaurants mit guter Qualität
num_good <- Restaurant |> filter(Quality == 'Good') |> nrow()
print(num_good)

# Anzahl der Restaurants mit Price <= 20
num_cheap <- Restaurant |> filter(Price <= 20) |> nrow()
print(num_cheap)

# Anzahl der Restaurants mit guter Qualität UND Price <= 20
num_good_and_cheap <- Restaurant |> filter(Quality == 'Good' & Price <= 20) |> nrow()
print(num_good_and_cheap)

# Anzahl der Restaurants mit guter Qualität ODER Price <= 20
num_good_or_cheap <- Restaurant |> filter(Quality == 'Good' | Price <= 20) |> nrow()
print(num_good_or_cheap)



















# -----------------------------------------------------------------------------
# 10. Kreuztabellen
# Kreuztabellen (Kontingenztafeln) fassen die Daten für zwei Variablen tabellarisch zusammen.
# -----------------------------------------------------------------------------

# Extrahieren der Quality und Price Variablen aus dem Restaurant Datensatz
Quality <- Restaurant$Quality
Price <- Restaurant$Price

# Erstellen einer Kreuztabelle zwischen Quality und Price
ct1 <- table(Quality, Price)
print(ct1)

# Erstellen von Preisbereichen (Bins) für die Variable Price
bins <- 10 * (0:5)
Price_ranges <- Price |> cut(bins)
# Erstellen einer Kreuztabelle mit den Preisbereichen
ct2 <- table(Quality, Price_ranges)
print(ct2)













# -----------------------------------------------------------------------------
# 11. Recoding
# Beim Recoding werden Variablen umkodiert. Hier wird im Datensatz 'Inventory'
# die Variable 'shirt' in drei Variablen (style, colour, size) aufgeteilt.
# Dafür wird die Funktion str_split_fixed() aus dem Paket stringr verwendet.
# -----------------------------------------------------------------------------

library(stringr)

# Aufteilen der 'shirt'-Variable in drei Teile
shirt_split <- Inventory |>
  pull(shirt) |>
  str_split_fixed(',', 3)


















# -----------------------------------------------------------------------------
# 12. Umgestalten eines Dataframes
# Hier wird ein neuer Dataframe 'Inventory2' durch das Recoding der 'shirt'-Variable erstellt,
# Spalten umbenannt und zusätzliche Spalten (Preis, Rabatt) hinzugefügt.
# -----------------------------------------------------------------------------

# Erstellen von Inventory2 durch Aufteilen der 'shirt'-Variable und Umwandeln in einen Dataframe
Inventory2 <- shirt_split |> 
  data.frame() |>
  setNames(c('style', 'colour', 'size'))

# Hinzufügen der Preise als neue Spalte
Inventory2$price <- Inventory |> pull(price)

# Berechnen eines 30%-Rabattes auf den Preis und Hinzufügen als neue Spalte 'discount'
Inventory2$discount <- Inventory2$price * (1 - 0.30)

# Überprüfe die Struktur des neuen Dataframes
str(Inventory2)

# -----------------------------------------------------------------------------
# 13. Aggregating
# Aggregating fasst Daten zusammen. Hier wird Inventory2 hinsichtlich der Variable 'colour' aggregiert.
# -----------------------------------------------------------------------------

agg_result <- Inventory2 |> 
  aggregate(list(Inventory2$colour), length)

















# -----------------------------------------------------------------------------
# 14. Streudiagramme
# Streudiagramme visualisieren die Beziehung zwischen zwei quantitativen Variablen.
# Hier betrachten wir den Datensatz 'Stereo' und die Variablen 'Sales' und 'Commercials'.
# -----------------------------------------------------------------------------

# Erstellen eines Streudiagramms
plot(Sales ~ Commercials,
     data = Stereo,
     main = "Streudiagramm: Sales vs Commercials",
     xlab = "Commercials",
     ylab = "Sales",
     pch = 19,
     col = "blue")

# Hinzufügen einer Trendlinie mittels linearer Regression
fit <- lm(Sales ~ Commercials, data = Stereo)
abline(fit, col = "red", lwd = 2)

# -----------------------------------------------------------------------------
# 15. Typen des Zusammenhangs
# Die Steigung der Trendlinie gibt einen Hinweis auf die Art des Zusammenhangs zwischen den Variablen:
# - Positive Steigung: positive Beziehung
# - Keine Steigung: kein Zusammenhang
# - Negative Steigung: negative Beziehung
# Dieser Abschnitt enthält keine weiteren Code-Beispiele.
# -----------------------------------------------------------------------------
