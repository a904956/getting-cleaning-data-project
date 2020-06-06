library(dplyr)

# Downloading & Unzipping Folder
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filename = "dataset.zip"
download.file(url,filename,method="curl")
unzip(filename)

# Reading Activity Labels & Features 
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

# Reading training set
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
colnames(subject_train) = features$V2

x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
colnames(x_train) = features$V2

y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
colnames(y_train) = c("activity_code")

# Reading test set
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
colnames(subject_test) = c("subject")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
colnames(x_test) = features$V2

y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
colnames(y_test) = c("activity_code")

# 1. Merges the training and the test sets to create one data set.

x = rbind(x_train,x_test)
y = rbind(y_train,y_test)
subject = rbind(subject_train,subject_test)

df = cbind(subject,y,x)
head(df)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

df2 <- df[,grep("std\\(\\)|mean\\(\\)|activity_code|subject", colnames(df), value=TRUE)] 
head(df2)

# 3. Uses descriptive activity names to name the activities in the data set

df2$activity_description = factor(df2$activity_code, levels = activity_labels[,1], labels = activity_labels[,2])
head(df2)

# 4. Appropriately labels the data set with descriptive variable names.

names(df2)<-gsub("Acc", "Accelerometer", names(df2))
names(df2)<-gsub("Gyro", "Gyroscope", names(df2))
names(df2)<-gsub("BodyBody", "Body", names(df2))
names(df2)<-gsub("Mag", "Magnitude", names(df2))
names(df2)<-gsub("^t", "Time", names(df2))
names(df2)<-gsub("^f", "Frequency", names(df2))
names(df2)<-gsub("tBody", "timeBody", names(df2))
names(df2)<-gsub("-mean()", "Mean", names(df2), ignore.case = TRUE)
names(df2)<-gsub("-std()", "Std", names(df2), ignore.case = TRUE)
names(df2)<-gsub("-freq()", "Freq", names(df2), ignore.case = TRUE)
names(df2)<-gsub("[-()]", "", names(df2))

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

final_df <- df2 %>%
  group_by(subject, activity_code) %>%
  summarise_all(funs(mean))

head(final_df)
write.table(final_df, "final_df.txt", row.name=FALSE)