# SEI-x-Phillies-Hackathon

Link to view presentation: [Phillies x Hackathon Presentation.pdf](https://github.com/Moochelo/SEI-x-Phillies-Hackathon/files/15191247/Phillies.x.Hackathon.Presentation.pdf)

Competition hosted by the Philadelphia Phillies and SEI. Goal was to make a product that would predict whether the pitch would be a strike or a ball given various categorical and numerical variables.

## Name

Michael Mucciolo


## Project title

Estimating Strike Probabilities Through Umpire Tendencies

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

This project is applicable to the following groups of people for the following reasons:

- Baseball Teams and Coaches:
  - Utilize strike probability models for optimized player performance and strategy during games.
    - Enhance catcher framing techniques and pitcher effectiveness based on predicted strike probabilities.
- Umpires and Officiating Organizations:
  - Gain insights into umpire tendencies and decision-making processes.
    - Enhance consistency and accuracy in calling pitches by understanding factors influencing strike calls.
- Analytics Departments and Data Scientists:
  - Leverage strike probability models for advanced statistical analysis and player evaluation.
    - Develop innovative strategies and metrics for competitive edge in recruitment and game tactics.
- Broadcasters and Media Outlets:
  - Enhance live game coverage with real-time insights into pitch outcomes and strike probabilities.
    - Enrich post-game analysis with data-driven narratives and visualizations.
- Baseball Fans and Enthusiasts:
  - Deepen understanding and appreciation of the game through exploring pitch dynamics and umpire decisions.
    - Engage with interactive dashboards to track player performance and game trends.




## Exploratory Data Analysis

During the exploratory data analysis, the team generated a scatter plot to visualize pitch positions within our makeshift strike zone, defined by the following dimensions: 

Strike Zone Width = 17 inches (8.5 inches to left and right of center of home plate)
Top of Strike Zone Line = Average of sz_top = 3.379 Feet
Bottom of Strike Zone Line = Average of sz_bot = 1.598 Feet

This plot illustrated both accuracy of umpire calls for strikes and the areas where potential errors in missed calls might have occurred.


![image](https://github.com/Moochelo/SEI-x-Phillies-Hackathon/assets/117478032/9b3b481a-0219-4e23-9d7c-5754cf28c22e)


Noticeable from the plot, the majority of called strikes align with the boundaries of our constructed strike zone plot. To further analyze how many of the pitches called by umpires were within the supposed strike zone however, an accuracy test was completed.

               
![image](https://github.com/Moochelo/SEI-x-Phillies-Hackathon/assets/117478032/c0e46f91-241f-4d13-aa51-a901aa0c32ce)


The accuracy test calculated that umpires called balls with 94.9% accuracy over the course of the season. Atop this, umpires called strikes with 86.3% accuracy. Overall showing that umpires are 92.1% accurate based purely on expected call. These results are displayed graphically in the “Comparison of Description vs Actual Pitch Location” chart. This tells us that overall, umpires do a good job of judging strikes and balls from behind the plate. The discrepancy in accuracy between strike and ball accuracy can be explained through the fact that balls are easier to call. For example if a pitch is thrown into the dirt or way outside the strike zone up or from left to right it is easy for an umpire to declare that pitch a ball. The strike zone is a little different in that a lot of the time pitchers are good at “painting the corners” which means they can effectively throw the ball in a place which is difficult for the batter to hit as well as making the margin between strike and ball more difficult to discern for umpires.

![image](https://github.com/Moochelo/SEI-x-Phillies-Hackathon/assets/117478032/d1156a41-4642-4b5e-ae2c-c8f13194d64b)



