##This document explains how run_analysis.R works

*run_analysis.R is a script that reads in data from the dataset called “UCI HAR Dataset”, which must be in the working directory. This is accelerometer and gyroscope data from a wearable gadget.
*It changes the activity names from numbers to descriptive words.
*It then combines both test and training data into one dataset, and pulls out just the variables that relate to mean or standard deviation.
*For each subject and activity, it computes the mean of all the readings for each variable, and stores the result in a file called “tidyDataK.csv”

For more information about the variables and calculations, see CodeBook.md