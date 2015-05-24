## Introduction

This my first time to write .md file. If anything wrong such like bad words or
syntax, please contact with me that let me correct it quickly. 

## Getting Cleaning Data

According to contects of Getting and Cleaning Data in Course Project, we got five
points help us to think about this. I will follow these steps to explain my code 
how to work.

1. `Merges the training and the test sets to create one data set.`
2. `Extracts only the measurements on the mean and standard deviation for each measurement.`
3. `Uses descriptive activity names to name the activities in the data set.`
4. `Appropriately labels the data set with descriptive variable names.`
5. `From the data set in step 4, creates a second, independent tidy data set with the average
   of each variable for each activity and each subject.`

### The first what I do (Reading data set)

Reading dataset from work directory, in this step I only used these file under "test" and "train"
but not include "Inertial Signals" that because of referred to the topic (https://class.coursera.org/getdata-014/forum/thread?thread_id=30). David said that we would not use that we can get what we needed.


### The second

I replaced the column names from the definition by code book. I didn't change anything of columns name so that just 
reserved its. And replaced two data sets to the same each other. When I done for this, start to combine the two data
sets into one set using `rbind` fuction thought loop statement and make sure it will be added to the end row each.


### The third

Added two columns are named of `Subjects` and `Activity` in the data set that I am already done above.
The column of `Activity` is a numeric value. Now I am going to change to character that it correspond to the difinition 
file what it means.

Num | Character
----|----------
1 | WALKING
2 | WALKING_UPSTAIRS
3 | WALKING_DOWNSTAIRS
4 | SITTING
5 | STANDING
6 | LAYING

### The fourth

In this step, I am used `grep` funcion and `dplyr` package help me to extract only the measurements on the mean and standard deviation for each measurement. So that you should install the package first then you can work out. Filter out measuremant only value and caluate all of columns of average. And put it back in the end each using `cbind` and `rbind` again though loop
statement. Order each subject which its maps activity and create a data frame have two length and 180 rows (30 subjects * 6 activitys). Now merge these two data frame with one, that is a tidy data from the source file!
