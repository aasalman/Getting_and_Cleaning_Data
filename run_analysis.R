# 1. Merges the training and the test sets to create one data set 

# rename columns for R purposes

features <- read.table('./features.txt',header=FALSE)
features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])
features[,2] = gsub('[-()]', '', features[,2])

# load training data

activity.label <- read.table('./activity_labels.txt',header=FALSE)
subject.train <- read.table('./train/subject_train.txt',header=FALSE)
x.train <- read.table('./train/x_train.txt',header=FALSE)
y.train <- read.table('./train/y_train.txt',header=FALSE)

# assign col names to training data

colnames(activity.label) <- c('activityID','activity.label')
colnames(subject.train) <- "subjectID"
colnames(x.train) <- features[,2]
colnames(y.train) <- "activityID"

# create training set

trainset <- cbind(y.train,subject.train,x.train)

# load test data

subject.test <- read.table('./test/subject_test.txt',header=FALSE)
x.test <- read.table('./test/x_test.txt',header=FALSE)
y.test <- read.table('./test/y_test.txt',header=FALSE)

# assign col names to test data

colnames(subject.test) <- "subjectID"
colnames(x.test) <- features[,2]
colnames(y.test) <- "activityID"

# create test set

testset <- cbind(y.test,subject.test,x.test)

# create final data set

finalset <- rbind(trainset,testset)


# 2. Extracts only the measurements on the mean and standard deviation for each measurement

# get only the data on mean and standard deviation

mstd <- grep(".*Mean.*|.*Std.*", features[,2])


# 3. Uses descriptive activity names to name the activities in the data set

# filter out features we don't need

features <- features[mstd,]

# remove the unnecessary columns from final data set

finalset <- finalset[,mstd]


# 4. Appropriately labels the data set with descriptive variable names.

colnames(finalset) <- tolower(colnames(finalset))

current.activity <- 1

for (current.label in activity.label[,2]) {
  
  finalset$activity <- gsub(current.activity, current.label, finalset$activity)
  
  current.activity <- current.activity + 1
  
}


# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# convert activity and subjects into factors in order to be used in aggregate function to create lists of averages of each variable

finalset$activity <- as.factor(finalset$activity)

finalset$subject <- as.factor(finalset$subject)

# generate tidy data set

tidy <- aggregate(finalset, by=list(activity = finalset$activity, subject=finalset$subject), mean)

# delete  subject and activity columns, because means are null

tidy[,90] <- NULL

tidy[,89] <- NULL

write.table(tidy, "tidy.txt", sep="\t")
