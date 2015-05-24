library("dplyr")
# Read data from source document.

Training.Set <- read.table("~/UCI HAR Dataset/train/X_train.txt")
Training.Activity <- read.table("~/UCI HAR Dataset/train/Y_train.txt")
Training.Subjects <- read.table("~/UCI HAR Dataset/train/subject_train.txt", stringsAsFactors=FALSE)
Test.Set <- read.table("~/UCI HAR Dataset/test/X_test.txt")
Test.Activity <- read.table("~/UCI HAR Dataset/test/Y_test.txt")
Test.Subjects <- read.table("~/UCI HAR Dataset/test/subject_test.txt", stringsAsFactors=FALSE)
Variables <- read.table("~/UCI HAR Dataset/features.txt")

# Replace the column names to the definition by code book.
colnames(Training.Set) <- as.vector(Variables$V2)
colnames(Test.Set) <- as.vector(Variables$V2)

# Start to combine two data sets into one.

New.dataset <- rbind(Training.Set, Test.Set)
colnames(Training.Set) <- as.vector(Variables$V2)
New.Activity <- rbind(Training.Activity, Test.Activity)
New.Subjects <- rbind(Training.Subjects, Test.Subjects)

# Replace the first factor value in value of subjects file that make sure it same with others.

Training.Subjects[Training.Subjects == 'I1'] <- '1'

# Get one dataset be cleaned in order to let it be tidy data.

New.Subjects <- rbind(Training.Subjects, Test.Subjects)
Temp.dataset <- cbind(New.Subjects,New.Activity)
New.dataset <-  cbind(Temp.dataset,New.dataset)
colnames(New.dataset)[c(1,2)] <- c("Subjects", "Activity")

# Uses descriptive activity names to name the activities in the data set.

for(i in 1:length(New.dataset$Activity)) {
        if(New.dataset$Activity[i] == 1) {
                New.dataset$Activity[i] <- "WALKING"
        }else if(New.dataset$Activity[i] == 2) {
                New.dataset$Activity[i] <- "WALKING_UPSTAIRS"   
        }else if(New.dataset$Activity[i] == 3) {
                New.dataset$Activity[i] <- "WALKING_DOWNSTAIRS" 
        }else if(New.dataset$Activity[i] == 4) {
                New.dataset$Activity[i] <- "SITTING"
        }else if(New.dataset$Activity[i] == 5) {
                New.dataset$Activity[i] <- "STANDING"
        }else if(New.dataset$Activity[i] == 6) {
                New.dataset$Activity[i] <- "LAYING"
        }
}

# Extracts only the measurements on the mean and standard deviation for each measurement.

New.dataset1 <- New.dataset[, grep(c("Subjects|Activity|mean|std"), names(New.dataset), ignore.case = TRUE)]

step5 <- data.frame()
g <- data.frame()
for(j in 1:30) {
        for(k in 1:6) {
                s <- colMeans(select(filter(New.dataset1, Subjects == j & Activity == unique(New.dataset1$Activity)[k]),-(Subjects:Activity)))
                step5 <- rbind(step5,s)
                v <- unique(select(filter(New.dataset1, Subjects == j & Activity == unique(New.dataset1$Activity)[k]),(Subjects:Activity)))
                g <- rbind(g,v)
        }
                result <- cbind(g,step5)
                colnames(result) <- c("Subjects","Activity",names(select(New.dataset1,-(Subjects:Activity))))
}
write.table(result,file="result.txt", row.names =  FALSE)


