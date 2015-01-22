# Getting and Cleaning Data - Project

**Introduction**

The repository contains scripts and files required for the Getting and Cleaning Data project.

**Data**

The data set used for the project originated from UCI Machine Learning Repository. The data included:

1. Features are unlabeled in the x_test.txt and x_train.txt files
2. Activity labels found in the y_test.txt and y_train.txt files
3. Test subjects found in the subject_test.txt and subject_train.txt files

**Script**

Script is named run_analysis.R, which does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set (tidy.txt) with the average of each variable for each activity and each subject.

**Codebook**

The code book describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md.
