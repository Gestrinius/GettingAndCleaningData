# Step 1. 
# Merges the training and the test sets to create one data set.

# setwd("~/Desktop/Coursera/Getting and cleaning data - Course Project")

# Download and unzip the data (if the dataset exists):

theDataset <- "UCI HAR Dataset.zip"

if (!file.exists(theDataset)){
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, theDataset, method = "curl")  
}
if (!file.exists("UCI HAR Dataset")){
        unzip(theDataset)
}

# Reading of the training tables
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
dim(x_train) #7352*561
head(x_train)

y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
dim(y_train) #7352*1
table(y_train)

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

# Reading of the testing tables
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
dim(x_test) #2947*561

y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
dim(y_test) #2947*1
table(y_test)

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Creates data set for X.
joinDataX <- rbind(x_train, x_test)
dim(joinDataX) #10299*561

# Creates data set for Y.
joinDataY <- rbind(y_train, y_test)
dim(joinDataY) #10299*1

# Creates data set for Subject.
joinSubject <- rbind(subject_train, subject_test)
dim(joinSubject) #10299*1

# Step 2. 
# Extracts only the measurements on the mean and standard deviation
# for each measurement.

features <- read.table("UCI HAR Dataset/features.txt")
dim(features) #561*2

# Only captures the measurements that has 'mean()' or 'std()' in 
# their description name.
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[,2])
length(meanStdIndices) #66

# Subset the columns I whant.
joinDataX <- joinDataX[, meanStdIndices]
dim(joinDataX) #10299*66

# Change the names of the columns
# Removes the '()'.
names(joinDataX) <- gsub("\\(\\)", "", features[meanStdIndices, 2])

# Remove the "-" in column names.
names(joinDataX) <- gsub("-", "", names(joinDataX))

# Capitalises 'M' in 'mean'.
names(joinDataX) <- gsub("mean", "Mean", names(joinDataX))

# Capitalises 'S' in 'std'.
names(joinDataX) <- gsub("std", "Std", names(joinDataX))

# Step 3. 
# Uses descriptive activity names to name the activities in the data set.

activity <- read.table("UCI HAR Dataset/activity_labels.txt")

# Turns the letters in to small case.
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))

# Makes the doubble words second word into upper cases
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))

activityDataY <- activity[joinDataY[, 1], 2]

joinDataY[, 1] <- activityDataY

names(joinDataY) <- "activity"

# Step 4. 
# Appropriately labels the data set with descriptive variable names.

names(joinSubject) <- "subject"
tidyData <- cbind(joinSubject, joinDataY, joinDataX)
dim(tidyData) # 10299*68
write.table(tidyData, "./merged_data.txt")

# Step 5. 
# From the data set in step 4, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject.

subjectLength <- length(table(joinSubject))
activityLength <- dim(activity)[1]
columnLength <- dim(tidyData)[2]
result <- matrix(NA, nrow = subjectLength * activityLength, ncol = columnLength)
result <- as.data.frame(result)
colnames(result) <- colnames(tidyData)
row <- 1
for(i in 1:subjectLength) {
        for(j in 1:activityLength) {
                result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
                result[row, 2] <- activity[j, 2]
                bool1 <- i == tidyData$subject
                bool2 <- activity[j, 2] == tidyData$activity
                result[row, 3:columnLength] <- colMeans(tidyData[bool1&bool2, 3:columnLength])
                row <- row + 1
        }
}
head(result)
write.table(result, "data_with_means.txt")

# theData <- read.table("./data_with_means.txt")
# theData[1:12, 1:6]
