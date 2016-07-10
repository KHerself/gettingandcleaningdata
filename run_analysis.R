#This function reads in data from a dataset in the same working directory, and outputs a CSV file with just the data needed.
#This is for the Getting and Cleaning Data course

#Read in the necessary files
data_test <- read.table("UCI\ HAR\ Dataset/test/X_test.txt")
activity_test <- read.table("UCI\ HAR\ Dataset/test/Y_test.txt")
subject_test <- read.table("UCI\ HAR\ Dataset/test/subject_test.txt")

#all_test <- cbind(subject_test, activity_test, data_test)

data_train <- read.table("UCI\ HAR\ Dataset/train/X_train.txt")
activity_train <- read.table("UCI\ HAR\ Dataset/train/Y_train.txt")
subject_train <- read.table("UCI\ HAR\ Dataset/train/subject_train.txt")

#all_train <- cbind(subject_train, activity_train, data_train)

#Read in the names for each of the data values (data_test & data_train) and find the ones that relate to mean and standard deviation. Then combine them, sorted, for use.
features <- read.table("UCI\ HAR\ Dataset/features.txt")
meandata_nums <- grep("mean", features[,2])
stddata_nums <- grep("std", features[,2])
mean_std <- sort(c(meandata_nums, stddata_nums))

#Pull out just the data I care about (mean and standard deviation data)
data_to_use_test <- data_test[,mean_std]
data_to_use_train <- data_train[,mean_std]

#combine data for testing and training into one data frame each
all_test <- cbind(subject_test, activity_test, data_to_use_test)
all_train <- cbind(subject_train, activity_train, data_to_use_train)

#name the datasets
all_names <- c("subject","activity", as.character(features[mean_std,2]))
all_names <- sub("\\(\\)","",all_names,)
names(all_test) <- all_names
names(all_train) <- all_names

#combining it all into one dataset
all_data <- rbind(all_test,all_train)

#activity_names <- read.table("UCI\ HAR\ Dataset/activity_labels.txt")
#names(activity_names) <- c("number","activity")

#make the activity data useful by replacing numbers with names
all_data$activity <- as.character(all_data$activity)
all_data$activity[all_data$activity=="1"] <- "walking"
all_data$activity[all_data$activity=="2"] <- "walkingUpStairs"
all_data$activity[all_data$activity=="3"] <- "walkingDownStairs"
all_data$activity[all_data$activity=="4"] <- "sitting"
all_data$activity[all_data$activity=="5"] <- "standing"
all_data$activity[all_data$activity=="6"] <- "laying"

#The next portion of this code calculates the mean of all the readings for each variable within a subject/activity pair and stores the result in tidyDataK.

subjects <- 1:30
activities <- c("walking", "walkingUpStairs", "walkingDownStairs", "sitting", "standing", "laying")

tidyDataK <- data.frame(matrix(ncol=81, nrow=0))
names(tidyDataK) <- all_names

for(i in subjects) {
	subjectloop <- i
	#print(i)
	for(j in activities) {
		activityloop <- j
		#print(j)
		loopsub <- subset(all_data, subject==subjectloop & activity==activityloop)
		loopmeans <- as.data.frame(t(colMeans(loopsub[,3:81])))
		tidyDataK <- rbind(tidyDataK, cbind(subjectloop, activityloop, loopmeans))
	}
}

names(tidyDataK) <- all_names

#Finally, write the resulting dataset to tidyDataK.csv
#write.csv(all_data, file="all_data.csv")
write.csv(tidyDataK, file="tidyDataK.csv")
