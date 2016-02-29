##Codebook

This is the codebook that describes the variables of the [run_analysis.R](https://github.com/JacksonChou/Getting-and-Cleaning-Data-Course-Project/blob/master/run_analysis.R) output in ```"tidydataset.txt"```.

##Original Data Source

Data Source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Description of dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

##Data Definitions

**Subjects**  - factor that represents the subject (ranging from 1 to 30)

**Activity** - factor that represents the activity as described in the data set information: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

**Columns ```3:68```** - represents the mean or standard deviation of the features selected in [features_info.txt](https://github.com/JacksonChou/Getting-and-Cleaning-Data-Course-Project/edit/master/features_info.txt).  These are the original feature description from UCI dataset.

##Data Transformations

The column names in the ```tidydataset.txt``` has been renamed for clarity.  Output of the tidy dataset results in 180 rows and 68 columns.

The following is a list where portions of the descriptive variables were renamed:

```{r}
"BodyBody" to "Body"
"tBody", "Body"
"fBody", "FFTBody"
"tGravity", "Gravity"
"fGravity", "FFTGravity"
"Acc", "Acceleration"
"Gyro", "AngularVelocity"
"Mag", "Magnitude"
```
Example:
 
The original variable  ```tBodyAcc-mean()-X``` was renamed to ```BodyAccelerationmeanX```.




