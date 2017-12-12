# Data Cleaning Of Human Activity Recognition Using Smartphones Data Set

The repository contains an initial data from 'Human Activity Recognition Using Smartphones Data Set', script to clean the data, file with resilting cleaned data set, code book explaining content of this file.

## Content

* 'UCI HAR Dataset' - folder with initial data set.
* 'run_analysis.R' - script written in R language to clean the data and to create resulting data set in 'averaged_data_by_subject_and_activity.txt' file.
* 'averaged_data_by_subject_and_activity.txt' - resulting data set.
* 'CodeBook.md' - description of the content of the 'averaged_data_by_subject_and_activity.txt' data set.

## How the R script works

You must be aware that the script required 'dplyr' R package installed.

* First of all it read information about all features and all activities into 'features' and 'activity_labels' frames.
* Then it extracts only names of features containing 'mean(' or 'std(' into 'mean_std_features' vector.
* After that the script starts reading training data set.
* It reads information about subjects participating in the training into 'train_subject' frame.
* It reads identifiers of activities into 'train_labels', merges it with 'activity_labels' to get names of activities of each observation. The information is stored into 'train_labels' frame.
* It reads variables observations into 'train_data' frame. Then it leaves only columns from 'mean_std_features' vector. The result is stored in the 'train_data' frame.
* It merges 'train_subject', 'train_labels' and 'train_data' frames using 'cbind' to assign subjects and activities to the observations. The result is stored into the 'train_data' frame
* After that the same process is repeated for the testing data set. In the end we have 'test_data' frame with the same columns as in the 'train_data' frame.
* Then we merge training and testing data together into 'all_data' frame.
* We group this frame by subject and activity into 'all_data_by_subject_and_activity' frame.
* After that we calculate average value (mean) for each group using 'summarise_each' function. The result is stored into 'averaged_data_by_subject_and_activity' frame.
* And we clean names of variables/columns by removing '(' and ')' symbols.
* In the end we store the result into 'averaged_data_by_subject_and_activity.txt' file using 'write.table' function.