
# Step 1 
## Merges the training and the test sets to create one data set.

subject_test_data <- read.table("UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="")
x_test_data <- read.table("UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")
y_test_data <- read.table("UCI HAR Dataset/test/Y_test.txt", quote="\"", comment.char="")

subject_train_data <- read.table("UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="")
x_train_data <- read.table("UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")
y_train_data <- read.table("UCI HAR Dataset/train/Y_train.txt", quote="\"", comment.char="")

test_data <- cbind(subject_test_data, y_test_data, x_test_data)

names(test_data)[1] <- "id"
names(test_data)[2] <- "label"

train_data <- cbind(subject_train_data, y_train_data, x_train_data)
names(train_data)[1] <- "id"
names(train_data)[2] <- "label"

data <- rbind(test_data, train_data)

# Step 2
## Extracts only the measurements on the mean and standard deviation for each measurement.

feature <- read.table("UCI HAR Dataset/features.txt", quote="\"", comment.char="")
feature$extract = grepl("mean|std", feature$V2)
feature$extract_index <- as.numeric(rownames(feature))+2
feature_index_extract <- feature[feature$extract == TRUE,]$extract_index
col_index <- c(1,2, feature_index_extract)

data_extracted <- data[col_index]

# Step 3
## Uses descriptive activity names to name the activities in the data set

act_name <- read.table("UCI HAR Dataset/activity_labels.txt", quote="\"", comment.char="")
act_name[,2] <-c("WLK","WLK_UP","WLK_DW","SIT","STD","LAY") 
for ( index in act_name[,1] ) {
  data_extracted$label <- gsub(as.character(index),act_name[index,2],as.character(data_extracted$label))
}

# Step 4
## Appropriately labels the data set with descriptive variable names.

vrb_name <- read.table("UCI HAR Dataset/features.txt", quote="\"", comment.char="")

## replace the full activity name with the describe name

vrb_name$V2 <- gsub("mean","m",as.character(vrb_name$V2))
vrb_name$V2 <- gsub("Mean","M",as.character(vrb_name$V2))
vrb_name$V2 <- gsub("Body","B",as.character(vrb_name$V2))
vrb_name$V2 <- gsub("Acc","A",as.character(vrb_name$V2))
vrb_name$V2 <- gsub("Gravity","G",as.character(vrb_name$V2))
vrb_name$V2 <- gsub("Jerk","Jk",as.character(vrb_name$V2))
vrb_name$V2 <- gsub("entropy","etr",as.character(vrb_name$V2))
vrb_name$V2 <- gsub("correlation","corr",as.character(vrb_name$V2))
vrb_name$V2 <- gsub("energy","erg",as.character(vrb_name$V2))
vrb_name$V2 <- gsub("correlation","corr",as.character(vrb_name$V2))
vrb_name$V2 <- gsub("arCoeff","aCoe",as.character(vrb_name$V2))
vrb_name$V2 <- gsub("Gyro","Gy",as.character(vrb_name$V2))
vrb_name$V2 <- gsub("skewness","skw",as.character(vrb_name$V2))
vrb_name$V2 <- gsub("bandsEnergy","bdE",as.character(vrb_name$V2))
vrb_name$V2 <- gsub("angle","agl",as.character(vrb_name$V2))
vrb_name$V2 <- gsub("gravity","grvt",as.character(vrb_name$V2))
vrb_name$V2 <- gsub("[()]", "",as.character(vrb_name$V2))
vrb_name$V2 <- gsub("-", "_",as.character(vrb_name$V2))

## replace the column name with descriptive activity name
colnames(data_extracted) = gsub("V", "", colnames(data_extracted))
for ( index in vrb_name[,1] ) {
  colnames(data_extracted) <- gsub(as.character(index),vrb_name[index,2],as.character(colnames(data_extracted)))
}

# Step 5
## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

data_extracted_sum <- aggregate(.~id+label, data=data_extracted, FUN = mean)

write.table(data_extracted_sum, row.name=FALSE, file = "tidy_data_set.txt" )
   