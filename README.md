# GettingAndCleaningData
Getting and Cleaning Data Course Project

This README.md file describes how the 'run_analysis.R' script works.

I recommend you to download the data from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
and rename the folder to 'theData' (otherwise the script will download and unzip the data for you).

Before you run the script 'run_analysis.R' you have to make sure that the script 'run_analysis.R' and theData will be in the same working directory.

When the above has been done you open "R" and types 'source("run_analysis.R")' in R.

When you have run the script by typing the command above you will find two files generated in your working directory called:

- merged_data.txt (7.9 Mb)
- data_with_means.txt (219.7 Kb)

Now type 'theData <- read.table("data_with_means.txt")' to get the final data table.
