# GettingAndCleaningData  
get the  data set of wearable computing data originally from   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  

#Files in this repo  
 * README.md  
 * CookBook.md  
 * run_analysis.R  

#run_analysis.R goals
You should create one R script called run_analysis.R that does the following.   
* 1.Merges the training and the test sets to create one data set.  
* 2.Extracts only the measurements on the mean and standard deviation for each measurement.   
* 3.Uses descriptive activity names to name the activities in the data set  
* 4.Appropriately labels the data set with descriptive variable names.   
* 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  

The code should have a file run_analysis.R in the main directory that can be run as long as the Samsung data is in your working directory. The run_analysis.R is in the same directory with the UCI HAR Dataset folder.The run_analysis.R is also out of the UCI HAR Dataset folder.  

#run_analysis.R walkthrough
It follows the goals step by step.  
* Step 1:  
  reading test data  
* Step 2:  
  set the extraction standard,and .Extracts only the measurements on the mean and standard deviation for each measurement from the original test data.  
* Step 3:    
  for the test data,use descriptive activity names to name the activities in the data set,and appropriately labels the data set with descriptive variable names.  
* Step 4：  
  repeat step 1,2,3 for the train data.  
* Step 5:  
  Merges the training and the test sets to create one data set.  
* Step 6:  
  creates a second, independent tidy data set with the average of each variable for each activity and each subject.  
  Writes the data with write.table() using row.name=FALSE .  
