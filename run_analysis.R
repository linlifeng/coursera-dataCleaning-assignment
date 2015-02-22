#import library
library("dplyr")

#####################################################################
#load individual data files
features <- read.table("features.txt", col.names=c("featureId", "featureName"))
activity_labels <- read.table("activity_labels.txt", col.names=c("labelId","label"))

#combine test and training datasets into one
combined_x <- rbind(
        read.table("train//X_train.txt", col.names=features$featureName), 
        read.table("test//X_test.txt",col.names=features$featureName)
)
combined_y <- rbind(
        read.table("train//y_train.txt", col.names="labels"), 
        read.table("test//y_test.txt", col.names="labels")
)
combined_subject <- rbind(
        read.table("train//subject_train.txt", col.names="subject"),
        read.table("test//subject_test.txt", col.names="subject")
)
combined_body_acc_x <- rbind(
        read.table("train//Inertial Signals//body_acc_x_train.txt"), 
        read.table("test//Inertial Signals//body_acc_x_test.txt")
)
combined_body_acc_y <- rbind(
        read.table("train//Inertial Signals//body_acc_y_train.txt"), 
        read.table("test//Inertial Signals//body_acc_y_test.txt")
)
combined_body_acc_z <- rbind(
        read.table("train//Inertial Signals//body_acc_z_train.txt"), 
        read.table("test//Inertial Signals//body_acc_z_test.txt")
)
combined_body_gyro_x <- rbind(
        read.table("train//Inertial Signals//body_gyro_x_train.txt"), 
        read.table("test//Inertial Signals//body_gyro_x_test.txt")
)
combined_body_gyro_y <- rbind(
        read.table("train//Inertial Signals//body_gyro_y_train.txt"), 
        read.table("test//Inertial Signals//body_gyro_y_test.txt")
)
combined_body_gyro_z <- rbind(
        read.table("train//Inertial Signals//body_gyro_z_train.txt"), 
        read.table("test//Inertial Signals//body_gyro_z_test.txt")
)
combined_total_acc_x <- rbind(
        read.table("train//Inertial Signals//total_acc_x_train.txt"), 
        read.table("test//Inertial Signals//total_acc_x_test.txt")
)
combined_total_acc_y <- rbind(
        read.table("train//Inertial Signals//total_acc_y_train.txt"), 
        read.table("test//Inertial Signals//total_acc_y_test.txt")
)
combined_total_acc_z <- rbind(
        read.table("train//Inertial Signals//total_acc_z_train.txt"), 
        read.table("test//Inertial Signals//total_acc_z_test.txt")
)
# this might not be needed
complete <- cbind(combined_subject, 
                  combined_y, 
                  combined_x, 
                  rowMeans(combined_body_acc_x),
                  combined_body_acc_y,
                  combined_body_acc_z,
                  combined_body_gyro_x,
                  combined_body_gyro_y,
                  combined_body_gyro_z,
                  combined_total_acc_x,
                  combined_total_acc_y,
                  combined_total_acc_z
)
# this is the requested summary dataset in "step 4" of the assignment
mean_and_sd <- cbind(combined_subject,
                     combined_y,
                     combined_x$tBodyAcc.mean...X,
                     combined_x$tBodyAcc.mean...Y,
                     combined_x$tBodyAcc.mean...Z,
                     combined_x$tBodyAcc.std...X,
                     combined_x$tBodyAcc.std...Y,
                     combined_x$tBodyAcc.std...Z,
                     combined_x$tGravityAcc.mean...X,
                     combined_x$tGravityAcc.mean...Y,
                     combined_x$tGravityAcc.mean...Z,
                     combined_x$tGravityAcc.std...X,
                     combined_x$tGravityAcc.std...Y,
                     combined_x$tGravityAcc.std...Z,
                     combined_x$tBodyGyro.mean...X,
                     combined_x$tBodyGyro.mean...Y,
                     combined_x$tBodyGyro.mean...Z,
                     combined_x$tBodyGyro.std...X,
                     combined_x$tBodyGyro.std...Y,
                     combined_x$tBodyGyro.std...Z
)

#######################################################################
#rename columns
colnames(mean_and_sd) <- c("subject", "activity", 
                           "meanBodyAcc_x",
                           "meanBodyAcc_y",
                           "meanBodyAcc_z",
                           "stdBody_x",
                           "stdBody_y",
                           "stdBody_z",
                           "meanGrav_x",
                           "meanGrav_y",
                           "meanGrav_z",
                           "stdGrav_x",
                           "stdGrav_y",
                           "stdGrav_z",
                           "meanGyr_x",
                           "meanGyr_y",
                           "meanGyr_z",
                           "stdGyr_x",
                           "stdGyr_y",
                           "stdGyr_z"
)

# create and export summary table
average_summary_table <- summarize(group_by(mean_and_sd, 
                                            as.character(subject), 
                                            as.character(activity)), 
                                   mean(meanBodyAcc_x),
                                   mean(meanBodyAcc_y),
                                   mean(meanBodyAcc_z),
                                   mean(meanGrav_x),
                                   mean(meanGrav_y),
                                   mean(meanGrav_z),
                                   mean(meanGyr_x),
                                   mean(meanGyr_z)
)
write.table(average_summary_table, file="average_summary_out.tab", row.name=FALSE)
                     
