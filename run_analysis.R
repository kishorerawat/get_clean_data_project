##read activity files

a_test  <- read.table("test/y_test.txt",header = FALSE)
a_train <- read.table("train/y_train.txt",header = FALSE)


##read the subject files
s_test <- read.table("test/subject_test.txt",header = FALSE)
s_train <- read.table("train/subject_train.txt",header = FALSE)


##read the features file

f_test <- read.table("test/X_test.txt",header = FALSE)
f_train <- read.table("train/X_train.txt",header = FALSE)


##merge the test and train data rows

test_train_activity <- rbind(a_train, a_test)
test_train_subjects <- rbind(s_train, s_test)
test_train_features <- rbind(f_train, f_test)


##set names of the columns for these merged tables

names(test_train_activity) <- c("activity")
names(test_train_subjects) <- c("subject")


##for column names for the features table, first read the "features.txt" file

feature_names <- read.table("features.txt", header = FALSE)

##the V2 column in this table contains all the names of the features, use that to set the column names for the 
##merged features tables

names(test_train_features) <- feature_names$V2


##merge the columns of all these tables to get 1 single data frame

data_combined_temp <- cbind(test_train_subjects, test_train_activity)
data_combined_final <- cbind(test_train_features, data_combined_temp)


##Now, extact columns containing either "mean" or "std"

features_mean_std <- feature_names$V2[grep("mean\\(\\)|std\\(\\)", feature_names$V2)]

##add the two columns for "subject" and "activity"

features_selected <- c(as.character(features_mean_std), "subject", "activity" )

## extract data only for these selected columns
data_selected <- subset(data_combined_final, select=features_selected)

## read the activity labels and repalce in data_selected in the "activity" column
act_labels <- read.table("activity_labels.txt", header = FALSE)

## replace the activity number by its equivalent text label
data_selected$activity <- act_labels$V2[data_selected$activity]

## create a new dataset - containing average of each varible ordered by subject and activity
data_avg <- aggregate(. ~subject + activity, data_selected, mean)
data_avg <- data_avg[order(data_avg$subject, data_avg$activity),]

##store this new subject+activity wise average data into a new file
write.table(data_avg, file="HAR_avg_tidy.txt", row.name=FALSE)