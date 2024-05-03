#Hackathon Code
#Michael Mucciolo, Kale Wiley, Gibson Hurst, Cara Fredericks
#2024-04-24
#Temple University

#Getting necessary libraries and importing Excel sheet Into R

library(readxl)
library(dplyr)
library(tidyr)
library(ggplot2)


baseball_copy <- read_excel("baseball copy.xlsx")

# Create scatterplot of all pitches in dataset 
# (using makeshift strikezone to visualize where 
# each pitch has landed and whether it is in the strikezone)

set.seed(42)  
sampled_data <- baseball_copy[sample(nrow(baseball_copy), 2000), ]

lower_boundary <- 1.598
upper_boundary <- 3.379
left_boundary <- -((17/12)/2)
right_boundary <- ((17/12)/2)

call_colors <- c("ball" = "red", "called_strike" = "blue")

# Plotting pitch positions (makeshift strike zone)
plot(sampled_data$plate_x,
     sampled_data$plate_z,
     pch = 20,
     col = call_colors[sampled_data$description],
     xlim = c(-4, 4),
     ylim = c(-1, 6),
     xlab = "Horizontal Position",
     ylab = "Vertical Position",
     main = "Pitch Positions of Umpire Called Pitches")

abline(v = c(left_boundary, right_boundary), col = "black", lwd = 2)
abline(h = c(lower_boundary, upper_boundary), col = "black", lwd = 2)

legend_colors <- c("red", "blue")
legend_labels <- c("Called Ball", "Called Strike")

legend("topright",
       legend = legend_labels,
       fill = legend_colors)


# Analyze how accurate umpires are in calling pitches strikes or balls 
# (purely based on the zone the ball is in when the pitch reaches the plate)

# Defining strike zone
strike_zones <- 1:9
ball_zones <- 11:14

baseball_copy <- baseball_copy %>%
  mutate(predicted_call = case_when(
    zone %in% strike_zones ~ "strike",
    zone %in% ball_zones ~ "ball",
    TRUE ~ NA_character_
  ))

conf_matrix <- table(baseball_copy$description, baseball_copy$predicted_call)

# Calculating and printing accuracy
accuracy <- sum(diag(conf_matrix)) / sum(conf_matrix)

print(conf_matrix)
cat("Accuracy:", accuracy, "\n")

counts <- baseball_copy %>%
  group_by(description, predicted_call) %>%
  summarise(count = n()) %>%
  mutate(proportion = count / sum(count) * 100)

# Displaying umpire accuracy based purely on zone
ggplot(counts, aes(x = description, y = proportion, fill = predicted_call)) +
  geom_bar(stat = "identity", position = "dodge", color = "black", width = 0.7) +
  labs(title = "Comparison of Description vs. Actual Pitch Location",
       subtitle = sprintf("Accuracy: %.2f%%", accuracy * 100),
       x = "Umpire's Call of Pitch",
       y = "Accuracy of Pitches",
       fill = "Actual Pitch Location") +
  scale_fill_manual(values = c("strike" = "blue", "ball" = "red"),
                    breaks = c("strike", "ball"),
                    labels = c("Strike Zone", "Ball Zone")) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 18, hjust = 0.5, face = "bold"),
    plot.subtitle = element_text(size = 16, hjust = 0.5),
    axis.title.x = element_text(size = 14, face = "bold"),
    axis.title.y = element_text(size = 14, face = "bold"),
    axis.text = element_text(size = 12),
    legend.title = element_text(size = 14, face = "bold"),
    legend.text = element_text(size = 12),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  ) +
  geom_text(aes(label = sprintf("%.1f%%", proportion)), position = position_dodge(width = 0.7), vjust = -0.5, size = 4)


# Running regression on each variable against description 
# (seeing how much of an impact each variable has on the call 
# the umpire calls for each pitch)

# Converting description column variables (1 for called_strike and 0 for ball)
baseball_copy$description_binary <- ifelse(baseball_copy$description == "called_strike", 1, 0)

# Regression for each variable against description
variables <- c("pitch_type", "stand", "p_throws", "balls", "strikes", "plate_x", "plate_z", "sz_top", "sz_bot", "zone")
results <- lapply(variables, function(var) {
  formula <- as.formula(paste("description_binary ~", var))
  first_model <- glm(formula, data = baseball_copy, family = binomial)
  return(summary(first_model)$coefficients)
})

names(results) <- variables
print(results)


# Creating second logistic regression (simpler to use for manipulation, same principles as first regression)
logmodel <- glm(description_binary ~ ., data = baseball_copy[, c("description_binary", variables)], family = binomial)

summary(logmodel)

# Residuals plot to analyze model fit
residuals <- residuals(logmodel, type = "deviance")

plot(residuals, main = "Deviance Residuals", ylab = "Deviance Residuals", col = "blue")
abline(h = 0, col = "red")  


# Accuracy analysis of regression 2 to determine which cutoff level should be used 
# to make model as accurate as possible (for prediction analysis)

# Defining cutoff levels to determine the threshold probability for classifying an outcome as either positive (strike) or negative (ball)
cutoffs <- seq(0.1, 0.9, 0.1)

accuracy <- NULL

# Calculating accuracy for each cutoff level and creating plot
for (i in seq_along(cutoffs)){
  prediction <- ifelse(logmodel$fitted.values >= cutoffs[i], 1, 0)
  accuracy <- c(accuracy, sum(prediction == baseball_copy$description_binary)/length(prediction)*100)
}

plot(cutoffs, accuracy, type='l', xlab="Cutoff Level", ylab="Accuracy %",
     main="Cutoff Level vs. Model Accuracy")


# # Testing the model (input variables below in new_pitch data frame and 
# input cutoff level in ifelse prediction section, output will be the prediction 
# of whether the pitch would be a ball or a strike given all variables)

# Running new_pitch data frame to analyze accuracy of regression model 
# (based on variables input should the pitch be called a ball or a strike)
new_pitch <- data.frame(
  pitch_type = "SL",
  stand = "L",
  p_throws = "L",
  balls = 3,
  strikes = 2,
  plate_x = 0.5,
  plate_z = 1.5,
  sz_top = 2.5,
  sz_bot = 1.0,
  zone = 11
)

# Prediction using the regression model
prediction <- predict(logmodel, newdata = new_pitch, type = "response")

# Determining if the pitch will be called a strike or ball based on the cutoff level and other variables
ifelse(prediction >= 0.8, "Strike", "Ball")

