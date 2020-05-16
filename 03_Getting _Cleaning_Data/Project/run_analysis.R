##  Getting and Cleaning Data Course Project ##

## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation 
## for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.

## Download and unzip the files to working directory
dataset_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataset_url,destfile = "Dataset.zip")
unzip("Dataset.zip")
path <- getwd()

## Load activity and features data
library(data.table)

activity <- fread(file.path(path,"UCI HAR Dataset","activity_labels.txt"),
                  col.names = c("activityId","activityName"))

features <- fread(file.path(path,"UCI HAR Dataset","features.txt"),
                  col.names = c("featureId","featureName"))

## Extract only mean and standard deviation measurements from features

featuresSelected <- grep(pattern = "(mean|std)\\(\\)", 
                         x= features[, featureName])

measurements <- features[featuresSelected, featureName]
measurements <- gsub("[()]","",measurements)

## Load train datasets

train <- fread(file.path(path,"UCI HAR Dataset","train","X_train.txt"))[ ,featuresSelected, with=FALSE]
setnames(train,measurements)
trainActivities <- fread(file.path(path,"UCI HAR Dataset","train","y_train.txt"),
                         col.names=c("activityId"))

## The below piece of code is not used. Instead of Merge activity names can be 
## populated using factor which is done below 

##trainActivities <- merge(trainActivities,activity,by="activityId")
##trainActivities[, `:=` (activityId = NULL) ]

trainSubjects <- fread(file.path(path,"UCI HAR Dataset","train","subject_train.txt"),
                       col.names = c("subjectId"))
train <- cbind(trainSubjects,trainActivities,train)

## Load test datasets

test <- fread(file.path(path,"UCI HAR Dataset","test","X_test.txt"))[ ,featuresSelected, with=FALSE]
setnames(test,measurements)
testActivities <- fread(file.path(path,"UCI HAR Dataset","test","y_test.txt"),
                         col.names=c("activityId"))

## The below piece of code is not used. Instead of Merge activity names can be 
## populated using factor which is done below 

##testActivities <- merge(testActivities,activity,by="activityId")
##testActivities[, `:=` (activityId = NULL) ]


testSubjects <- fread(file.path(path,"UCI HAR Dataset","test","subject_test.txt"),
                       col.names = c("subjectId"))
test <- cbind(testSubjects,testActivities,test)

## Combine train and test datasets
train_test <- rbind(train, test)


## Convert Subjects and Activity names to factors
train_test[, `:=` (subjectId = as.factor(subjectId),
                   activityId = factor(activityId,
                                       levels=activity[,activityId],
                                       labels=activity[,activityName]))]


## convert wide dataset to long dataset

## Not used . Other way of calculating mean using melt and cast function ##
## train_test <- melt(train_test, id = c("subjectId","activityId"))
## train_test <- dcast(train_test,subjectId+activityId~variable,
##                         fun.aggregate = mean)


## Group by SubjectId, activityId and calculate mean for all the columns
## other than subjectId,activityId
train_test <- train_test[, lapply(.SD, mean),by = c("subjectId","activityId"),
           .SDcols = names(train_test)[-(1:2)]]


fwrite(x=train_test,file = "tidyData.txt",quote = TRUE)
