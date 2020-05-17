# Getting and Cleaning Data Project

**Description**

The purpose of this project is to perform the following steps :

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

**Analysis File **

Please see the R code in the [runanalysis.R](https://github.com/rajaram-ramakrishnan/datascience_specalization_coursera/blob/master/03_Getting%20_Cleaning_Data/Project/run_analysis.R)

**Steps**

1. Load Activity and Features data from the files activity_labels.txt and features.txt respectivley.
2. As there are 561 measurements, only mean and standard deviation measures are selected out of 561.
3. Train Dataset is loaded using the files X_train.txt, y_train.txt and subject_train.txt files. X_train.txt file will have 561 measurements for each subjects and only the measurements selected in step 2 will be loaded.
4. Test Dataset is loaded using the files X_test.txt, y_test.txt and subject_test.txt files. X_test.txt file will have 561 measurements for each subjects and only the measurements selected in step 2 will be loaded.
5. Combine train and test data in to single dataset.
6. Calculate the mean of the measures at subject and Activity level.
7. Write the output to the file tidyData.txt

