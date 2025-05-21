##############################################################
# WDDA Lecture 06 – Multiple lineare Regression (komplett)
# Themen:
# - Multiple Regression mit zwei und drei Prädiktoren
# - Residuenanalyse und Modellgüte
# - Prognose und Fehlerbereich
# - Nichtlineare und polynomiale Regression
# - Modellvergleich: R², Adjustiertes R² und RSE
##############################################################

# Pakete laden
library(scatterplot3d)
library(rgl)
library(car)
library(readxl)

# Daten laden
data <- read_excel("data/WDDA_06.xlsx", sheet = "Advertising")

# variablen direkt anwählbar machen
attach(data)








##############################################################
# 1. Untersuchung der erklärenden Variablen
##############################################################

# Korrelationen
cor_tv <- cor(sales, TV)
cor_radio <- cor(sales, radio)
cat("Korrelation (TV vs. Sales):", round(cor_tv, 4), "\n")
cat("Korrelation (Radio vs. Sales):", round(cor_radio, 4), "\n\n")

# 3D-Visualisierung (TV, Radio, Sales)
scatterplot3d(x = TV, y = radio, z = sales, scale.y = 0.9, angle = 30,
              main = "3D Scatterplot: TV, Radio und Sales",
              xlab = "TV (in 1000 USD)", ylab = "Radio (in 1000 USD)", zlab = "Sales (in 1000 USD)")

# Dynamisches 3D-Scatterplot
scatter3d(x = TV, z = radio, y = sales, surface = FALSE)








##############################################################
# 2. Multiple lineare Regression (TV und Radio)
##############################################################

# Modell mit zwei Prädiktoren
md2 <- lm(sales ~ TV + radio)
summary(md2)




# Regressionsgleichung
B <- coef(md2)
cat("Regressionsgleichung:\n")
cat("sales ≈", round(B[1], 3), "+", round(B[2], 3), "* TV +", round(B[3], 3), "* radio\n\n")

# Vorhersage mit Fehlerbereich
RSE <- summary(md2)$sigma
tv_new <- 230.1
radio_new <- 37.8
predicted <- predict(md2, newdata = data.frame(TV = tv_new, radio = radio_new))
pred_interval <- predicted + c(-1, 1) * 2 * RSE
cat("Prognose für TV =", tv_new, "und Radio =", radio_new, ":", round(predicted, 2), "\n")
cat("95%-Prognoseintervall:", round(pred_interval[1], 2), "bis", round(pred_interval[2], 2), "\n\n")











##############################################################
# 3. Regressionsfläche (Plane of Best Fit)
##############################################################

# Visualisierung der Regressionsfläche
scatter3d(x = TV, z = radio, y = sales, fit = "linear", residuals = TRUE, grid = TRUE)








##############################################################
# 4. Modellgüte und Erklärungskraft
##############################################################

# Berechnung von TSS, RSS und R²
TSS <- sum((sales - mean(sales))^2)
RSS <- sum((sales - predict(md2))^2)
r_squared <- 1 - (RSS / TSS)

cat("Bestimmtheitsmass (R²):", round(r_squared, 4), "\n")
cat("TV und Radio erklären", round(r_squared * 100, 2), "% der Variation in Sales.\n\n")







##############################################################
# 5. Residuenanalyse
##############################################################

# Residuenplots
hist(resid(md2), main = "Histogramm der Residuen", xlab = "Residuen")
plot(resid(md2) ~ TV, main = "Residuen vs. TV", xlab = "TV", ylab = "Residuen")
abline(h = 0, col = "gray")
plot(resid(md2) ~ radio, main = "Residuen vs. Radio", xlab = "Radio", ylab = "Residuen")
abline(h = 0, col = "gray")

# Residuen vs. Vorhergesagte Werte
plot(resid(md2) ~ predict(md2), main = "Residuen vs. Vorhergesagte Werte", xlab = "Vorhersage", ylab = "Residuen")
abline(h = 0, col = "gray")

# Kalibrierungsplot
plot(sales ~ predict(md2), main = "Kalibrierungsplot: sales vs. Vorhersage", xlab = "Vorhersage", ylab = "Sales")
abline(0, 1, col = "blue")







##############################################################
# 6. Erweiterung: Multiple Regression mit drei Prädiktoren
##############################################################

# Modell mit TV, Radio und Newspaper
md3 <- lm(sales ~ TV + radio + newspaper)
summary(md3)

# Vergleich von R² und RSE
cat("Modellvergleich:\n")
cat("R² (TV + Radio):", round(summary(md2)$r.squared, 4), "\n")
cat("R² (TV + Radio + Newspaper):", round(summary(md3)$r.squared, 4), "\n")
cat("RSE (TV + Radio):", round(summary(md2)$sigma, 4), "\n")
cat("RSE (TV + Radio + Newspaper):", round(summary(md3)$sigma, 4), "\n\n")








##############################################################
# 7. Nichtlineare Modelle: Quadratische und polynomiale Regression
##############################################################

# Quadratische Regression
md.q2 <- lm(sales ~ TV + I(TV^2) + radio)
summary(md.q2)

# Polynomiale Regression (Grad 3)
md.q3 <- lm(sales ~ poly(TV, 3) + radio)
summary(md.q3)

# Modellvergleich: Adjustiertes R²
cat("Modellvergleich (nichtlinear):\n")
cat("R² (linear):", round(summary(md2)$adj.r.squared, 4), "\n")
cat("R² (quadratisch):", round(summary(md.q2)$adj.r.squared, 4), "\n")
cat("R² (kubisch):", round(summary(md.q3)$adj.r.squared, 4), "\n\n")
