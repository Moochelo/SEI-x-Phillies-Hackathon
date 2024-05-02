# SEI-x-Phillies-Hackathon

Competition hosted by the Philadelphia Phillies and SEI. Goal was to make a product that would predict whether the pitch would be a strike or a ball given various categorical and numerical variables.

***

Link to view presentation: [Phillies x Hackathon Presentation.pdf](https://github.com/Moochelo/SEI-x-Phillies-Hackathon/files/15191247/Phillies.x.Hackathon.Presentation.pdf)

## Name

Michael Mucciolo

***


## Project title

Estimating Strike Probabilities Through Umpire Tendencies

***

## Group Members

Cara Fredericks, Kale Wiley, Gibson Hurst

***


## Project Overview

Our group created a model in R-Studio that analyzed all pitch data from the 2022 MLB season. Each participating group was provided with an Excel dataset containing detailed information on every pitch recorded during the 2022 MLB regular season. This dataset includes various variables that exert different degrees of influence on the umpire's call, which will be elaborated upon in our report. This model determined how significant each variable  in the given dataset was for umpire's calls of pitches (whether the umpire had called the pitch a ball or a strike). From this analysis, the model was trained so if it was given new data unseen before, it could predict whether the pitch would be a ball or a strike. The practical application of this project is crucial for baseball teams, as it offers valuable insights that can influence various aspects of the game, from assessing catcher framing and swing decisions to understanding umpire tendencies.


***

## Data Exploration and Preprocessing

The dataset provided contained the following variables:

-	game_pk: Unique integer that identifies a specific game 
-	game_date: Game_date in MM/DD/YYYY format 
-	at_bat_number: Unique integer that identifies a specific plate appearance within a game
-	pitch_number: Unique integer that identifies a specific pitch within a plate appearance
-	pitch_type: String identifying the type of pitch thrown. Values are defined here and include:
  	- CH: changeup 
  	- CS, CU: curveball 
  	- EP: eephus 
  	- FA, FF: four-seam fastball 
  	- FC: cutter 
  	- FS: splitter 
  	- KC: knuckle-curve 
  	- KN: knuckle-ball 
  	- SI: sinker 
  	- SL: slider 
-	pitcher_name: Name of the pitcher in LAST, FIRST format 
-	pitcher: Unique integer that identifies the pitcher 
-	batter: Unique integer that identifies the batter 
-	catcher: Unique integer that identifies the catcher 
-	description: String that describes the result of the pitch. Either “ball” or “called_strike” 
-	zone: Unique integer identifying the zone location of the ball when it crosses the plate from the catcher’s perspective (zones one through nine comprise the rulebook strike zone and zones 11-14 signify the area where a pitch should be called a ball) 
-	stand: One of “L” or “R” corresponding to the handedness of the batter 
-	p_throws: One of “L” or “R” corresponding to the handedness of the pitcher 
-	balls: Number of balls in the count at the time of the pitch 
-	strikes: Number of strikes in the count at the time of the pitch 
-	plate_x: Horizontal position of the ball when it crosses home plate from the catcher’s perspective (the middle of home plate is the origin; units of feet)
-	plate_z: Vertical position of the ball when it crosses home plate from the catcher’s perspective (the ground is the origin, units of feet) 
-	sz_top: The top of the batter’s strike zone set by the operator when the ball is halfway to the plate (units of feet) 
-	sz_bottom: The bottom of the batter’s strike zone set by the operator when the ball is halfway to the plate (units of feet) 
-	broadcast: Link to a broadcast video of the pitch 

Atop these variables, our group created these variables for further help with analysis:

-	balls_plus_strikes: Number of overall pitches in the count at the time of the pitch 
-	in_strikezone: Whether the pitch in question was in the strike zone (sones 1-8)
-	same_side: Whether the pitcher had the same stance as the batter (RHP and RHB for example)
-	abs_value_plate_x: Absolute horizontal position of the ball from home plate (going from the origin, or middle of the plate)
-	abs_value_plate_z: Absolute vertical position of the ball from home plate (going from the origin, or ground)
-	plate_z_corrected:  Variable to correct for issued values for height of ball position 
-	description_binary: Converting description column variables to binary (1 for called_strike and 0 for ball) 
-	predicted_call: Based purely on zone, whether the pitch should be called a ball or a strike



***


## Audience and Application

This model is applicable to the following groups of people for the following reasons:

- Baseball Teams and Coaches:
  - Teams can utilize strike probability models for optimized player performance and strategy during games.
    - This could include enhancing catcher framing techniques, umpire call tendencies and pitcher effectiveness based on predicted strike probabilities.
- Umpires and Officiating Organizations:
  - Umpires can gain insights into umpire tendencies (of themselves and other umpires) and decision-making processes.
    - These umpires in question could improve upon consistency and accuracy in calling pitches by understanding factors influencing strike calls.
- Sports Analysts:
  - Those in the profession of sports analytics could learn to improve upon and build their own strike probability models for advanced statistical analysis and player evaluation.
    - Developing innovative strategies and metrics could lead to competitive edge in recruitment and game tactics.
- Broadcasters and Media Outlets:
  - Those involved in media could improve upon their live game coverage with real-time insights into pitch outcomes and strike probabilities.
    - They could additionally enrich their post-game analysis with data-driven narratives and visualizations.
- Baseball Fans and Enthusiasts:
  - Fans of the sport could improve their understanding and appreciation of the game through exploring pitch dynamics and umpire decisions.
    - Engaging with interactive dashboards to track player performance and game trends could show more of the whole picture for those attempting to learn more about the game.


***

## Exploratory Data Analysis

During the exploratory data analysis, the team generated a scatter plot to visualize pitch positions within our makeshift strike zone, defined by the following dimensions: 

Strike Zone Width = 17 inches (8.5 inches to left and right of center of home plate)
Top of Strike Zone Line = Average of sz_top = 3.379 Feet
Bottom of Strike Zone Line = Average of sz_bot = 1.598 Feet

This plot illustrated both accuracy of umpire calls for strikes and the areas where potential errors in missed calls might have occurred.


![image](https://github.com/Moochelo/SEI-x-Phillies-Hackathon/assets/117478032/9b3b481a-0219-4e23-9d7c-5754cf28c22e)

## Strike Zone Intro Analysis 


Noticeable from the plot, the majority of called strikes align with the boundaries of our constructed strike zone plot. To further analyze how many of the pitches called by umpires were within the supposed strike zone however, an accuracy test was completed.

               
![image](https://github.com/Moochelo/SEI-x-Phillies-Hackathon/assets/117478032/c0e46f91-241f-4d13-aa51-a901aa0c32ce)



## Exploratory Matrix (Comparing Umpire Calls with Expected Calls)




![image](https://github.com/Moochelo/SEI-x-Phillies-Hackathon/assets/117478032/9e6ac2ed-47cb-42df-ad58-bf4182220631)




## Strike Zone Grid (Numbers 1-9 indicate an expected strike, numbers 11-14 indicate an expected ball) 




The accuracy test calculated that umpires called balls with 94.9% accuracy over the course of the season. Atop this, umpires called strikes with 86.3% accuracy. Overall showing that umpires are 92.1% accurate based purely on expected call (zone location). To expand on this, all These results are displayed graphically in the “Comparison of Description vs Actual Pitch Location” chart. This tells us that overall, umpires do a good job of judging strikes and balls from behind the plate. The discrepancy in accuracy between strike and ball accuracy can be explained through the fact that balls are easier to call. For example if a pitch is thrown into the dirt or way outside the strike zone up or from left to right it is easy for an umpire to declare that pitch a ball. The strike zone is a little different in that a lot of the time pitchers are good at “painting the corners” which means they can effectively throw the ball in a place which is difficult for the batter to hit as well as making the margin between strike and ball more difficult to discern for umpires.

![image](https://github.com/Moochelo/SEI-x-Phillies-Hackathon/assets/117478032/d1156a41-4642-4b5e-ae2c-c8f13194d64b)



***


## Regression Model 


A logistic regression model was created to determine how significant each vatiable is against umpire call (the description variable). The analysis revealed that pitches with positive coefficients had a higher chance of being called a strike, pitches on the outside of the strike zone are most likely to be called incorrectly, and higher strike counts at the time of the pitch reduced the likelihood that the pitch would be called a strike.


***

## Cutoff Level 


An accuracy analysis model was developed based off of the logistic regression to test the model with new or unseen data. Levels of 0.1 to 0.9 were used for the cutoff levels and this helped improve overall model accuracy as a result. (Lower cutoff level means more false positives and fewer false negatives and higher cutoff level could lead to fewer false positives and more false negatives). Accuracy was calculated from the model based on whether the pitch was called a strike or a ball.


![image](https://github.com/Moochelo/SEI-x-Phillies-Hackathon/assets/117478032/09339ce6-42cf-46cd-a241-e9b3fba3c87b)

## Plot Showing a Visual Representation of Relationship Between Cutoff Levels and Accuracy 


***


## Model Evaluation  


A deviance residuals test was conducted to analyze the normality of the residuals for the regression. 


![image](https://github.com/Moochelo/SEI-x-Phillies-Hackathon/assets/117478032/40f4ef74-7321-4049-998f-dc72de000de4)

## Deviance Residuals Plot 

To evaluate the performance of the logistic regression model a residual plot was created to visually display the relationship between the outcome and the predicted probability of the model. The residual plot shows a line at y=0 as well as residual points which are the difference between the actual call and the probability of that call. The plot shows that the residuals are evenly scattered above as well as below that line (the points are the blue dots and the line is the red line about 0). This is a good indication that the model is on average unbiased in its predictions. If the plot showed points only above or below then it would suggest that the model is underpredicting the probability of either strike or ball. Since this is not the case it is assumed that the model is predicting without bias and fits the data.

***

## Evaluating the Model with Unseen Data

To test the model’s accuracy, our group used a new pitch data frame and the optimal cutoff level determined from the accuracy analysis. (These variables can be adjusted when running the code, simply input whatever variables you desire and replace them with whatever values are desired).By following this approach, one can adjust the model accordingly and ensure its accuracy for predicting umpire calls, framing the pitch, and knowing what pitches batters should be more susceptible to swing at.

***


## Limitations and Future Directions

The following limitations within the model/data include:

- A strong imbalance exists with the data as there are twice as many called balls as strikes in the data, potentially hurting performance.
- The model will lose performance over time with each new season, player, and umpire (the model will have to be retrained each new season).

Future directions that can be taken following this competition include:

- Future data could include Umpire ID, Umpire Name, and ballpark elevation as these would have made good predictor variables (to see if elevation hardened baseballs, and how the strike zone varied from umpire to umpire).
- Future models could use tree-based classifiers like Decision Tree or Random Forest (to include a random element and not have the new data build purely off of the old dataset).
- Future model evaluation could include additional metrics such as F1, Precision, and Recall.


***


## Conclusion

In conclusion, this project undertaken for the SEI x Phillies Hackathon competition aimed to estimate the probability of umpire calls for pitches taken in the 2022 Major League Baseball season. The data analysis and modeling uncovered valuable information about umpire tendencies, accuracy, and what factors influence their decisions. Following the creation of a few calculated variables, the exploratory data analysis that was performed revealed significant features for predicting umpire calls. A logistic regression model on the binary variable (description) was created to construct a predictive model that accurately predicts the probability of an umpire call. The application of this model extends beyond umpire call predictions and can help with catcher framing and improving decision making on and off the field. Teams can use this model to identify the types of pitches pitchers are more likely to throw for strikes, optimize catcher positioning for more strike calls, and determine which pitches batters should frequently swing at.

***

## Instructions for User Implementation

Instructions for running code:
1. Import necessary libraries:
   - library(readxl)
   - library(dplyr)
   - library(tidyr)
   - library(ggplot2)
3. Import Dataset (We kept the name the same):
   - baseball_copy <- read_excel("baseball copy.xlsx")
5. Run regression code 
6. Run Accuracy Analysis (Determining Cutoff Level Code)
7. Testing model (Run new_pitch data frame code and adjust variables accordingly)

***


## References

Mills, B. M. (2023, October 9). Umpire Analytics. Society for American Baseball Research. https://sabr.org/journal/article/umpire-analytics/ 

Palmer, B. (2024, April 10). Believe it or Not, Umpires Are More Accurate Than Ever. Pitcher List. https://pitcherlist.com/believe-it-or-not-umpires-are-more-accurate-than-ever/#:~:text=But%20in%20every%20season%20since,improvement%20between%202008%20and%202023.


***

## Code for Hackacthon Competition

### Getting necessary libraries and importing Excel sheet Into R

library(readxl)
library(dplyr)
library(tidyr)
library(ggplot2)


baseball_copy <- read_excel("baseball copy.xlsx")

### Create scatterplot of all pitches in dataset (using makeshift strikezone to visualize where each pitch has landed and whether it is in the strikezone)

set.seed(42)  
sampled_data <- baseball_copy[sample(nrow(baseball_copy), 2000), ]

lower_boundary <- 1.598
upper_boundary <- 3.379
left_boundary <- -((17/12)/2)
right_boundary <- ((17/12)/2)

call_colors <- c("ball" = "red", "called_strike" = "blue")

### Plotting pitch positions (makeshift strike zone)
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


### Analyze how accurate umpires are in calling pitches strikes or balls (purely based on the zone the ball is in when the pitch reaches the plate)

### Defining strike zone
strike_zones <- 1:9
ball_zones <- 11:14

baseball_copy <- baseball_copy %>%
  mutate(predicted_call = case_when(
    zone %in% strike_zones ~ "strike",
    zone %in% ball_zones ~ "ball",
    TRUE ~ NA_character_
  ))

conf_matrix <- table(baseball_copy$description, baseball_copy$predicted_call)

### Calculating and printing accuracy
accuracy <- sum(diag(conf_matrix)) / sum(conf_matrix)

print(conf_matrix)
cat("Accuracy:", accuracy, "\n")

counts <- baseball_copy %>%
  group_by(description, predicted_call) %>%
  summarise(count = n()) %>%
  mutate(proportion = count / sum(count) * 100)

### Displaying umpire accuracy based purely on zone
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


### Running regression on each variable against description (seeing how much of an impact each variable has on the call the umpire calls for each pitch)

### Converting description column variables (1 for called_strike and 0 for ball)
baseball_copy$description_binary <- ifelse(baseball_copy$description == "called_strike", 1, 0)

### Regression for each variable against description
variables <- c("pitch_type", "stand", "p_throws", "balls", "strikes", "plate_x", "plate_z", "sz_top", "sz_bot", "zone")
results <- lapply(variables, function(var) {
  formula <- as.formula(paste("description_binary ~", var))
  first_model <- glm(formula, data = baseball_copy, family = binomial)
  return(summary(first_model)$coefficients)
})

names(results) <- variables
print(results)


### Creating second logistic regression (simpler to use for manipulation, same principles as first regression)
logmodel <- glm(description_binary ~ ., data = baseball_copy[, c("description_binary", variables)], family = binomial)

summary(logmodel)

### Residuals plot to analyze model fit
residuals <- residuals(logmodel, type = "deviance")

plot(residuals, main = "Deviance Residuals", ylab = "Deviance Residuals", col = "blue")
abline(h = 0, col = "red")  


### Accuracy analysis of regression 2 to determine which cutoff level should be used to make model as accurate as possible (for prediction analysis)

### Defining cutoff levels to determine the threshold probability for classifying an outcome as either positive (strike) or negative (ball)
cutoffs <- seq(0.1, 0.9, 0.1)

accuracy <- NULL

### Calculating accuracy for each cutoff level and creating plot
for (i in seq_along(cutoffs)){
  prediction <- ifelse(logmodel$fitted.values >= cutoffs[i], 1, 0)
  accuracy <- c(accuracy, sum(prediction == baseball_copy$description_binary)/length(prediction)*100)
}

plot(cutoffs, accuracy, type='l', xlab="Cutoff Level", ylab="Accuracy %",
     main="Cutoff Level vs. Model Accuracy")


### Testing the model (input variables below in new_pitch data frame and input cutoff level in ifelse prediction section, output will be the prediction of whether the pitch would be a ball or a strike given all variables)

### Running new_pitch data frame to analyze accuracy of regression model (based on variables input should the pitch be called a ball or a strike)
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

### Prediction using the regression model
prediction <- predict(logmodel, newdata = new_pitch, type = "response")

### Determining if the pitch will be called a strike or ball based on the cutoff level and other variables
ifelse(prediction >= 0.8, "Strike", "Ball")




