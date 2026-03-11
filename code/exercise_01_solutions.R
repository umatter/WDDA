# WDDA FS 2026: Lösungen für Aufgabenserie 1
# Dieses Skript enthält die R-Code-Lösungen für die Aufgabenserie 1


# ============================================================================
# Aufgabe 1: Variablenklassifikation
# ============================================================================
# Keine Berechnung erforderlich

# (a) Anzahl der wöchentlich von einer Fussballmannschaft erzielten Tore
#     -> metrisch, diskret

# (b) Körpergrössen der Spieler eines Footballteams
#     -> metrisch, stetig

# (c) Die beliebtesten Radiosender
#     -> nominal, diskret

# (d) Die Anzahl der Kinder in einer japanischen Familie
#     -> metrisch, diskret

# (e) Der Dienstgrad eines Soldaten
#     -> ordinal, diskret

# (f) Die Anzahl der Brote, die eine Familie pro Woche kauft
#     -> metrisch, diskret

# (g) Die Art der Haustiere, welche die Schüler einer 8. Klasse besitzen
#     -> nominal, diskret

# (h) Die Anzahl der Blätter an Bäumen
#     -> metrisch, diskret

# (i) Die Anzahl der Sonnenstunden an einem Tag
#     -> metrisch, stetig

# (j) Die Anzahl der Menschen, die jedes Jahr in den USA an Krebs sterben
#     -> metrisch, diskret

# (k) Die Herkunftsländer der Einwanderer
#     -> nominal, diskret

# (l) Die Farben der Autos
#     -> nominal, diskret

# (m) Das Geschlecht von Schulleitern
#     -> nominal, diskret

# (n) Die Zeit, die mit Hausaufgaben verbracht wird
#     -> metrisch, stetig

# (o) Die Kategorien von Pokerhänden
#     -> ordinal, diskret

# (p) Der Betrag, der in Dollar pro Woche für Lebensmittel ausgegeben wird
#     -> metrisch, stetig

# (q) Die in einer Klassenarbeit erzielten Noten
#     -> ordinal, diskret

# (r) Die Anzahl der im Schulbistro verkauften Artikel
#     -> metrisch, diskret

# (s) Die Anzahl der Streichhölzer in einer Schachtel
#     -> metrisch, diskret

# (t) Die Endpositionen der Athleten in einem Rennen
#     -> ordinal, diskret

# (u) Die Endzeiten der Athleten eines Rennens
#     -> metrisch, stetig

# (v) Die Gründe, warum Menschen Taxis benutzen
#     -> nominal, diskret

# (w) Die Sportarten, die von Schülern an Gymnasien gespielt werden
#     -> nominal, diskret

# (x) Die Verbraucherpräferenz zwischen drei verschiedenen Produkten
#     -> nominal, diskret
#     (Nebenbemerkung: Aus mikroökonomischer Sicht könnte man argumentieren,
#      dass Konsumenten Produkte in eine ordinale Rangfolge bringen können.)

# (y) Die Pulsraten einer Gruppe von Sportlern in Ruhe
#     -> metrisch, stetig




# ============================================================================
# Aufgabe 2: Bestimmung von Variablenwerten
# ============================================================================
# Keine Berechnung erforderlich

# (a) Politisches Spektrum: Umfrage mit Likert-Skala oder Selbstidentifikation
# (b) Blutdruck: Messung mit Sphygmomanometer (metrisch, stetig)
# (c) Armutsgrenze: Absoluter oder relativer Ansatz (metrisch, stetig)
# (d) Ausdauerleistung: Zeit-bis-zur-Erschöpfung oder VO2-max-Test
# (e) Anzahl Lügen pro Tag: Selbstberichterstattung oder Beobachtung (metrisch, diskret)




# ============================================================================
# Aufgabe 3: Grafikanalyse (MSNBC vs. Fox News)
# ============================================================================
# Keine Berechnung erforderlich

# (a) Zwei Variablen: Faktische Berichterstattung und Politische Voreingenommenheit
# (b) Werte könnten durch Inhaltsanalyse, Expertenpanel, Publikumsbefragung ermittelt werden
# (c) Beide Variablen sind ordinal und diskret




# ============================================================================
# Aufgaben 4-7: Arbeiten mit dem BFH-Datensatz (konzeptionell)
# ============================================================================
# Hinweis: Diese Aufgaben sind konzeptionell. Die Variablen stammen
# aus dem BFH-Datensatz (WDDA_02.xlsx, Blatt "BFH").

# --- Aufgabe 4: sum(cash) vs sum(gender) ---
# sum(cash) funktioniert: cash ist metrisch, ergibt Gesamtbetrag
# sum(gender) erzeugt Fehler: gender ist nominal (nicht numerisch)

# --- Aufgabe 5: height/100 ---
# Konvertiert Körpergrösse von Zentimetern in Meter
# z.B. 175 cm -> 1.75 m

# --- Aufgabe 6: reaction1 - reaction2 ---
# Berechnet die Differenz der Reaktionszeiten
# Positiv = Verbesserung (zweiter Versuch schneller)
# Negativ = Verschlechterung

# --- Aufgabe 7: siblings * present ---
# Multipliziert Anzahl Geschwister mit Geschenkbetrag pro Geschwister
# Ergibt Gesamtausgaben für Geschenke pro Person
# sum(siblings * present) = Gesamtausgaben über alle Personen




# ============================================================================
# Aufgabe 8: Ausschreiben von Summen
# ============================================================================

# (a) sum_{r=1}^{4} r^3
# = 1^3 + 2^3 + 3^3 + 4^3
r <- 1:4
sum(r^3)  # = 100

# (b) sum_{r=1}^{6} (2r + 1)
# = 3 + 5 + 7 + 9 + 11 + 13
r <- 1:6
sum(2 * r + 1)  # = 48

# (c) sum_{n=1}^{5} 3^(2n)
# = 3^2 + 3^4 + 3^6 + 3^8 + 3^10
n <- 1:5
sum(3^(2 * n))  # = 66429

# (d) sum_{n=1}^{7} 4
# = 4 + 4 + 4 + 4 + 4 + 4 + 4
7 * 4  # = 28




# ============================================================================
# Aufgabe 9: Verwendung der Sigma-Notation für Summen
# ============================================================================
# Keine Berechnung erforderlich

# (a) 1^2 + 2^2 + ... + 7^2 = sum_{n=1}^{7} n^2
n <- 1:7
sum(n^2)  # = 140

# (b) 2^1 + 2^2 + ... + 2^10 = sum_{n=1}^{10} 2^n
n <- 1:10
sum(2^n)  # = 2046

# (c) 1/1 + 1/2 + ... + 1/77 = sum_{n=1}^{77} 1/n
n <- 1:77
sum(1 / n)  # harmonische Reihe

# (d) (1*3)/(2*4) + (2*4)/(3*5) + ... + (19*21)/(20*22)
#     = sum_{n=1}^{19} (n*(n+2)) / ((n+1)*(n+3))
n <- 1:19
sum((n * (n + 2)) / ((n + 1) * (n + 3)))




# ============================================================================
# Aufgabe 10: Auswerten von Summen
# ============================================================================

# (a) sum_{r=1}^{6} r
r <- 1:6
sum(r)  # = 21

# (b) sum_{r=1}^{6} 3r
sum(3 * r)  # = 63

# (c) 3 * sum_{r=1}^{6} r
3 * sum(r)  # = 63

# (b) und (c) ergeben dasselbe: eine Konstante kann aus der Summe gezogen werden




# ============================================================================
# Aufgabe 11: Ausschreiben allgemeiner Summen
# ============================================================================
# Keine Berechnung erforderlich

# (a) sum_{r=1}^{n} x_r = x_1 + x_2 + ... + x_n
# (b) sum_{r=1}^{n} x_r^2 = x_1^2 + x_2^2 + ... + x_n^2
# (c) sum_{r=1}^{n} x_r^r = x_1^1 + x_2^2 + ... + x_n^n




# ============================================================================
# Aufgabe 12: Richtig oder falsch
# ============================================================================
# Keine Berechnung erforderlich

# (a) sum(x_r) + sum(y_r) = sum(x_r + y_r)
#     -> Richtig (Addition ist kommutativ und assoziativ)

# (b) sum(x_r) * sum(y_r) = sum(x_r * y_r)
#     -> Falsch (Gegenbeispiel: (x1+x2)*(y1+y2) != x1*y1 + x2*y2)

# (c) sum(c * x_r) = c * sum(x_r)
#     -> Richtig (Konstante kann aus der Summe gezogen werden)




# ============================================================================
# Aufgabe 13: Ausschreiben von sum_{m=1}^{4} (-1)^m * x
# ============================================================================

# = (-1)^1*x + (-1)^2*x + (-1)^3*x + (-1)^4*x
# = -x + x - x + x
# = 0




# ============================================================================
# Aufgabe 14: Finden von sum_{r=1}^{7} (x_r - 2)^2
# ============================================================================
# Gegeben: sum(x_r^2) = 100, sum(x_r) = 10

# Ausmultiplizieren:
# sum((x_r - 2)^2) = sum(x_r^2 - 4*x_r + 4)
#                   = sum(x_r^2) - 4*sum(x_r) + 7*4
#                   = 100 - 4*10 + 28
#                   = 88

sum_xr2 <- 100
sum_xr <- 10
n <- 7
ergebnis <- sum_xr2 - 4 * sum_xr + n * 4
ergebnis  # = 88




# ============================================================================
# Aufgabe 15: Ausschreiben statistischer Notationen
# ============================================================================
# Keine Berechnung erforderlich

# (a) (1/N) * sum_{i=1}^{N} x_i
#     = Arithmetisches Mittel: (x_1 + x_2 + ... + x_N) / N

# (b) sum_{r=1}^{n} (x_r - x_bar)^2
#     = Summe der quadrierten Abweichungen vom Mittelwert (Teil der Varianzberechnung)

# (c) sum_{i=1}^{n} w_i * x_i
#     = Gewichtete Summe: w_1*x_1 + w_2*x_2 + ... + w_n*x_n

# (d) sum_{i=1}^{n} P(E_i)
#     = Summe der Wahrscheinlichkeiten: P(E_1) + P(E_2) + ... + P(E_n)

# (e) sum_{i=1}^{3} sum_{j=1}^{2} P_ij
#     = Doppelsumme: P_11 + P_12 + P_21 + P_22 + P_31 + P_32

# (f) sum_{i=1}^{n} (x_i - x_bar)(y_i - y_bar)
#     = Summe der Kreuzprodukte der Abweichungen (Teil der Kovarianzberechnung)




# ============================================================================
# Aufgabe 16: Auswerten tabellenbasierter Summationen
# ============================================================================

# Tabelle:
#   1  2  3  4
#   5  6  7  8
#   9 10 11 12
#  13 14 15 16

A <- matrix(1:16, nrow = 4, byrow = TRUE)

# (a) sum_{n=1}^{4} a(n, 2) = Spalte 2: 2 + 6 + 10 + 14
sum(A[, 2])  # = 32

# (b) sum_{n=1}^{4} a(1, n) = Zeile 1: 1 + 2 + 3 + 4
sum(A[1, ])  # = 10

# (c) sum_{n=1}^{4} a(n, n) = Diagonale: 1 + 6 + 11 + 16
sum(diag(A))  # = 34

# (d) sum_{n=1}^{4} a(n,1) * a(n,3) = 1*3 + 5*7 + 9*11 + 13*15
sum(A[, 1] * A[, 3])  # = 332

# (e) sum_{n=1}^{4} a(n,1) * sum_{n=1}^{4} a(n,3)
#     = (1+5+9+13) * (3+7+11+15) = 28 * 36
sum(A[, 1]) * sum(A[, 3])  # = 1008

# (f) sum_{n=1}^{4} a(n,3) + sum_{m=1}^{4} a(4,m)
#     = (3+7+11+15) + (13+14+15+16) = 36 + 58
sum(A[, 3]) + sum(A[4, ])  # = 94

# (g) sum_{n=1}^{4} sum_{m=1}^{4} a(n,m) = Summe aller Elemente
sum(A)  # = 136

# (h) sum_{n=2}^{4} sum_{m=1}^{n-1} a(n,m)
#     n=2: a(2,1) = 5
#     n=3: a(3,1) + a(3,2) = 9 + 10 = 19
#     n=4: a(4,1) + a(4,2) + a(4,3) = 13 + 14 + 15 = 42
ergebnis_h <- 0
for (n in 2:4) {
  ergebnis_h <- ergebnis_h + sum(A[n, 1:(n - 1)])
}
ergebnis_h  # = 66
