# R-Code Beispiele aus WDDA Vorlesung 01

# -------------------------------------------------------------------
# 1. Import eines Datensatzes
# -------------------------------------------------------------------

# Lade das Paket readxl zum Importieren von Excel-Dateien
library(readxl)

# Importiere die Daten aus dem Blatt "Exchanges"
markets <- read_excel("WDDA_01.xlsx", sheet = "Exchanges")

# Prüfe die Struktur des importierten Dataframes
str(markets)












# -------------------------------------------------------------------
# 2. Navigation in Dataframes
# -------------------------------------------------------------------

# Zeige das gesamte Dataframe an
print(markets)

# Zeige die Spaltennamen des Dataframes an
print(names(markets))

# Klassische Subsetting-Beispiele:
print(markets$trades)    # Greife auf die Spalte 'trades' zu
markets[,"trades"]       # Alternativ: Greife auf die Spalte 'trades' zu
print(markets[3, ])      # Greife auf die dritte Zeile zu
print(markets[, 2])      # Greife auf die zweite Spalte zu
print(markets[3, 2])     # Greife auf das Element in der 3. Zeile und 2. Spalte zu

# Optional: Mit piping
print(markets |> pull(trades))         # Extrahiere die Spalte 'trades' als Vektor
print(markets |> slice(3))             # Greife auf die dritte Zeile zu
print(markets |> select(2))            # Wähle die zweite Spalte anhand ihrer Position aus
print(markets |> select(trades))       # Wähle die Spalte 'trades' anhand ihres Namens aus
print(markets |> slice(2) |> select(trades))  # Wähle zuerst die zweite Zeile, dann die Spalte 'trades'

# Zusätzlich: Zeige die ersten sechs Zeilen des Dataframes an
print(head(markets))











# -------------------------------------------------------------------
# 3. Verwendung von attach() und detach()
# -------------------------------------------------------------------

# Hänge das Dataframe an, sodass dessen Spalten direkt zugänglich sind
attach(markets)

# Jetzt kann auf 'trades' direkt zugegriffen werden, ohne den Dataframe-Namen zu verwenden
print(trades)

# Entferne das Dataframe aus dem Suchpfad, um Namenskonflikte zu vermeiden
detach(markets)

# Hinweis: Nach dem detach führt der Zugriff auf 'trades' ohne Dataframe-Namen zu einem Fehler.
# print(trades)  # Dies würde zu einem Fehler führen, da 'trades' nicht gefunden wird

# Alternative: Verwendung von with() für temporären Zugriff:
with(markets, print(summary(trades)))  # Fasst die Spalte 'trades' zusammen, ohne das Dataframe dauerhaft anzuhängen














# -------------------------------------------------------------------
# 4. Dimensionen vom Dataframe (Anzahl Spalten, Zeilen)
# -------------------------------------------------------------------

# Bei einem Dataframe gibt length() die Anzahl der Spalten zurück:
print(length(markets))

# Bei einer Liste oder einem Vektor gibt length() die Anzahl der Elemente (Beobachtungen) zurück:
# (Hier setzen wir voraus, dass 'trades' existiert, z.B. nachdem attach() genutzt wurde)
# Da 'trades' aktuell nicht verfügbar ist (nach detach), können wir auch:
trades_vector <- markets$trades
print(length(trades_vector))

# Um die Anzahl der Zeilen (Beobachtungen) des Dataframes zu erhalten, verwende nrow():
print(nrow(markets))

# Mit ncol() erhältst Du die Anzahl der Spalten:
print(ncol(markets))

# Dimensionen
dim(markets)


