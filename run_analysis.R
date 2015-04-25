
#load dplyr library
library(dplyr)

#load train tables
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", quote="\"")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", quote="\"")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", quote="\"")

#load test tables
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", quote="\"")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", quote="\"")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", quote="\"")

#load features (variable names)
features <- read.table("UCI HAR Dataset/features.txt", quote="\"")

#assign variable names to train and test data frames
names(X_train)<-features$V2
names(X_test)<-features$V2

#keep only mean and std deviation variables from each data frame
X_train<-X_train[,grepl("std()|Mean()", colnames(X_train))]
X_test<-X_test[,grepl("std()|Mean()", colnames(X_test))]

#name subject and activity variables
names(subject_train)[1]<-"subject"
names(subject_test)[1]<-"subject"
names(y_train)[1]<-"activity"
names(y_test)[1]<-"activity"

#bind train tables and test tables (resulting two data frames)
train<-cbind(subject_train,X_train,y_train)
test<-cbind(subject_test,X_test,y_test)


#assign intuitive names to activities
test<-within(test, activity <- factor(activity, labels =
c("walk", "walkup", "walkdown","sit","stand","lay")))
train<-within(train, activity <- factor(activity, labels =
c("walk", "walkup", "walkdown","sit","stand","lay")))

#create a variable that combines subject and activity
train<-mutate(train,subjactivity=paste(subject, activity,sep=""))
test<-mutate(test,subjactivity=paste(subject, activity,sep=""))
test <- subset(test, select = -(c(subject,activity)))
train <- subset(train, select = -(c(subject,activity)))            

#convert the two dataframes into table dataframes
tbl_test<- tbl_df(test)
tbl_train<-tbl_df(train)

#bind (rows) the two tables into one
tbl_all<-rbind(tbl_test,tbl_train)

#groupe by subject and activity (subjactivity)
tbl_all_grouped<-group_by(tbl_all,subjactivity)

#tidy variable names removing "(" ,"/", ",", "-" and converting
#all strings to lowercase
names(tbl_all_grouped) <- gsub(",", "", names(tbl_all_grouped))
names(tbl_all_grouped) <- gsub("\\(", "", names(tbl_all_grouped))
names(tbl_all_grouped) <- gsub(")", "", names(tbl_all_grouped))
names(tbl_all_grouped) <- gsub("-", "", names(tbl_all_grouped))
names(tbl_all_grouped)<-tolower(names(tbl_all_grouped))

#summarize the mean of each subject and activity combination 
tbl_all_grouped<-summarise_each(tbl_all_grouped,funs(mean))

#display final table
View(tbl_all_grouped)
