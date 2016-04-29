
This project uses the various HAR data files (described in detail in ReadMe.MD) and processes
the same by running run_analysis.R source code file.

The run_analysis.R source code does the following major steps,

1) reads the 2 activity files - "test/y_test.txt" and "train/y_train.txt" 

2) reads the 2 subject files - "test/subject_test.txt" and "train/subject_train.txt"

3) reads the 2 features files - "test/X_test.txt" and "train/X_train.txt"

4) merge these files - first rowwise and then column-wise to create a single file

5) extract only those columns which have either "std" or "mean" in the column-name

6) create average of all columns arranged by subject + activity

7) store this newly created tidy data in a new file named "HAR_avg_tidy.txt"
