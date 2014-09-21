##run_analysis

###System
The analysis was done using
* RStudio Version 0.98.1062
* R version R 3.1.1 GUI 1.65 Mavericks build (6784)
* On a MacBook Pro - i7 16gb RAM


###Assumptions
* the UCI HAR Dataset is in your working directory
* you have maintained the file heirachy

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

