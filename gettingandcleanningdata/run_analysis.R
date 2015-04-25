## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##install the packages
if (!require("data.table")) {
        install.packages("data.table")
}

if (!require("dplyr")) {
        install.packages("dplyr")
}

if (!require("reshape2")) {
        install.packages("reshape2")
}
if (!require("tidyr")) {
        install.packages("tidyr")
}

library(data.table)
library(reshape2)
library(dplyr)
library(tidyr)

##change the working directory
##setwd("C:/Users/Administrator/Desktop/3getting and cleaning data/wd/data")

##load the data
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
head(subject_test)

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

##set the extraction standard 
features <- read.table("./UCI HAR Dataset/features.txt")[,2]
extract_features <- grepl("mean()|std()", features)&!grepl("meanFreq", features)

##extract the feature of the  test data
names(X_test) = features
X_test = X_test[,extract_features]

## load the activity labels
y_test[,2] = activity_labels[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "subject"

##combine the test data
test<-cbind(as.data.table(subject_test),X_test,y_test)
str(test)

##repeat above process for train data 
##load the data
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
head(subject_train)

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

##set the extraction standard 
features <- read.table("./UCI HAR Dataset/features.txt")[,2]
extract_features <- grepl("mean|std", features)&!grepl("meanFreq", features)

##extract the feature of the  train data
names(X_train) = features
X_train = X_train[,extract_features]

## load the activity labels
y_train[,2] = activity_labels[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "subject"

##combine the train data
train<-cbind(as.data.table(subject_train),X_train,y_train)
str(train)

##Merges the training and the test sets to create one data set.
data<-rbind(test,train)

##creates a second, independent tidy data set with the average 
##of each variable for each activity and each subject.
data%>%
gather(recordings,values,-Activity_ID,-Activity_Label,-subject,na.rm = TRUE)%>%
select(-Activity_ID)%>%
group_by(Activity_Label,subject,recordings)%>%
summarise(mean=mean(values))%>%
spread(recordings,mean)%>%
##dim()%>%
##write the data
write.table(file = "./UCI HAR Dataset/tidy_data.txt",row.names=FALSE)

