# CleaningData
Course Project of Getting and Cleaning Data (Data Scientist Specialization - Johns Hopkins)

This project uses a Human Activity Recognition database built from the recordings of 30 subjects withing an age bracket of 19-48 years performing activities of daily living while carrying a waist-mounted smartphone with embededed inertial sensors.
The full description of the original database is made available at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The raw database can be downloaded from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The processing script (run_analisys.R) selects only the mean and standard deviation variables. A listing and description of the considered variables is available in CodeBook.md The end result is a data frame describing the selected variables mean for each subject and activity (30 subjects, 6 activities = 180 rows). 

Both the train and test sets were merged into one table dataframe (rbind), resulting in a 180 rows and 41 columns table. Both tables were handled separately, just in case one wishes to cbind both tables (getting as a result a 81 column table). 

The description of run_analysis is selfcontained in the script because of the numerous comments in it.
