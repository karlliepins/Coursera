library(dplyr)

download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "data.zip")
unzip(zipfile = "data.zip")

VarNames <- read.table("UCI HAR Dataset/features.txt")

testDF <- read.table("UCI HAR Dataset/test/X_test.txt")
names(testDF) <- VarNames$V2
testDF$Subj <- read.table("UCI HAR Dataset/test/subject_test.txt")[,1]
testDF$Lable <- read.table("UCI HAR Dataset/test/y_test.txt")[,1]
rownames(testDF) <- c()

trainDF <- read.table("UCI HAR Dataset/train/X_train.txt")
names(trainDF) <- VarNames$V2
trainDF$Subj <- read.table("UCI HAR Dataset/train/subject_train.txt")[,1]
trainDF$Lable <- read.table("UCI HAR Dataset/train/y_train.txt")[,1]
rownames(trainDF) <-c()

mergedDF <- rbind(testDF,trainDF)
valid_names <- make.names(names = names(mergedDF),unique = TRUE, allow_ = TRUE)
names(mergedDF) <- valid_names

mergedDF2 <- mergedDF %>%
        select(matches("std\\.\\.|mean\\.\\.",ignore.case = FALSE),"Subj","Lable")

LabelsDF <- read.table("UCI HAR Dataset/activity_labels.txt")

mergedDF2$Lable <- sapply(X = mergedDF2$Lable, FUN = function(x) LabelsDF$V2[match(x,LabelsDF$V1)])

resultDF <- mergedDF2 %>%
        group_by(Subj, Lable) %>%
        summarise_all(mean)
