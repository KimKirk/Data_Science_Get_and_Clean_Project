
##set working directory to inside of unzipped folder
    setwd(paste(getwd(), 'UCI HAR Dataset', sep = "/"))
##import "features" as vector
    features_labels <- scan("./features.txt", what = "text", sep = "\t")
##import "y_test" as vector
    test_activities <- scan("./test/y_test.txt", what = "numeric", sep = "\t")
    test_activities <- as.numeric(test_activities)
##import "y_train" as vector
    train_activities <- scan("./train/y_train.txt", what = "numeric", sep = "\t")
    train_activities <- as.numeric(train_activities)
##import "subject_test" as vector
    test_subjects <- scan("./test/subject_test.txt", what = "numeric", sep = "\t")
    test_subjects <- as.numeric(test_subjects)
##import "subject_train" as vector
    train_subjects <- scan("./train/subject_train.txt", what = "numeric", sep = "\t")
    train_subjects <- as.numeric(train_subjects)
##import "X_test" file
    test_features <- read.table("./test/X_test.txt", header = FALSE, col.names = features_labels, na.strings = c(" ", "NA"), stringsAsFactors = FALSE, strip.white = TRUE, colClasses = "numeric")
##import "X_train" file
    train_features <- read.table("./train/X_train.txt", header = FALSE, col.names = features_labels, na.strings = c(" ", "NA"), stringsAsFactors = FALSE, strip.white = TRUE, colClasses = "numeric")
##create vector to use as labels input for factors
    factors_labels <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
##convert y_test_activities file into factor and save in a new object
    test_activities_factors <-factor(test_activities, labels =factors_labels)
##convert y_train_activities file into factor and save in a new object
    train_activities_factors <-factor(train_activities, labels = factors_labels)
##convert test_subjects file into factor and save in new object
    test_subjects_factors <-factor(test_subjects, labels = c("Subject 2", "Subject 4", "Subject 9", "Subject 10", "Subject 12", "Subject 13", "Subject 18", "Subject 20", "Subject 24"))
##convert train_subjects file into factor and save in new object
    train_subjects_factors <-factor(train_subjects, labels = c("Subject 1", "Subject 3", "Subject 5", "Subject 6", "Subject 7", "Subject 8", "Subject 11", "Subject 14", "Subject 15", "Subject 16", "Subject 17", "Subject 19", "Subject 21", "Subject 22", "Subject 23", "Subject 25", "Subject 26", "Subject 27", "Subject 28", "Subject 29", "Subject 30"))
##bind y_test_activities_factors
    test_bind <- cbind(test_activities_factors, test_features)
##bind y_train_activities_factors 
    train_bind <- cbind(train_activities_factors, train_features)
##bind y_test_subjects_factors to features data set
    test_bind_final <- cbind(test_subjects_factors, test_bind)
##bind y_train_subjects_factors to features data set
    train_bind_final <- cbind(train_subjects_factors, train_bind)
##rename first and second variable of test_bind_final
    colnames(test_bind_final)[2] <- "activities"
    colnames(test_bind_final)[1] <- "subject"
##rename first and second variable of train_bind_final
    colnames(train_bind_final)[2] <- "activities"
    colnames(train_bind_final)[1] <- "subject"
##bind test and train datasets together
   combined_test_train_datasets <- rbind(test_bind_final, train_bind_final)
##check for package, prompt user to download if no required package, load library
##credit Matthew on StackOverflow https://stackoverflow.com/users/4125693/matthew
   using<-function(...) {
       libs<-unlist(list(...))
       req<-unlist(lapply(libs,require,character.only=TRUE))
       need<-libs[req==FALSE]
       n<-length(need)
       if(n>0){
           libsmsg<-if(n>2) paste(paste(need[1:(n-1)],collapse=", "),",",sep="") else need[1]
           print(libsmsg)
           if(n>1){
               libsmsg<-paste(libsmsg," and ", need[n],sep="")
           }
           libsmsg<-paste("The following packages could not be found: ",libsmsg,"\n\r\n\rInstall missing packages?",collapse="")
           if(winDialog(type = c("yesno"), libsmsg)=="YES"){       
               install.packages(need)
               lapply(need,require,character.only=TRUE)
           }
       }
   }
   using("dplyr")
##return columns for "subject", "activities", "mean", and "std"
    tidy_data_set <- select(combined_test_train_datasets, subject, activities, matches("mean"), matches("std"))
##calculate mean for each "features" variable grouped by subject and activity
    tidy_data_set %>% group_by(tidy_data_set$subject, tidy_data_set$activities) %>% summarise_if(is.numeric, mean, na.rm = TRUE) -> final_tidy_data
##rename all features column names to be more human friendly
    names(final_tidy_data) <- c("subject", "activities", "T_XAxis_BodyAccelerometer_Mean","T_YAxis_BodyAccelerometer_Mean",
                      "T_ZAxis_BodyAccelerometer_Mean", "T_XAxis_GravityAccelerometer_Mean", "T_YAxis_GravityAccelerometer_Mean",
                      "T_ZAxis_GravityAccelerometer_Mean", "T_XAxis_BodyAccelerometerJerk_Mean",
                      "T_YAxis_BodyAccelerometerJerk_Mean", "T_ZAxis_BodyAccelerometerJerk_Mean",
                      "T_XAxis_BodyGyroscope_Mean","T_YAxis_BodyGyroscope_Mean",
                      "T_ZAxis_BodyGyroscope_Mean", "T_XAxis_BodyGyroscopeJerk_Mean", 
                      "T_YAxis_BodyGyroscopeJerk_Mean","T_ZAxis_BodyGyroscopeJerk_Mean",
                      "T_BodyAccelerometerMagnitude_Mean", "T_GravityAccelerometerMagnitude_Mean",
                      "T_BodyAccelerometerJerkMagnitude_Mean", "T_BodyGyroscopeMagnitude_Mean",
                      "T_BodyGyroscopeJerkMagnitude_Mean", "F_XAxis_BodyAccelerometer_Mean",
                      "F_YAxis_BodyAccelerometer_Mean", "F_ZAxis_BodyAccelerometer_Mean",
                      "F_XAxis_BodyAccelerometer_MeanFrequency", "F_YAxis_BodyAccelerometer_MeanFrequency",
                      "F_ZAxis_BodyAccelerometer_MeanFrequency", "F_XAxis_BodyAccelerometerJerk_Mean",
                      "F_YAxis_BodyAccelerometerJerk_Mean", "F_ZAxis_BodyAccelerometerJerk_Mean",
                      "F_XAxis_BodyAccelerometerJerk_MeanFrequency", "F_YAxis_BodyAccelerometerJerk_MeanFrequency",
                      "F_ZAxis_BodyAccelerometerJerk_MeanFrequency", "F_XAxis_BodyGyroscope_Mean",
                      "F_YAxis_BodyGyroscope_Mean", "F_ZAxis_BodyGyroscope_Mean", "F_XAxis_BodyGyroscope_MeanFrequency",
                      "F_YAxis_BodyGyroscope_MeanFrequency", "F_ZAxis_BodyGyroscope_MeanFrequency",
                      "F_BodyAccelerometerMagnitude_Mean", "F_BodyAccelerometerMagnitude_MeanFrequency",
                      "F_BodyBodyAccelerometerJerkMagnitude_Mean", "F_BodyBodyAccelerometerJerkMagnitude_MeanFrequency",
                      "F_BodyBodyGyroscopeMagnitude_Mean", "F_BodyBodyGyroscopeMagnitude_MeanFrequency",
                      "F_BodyBodyGyroscopeJerkMagnitude_Mean", "F_BodyBodyGyroscopeJerkMagnitude_MeanFrequency",
                      "Angle_TimeDomainSignal_BodyAccelerometerMean_Gravity", "Angle_TimeDomainSignal_BodyAccelerometerJerkMean_GravityMean",
                      "Angle_TimeDomainSignal_BodyGyroscopeMean_GravityMean", "Angle_TimeDomainSignal_BodBodyGyroscopeJerkMean_GravityMean",
                      "Angle_XAxis_GravityMean", "Angle_YAxis_GravityMean", "Angle_ZAxis_GravityMean", "T_XAxis_BodyAccelerometer_SD",
                      "T_YAxis_BodyAccelerometer_SD", "T_ZAxis_BodyAccelerometer_SD", "T_XAxis_GravityAccelerometer_SD",
                      "T_YAxis_GravityAccelerometer_SD", "T_ZAxis_GravityAccelerometer_SD", "T_XAxis_BodyAccelerometerJerk_SD",
                      "T_YAxis_BodyAccelerometerJerk_SD", "T_ZAxis_BodyAccelerometerJerk_SD", "T_XAxis_BodyGyroscope_SD",
                      "T_YAxis_BodyGyroscope_SD", "T_ZAxis_BodyGyroscope_SD", "T_XAxis_BodyGyroscopeJerk_SD",
                      "T_YAxis_BodyGyroscopeJerk_SD", "T_ZAxis_BodyGyroscopeJerk_SD", "T_BodyAccelerometerMagnitude_SD",
                      "T_GravityAccelerometerMagnitude_SD", "T_BodyAccelerometerJerkMagnitude_SD", "T_BodyGyroscopeMagnitude_SD",
                      "T_BodyGyroscopeJerkMagnitude_SD", "F_XAxis_BodyAccelerometer_SD", "F_YAxis_BodyAccelerometer_SD",
                      "F_ZAxis_BodyAccelerometer_SD", "F_XAxis_BodyAccelerometerJerk_SD", "F_YAxis_BodyAccelerometerJerk_SD",
                      "F_ZAxis_BodyAccelerometerJerk_SD", "F_XAxis_BodyGyroscope_SD", "F_YAxis_BodyGyroscope_SD", "F_ZAxis_BodyGyroscope_SD",
                      "F_BodyAccelerometerMagnitude_SD", "F_BodyBodyAccelerometerJerkMagnitude_SD", "F_BodyBodyGyroscopeMagnitude_SD",
                      "F_BodyBodyGyroscopeJerkMagnitude_SD")
##show user means for each "features" variable grouped by subject and their activity
    View(final_tidy_data)
                                                                        
                                                                        