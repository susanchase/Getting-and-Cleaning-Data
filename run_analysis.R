run_analysis <- function(directory) {
	##  Merge and make a tidy dataset of the 
	##  Human Activity Recognition Using Smartphones datasets.
	##
	##  'directory' is a character vector of length 1 indicating
  ##  the location of the CSV files
	##
	##  Read test and training files in and merge the files.
	##
	##  1. Read in files and Column bind train data
	##		subject_train.txt - file with subject number, 7352 rows
	##		y_train.txt - file with activity type, 7352 rows
	##		x_train.txt - file with std and mean among other calcs 
	##			561 columns by 7352 rows
	##
	##  2. Read in files and Column bind test data
	##		subject_test.txt - file with subject number, 2947 rows
	##		y_test.txt - file with activity type, 2947 rows
	##		x_test.txt - file with std and mean among other calcs 
	##			561 columns by 2947 rows
	##
	##  3. Row Bind the train and test datasets
	##
	##  4. Subset dataset to include the following columns only:
	##		1 - SubjectNumber
	##		2 - ActivityType
	##		3 - tBodyAcc-mean()-X
	##		4 - tBodyAcc-mean()-Y
	##		5 - tBodyAcc-mean()-Z
	##		6 - tBodyAcc-std()-X
	##		7 - tBodyAcc-std()-Y
	##		8 - tBodyAcc-std()-Z
	##
	##  5. Modify column headings to be readable column headings:
	##		1 - SubjectNumber
	##		2 - ActivityType
	##		3 - MeanX
	##		4 - MeanY
	##		5 - MeanZ
	##		6 - StdX
	##		7 - StdY
	##		8 - StdZ
	##
	##  6. Modify varible values in Column 2 - ActivityName to be readable
	##		1 - WALKING
	##		2 - WALKING_UPSTAIRS
	##		3 - WALKING_DOWNSTAIRS
	##		4 - SITTING
	##		5 - STANDING
	##		6 - LAYING
	##
	##  7. Create a separate dataset with an average for each variable for 
	##		per test subject (column 1).
	##
	##  8. Write data frame to file.


	##  1. Read in files and Column bind train data

	setwd(directory)

	subjectfilename <- ".\\train\\subject_train.txt"
	yfilename <- ".\\train\\y_train.txt"
	xfilename <- ".\\train\\x_train.txt"

	traindata <- read.table(file=subjectfilename, header=FALSE, sep = " ")
	ydata <- read.table(file=yfilename, header=FALSE, sep = " ")
	xdata <- read.table(file=xfilename, header=FALSE, sep = "")

	traindata <- cbind(traindata, ydata)
	traindata <- cbind(traindata, xdata)

	##  2. Read in files and Column bind test data
	subjectfilename <- ".\\test\\subject_test.txt"
	yfilename <- ".\\test\\y_test.txt"
	xfilename <- ".\\test\\x_test.txt"

	testdata <- read.table(file=subjectfilename, header=FALSE, sep = " ")
	ydata <- read.table(file=yfilename, header=FALSE, sep = " ")
	xdata <- read.table(file=xfilename, header=FALSE, sep = "")

	testdata <- cbind(testdata, ydata)
	testdata <- cbind(testdata, xdata)

	##  3. Row Bind the train and test datasets

	fulldata <- rbind(traindata, testdata)

	##  4. Subset dataset to include the first 8 columns:
	
	data <- fulldata[,1:8]

	##  5. Modify column headings to be readable column headings:

	colnames(data) <- c("SubjectNumber", "ActivityType",
		"MeanX","MeanY","MeanZ","StdX","StdY","StdZ")

	##  6. Modify varible values in Column 2 - ActivityName to be readable
	
	data$ActivityType[data$ActivityType== 1] <- "WALKING"
	data$ActivityType[data$ActivityType== 2] <- "WALKING_UPSTAIRS"
	data$ActivityType[data$ActivityType== 3] <- "WALKING_DOWNSTAIRS"
	data$ActivityType[data$ActivityType== 4] <- "SITTING"
	data$ActivityType[data$ActivityType== 5] <- "STANDING"
	data$ActivityType[data$ActivityType== 6] <- "LAYING"


	##  7. Create a separate dataset with an average for each variable  
	##		per test subject (column 1).
	
	aggdata <- aggregate(data[, 3:8], list(data$SubjectNumber, data$ActivityType), mean)

	## aggregate function renames the first two columns.  Fix column names.
	colnames(aggdata) <- c("SubjectNumber", "ActivityType",
		"MeanX","MeanY","MeanZ","StdX","StdY","StdZ")

	##  8. Write data frame to file.
	
	write.table(aggdata, file = "project_data.txt", quote=FALSE, 
		sep = " ", row.names = FALSE)

}
