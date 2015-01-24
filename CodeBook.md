This file describes the data, transformations and steps taken to clean, analyze and save file for the 
Getting and Cleaning Data class project.

	  1. Read in files and Column bind train data
			subject_train.txt - file with subject number, 7352 rows
			y_train.txt - file with activity type, 7352 rows
			x_train.txt - file with std and mean among other calcs 
				561 columns by 7352 rows
	
	  2. Read in files and Column bind test data
			subject_test.txt - file with subject number, 2947 rows
			y_test.txt - file with activity type, 2947 rows
			x_test.txt - file with std and mean among other calcs 
				561 columns by 2947 rows
	
	  3. Row Bind the train and test datasets
	
	  4. Subset dataset to include the following columns only:
			1 - SubjectNumber
			2 - ActivityType
			3 - tBodyAcc-mean()-X
			4 - tBodyAcc-mean()-Y
			5 - tBodyAcc-mean()-Z
			6 - tBodyAcc-std()-X
			7 - tBodyAcc-std()-Y
			8 - tBodyAcc-std()-Z
	
	  5. Modify column headings to be readable column headings:
			1 - SubjectNumber
			2 - ActivityType
			3 - MeanX
			4 - MeanY
			5 - MeanZ
			6 - StdX
			7 - StdY
			8 - StdZ
	
	  6. Modify varible values in Column 2 - ActivityName to be readable
			1 - WALKING
			2 - WALKING_UPSTAIRS
			3 - WALKING_DOWNSTAIRS
			4 - SITTING
			5 - STANDING
			6 - LAYING
	
	  7. Create a separate dataset with an average for each variable 
			per test subject (column 1).
	
	  8. Write data frame to file.
