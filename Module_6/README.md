# Module 6 Assignment: Advanced Regression Techniques and Data Subsetting

## Overview

In this assignment, I explored advanced regression techniques by creating dummy variables to subset a dataset and analyze the impact of a categorical variable on regression. The dataset used pertains to height and weight measurements, and the objective was to understand the differences in regression lines when data is subsetted by gender.

## Instructions

- **R Script**: The R code for this assignment is organized under the subheading "Week 6" in the "R Script.R" document.
- **Statistical Outputs**: The results of the analysis are presented under the same subheading in the "R Outputs.docx" file.

## Process

1. Imported and installed necessary packages, then loaded the height and weight dataset.
2. Created a dummy variable for gender and renamed the column to "Maleness".
3. Conducted a regression analysis with height as the dependent variable and weight and maleness as predictors.
4. Created a scatterplot with multiple regression lines to visualize the impact of gender on height.
5. Subsequently, subsetted the data by gender and created separate regression models for males and females.
6. Plotted the separate regression lines to compare with the combined regression model.

## Key Findings

- **Regression with Dummy Variable**: The initial regression model indicated a difference in height between male and female samples, with two distinct regression lines representing each gender.
- **Separate Regression Models**: After subsetting the data by gender, the separate regression lines for males and females were not parallel, suggesting that the effect of weight on height differs between genders and that gender becomes less significant as height increases.

## Reflection

The use of dummy variables and subsetting provided a nuanced understanding of the relationship between height, weight, and gender. The findings from the separate regression models were particularly insightful, revealing that gender differences in height may diminish with increasing height. This assignment highlighted the importance of considering categorical variables and subgroups when analyzing and interpreting regression models.

For more details on the code and outputs, please refer to files in the repository.
