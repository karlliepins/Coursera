library(dplyr)

#Obtaining the data 
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "data.zip")
unzip(zipfile = "data.zip")

VarNames <- read.table("UCI HAR Dataset/features.txt")

#Preparing the TEST set
testDF <- read.table("UCI HAR Dataset/test/X_test.txt")
names(testDF) <- VarNames$V2
testDF$Subj <- read.table("UCI HAR Dataset/test/subject_test.txt")[,1]
testDF$Lable <- read.table("UCI HAR Dataset/test/y_test.txt")[,1]
rownames(testDF) <- c()

#Preparing the TRAIN set
trainDF <- read.table("UCI HAR Dataset/train/X_train.txt")
names(trainDF) <- VarNames$V2
trainDF$Subj <- read.table("UCI HAR Dataset/train/subject_train.txt")[,1]
trainDF$Lable <- read.table("UCI HAR Dataset/train/y_train.txt")[,1]
rownames(trainDF) <-c()

#Merging the TEST and TRAIN sets
mergedDF <- rbind(testDF,trainDF)
valid_names <- make.names(names = names(mergedDF),unique = TRUE, allow_ = TRUE)
names(mergedDF) <- valid_names

#Extracting the required measurements
mergedDF2 <- mergedDF %>%
        select(matches("std\\.\\.|mean\\.\\.",ignore.case = FALSE),"Subj","Lable")

#Lebeling the data set
LabelsDF <- read.table("UCI HAR Dataset/activity_labels.txt")
mergedDF2$Lable <- sapply(X = mergedDF2$Lable, FUN = function(x) LabelsDF$V2[match(x,LabelsDF$V1)])

#Creating an independent tidy data set with averages
resultDF <- mergedDF2 %>%
        group_by(Subj, Lable) %>%
        summarise_all(mean)
