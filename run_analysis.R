library(reshape2)

#1. Merges the training and the test sets to create one data set----------------

#Preparation of the workspace and Obtaining the web data
wd=getwd()


wd1=paste(wd,"/analysis", sep = "")#address of the folder where it will be downloaded
                                   #and unzip the file.
wd2=paste(wd1,"/data.zip", sep = "")#address of the data.zip file.

dataurl="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists("./analysis")) {
        dir.create("./analysis")
        download.file(url=dataurl, destfile=wd2)
        unzip(zipfile = wd2, exdir = wd1)
}
setwd(wd1)#Working directory where you will work.


#Preparation and reading of data

# train data
x_train=read.table("./UCI HAR Dataset/train/X_train.txt")
y_train=read.table("./UCI HAR Dataset/train/Y_train.txt")
s_train=read.table("./UCI HAR Dataset/train/subject_train.txt")

# test data
x_test=read.table("./UCI HAR Dataset/test/X_test.txt")
y_test=read.table("./UCI HAR Dataset/test/Y_test.txt")
s_test=read.table("./UCI HAR Dataset/test/subject_test.txt")

#Joining the dataset

x_data=rbind(x_train, x_test)
y_data=rbind(y_train, y_test)
s_data=rbind(s_train, s_test)


#Reading of information of features and activitys

# feature info
feature=read.table("./UCI HAR Dataset/features.txt")
feature[,2]=as.character(feature[,2])
# activity labels
activity=read.table("./UCI HAR Dataset/activity_labels.txt")
activity[,2]=as.character(activity[,2])


#2. Extracts only the measurements on the mean and standard deviation
#for each measurement-----------------------------------------------------------

selcol=grep("-(mean|std).*",feature[,2])#Take the columns that meet the condition
selcolname=feature[selcol, 2]
selcolname=gsub("-mean", "Mean", selcolname)
selcolname=gsub("-std", "Std", selcolname)
selcolname=gsub("[-()]", "", selcolname)

#From the set x_data extracts the columns that contain the mean and standard deviation information
x_data=x_data[selcol]


#3.Appropriately labels the data set with descriptive variable names------------

allData=cbind(s_data, y_data, x_data)#une todos los conjuntos de datos
colnames(allData)=c("Subject", "Activity", selcolname)

#4.Uses descriptive activity names to name the activities in the data set-------

#Change the numerical value in the Activity column to the categorical value in the activity file
allData$Activity=factor(allData$Activity, levels = activity[,1], labels = activity[,2])
allData$Subject=as.factor(allData$Subject)

#5. From the data set in step 4, creates a second, independent tidy data set
#with the average of each variable for each activity and each subject.----------

#the columns that will serve as identification are identified
meltedData=melt(allData, id = c("Subject", "Activity"))
tidyData=dcast(meltedData, Subject + Activity ~ variable, mean)

#Generate an ordered data table with the desired data
write.table(tidyData, "./tidy_dataset.txt", row.names = FALSE, quote = FALSE)

read.table("tidy_dataset.txt")


