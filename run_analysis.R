library(plyr)

## Getting and Cleaning Data Course Project
## Carol Roffer  -  November 2015
##
##  This script, run_analysis.R,  does the following: 
##  1. Merges the training and the test sets to create one data set.
##  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
##  3. Uses descriptive activity names to name the activities in the data set
##  4. Appropriately labels the data set with descriptive variable names. 
##  5. From the data set in step 4, creates a second, independent tidy data set 
##     with the average of each variable for each activity and each subject

## Assumes the zip file has been downloaded already

zipfile <- "getdata-projectfiles-UCI HAR Dataset.zip"

if (!file.exists("UCI HAR Dataset")) { 
        unzip(zipfile) 
}

# Merge the training and test  data sets for subjects and activities

# Activities (y data)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt",header = FALSE)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt",header = FALSE)

# Subject (Volunteers)
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt",header = FALSE)
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt",header = FALSE)

# Combine the rows of 'y'(activity) and 'subject' data sets, respectively
activity_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)

# read the names of the feature variables 
features <- read.table("UCI HAR Dataset/features.txt",header = FALSE)
features[,2] <- as.character(features[,2])

# extract names that are "mean()" or "std()"
features_names <- grep("mean\\(\\)|std\\(\\)", features[,2])
features_names_clean <- features[features_names,2]

# clean up feature names
features_names_clean = gsub('-mean', 'Mean', features_names_clean)
features_names_clean = gsub('-std', 'Std', features_names_clean)
features_names_clean <- gsub('[-()]', '',features_names_clean)

# read features (x data) where record is a mean or std
x_train <- read.table("UCI HAR Dataset/train/X_train.txt",header = FALSE) [features_names]
x_test <- read.table("UCI HAR Dataset/test/X_test.txt",header = FALSE) [features_names]
feature_data <- rbind(x_train, x_test)

# combine subject and activity columns,and bind to feature data frames
subject_activity <- cbind(subject_data, activity_data)
all_data <- cbind(subject_activity, feature_data)

# set names to data set
names(all_data) <- c("subject", "activity", features_names_clean)

# read descriptive activity labels
activities <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
activities[,2] <- as.character(activities[,2])

all_data$activity <- factor(all_data$activity, levels = activities[,1], 
                            labels = activities[,2])
all_data$subject <- as.factor(all_data$subject)

# Create a tidy data set with the average of each variable
# for each activity and each subject (Means of columns 3-68) 
# turn activities & subjects into factors
data_mean <- aggregate(. ~subject + activity, all_data, mean)
data_order <- data_mean[order(data_mean$subject,data_mean$activity),]
write.table(data_order, file = "tidydata.txt",row.name=FALSE)

