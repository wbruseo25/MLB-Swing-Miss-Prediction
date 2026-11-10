# MLB Swing & Miss Prediction

**Project Status: In Progress**

**Technologies:** R | RStudio | tidyverse | ggplot2 | Statistical Learning

## Project Overview

This project focuses on predicting whether an MLB batter swings and misses at a pitch based on its physical characteristics using statistical learning methods.

Using 25,000 MLB Statcast pitch observations, the goal is to determine which pitch characteristics are most useful in predicting swing-and-miss outcomes and compare the performance of different classification methods.

The analysis focuses on factors such as pitch type, release speed, spin rate, pitch movement, and pitch location. R is used for data processing, exploratory data analysis, visualization, and the development of classification models.

## Dataset

The dataset contains **25,000 MLB Statcast pitch observations** from June 17–30, 2025.

Each observation represents an individual pitch where the batter either made contact or swung and missed.

A binary response variable was created to classify the outcomes:

- **0 = Contact**
- **1 = Swing and Miss**

The main variables being considered include:

| Variable | Description |
|---|---|
| pitch_type | Type of pitch thrown |
| release_speed | Pitch velocity (mph) |
| release_spin_rate | Spin rate (RPM) |
| pfx_x / pfx_z | Horizontal and vertical pitch movement |
| plate_x / plate_z | Horizontal and vertical pitch location |
| stand | Batter's hitting side |
| balls / strikes | Ball-strike count before the pitch |

## Exploratory Data Analysis

The initial stage of the project focused on understanding the dataset and identifying patterns that could be useful for predictive modeling.

Three visualizations were created in R to examine relationships between pitch characteristics and swing outcomes.

### 1. Swing-and-Miss Rate by Pitch Type

Calculated swing-and-miss percentages across different pitch types and compared the results using a horizontal bar chart.

Some observations from the dataset include:

- Knuckle curves: 37.0% miss rate
- Slurves: 33.8% miss rate
- Sliders: 30.8% miss rate
- Four-seam fastballs: 18.5% miss rate
- Sinkers: 12.2% miss rate

These differences suggest that pitch type could be an important factor in predicting swing-and-miss outcomes. However, sample sizes vary across pitch types, which should be considered when interpreting the results.

### 2. Release Speed vs. Swing Outcome

Compared pitch velocities between contact and missed-swing outcomes using summary statistics and boxplots.

The results showed:

- **Contact:** Average release speed of 89.9 mph
- **Swing and Miss:** Average release speed of 88.5 mph

Although the two groups had different average velocities, their distributions overlapped considerably. This suggests that release speed alone may not be a strong enough predictor and should be evaluated alongside other pitch characteristics.

### 3. Pitch Location Analysis

Created a heatmap showing swing-and-miss rates based on the horizontal and vertical locations where pitches crossed the plate.

Higher miss rates were generally observed in lower pitch locations, while pitches toward the middle of the plotted region tended to have lower miss rates.

These findings suggest that pitch location may be another useful predictor when developing classification models.

## Data Quality and Preprocessing

Initial data-quality checks were performed to identify potential issues before model development.

These included:

- Checking for missing values across important variables
- Reviewing numerical and categorical variables
- Examining pitch outcome distributions
- Checking for duplicate observations
- Identifying unusual release-speed values

Of the 25,000 pitch observations:

- **5,585 (22.34%)** resulted in a swing and miss.
- **19,415 (77.66%)** resulted in contact.

This indicates class imbalance, which will need to be considered when training and evaluating classification models.

Additional preprocessing, including categorical variable encoding, feature selection, and predictor standardization, will be addressed during the modeling stage.

## Statistical Learning Methods

The next stage of the project will focus on implementing and comparing three classification methods:

| Method | Description |
|---|---|
| Logistic Regression | Models the probability of a swing-and-miss outcome based on pitch characteristics |
| K-Nearest Neighbors (KNN) | Classifies pitch outcomes based on similarities between observations |
| Linear Discriminant Analysis (LDA) | Uses relationships between predictor variables to classify swing outcomes |

Model performance will be compared using:

- Classification accuracy
- Precision
- Recall
- Confusion matrices

The goal is to determine which method performs best on the dataset and identify the pitch characteristics most useful for predicting swing-and-miss outcomes.

## Repository Files

```text
MLB-Swing-Miss-Prediction/
├── README.md
├── .gitignore
├── scripts/
│   ├── README.md
│   └── CourseProject_Math478_Stage2.R
└── data/
    ├── README.md
    └── CourseProject_Math478.csv
```

### Running the Analysis

1. Install R and RStudio.
2. Install the `tidyverse` package:

   ```r
   install.packages("tidyverse")
   ```

3. Download or clone the repository.
4. Open `CourseProject_Math478_Stage2.R` in RStudio.
5. Run the script and select `CourseProject_Math478.csv` when prompted.

The current script generates summary statistics, three exploratory visualizations, and preliminary data-quality assessments.

## Current Status

**In Progress — Fall 2026**

The exploratory data analysis, initial data-quality checks, and three statistical visualizations have been completed.

The next stage will focus on implementing Logistic Regression, K-Nearest Neighbors (KNN), and Linear Discriminant Analysis (LDA) to predict swing-and-miss outcomes. Model performance will then be compared to determine which approach works best and which pitch characteristics contribute most to the predictions.

The repository will be updated as additional analysis and modeling are completed.
