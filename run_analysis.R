library(dplyr)

# Read information about activities names

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", 
                             header = FALSE, 
                             sep = " ", 
                             colClasses = c("numeric", "character"),
                             col.names = c("activityId", "activityName"))

# Read information about features/variables names

features <- read.table("UCI HAR Dataset/features.txt", 
                             header = FALSE, 
                             sep = " ", 
                             colClasses = c("numeric", "character"),
                             col.names = c("featureId", "featureName"))

# Get only variables for mean and standard deviation

mean_std_features <- features$featureName[grepl("mean\\(|std\\(", features$featureName)]

# Train data set

# Read information about subjects for each observation

train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                          header = FALSE, 
                          sep = " ", 
                          colClasses = c("numeric"),
                          col.names = c("subjectId"))

# Read information about activities for each observation

train_labels <- read.table("UCI HAR Dataset/train/y_train.txt", 
                          header = FALSE, 
                          sep = " ", 
                          colClasses = c("numeric"),
                          col.names = c("activityId"))
train_labels <- merge(train_labels, activity_labels, by.x = "activityId", by.y = "activityId")
train_labels <- data.frame(train_labels[, "activityName"])
names(train_labels) <- "activityName"

# Read data

train_data <- read.table("UCI HAR Dataset/train/X_train.txt", 
                         header = FALSE, 
                         strip.white = TRUE, 
                         colClasses = "numeric")
names(train_data) <- features$featureName

# Choose only columns for mean and standard deviation

train_data <- train_data[,mean_std_features]

# Join with information about subjects and activities

train_data <- cbind(train_subject, train_labels, train_data)

# Test data set

# Read information about subjects for each observation

test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt", 
                          header = FALSE, 
                          sep = " ", 
                          colClasses = c("numeric"),
                          col.names = c("subjectId"))

# Read information about activities for each observation

test_labels <- read.table("UCI HAR Dataset/test/y_test.txt", 
                         header = FALSE, 
                         sep = " ", 
                         colClasses = c("numeric"),
                         col.names = c("activityId"))
test_labels <- merge(test_labels, activity_labels, by.x = "activityId", by.y = "activityId")
test_labels <- data.frame(test_labels[, "activityName"])
names(test_labels) <- "activityName"

# Read data

test_data <- read.table("UCI HAR Dataset/test/X_test.txt", 
                        header = FALSE, 
                        strip.white = TRUE, 
                        colClasses = "numeric")
names(test_data) <- features$featureName

# Choose only columns for mean and standard deviation

test_data <- test_data[,mean_std_features]

# Join with information about subjects and activities

test_data <- cbind(test_subject, test_labels, test_data)

all_data <- rbind(test_data, train_data)

# Group data by subject and activity

all_data_by_subject_and_activity <- group_by(all_data, subjectId, activityName)

# Calculate averages of variables

averaged_data_by_subject_and_activity <- summarise_each(all_data_by_subject_and_activity, funs(mean))

# Clean variable names from brackets

names(averaged_data_by_subject_and_activity) <- gsub("\\(|\\)", "", names(averaged_data_by_subject_and_activity))

# Write result to a file

write.table(averaged_data_by_subject_and_activity, file = "averaged_data_by_subject_and_activity.txt", row.names = FALSE)