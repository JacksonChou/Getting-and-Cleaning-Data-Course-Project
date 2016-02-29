# Getting and Cleaning Data Course Project

##Course Project Assignment
You should create one R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


##Dependencies

The script run_analysis.R depends on the the following libraries:

```{r}
  1. reshape2
  2. dplyr
  3. plyr
  4. stringr
```

The script will check if you have these libraries installed, if not it will install them for you.

##Using run_analysis.R

The [run_analysis.R](https://github.com/JacksonChou/Getting-and-Cleaning-Data-Course-Project/blob/master/run_analysis.R) script downloads the UCI Har Dataset, subsets the data to only measurements of mean and standard deviation for each activity, and transforms the subset data into a tidy dataset.  In this tidy dataset, the output in each column represents a variable, and each variable represents a measure or characteristic of the subjects.

More information on the variables in the tidydataset can be found in codebook.md

The following is the process of ```{r}run_analysis.R```:

1. Downloads and reads the zipped files from UCI repository, then merges the training and test set into one data set
2. After merging dataset, subset data to only keep columns (variables) that have mean or standard deviation measures of the subjects
3. Renames the columns of the combined dataset based on the ```{r}"activity_labels.txt"``` file from UCI Har Dataset
4. From the subsetted data, creates a secondary dataset that averages each column by the subject and activity factors
5. Output of the script will be a text file ```{r}"tidydataset.txt"```


