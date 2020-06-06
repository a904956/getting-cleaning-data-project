# getting-cleaning-data-project

The work done in this project followed the following structure:

1. Download the data provided by downloading zip, unzipping it and getting the data from the folder downloaded. All in an R environment.
2. Structure the downloads, utilizing the labels for the variables of the newly created datasets.
3. Merging X data, from both training and test set. This was done for Y data and subject data as well.
4. Using the 3 merged dataframes, I bind them for further use.
5. Extract measurements on mean/std identifying appropiate strings on labels.
6. Use the activity labels to a newly created variables named activity_description
7. Change some words for others more descriptive in the variable names
8. Calculated the mean for each variable for each activity and each subject using the dplyr library, grouping by subject and activity_code
9. Wrote the final data in a txt file.
