# Getting-and-Cleaning-Data-Course-Project
This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R does the following.

a. Download the dataset if it does not already exist in the working directory
b. Load all project dataset: activity,feature, test and train, keeping only columns which reflect a mean or standard deviation
b. Loads the activity and subject data for train and test datasets
c. Merges the two datasets (merges the selected columns in a full dataset)
d. Converts the activity and subject columns into factors
e. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
f. The end result is shown in the file tidy_data.txt.
