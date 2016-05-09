# read the Test data set
test_table <- read.table("test/X_test.txt")

#read the Train data set
train_table <- read.table("train/X_train.txt")

#combine by row
combined_table <- rbind(test_table, train_table)

# read the activities labels
activities < read.table("activity_labels.txt")

# read the activities list for Test
act_test <- read.table("test/y_test.txt")
# read the activities list for Train
act_train <- read.table("train/y_train.txt")

# name the data table columns with the variable names
features <- read.table("features.txt")
names(combined_table) <- features[,2]

# remove duplicated variable/columns
combined_table <- combined_table[,unique(features[,2])]

# extracts mean and std variables only
mean_std_table <- select(combined_table, matches("mean|Mean|std|Std"))

#combine the activities list
act_combined <- rbind(act_test, act_train)

# replace the activity ID with the description
act_combined <- mutate(act_combined, activities[V1,2])

# add the activity column to the combined data set
activities_table <- cbind("activities" = act_combined[,2], combined_table)

# read and combine the subject
subjects_test <- read.table("test/subject_test.txt")
subjects_train <- read.table("train/subject_train.txt")
subjects <- rbind(subjects_test,subjects_train)

# add the subject to the table
activ_subject_table <- cbind("subjects" = subjects[,1],activities_table)

# group by activity and by subject and compute the mean
group_table <- activ_subject_table %>% group_by(activities, subjects) %>% summarize_each(funs(mean))

# if we want to get the same new table using only "Mean" and "std" columns
group_table_std_mean <- activ_subject_table %>% select(matches("activities|subjects|mean|Mean|std|Std")) %>%
  group_by(activities, subjects) %>% 
  summarize_each(funs(mean))








