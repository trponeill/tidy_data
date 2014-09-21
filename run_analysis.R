`#Class Project
#Source website http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#
#data source https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

#The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
#The goal is to prepare tidy data that can be used for later analysis. 
#You will be graded by your peers on a series of yes/no questions related to the project. 
#You will be required to submit: 1) a tidy data set as described below, 
#2) a link to a Github repository with your script for performing the analysis, and 
#3) a code book that describes the variables, the data, and any transformations or work that you performed 
#to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. 
#This repo explains how all of the scripts work and how they are connected.  


#file name 
# step 1. Merges the training and the test sets to create one data set.
# step 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
# step 3.Uses descriptive activity names to name the activities in the data set
# step 4.Appropriately labels the data set with descriptive variable names. 
# step 5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


###run_analysis.R
library(plyr)
library(dplyr)
library(data.table)
#Get data into R to see shape and dimensions
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE, sep="")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE, sep="")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE, sep="")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE, sep="")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep="")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep="")
features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE, sep="")
activity <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE, sep="")

#combine the test and train data sets using rbind
Xdata<- rbind(X_test, X_train)         
ydata<- rbind(y_test, y_train)            
subjectData<- rbind(subject_test, subject_train)       

#add meaningful column names
colnames(Xdata)=(features$V2)           #add feature column names to Xdata
colnames(activity)=c("activityID","activityType")           ##add  column names to activity 
colnames(ydata)=("activityID")          #add column names to ydata
colnames(subjectData)=("subjectID")         #add column names to subject

#subset only features with mean/std using dplyr select 
XdataSubset1 <-select(Xdata, contains("mean"))        #subsets columns with 'mean'
XdataSubset2 <-select(Xdata, contains("std"))           #subset columns with'std'
XdataSubset <-cbind(XdataSubset1, XdataSubset2)         #combines columns with bind

#add activity names to ydata by using plyr 'join'
ydata <- arrange(join(ydata, activity), activityID)
ydata$activityID <-NULL       #drop ID as not needed

#combine data sets into one
DataSet <- cbind(ydata, subjectData, XdataSubset)

#tidy columns using 'names' expand abbrebiations
names<-names(DataSet)
names<-gsub("mean", "Mean",names)       
names<-gsub("std", "StdDev",names)
names<-gsub("\\()","",names)
names<-gsub("^(t)", "Time",names)
names<-gsub("tBody", "TimeBody",names)
names<-gsub("^(f)", "Freq",names)
names<-gsub("BodyBody", "Body",names)
setnames(DataSet, names)

#apply mean to tidyDataSet variables by activity and subject
tidyDataSet <-tbl_df(DataSet) #prepare for dplyr
tidyDataSet <- group_by(tidyDataSet, activityType, subjectID)
tidyDataSet <-summarise_each(tidyDataSet,funs(mean))

#write tidyDataSet to txt file 'tidy_data
write.table(tidyDataSet, file = "./tidy_data.txt", row.name=FALSE)






