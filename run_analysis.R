## run_analysis.R

## preliminary tasks: 
## loading packages used to develop the project
if (!require("data.table")){nstall.packages("data.table")}
if (!require("reshape2")){install.packages("reshape2")}
require("data.table")
require("reshape2")
require("dplyr")

## Project:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## a. Preparing data from original datasets:
## loading datasets and cleaning them from "/c/Users/MartaT/UCI HAR Dataset 
## (i.e. Load/Extract/Transform(cleaning) process for every dataset)"

## local files
setwd("C:/Users/MartaT")

### Load activity label dataset
act_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
act_labels[,2] <- as.character(act_labels[,2])
### Loading features dataset
features <- read.table("./UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])
### Loading test datasets
test <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_act <- read.table("./UCI HAR Dataset/test/y_test.txt")
test_sub <- read.table("./UCI HAR Dataset/test/subject_test.txt")
fulltest <- cbind(test_sub, test_act, test)
### Loading train datasets
train <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_act <- read.table("./UCI HAR Dataset/train/y_train.txt")
train_sub <- read.table("./UCI HAR Dataset/train/subject_train.txt")
fulltrain <- cbind(train_sub, train_act, train)

#### Preparing features only for mean and standard deviation 
meanstd_features <- grep(".*mean.*|.*std.*", features[,2])
meanstd_features.names <- features[meanstd_features,2]
meanstd_features.names = gsub('-mean', 'Mean', meanstd_features.names)
meanstd_features.names = gsub('-std', 'Std', meanstd_features.names)
meanstd_features <- gsub('[-()]', '', meanstd_features.names)

# Merging datasets and adding labels to generate the tidy dataset
fulldata <- rbind(fulltest, fulltrain)
colnames(fulldata) <- c("subject", "activity", meanstd_features.names)

fulldata$activity <- factor(fulldata$activity, levels = act_labels[,1], labels = act_labels[,2])
fulldata$subject <- as.factor(fulldata$subject)

## Alternative 1: fulldata.melted <- melt(fullata, id = c("subject", "activity")) 
## I didn't use this expression because melt function gave match.names() error

# Alternative 2:
fulldata.melted <- 
  fulldata %>% 
  as.data.frame %>%
  melt(., id = c("subject", "activity")) 

fulldata.mean <- dcast(fullata.melted, subject + activity ~ variable, mean)

write.table(fulldata.mean, "C:/Users/MartaT/UCI HAR Dataset/tidy_data.txt")

