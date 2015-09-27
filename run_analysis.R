
file_path <- file.path("./UCI HAR Dataset")

# read all the files
featureNames   = read.table(file.path(file_path, "features.txt" ), header=FALSE);
activityLabels = read.table(file.path(file_path, "activity_labels.txt" ), header=FALSE);

# read training files
subjectTrain  = read.table(file.path(file_path, "train" , "subject_train.txt" ), header=FALSE);
featureTrain  = read.table(file.path(file_path, "train" , "X_train.txt" ), header=FALSE);
activityTrain = read.table(file.path(file_path, "train" , "y_train.txt" ), header=FALSE);

# read test files
subjectTest   = read.table(file.path(file_path, "test" , "subject_test.txt" ), header=FALSE);
featureTest   = read.table(file.path(file_path, "test" , "X_test.txt" ), header=FALSE);
activityTest  = read.table(file.path(file_path, "test" , "y_test.txt" ), header=FALSE);

# concatenate train and test data
subject  = rbind(subjectTrain, subjectTest)
activity = rbind(subjectTrain, subjectTest)
feature  = rbind(featureTrain, featureTest)

# set field names for variables
names(subject)  = c("subject")
names(activity) = c("activity")
names(feature)  = featureNames[,2]

# merge all the tables to form the total data
completeData = cbind(feature, subject, activity)

# select the mean and std features from the whole data
meanStdNames    = featureNames$V2[grep("mean\\(\\)|std\\(\\)", featureNames$V2)]
selectedNames   = c(as.character(meanStdNames), "subject", "activity" )
completeData    = subset(completeData, select=selectedNames)

# rename fields to somthing more sensible
names(completeData) = gsub("^t", "Time", names(completeData))
names(completeData) = gsub("^f", "Frequency", names(completeData))
names(completeData) = gsub("Acc", "Accelerometer", names(completeData))
names(completeData) = gsub("Gyro", "Gyroscope", names(completeData))
names(completeData) = gsub("Mag", "Magnitude", names(completeData))
names(completeData) = gsub("BodyBody", "Body", names(completeData))

# create tidy data and write it to file
library(plyr);
data_aggregrate = aggregate(. ~subject + activity, completeData, mean)
data_aggregrate = data_aggregrate[order(data_aggregrate$subject, data_aggregrate$activity), ]
write.table(data_aggregrate, file = "output_data.txt",row.name=FALSE)


