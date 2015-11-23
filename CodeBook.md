# Codebook for run_analysis.R and resulting output, tidydata.txt
## Source Information
1. Source Project Information > http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
2. Source Data >https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
3. Review Source README.txt and feature_info.txt to understand feature measurements
4. Files Used
  * UCI HAR Dataset/features.txt
  * UCI HAR Dataset/activity_labels.txt
  * UCI HAR Dataset/train/x_train.txt
  * UCI HAR Dataset/train/y_train.txt
  * UCI HAR Dataset/train/subject_train.txt
  * UCI HAR Dataset/test/subject_test.txt
  * UCI HAR Dataset/test/x_train.txt
  * UCI HAR Dataset/test/y_train.txt
  
## Variables Used
* subject - participant variable in the test or train efforts
* activity - 6 different activity variables
 *SITTING
 *STANDING
 *WALKING
 *WALKING_DOWNSTAIRS
 *WALKING_UPSTAIRS
 *LAYING
* features - 66 variables with name containing "mean()" or "std()"

##Processing
* Used plyr package
* Combined test and train data for activities (y data) and subjects
* Read feature names, and grep rows where name containing "mean()" or "std()"; results in 66 measurements
* Clean the feature names; removing (), removing hyphens; but essentially as described in features_info.txt
* Combined all data (subject,activity and measurements(features)) 10299 rows and 68 columns in resulting data_frame
* Factored activity variable to apply descriptive name
* Aggregated the data frame by subject and mean, calculating mean on all other columns (measurements)
* Sorted data by subject and mean
* Wrote data to tidydata.txt file

## Results
tidydata.txt > 180 rows x 68 columns
