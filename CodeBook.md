file_path   = The root project directory

featureNames   = data from features.txt containing names of features
activityLabels = data from activity_labels containing labels

# read training files
subjectTrain  = training data for subjects
featureTrain  = training data for features
activityTrain = training data for activities

# read test files
subjectTest   = test data for features
featureTest   = test data for features
activityTest  = test data for activities

# concatenate train and test data
subject  = test and train data for subjects
activity = test and train data for activity
feature  = test and train data for feature

# merge all the tables to form the total data
completeData = table containg the merge from all tables (subject, activity, feature)

# select the mean and std features from the whole data
meanStdNames    = fetch feature names with 'std' and 'mean' in them
selectedNames   = append the meanStdNames to the existing field names in completeData
completeData    = subset of the completeData having the names in selectedNames

# create tidy data and write it to file
data_aggregrate = aggregate the mean of all data belonging to a subject having a common activity
data_aggregrate = ordered aggregate data ordered by subject and activity
