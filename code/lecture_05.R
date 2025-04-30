##############################################################
# WDDA Lecture 05 - Einfache Lineare Regression
#
# 
##############################################################


# Pakete laden
library(readxl)

# Daten laden
data <- read_excel("data/WDDA_05.xlsx", sheet = "Advertising")

# variablen direkt anwählbar machen
attach(data)





##############################################################
# 1. Variation
##############################################################

# Basis-Visualisierung: Zielvariable
hist(sales, main = "Verteilung der Verkaufszahlen", xlab = "Sales (in 1000 USD)")
cat("Varianz von sales:", round(var(sales), 2), "\n\n")








##############################################################
# 2. Erklärende Variable
##############################################################

# Scatterplot: Zusammenhang zwischen TV und Verkaufszahlen
plot(sales ~ TV, main = "Sales vs. TV", xlab = "TV-Ausgaben", ylab = "Sales")








##############################################################
# 3. Kandidaten vergleichen!
# Welche Trendlinie "passt" besser?
##############################################################


# Zwei mögliche Linien (manuell definiert)
line1 <- function(x) { 7 + 0.04 * x }
line2 <- function(x) { 5 + 0.07 * x }
abline(a = 7, b = 0.04, col = "blue", lty = 2)
abline(a = 5, b = 0.07, col = "red", lty = 3)
legend("bottomright", legend = c("line1", "line2"), col = c("blue", "red"), lty = c(2, 3))








##############################################################
# 4. Abweichungen vom Modell: Quantifizierung
##############################################################


# Vergleich der Abweichungen
cat("Sum of Squared Errors:\n")
cat("line1:", sum((sales - line1(TV))^2), "\n")
cat("line2:", sum((sales - line2(TV))^2), "\n\n")






##############################################################
# 5. Best Fit: Schätzgerade
##############################################################


# Methode der kleinsten Quadrate (händisch)
b1 <- cor(sales, TV) * sd(sales) / sd(TV)
b0 <- mean(sales) - b1 * mean(TV)
lbf <- function(x) { b0 + b1 * x }

# Zeichne Schätzgerade
plot(sales ~ TV, main = "Beste Gerade (Least Squares)", xlab = "TV", ylab = "Sales")
curve(lbf(x), add = TRUE, col = "darkgreen", lwd = 2)

# Abweichung (RSS)
rss <- sum((sales - lbf(TV))^2)
cat("Minimale Abweichung (RSS) der Schätzgerade:", round(rss, 2), "\n\n")

# Regressionsmodell mit lm()
md1 <- lm(sales ~ TV)
abline(md1, col = "orange", lwd = 2, lty = 1)








##############################################################
# 6. Residuen
##############################################################



# 1. Residuum (Beobachtung: TV = 230.1, sales = 22.1)
tv_val <- 230.1
sales_obs <- 22.1
sales_hat <- predict(md1, newdata = data.frame(TV = tv_val))
resid1 <- sales_obs - sales_hat
cat("1. Residuum:", round(resid1, 2), "\n\n")







##############################################################
# 7. TSS und RSS
##############################################################



# Quadratsummen: TSS, RSS, ESS
TSS <- sum((sales - mean(sales))^2)
RSS <- sum((sales - lbf(TV))^2)
ESS <- sum((lbf(TV) - mean(lbf(TV)))^2)








##############################################################
# 8. Zerlegung der Variation
##############################################################


cat("TSS (Totale Variation):", round(TSS, 2), "\n")
cat("RSS (Residuen):", round(RSS, 2), "\n")
cat("ESS (Erklärte Variation):", round(ESS, 2), "\n")
cat("TSS = ESS + RSS:", round(TSS, 2), "=", round(ESS, 2), "+", round(RSS, 2), "\n\n")









##############################################################
# 9. Bestimmtheitsmass
##############################################################



# Bestimmtheitsmaß R²
r_squared <- (TSS - RSS) / TSS
r_squared_check <- cor(sales, TV)^2
cat("Bestimmtheitsmaß R² (aus Varianzanalyse):", round(r_squared, 4), "\n")
cat("Bestimmtheitsmaß R² (aus Korrelation):    ", round(r_squared_check, 4), "\n\n")










##############################################################
# 10. Erwartungen an Residuen
##############################################################


# Residuen-Diagnostik
hist(resid(md1), main = "Histogramm der Residuen", xlab = "Residuen")
plot(resid(md1) ~ TV, main = "Residuen vs. TV", xlab = "TV", ylab = "Residuen")
abline(h = 0, col = "darkgray", lwd = 2)

# Standardfehler der Regression (RSE)
n <- length(sales)
RSE_manual <- sqrt(RSS / (n - 2))
RSE_lm <- summary(md1)$sigma
cat("RSE (manuell):", round(RSE_manual, 3), "\n")
cat("RSE (aus lm()):", round(RSE_lm, 3), "\n\n")









##############################################################
# 11. Prognose
##############################################################





# Prognose + Prognoseintervall
tv_new <- 230.1
predicted <- predict(md1, newdata = data.frame(TV = tv_new))
cat("Punktschätzung bei TV =", tv_new, ":", round(predicted, 2), "\n")
cat("95%-Prognoseintervall ≈", round(predicted - 2 * RSE_lm, 2), "bis", round(predicted + 2 * RSE_lm, 2), "\n\n")

# Interpretation der Koeffizienten
cat("Interpretation:\n")
cat("- Achsenabschnitt:", round(coef(md1)[1], 2), "→ erwartete sales bei TV = 0\n")
cat("- Steigung:", round(coef(md1)[2], 2), "→ erwarteter Anstieg von sales bei +1000$ TV\n")
