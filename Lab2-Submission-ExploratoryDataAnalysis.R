# *****************************************************************************
# Lab 2: Exploratory Data Analysis ----
#
# Course Code: BBT4206
# Course Name: Business Intelligence II
# Semester Duration: 21st August 2023 to 28th November 2023
#
# Lecturer: Allan Omondi
# Contact: aomondi [at] Strathmore.edu
#
# Note: The lecture contains both theory and practice. This file forms part of
#       the practice. It has required lab work submissions that are graded for
#       coursework marks.
#

# STEP 1. Install and use renv ----

if (!is.element("renv", installed.packages()[, 1])) {
  install.packages("renv", dependencies = TRUE)
}
require("renv")

# Select option 1 to restore the project from the lockfile
renv::init()

# Execute the following code to reinstall the specific package versions
# recorded in the lockfile:
renv::restore()

# One of the packages required to use R in VS Code is the "languageserver"
# package. It can be installed manually as follows if you are not using the
# renv::restore() command.
if (!is.element("languageserver", installed.packages()[, 1])) {
  install.packages("languageserver", dependencies = TRUE)
}
require("languageserver")

## STEP 2: Download sample datasets ----
X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset <- read.csv("data/20230412-20230719-BI1-BBIT4-1-StudentPerformanceDataset.csv")

if (!is.element("readr", installed.packages()[, 1])) {
  install.packages("readr", dependencies = TRUE)
}
require("readr")

## STEP 3. Load the downloaded sample datasets ----
if (!is.element("readr", installed.packages()[, 1])) {
  install.packages("readr", dependencies = TRUE)
}
require("readr")



View(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset)


## STEP 4. Load sample datasets that are provided as part of a package ----
if (!is.element("mlbench", installed.packages()[, 1])) {
  install.packages("mlbench", dependencies = TRUE)
}
require("mlbench")

data("X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset.csv")

## STEP 5. Preview the Loaded Datasets ----
# Dimensions refer to the number of observations (rows) and the number of
# attributes/variables/features (columns). Execute the following commands to
# display the dimensions of your datasets:

dim(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset)

## STEP 6. Identify the Data Types ----
# Knowing the data types will help you to identify the most appropriate
# visualization types and algorithms that can be applied. It can also help you
# to identify the need to convert from categorical data (factors) to integers
# or vice versa where necessary. Execute the following command to identify the
# data types:
sapply(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset, class)

### STEP 7. Identify the number of instances that belong to each class. ----
# It is more sensible to count categorical variables (factors or dimensions)
# than numeric variables, e.g., counting the number of male and female
# participants instead of counting the frequency of each participant’s height.
student_performance_romantic_relationships_freq <- X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset$romantic_relationships
cbind(frequency = table(student_performance_romantic_relationships_freq),
      percentage = prop.table(table(student_performance_romantic_relationships_freq)) * 100)

### STEP 8. Calculate the mode ----
# Unfortunately, R does not have an in-built function for calculating the mode.
# We, therefore, must manually create a function that can calculate the mode.

student_performance_romantic_relationships_mode <- names(table(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset$romantic_relationships))[
  which(table(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset$romantic_relationships) == max(table(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset$romantic_relationships)))
]
print(student_performance_romantic_relationships_mode)

### STEP 9. Measure the distribution of the data for each variable ----
summary(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset)
#check on this
sapply(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset[,21], sd)

### STEP 11. Measure the variance of each variable ----
sapply(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset[,2:55], var)

### STEP 12. Measure the kurtosis of each variable ----
# The Kurtosis informs you of how often outliers occur in the results.
if (!is.element("e1071", installed.packages()[, 1])) {
  install.packages("e1071", dependencies = TRUE)
}
require("e1071")

sapply(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset[, 4],  kurtosis, type = 2)

### STEP 13. Measure the skewness of each variable ----
# The skewness informs you of the asymmetry of the distribution of results.
sapply(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset[, 4],  skewness, type = 2)

## STEP 14. Measure the covariance between variables ----
# Note that the covariance and the correlation are computed for numeric values
# only, not categorical values.
X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset_cov <- cov(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset[ ,2:55])
View(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset_cov)

## STEP 15. Measure the correlation between variables ----
X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset_cor <- cor(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset[ ,2:55])
View(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset_cor)
## STEP 16. Perform ANOVA on the dataset ----
# ANOVA (Analysis of Variance) is a statistical test used to estimate how a
# quantitative dependent variable changes

# One-Way ANOVA 
X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset_one_way_anova <- aov(motivator ~ GRADE, data =X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset)
summary(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset_one_way_anova)


# Two-Way ANOVA
X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset_two_way_anova <- aov(drop_bi_now ~ read_content_before_lecture * study_time, data =X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset)
summary(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset_two_way_anova)

# Two-Way ANOVA
X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset_two_way_anova <- aov(drop_bi_now ~ read_content_before_lecture + study_time + find_terms_I_do_not_know, data =X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset)
summary(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset_two_way_anova)

### STEP 17. Create Histograms for Each Numeric Attribute ----

X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset_histo <- as.numeric(unlist(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset[, 2]))
hist(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset_histo, main = names(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset)[2])

### STEP 18. Create Box and Whisker Plots for Each Numeric Attribute
par(mfrow = c(1, 5))
for (i in 2:5) {
  boxplot(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset[, i], main = names(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset)[i])
}

par(mfrow = c(1, 5))
for (i in 10:12) {
  boxplot(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset[, i], main = names(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset)[i])
}


### STEP 19. Create Bar Plots for Each Categorical Attribute ----
barplot(table(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset[, 2]), main = names(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset)[2])
barplot(table(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset[, 100]), main = names(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset)[100])

### STEP 20. Create a Missingness Map to Identify Missing Data ----
# “Amelia” package.

if (!is.element("Amelia", installed.packages()[, 1])) {
  install.packages("Amelia", dependencies = TRUE)
}
require("Amelia")

missmap(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset, col = c("red", "grey"), legend = TRUE)

## Multivariate Plots ----

### STEP 21. Create a Correlation Plot ----
if (!is.element("corrplot", installed.packages()[, 1])) {
  install.packages("corrplot", dependencies = TRUE)
}
require("corrplot")
corrplot(cor(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset[, 2:4]), method = "shade")

if (!is.element("ggcorrplot", installed.packages()[, 1])) {
  install.packages("ggcorrplot", dependencies = TRUE)
}
require("ggcorrplot")
ggcorrplot(cor(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset[, 2:4]))

### STEP 22. Create a Scatter Plot ----
ggplot(X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset,
       aes(x = study_time, y = motivator, shape = GRADE, color = GRADE)) +
  geom_point() +
  geom_smooth(method = lm)


### STEP 23. Create Multivariate Box and Whisker Plots by Class ----
if (!is.element("caret", installed.packages()[, 1])) {
  install.packages("caret", dependencies = TRUE)
}
require("caret")
featurePlot(x = X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset[, 42:48], y = X20230412_20230719_BI1_BBIT4_1_StudentPerformanceDataset[, 2], plot = "box")

# **Deinitialization: Create a snapshot of the R environment ----
renv::snapshot()
