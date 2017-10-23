# Data_Science_Get_and_Clean_Project
data science project getting and cleaning data

Processing Instructions:
The script "script_1_for_run_analysis" is run before the "run_analysis" script.
Both scripts should only be run in RStudio IDE, do not run in the R Console.
Run "script_1_for_run_analysis" script first.
Go into your R Studio working directory and unzip the file that was downloaded. Do not create a new folder to hold the unzipped file in, simply unzip the downloaded file directly into your working directory.
Run "run_analysis" script last.
Final result is you will see a table that groups the "subject" variable with subgroups for "activities", each of the activities has a mean for the "features" variables; this is the final tidy data table.


Data was tidied by: 
removing N/A values
converting scientific notation to numeric data type
all variables have descriptive labels
all variables have single value
all variables have a single data type
all rows are one observation
there are no duplicate columns

Steps to Transformation:
Zip file “getdata_projectfiles_UCI HAR Dataset” was downloaded from host website.
Set file path to save download to.
Set url for download.
Download file and save to working directory.
“y_test" and "y_train" were converted into Factor with 6 levels.
 “x_train” was converted into numeric, non scientific notation.
"subject_train" was converted into Factor with 21 levels.
“subject_test” was converted into Factor with 9 levels.
“x_test” was converted into numeric, non scientific notation.
“features” was converted into character vector and used as headings for “x_train” and “x_test”.
“subject_train” and “subject_test” were bound to “x_train” and “x_test” respectively.
“y_test” and “y_train” were bound together by column “x_test” and “x_train” respectively.
“x_test” and “x_train” were bound together by row.
Check for dplyr package, prompt user to download if no required package, load dplyr library.
Columns were subset for “mean” and “standard deviation” for the “x_test” and “x_train” combined datasets.
Average was calculated (using the “mean” function) for all numeric variables in the “x_test” and “x_train” combined datasets grouped by “subject” and “activities” variables (aka final “tidy dataset”).
Variable names were assigned to the final “tidy dataset”.
