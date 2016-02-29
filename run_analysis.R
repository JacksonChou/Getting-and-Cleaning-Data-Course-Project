
##################################################################################
# 
# Getting and Cleaning Data Course Project
# 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
#Jackson Chou
#02/28/2016
#################################################################################


if (!require('reshape2')) {
  install.packages('reshape2')
}


if (!require('dplyr')) {
  install.packages('dplyr')
}

if (!require('plyr')) {
  install.packages('plyr')
}

if (!require('stringr')) {
  install.packages('stringr')
}


require('reshape2')
require('dplyr')
require('plyr')
require('stringr')

#Download the zip files

fileurl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#For zip files, we'll need to create a temp path for the decompressed data
temp <- tempfile()
download.file(fileurl, temp)

#Read the data/files in zipped dataset
activitydata <- read.table(unz(temp, "UCI HAR Dataset/activity_labels.txt"))
featuresdata <- read.table(unz(temp, "UCI HAR Dataset/features.txt"))

xtestdata <- read.table(unz(temp, "UCI HAR Dataset/test/X_test.txt"))
ytestlabeldata <- read.table(unz(temp, "UCI HAR Dataset/test/y_test.txt"))
testsubjectdata <- read.table(unz(temp, "UCI HAR Dataset/test/subject_test.txt"))

xtraindata <- read.table(unz(temp, "UCI HAR Dataset/train/X_train.txt"))
ytrainlabeldata <-read.table(unz(temp, "UCI HAR Dataset/train/y_train.txt"))
trainsubjectdata <- read.table(unz(temp, "UCI HAR Dataset/train/subject_train.txt"))

unlink(temp)


#Merge test and train dataset

xmergedata <-rbind(xtestdata,xtraindata)

ymergedata <- rbind(ytestlabeldata, ytrainlabeldata)

subjectmergeddata <- rbind(testsubjectdata, trainsubjectdata)

#Name the columns for merged dataset
featuresdata$V2 <- as.character(featuresdata$V2)
featurenames <- make.names(featuresdata$V2, unique = T)
names(xmergedata) <- featurenames
names(subjectmergeddata) <- c("subjects")

#Merge training and subject dataframes to test data

xmergedata <- cbind(ymergedata, xmergedata)
xmergedata <- cbind(subjectmergeddata, xmergedata)


#Extracts only the measurements on the mean and standard deviation for each measurement.

extractdata <- select(xmergedata, subjects, V1, contains(".mean."), contains(".std."))

#change subjects str to factor
extractdata$subjects <- as.factor(extractdata$subjects)
extractdata$V1 <- as.factor(extractdata$V1)

str(extractdata)

#Name the activities for column 'V1' in extracted dataset
activityindex <- c(1:6)
activityindex <- as.character(activityindex)
activitynames <- as.character(activitydata[,2])

extractdata$V1 <- plyr::mapvalues(extractdata$V1, from = activityindex, to = activitynames)


#Label extracted dataset with descriptive variable names


names(extractdata) <- str_replace_all(names(extractdata), "BodyBody", "Body")
names(extractdata) <- str_replace_all(names(extractdata), "tBody", "Body")
names(extractdata) <- str_replace_all(names(extractdata), "fBody", "FFTBody")
names(extractdata) <- str_replace_all(names(extractdata), "tGravity", "Gravity")
names(extractdata) <- str_replace_all(names(extractdata), "fGravity", "FFTGravity")
names(extractdata) <- str_replace_all(names(extractdata), "Acc", "Acceleration")
names(extractdata) <- str_replace_all(names(extractdata), "Gyro", "AngularVelocity")
names(extractdata) <- str_replace_all(names(extractdata), "Mag", "Magnitude")
names(extractdata) <- str_replace_all(names(extractdata), "[.][.]", "")

names(extractdata) <- gsub("\\.", "", names(extractdata))


#Create second independent tidy data set with average of each variable for each activity and each subject

splitdata <- split(select(extractdata, 3:68), list(extractdata$subjects, extractdata$V1))

averagedata <- lapply(splitdata, function(x) apply(x, 2, mean, na.rm=T))

tidydata <- data.frame(t(sapply(averagedata,c)))

tidyfactors <- data.frame(t(sapply(strsplit(rownames(tidydata), "[.]"), c)))

tidydata <- cbind(tidyfactors, tidydata)

tidydata <- dlyr::rename(tidydata, Subjects = X1, Activity = X2)

tidydata$Subjects <-as.factor(tidydata$Subjects)
tidydata$Activity <-as.factor(tidydata$Activity)

rownames(tidydata) <- NULL

write.table(tidydata, "tidydataset.txt", row.names = F)



