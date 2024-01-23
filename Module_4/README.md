# Module 4 Assignment: Two-Sample T-Tests and Paired T-Tests

## Overview

This assignment involved conducting two-sample t-tests with unequal variance and paired t-tests to analyze datasets and answer specific research questions. The focus was on comparing body weights between male and female cats and evaluating the effect of meditation on sleep quality.

## Part 1: Two-Sample T-Test with Unequal Variance

- **Objective**: Determine if there is a significant difference in body weight between male and female cats using the "cats" dataset from the MASS package.
- **Method**: After cleaning the dataset and removing outliers, subsets for male and female cats were created. Descriptive statistics and histograms were generated to visualize the data distribution.
- **T-Test**: A two-sample t-test was conducted to compare the body weights of male and female cats.

## Part 2: Paired T-Test for Sleep Quality

- **Objective**: Assess whether meditation improves sleep quality based on average sleeping quality scores before and after a meditation workshop.
- **Method**: Histograms and boxplots were created to visualize the distribution of sleep quality scores. A paired t-test was used to compare the scores before and after the workshop.
- **Hypotheses**: The null hypothesis stated that there is no difference in mean sleep quality scores before and after the workshop, while the alternative hypothesis stated that there is a difference.
- **Significance Level**: The test was initially conducted at α = 0.05 and then repeated at α = 0.1 to evaluate the impact of changing the level of significance.

## Reflection

The analysis revealed a significant difference in body weight between male and female cats, with male cats being heavier on average. In the sleep quality study, the paired t-test indicated no significant improvement in sleep quality post-workshop at a 0.05 significance level. However, when the significance level was increased to 0.1, the confidence interval changed, suggesting a more nuanced interpretation may be necessary.