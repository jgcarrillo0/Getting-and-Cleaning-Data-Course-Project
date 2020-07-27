Code Book

When you run the program "run_analysis.R", it starts with the download of the
.zip file to our working directory.

wd=working directory
wd1=address of the folder where it will be downloaded and unzip the file.
wd2=address of the data.zip file.

x_train=X_train.txt
y_train=Y_train.txt
s_train=subject_train.txt

x_test=X_test.txt
y_test=Y_test.txt
s_test=subject_test.txt


x_data=union of x_train and x_test
y_data=union of y_train and y_test
s_data=union of s_train and s_test


feature=features.txt
activity=activity_labels.txt

selcolname=contains the ordered name of the columns

allData=union of s_data, y_data and x_data

meltedData=assign the identification variables

tidyData=desired dataset








