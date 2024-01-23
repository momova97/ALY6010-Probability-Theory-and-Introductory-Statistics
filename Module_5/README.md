# Module 5 Assignment: Correlation and Regression Analysis

## Overview

In this assignment, I conducted correlation and regression analyses to examine relationships between variables in a water quality dataset. The goal was to identify key analytical findings and discuss the results of the regression analysis.

## Instructions

- **R Script**: The R code for this assignment is organized under the subheading "Week 5" in the "R Script.R" document.
- **Statistical Outputs**: The results of the analysis are presented under the same subheading in the "R Outputs.docx" file.

## Process

1. Imported and installed necessary packages, then loaded the water quality dataset.
2. Selected the first five numeric columns for analysis to maintain a manageable correlation chart.
3. Generated a correlation matrix and created a corrplot to visualize the relationships between variables.
4. Conducted a regression analysis using barium as the outcome variable and arsenic as the predictor.

## Key Findings

- **Correlation Analysis**: The corrplot revealed mostly positive correlations between variables, suggesting that pollution levels tend to rise and fall together across different contaminants. A notable exception was a weak negative correlation between chloramine and cadmium.
- **Regression Analysis**: Despite a strong correlation between chloramine and barium, the regression analysis indicated a low R-squared value of 19%, suggesting that the model is not a good fit for predicting barium levels based on chloramine.

## Reflection

The correlation analysis provided insights into the relationships between different pollutants in water samples. However, the regression analysis demonstrated that a strong correlation does not always translate into a reliable predictive model. This highlights the importance of understanding the underlying data and the limitations of statistical models.

For more details on the code and outputs, please refer files in the repository.
