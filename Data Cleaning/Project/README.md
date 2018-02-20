## Description

The function is achieved through five steps.

### Step 1

Subject_test_data, x_test_data and y_test_data are used to read the correspong test data, and then comnbined as test_data; same as train_data; test_data and train_data are combined into data.

### Step 2

"grepl is applied to find the column name containg mean or std, and the results are stored in data_extracted.

### Step 3

Activity names are simplified as"WLK","WLK_UP","WLK_DW","SIT","STD" and"LAY".

### Step 4

Some key words are replaced with simplified abbreviations. The codes are shown below:

- "mean","m"
- "Mean","M"
- ("Body","B"
- "Acc","A"
- "Gravity","G"
- "Jerk","Jk"
- "entropy","etr"
- "correlation","corr"
- "energy","erg"
- "correlation","corr"
- "arCoeff","aCoe"
- "Gyro","Gy"
- "skewness","skw"
- "bandsEnergy","bdE"
- "angle","agl"
- "gravity","grvt"

The "()" is deleted and the "-" is replaced with"_".


### Step 5

"aggregate" is applied to catch the mean for 180 combination.


## Code Book

data: the original combined dataset
data_extracted: stores information of subject, id and the measurements on the mean and standard deviation for each measurement.
data_extracted_sum: the summary of the average of each variable for each activity and each subject
act_name: stores descriptive activity name
vrb_name: stores descriptive feature name