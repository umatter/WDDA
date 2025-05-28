##############################################################
# WDDA Lecture 07 – Inferenz in Regressionsmodellen 
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
Advertising <- read_excel("data/WDDA_07.xlsx", sheet = "Advertising")


##############################################################
# Teil 1: Bootstrap & Konfidenzintervalle
##############################################################

# Einfaches Regressionsmodell (TV)
md1 <- lm(sales ~ TV, data = Advertising)
summary(md1)
confint(md1)  # klassisches Konfidenzintervall

# Bootstrap-Simulation für Koeffizienten
set.seed(123)
simcoef <- do(5000) * coef(lm(sales ~ TV, data = resample(Advertising)))
CI_intercept <- quantile(simcoef$Intercept, c(0.025, 0.975))
CI_tv <- quantile(simcoef$TV, c(0.025, 0.975))
cat("Bootstrap 95%-CI für Intercept:", round(CI_intercept, 3), "\n")
cat("Bootstrap 95%-CI für Steigung (TV):", round(CI_tv, 3), "\n\n")





# Multiple Regression (TV + radio)
md2 <- lm(sales ~ TV + radio, data = Advertising)
summary(md2)
confint(md2)

# Bootstrap für multiple Regression
set.seed(456)
simcoef_multi <- do(5000) * coef(lm(sales ~ TV + radio, data = resample(Advertising)))
CI_tv_multi <- quantile(simcoef_multi$TV, c(0.025, 0.975))
CI_radio_multi <- quantile(simcoef_multi$radio, c(0.025, 0.975))
cat("95%-CI für TV (multi):", round(CI_tv_multi, 3), "\n")
cat("95%-CI für Radio (multi):", round(CI_radio_multi, 3), "\n\n")





# Inferenz & Signifikanztests

# t-Tests für Regressionskoeffizienten
cat("t-Werte und p-Werte für md2:\n")
print(summary(md2)$coefficients)

# Interpretation:
# Prüft H0: β = 0 gegen H1: β ≠ 0
# → p < 0.05 ⇒ signifikant

# F-Statistik des Gesamtmodells
f_stat <- summary(md2)$fstatistic
f_value <- f_stat["value"]
df1 <- f_stat["numdf"]
df2 <- f_stat["dendf"]
cat("\nF-Statistik:", f_value, " (df1 =", df1, ", df2 =", df2, ")\n")

# Modellvergleich mit Zusatzprädiktor (Newspaper)
md3 <- lm(sales ~ TV + radio + newspaper, data = Advertising)
anova(md2, md3)  # Vergleich mittels F-Test

# Prognose: Punktschätzung & Intervalle
neue_werte <- data.frame(TV = 230.1, radio = 37.8)
pred <- predict(md2, newdata = neue_werte, interval = "confidence")  # Konfidenzintervall
pred2 <- predict(md2, newdata = neue_werte, interval = "prediction") # Prognoseintervall
cat("\nKonfidenzintervall für Erwartungswert (mean sales):\n")
print(pred)
cat("\nPrognoseintervall für Einzelbeobachtung:\n")
print(pred2)

# Visualisierung: Konfidenz- und Prognoseintervall
ggplot(Advertising, aes(x = TV, y = sales)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE, level = 0.95, color = "blue", fill = "lightblue") +
  labs(title = "Regressionslinie mit 95%-Konfidenzband (TV ~ sales)")


