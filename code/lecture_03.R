# R-Code Beispiele aus WDDA Lecture 03
# Deskriptive Statistik – Numerische Masse
# Dieses Skript zeigt Beispiele für Lage-, Streuungs- und Zusammenhangsmaße.
# Hinweis: Die folgenden Beispiele gehen davon aus, dass die entsprechenden Variablen
# (z. B. Salary, Brand, Major, sales, adverts) bereits im Workspace vorhanden sind.

# ---------------------------------------------------------------
# 1. Arithmetischer Mittelwert
# Der arithmetische Mittelwert (Mittelwert) ist die Summe aller Datenwerte geteilt durch die Anzahl der Beobachtungen.
# Für Stichproben: mean = sum(Salary)/length(Salary)
# Für Populationen gibt es einen ähnlichen Ansatz.
# ---------------------------------------------------------------

# Beispiel: Berechnung des Mittelwerts für die Variable Salary
sum_Salary <- sum(Salary)
n_Salary <- length(Salary)
mittelwert_manual <- sum_Salary / n_Salary  # Manuelle Berechnung
mittelwert_builtin <- mean(Salary)         # Eingebaute Funktion

print(mittelwert_manual)
print(mittelwert_builtin)


# ---------------------------------------------------------------
# 2. Median
# Der Median teilt die geordneten Daten in zwei Hälften.
# Bei ungerader Anzahl ist der Median der mittlere Wert,
# bei gerader Anzahl das arithmetische Mittel der beiden mittleren Werte.
# ---------------------------------------------------------------

# Beispiel: Berechnung des Medians
median_salary <- median(Salary)
print(median_salary)


# ---------------------------------------------------------------
# 3. Modus
# Der Modus ist der am häufigsten vorkommende Wert.
# Für nominale Daten (z.B. Automarken) kann man die Funktion table() verwenden.
# Hinweis: R bietet keine eingebaute Funktion für den Modus.
# ---------------------------------------------------------------

# Beispiel: Modus für die Variable Brand
brand_table <- table(Brand)
print(brand_table)
# Den häufigsten Wert (Modus) ermitteln:
modus_brand <- names(which.max(brand_table))
print(modus_brand)


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

max_salary <- max(Salary)
min_salary <- min(Salary)
spannweite <- max_salary - min_salary
print(max_salary)
print(min_salary)
print(spannweite)


# ---------------------------------------------------------------
# 6. Quartile und Interquartilsabstand (IQR)
# Quartile teilen den geordneten Datensatz in vier gleiche Teile.
# IQR = Q3 - Q1 gibt den Bereich der mittleren 50% der Daten an.
# ---------------------------------------------------------------

Q1 <- quantile(Salary, 0.25)
Q3 <- quantile(Salary, 0.75)
IQR_salary <- Q3 - Q1
print(Q1)
print(Q3)
print(IQR_salary)


# ---------------------------------------------------------------
# 7. Perzentile
# Das n-te Perzentil trennt die unteren n% der Daten von den oberen (100 - n)%.
# Beispiel: Das 95. Perzentil.
# ---------------------------------------------------------------

perzentil95 <- quantile(Salary, 0.95)
print(perzentil95)


# ---------------------------------------------------------------
# 8. Boxplots
# Boxplots visualisieren die Verteilung der Daten über ihre Quartile.
# Sie können auch zum Vergleich zwischen Gruppen verwendet werden.
# ---------------------------------------------------------------

# Boxplot der Variable Salary
boxplot(Salary, main = "Boxplot von Salary", ylab = "Salary")

# Boxplot von Salary gruppiert nach Major (z. B. Studienfach)
boxplot(Salary ~ Major, main = "Boxplot von Salary nach Major", xlab = "Major", ylab = "Salary")


# ---------------------------------------------------------------
# 9. Varianz
# Die Varianz misst die durchschnittliche quadrierte Abweichung vom Mittelwert.
# Für Stichproben wird durch (n-1) geteilt.
# ---------------------------------------------------------------

# Manuelle Berechnung der Stichprobenvarianz:
var_manual <- sum((Salary - mean(Salary))^2) / (length(Salary) - 1)
var_builtin <- var(Salary)

print(var_manual)
print(var_builtin)


# ---------------------------------------------------------------
# 10. Standardabweichung
# Die Standardabweichung ist die Quadratwurzel der Varianz und gibt die durchschnittliche
# Abweichung in den Originaleinheiten an.
# ---------------------------------------------------------------

sd_manual <- sqrt(var(Salary))
sd_builtin <- sd(Salary)

print(sd_manual)
print(sd_builtin)


# ---------------------------------------------------------------
# 11. Empirische Regel (68-95-99,7-Regel)
# Beispiel: Berechnung des Intervalls [mean - sd, mean + sd]
# ---------------------------------------------------------------

untere_grenze <- mean(Salary) - sd(Salary)
obere_grenze <- mean(Salary) + sd(Salary)
print(untere_grenze)
print(obere_grenze)


# ---------------------------------------------------------------
# 12. Standardisierung (z-Werte)
# Standardisierte Werte geben an, wie viele Standardabweichungen ein Datenpunkt vom Mittelwert entfernt ist.
# ---------------------------------------------------------------

Salary_z <- (Salary - mean(Salary)) / sd(Salary)
# Mittelwert und Standardabweichung der z-Werte sollten ca. 0 bzw. 1 sein:
print(mean(Salary_z))
print(sd(Salary_z))


# ---------------------------------------------------------------
# 13. Schiefe
# Die Schiefe misst die Asymmetrie der Verteilung.
# Für eine Stichprobe kann sie wie folgt manuell berechnet werden:
# ---------------------------------------------------------------

n <- length(Salary_z)
schiefe <- n / ((n - 1) * (n - 2)) * sum(Salary_z^3)
print(schiefe)
# Alternativ kann auch das Paket e1071 verwendet werden:
# library(e1071)
# print(skewness(Salary))


# ---------------------------------------------------------------
# 14. Kovarianz
# Die Kovarianz misst den linearen Zusammenhang zwischen zwei Variablen.
# ---------------------------------------------------------------

# Beispiel: Kovarianz zwischen sales und adverts (Datensatz Advertising)
n_sales <- length(sales)
cov_manual <- 1 / (n_sales - 1) * sum((sales - mean(sales)) * (adverts - mean(adverts)))
cov_builtin <- cov(sales, adverts)

print(cov_manual)
print(cov_builtin)


# ---------------------------------------------------------------
# 15. Korrelationskoeffizient
# Der Korrelationskoeffizient (r) normiert die Kovarianz und liegt zwischen -1 und +1.
# ---------------------------------------------------------------

corr_manual <- cov(sales, adverts) / (sd(sales) * sd(adverts))
corr_builtin <- cor(sales, adverts)

print(corr_manual)
print(corr_builtin)

# Hinweis: Der Korrelationskoeffizient hat keine Einheit.
