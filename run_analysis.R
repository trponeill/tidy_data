
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






