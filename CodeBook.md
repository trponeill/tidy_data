##CodeBook

###Source
The data was collected as part of the Human Activity Recognition database build and was
produced from the recordings of 30 subjects performing activities of daily living (ADL) 
while carrying a waist-mounted smartphone with embedded inertial sensors. 
(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

###Full Set of Variables and Features
The variables and features of the data used in this analysis can be found in the 
README and features texts of the UCI HAR Dataset and include the following files:


- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are 
equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity 
for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the 
smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 
element vector. The same description applies for the 'total_acc_x_train.txt' and 
'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained 
by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured 
y the gyroscope for each window sample. The units are radians/second. 



###Subset of Variables and Features
For the purposes of this analysis a subset of variables and features was determined by
the course conveners. This subset included the following:

* RAW Data Set
The RAW data set was subsetted to only include those 'features' with measurements on the
'mean' (mean) or the 'standard deviation' (std)

* TIDY Data Set
The tidy_data set was further subsetted to only include the average of each variable for
each activity and each subject


###Approach

* Read each of the required files in using read.table and assigned to a variable
* Combined each of the 'test' and 'train' files into a new variable using 'rbind'
* Added meaningful column names using 'colnames'
* Subsetted the resulting data sets to those with 'mean' and those with 'std' in thier names
* Combined the resulting data sets using 'cbind'
* Added the activity names to the ydata using a 'plyr' join - removed unnecessary columns
* Combined all data sets into one 'DataSet' using 'cbind'
* Tidied column variable names by removing symbols and expanding some abbreviations
* Prepared the 'DataSet' for transformation using 'dplyr' - tbl-df
* Grouped 'DataSet' with 'group_by' and used 'summarise_each' to apply the mean
* Used 'write.table' to write the tidy_data to a text file.

###Transformations

Column names were adjusted to be more readable but still compact
* "mean", "Mean"     
* "std", "StdDev"
* "()",""
* "t", "Time"
* "tBody", "TimeBody"
* "f", "Freq"
* "BodyBody", "Body"


