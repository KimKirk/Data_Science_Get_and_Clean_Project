
##set file path to save download to
    path <- file.path(paste(getwd(), 'getdata_projectfiles_UCI HAR Dataset.zip', sep = "/"))
##set url for download
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
##download file and save to working directory
    download.file(url, path)
    