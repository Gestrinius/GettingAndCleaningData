# The 'CodeBook' for Getting and Cleaning Data Course Project

According to the course instructions I should submit a code book that describes the variables, the data, and any transformations or work that I have performed to clean up the data called CodeBook.md(this file).

The submitted CodeBook.md is a decription of the data sets data, variables and the transformations of the data.

### The Data

The data was obtain from 'The Machine Learning Repository'on 2017-03-29
(Link:http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and zipped format of the data can be found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

The original description of the data set can be found in the original data sets 'Readme.txt'-file. My manipulation of the data set is described below.

### The Script

The 'run_analysis.R' script executes the steps described below on five steps to clean the data according to the assignment instructions:

Step 1.

The script first reads the 'X_train.txt', 'y_train.txt' and subject_train.txt table files from the "UCI HAR Dataset/train" folder and then stores them in the 'x_train', 'y_train' and 'subject_train' variables.

The script then reads the 'X_test.txt', 'y_test.txt' and 'subject_test.txt' from the "UCI HAR Dataset/train" folder and stores them in the 'x_test', 'y_test' and 'subject_test' variables.

The script then concatenates or joins the variables created abowe into datasets by row binding.
The variables 'x_train' and 'x_test' are joined together into a dataframe(dimensions: 10299x561)labeled 'joinDataX'.

The variables 'y_train' and 'y_test' are joined together into a dataframe(dimensions: 10299x1)labeled 'joinDataY'.

The variables 'subject_train' and 'subject_test' are joined together into a dataframe(dimensions: 10299x1)labeled 'joinSubject'.

Step 2.

The script now reads the 'features.txt' file from the 'UCI HAR Dataset/features.txt' to the variable labeled 'features'. 
I then extract the measurements on the mean and standard deviation for each measurement into a variable labeled 'meanStdIndices' using regex.
I then subset the columns I want from 'joinDataX' that I capture with 'meanStdIndices'.

Then I clean the names of the columns in the subset. I clean the subset by removing the "()" and "-" symbols from the column names and make the the firs letter of "mean" and "std" into capital letters.

Step 3.

The script then reads the 'activity_labels.txt' file from the 'UCI HAR Dataset/activity_labels.txt' file to the variable labeled 'features'.

Here I have choosen to transform the activity names into lower case letters exept the lables that are combined of two words where I hav made the second words first letter into a capital letter(as we have been thought in a previous course). The underscore between the two words has also been removed.

The script then changes the values of joinDataY according to the activity data frame.

Step 4.

The script now column binds the 'joinDataX, 'joinDataY' and 'joinSubject into a new variable and data frame labeled 'tidyData'. The first two columns are now named 'subject' and 'activity'.

The script now writes or copies the tidyData to a new "merged_data.txt" file in the working directory as a table.

Step 5.
The script generates a second independent tidy data set with the average of each measurement for each activity and each subject.
The 'subject' variable and the 'activity' variable togeather holds 180 combinations and are stored in a variable labeled 'result'. 
The script then calculates mean values for each combination of the 'result'.
The script the executes two "for-loops" and results in the data frame labeled 'result'.

The script writes or copies the result to a new "data_with_means.txt" file in the working directory as a table.
