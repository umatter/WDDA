# R-Code Beispiele aus WDDA Lecture 03
# Deskriptive Statistik – Numerische Masse
# Dieses Skript zeigt Beispiele für Lage-, Streuungs- und Zusammenhangsmaße.
# Hinweis: Die folgenden Beispiele gehen davon aus, dass die entsprechenden Variablen
# (z. B. Salary, Brand, Major, sales, adverts) bereits im Workspace vorhanden sind.


#----------------------------------------------------------------
# 0. Vorbereitung
# Laden von Paketen und Beispiel-Daten
#----------------------------------------------------------------

# Pakete laden
library(readxl)

# Daten importieren
Graduates <- read_excel("data/WDDA_03.xlsx", sheet = "Graduates")
Brand <- read_excel("data/WDDA_03.xlsx", sheet = "Auto")
Advertising <- read_excel("data/WDDA_03.xlsx", sheet = "Advertising")

# ---------------------------------------------------------------
# 1. Arithmetischer Mittelwert
# Der arithmetische Mittelwert (Mittelwert) ist die Summe aller Datenwerte geteilt durch die Anzahl der Beobachtungen.
# Für Stichproben: mean = sum(Salary)/length(Salary)
# Für Populationen gibt es einen ähnlichen Ansatz.
# ---------------------------------------------------------------

# Salary Variable aus dem Graduates Dataframe extrahieren
Salary <- Graduates$Salary

# Beispiel: Berechnung des Mittelwerts für die Variable Salary
sum_Salary <- Salary |> sum()
n_Salary <- Salary |> length()
mittelwert_manual <- sum_Salary / n_Salary  # Manuelle Berechnung
mittelwert_builtin <- Salary |> mean()      # Eingebaute Funktion


# ---------------------------------------------------------------
# 2. Median
# Der Median teilt die geordneten Daten in zwei Hälften.
# Bei ungerader Anzahl ist der Median der mittlere Wert,
# bei gerader Anzahl das arithmetische Mittel der beiden mittleren Werte.
# ---------------------------------------------------------------

# Beispiel: Berechnung des Medians
median_salary <- Salary |> median()


# ---------------------------------------------------------------
# 3. Modus
# Der Modus ist der am häufigsten vorkommende Wert.
# Für nominale Daten (z.B. Automarken) kann man die Funktion table() verwenden.
# Hinweis: R bietet keine eingebaute Funktion für den Modus.
# ---------------------------------------------------------------

# Beispiel: Modus für die Variable Brand
brand_table <- Brand |> table()
# Den häufigsten Wert (Modus) ermitteln:
modus_brand <- brand_table |> 
  which.max() |> 
  names()


# ---------------------------------------------------------------
# 4. Gewichteter Mittelwert
# Beim gewichteten Mittelwert wird jedem Datenwert ein Gewicht zugeordnet.
# ---------------------------------------------------------------

# Beispiel: Berechnung des gewichteten Mittelwerts
xvar <- c(3, 3.4, 2.8, 2.9, 3.25)
weight <- c(1200, 500, 2750, 1000, 800)
gewichteter_mittelwert <- sum(xvar * weight) / sum(weight)
print(gewichteter_mittelwert)


# ---------------------------------------------------------------
# 5. Spannweite
# Die Spannweite ist die Differenz zwischen dem größten und dem kleinsten Wert.
# ---------------------------------------------------------------

max_salary <- Salary |> max()
min_salary <- Salary |> min()
spannweite <- max_salary - min_salary


# ---------------------------------------------------------------
# 6. Quartile und Interquartilsabstand (IQR)
# Quartile teilen den geordneten Datensatz in vier gleiche Teile.
# IQR = Q3 - Q1 gibt den Bereich der mittleren 50% der Daten an.
# ---------------------------------------------------------------

Q1 <- Salary |> quantile(0.25)
Q3 <- Salary |> quantile(0.75)
IQR_salary <- Q3 - Q1


# ---------------------------------------------------------------
# 7. Perzentile
# Das n-te Perzentil trennt die unteren n% der Daten von den oberen (100 - n)%.
# Beispiel: Das 95. Perzentil.
# ---------------------------------------------------------------

perzentil95 <- Salary |> quantile(0.95)


# ---------------------------------------------------------------
# 8. Boxplots
# Boxplots visualisieren die Verteilung der Daten über ihre Quartile.
# Sie können auch zum Vergleich zwischen Gruppen verwendet werden.
# ---------------------------------------------------------------

# Boxplot der Variable Salary
boxplot(Salary, main = "Boxplot von Salary", ylab = "Salary")

# Boxplot von Salary gruppiert nach Major (z. B. Studienfach)
boxplot(Salary ~ Major,
        data = Graduates,
        main = "Boxplot von Salary nach Major",
        xlab = "Major", ylab = "Salary")


# ---------------------------------------------------------------
# 9. Varianz
# Die Varianz misst die durchschnittliche quadrierte Abweichung vom Mittelwert.
# Für Stichproben wird durch (n-1) geteilt.
# ---------------------------------------------------------------

# Manuelle Berechnung der Stichprobenvarianz:
var_manual <- Salary |> 
  (\(x) sum((x - mean(x))^2))() / (length(Salary) - 1)
var_builtin <- Salary |> var()


# ---------------------------------------------------------------
# 10. Standardabweichung
# Die Standardabweichung ist die Quadratwurzel der Varianz und gibt die durchschnittliche
# Abweichung in den Originaleinheiten an.
# ---------------------------------------------------------------

sd_manual <- Salary |> var() |> sqrt()
sd_builtin <- Salary |> sd()


# ---------------------------------------------------------------
# 11. Empirische Regel (68-95-99,7-Regel)
# Beispiel: Berechnung des Intervalls [mean - sd, mean + sd]
# ---------------------------------------------------------------

untere_grenze <- Salary |> mean() - (Salary |> sd())
obere_grenze <- Salary |> mean() + (Salary |> sd())


# ---------------------------------------------------------------
# 12. Standardisierung (z-Werte)
# Standardisierte Werte geben an, wie viele Standardabweichungen ein Datenpunkt vom Mittelwert entfernt ist.
# ---------------------------------------------------------------

Salary_z <- (Salary - (Salary |> mean())) / (Salary |> sd())


# ---------------------------------------------------------------
# 13. Schiefe
# Die Schiefe misst die Asymmetrie der Verteilung.
# Für eine Stichprobe kann sie wie folgt manuell berechnet werden:
# ---------------------------------------------------------------

n <- Salary_z |> length()
schiefe <- n / ((n - 1) * (n - 2)) * (Salary_z^3 |> sum())
# Alternativ kann auch das Paket e1071 verwendet werden:
# library(e1071)
# print(skewness(Salary))


# ---------------------------------------------------------------
# 14. Kovarianz
# Die Kovarianz misst den linearen Zusammenhang zwischen zwei Variablen.
# ---------------------------------------------------------------

# Extrahieren der Variablen sales und adverts aus dem Datensatz Advertising
sales <- Advertising$sales
adverts <- Advertising$adverts

# Beispiel: Kovarianz zwischen sales und adverts (Datensatz Advertising)
n_sales <- sales |> length()
cov_manual <- 1 / (n_sales - 1) * sum((sales - (sales |> mean())) * 
                                     (adverts - (adverts |> mean())))
cov_builtin <- cov(sales, adverts)


# ---------------------------------------------------------------
# 15. Korrelationskoeffizient
# Der Korrelationskoeffizient (r) normiert die Kovarianz und liegt zwischen -1 und +1.
# ---------------------------------------------------------------

corr_manual <- cov(sales, adverts) / ((sales |> sd()) * (adverts |> sd()))
corr_builtin <- cor(sales, adverts)

# Hinweis: Der Korrelationskoeffizient hat keine Einheit.
